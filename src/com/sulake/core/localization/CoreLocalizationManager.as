
package com.sulake.core.localization
{
    import com.sulake.core.runtime.Component;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;
    import com.sulake.core.localization.enum.LocalizationEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.Core;

    public class CoreLocalizationManager extends Component implements ICoreLocalizationManager 
    {

        private var _localizations:Dictionary;
        private var _SafeStr_8873:Map;
        private var _SafeStr_8874:String;
        private var _SafeStr_8875:String = "";
        private var _SafeStr_8876:Array;

        public function CoreLocalizationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._SafeStr_8876 = [];
            super(_arg_1, _arg_2, _arg_3);
            this._localizations = new Dictionary();
            this._SafeStr_8873 = new Map();
        }
        public function registerLocalizationDefinition(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:LocalizationDefinition = this._SafeStr_8873[_arg_1];
            if (_local_4 == null){
                _local_4 = new LocalizationDefinition(_arg_1, _arg_2, _arg_3);
                this._SafeStr_8873[_arg_1] = _local_4;
            };
        }
        public function activateLocalization(_arg_1:String):Boolean
        {
            var _local_2:LocalizationDefinition = this._SafeStr_8873[_arg_1];
            if (_local_2 != null){
                this._SafeStr_8874 = _arg_1;
                this.loadLocalizationFromURL(_local_2.url);
                return (true);
            };
            return (false);
        }
        public function getLocalizationDefinitions():Map
        {
            return (this._SafeStr_8873);
        }
        public function getLocalizationDefinition(_arg_1:String):ILocalizationDefinition
        {
            return ((this._SafeStr_8873[_arg_1] as ILocalizationDefinition));
        }
        public function getActiveLocalizationDefinition():ILocalizationDefinition
        {
            return (this.getLocalizationDefinition(this._SafeStr_8874));
        }
        public function loadLocalizationFromURL(_arg_1:String):void
        {
            var _local_2:String = _arg_1;
            if (assets.hasAsset(_local_2)){
                Logger.log(("[CoreLocalizationManager] reload localization for url: " + _arg_1));
            };
            var _local_3:URLRequest = new URLRequest(_arg_1);
            var _local_4:AssetLoaderStruct = assets.loadAssetFromFile(_local_2, _local_3, "text/plain");
            _local_4.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onLocalizationReady);
            _local_4.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onLocalizationFailed);
        }
        private function onLocalizationReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_3:String;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                _local_3 = _local_2.assetName;
                this.parseLocalizationData((_local_2.assetLoader.content as String));
                this.events.dispatchEvent(new Event(LocalizationEvent.LOCALIZATION_EVENT_LOCALIZATION_LOADED));
            };
        }
        protected function onLocalizationFailed(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            ErrorReportStorage.addDebugData("Localization name", _local_2.assetName);
            ErrorReportStorage.addDebugData("Localization url", _local_2.assetLoader.url);
            ErrorReportStorage.addDebugData("Localization error", ("Code: " + _local_2.assetLoader.errorCode));
            Core.error("Failed to download localization", true, Core._SafeStr_8884);
        }
        public function hasKey(_arg_1:String):Boolean
        {
            var _local_2:Localization = (this._localizations[_arg_1] as Localization);
            return (!((_local_2 == null)));
        }
        public function getKey(_arg_1:String, _arg_2:String=""):String
        {
            var _local_3:Localization = (this._localizations[_arg_1] as Localization);
            if (_local_3 == null){
                this._SafeStr_8876.push(_arg_1);
                return (_arg_2);
            };
            return (_local_3.value);
        }
        public function getRawValue(_arg_1:String, _arg_2:String=""):String
        {
            var _local_3:Localization = (this._localizations[_arg_1] as Localization);
            if (_local_3 == null){
                this._SafeStr_8876.push(_arg_1);
                return (_arg_2);
            };
            return (_local_3.raw);
        }
        public function updateKey(_arg_1:String, _arg_2:String):void
        {
            var _local_3:Localization = this._localizations[_arg_1];
            if (_local_3 == null){
                _local_3 = new Localization(_arg_1, _arg_2);
                this._localizations[_arg_1] = _local_3;
            }
            else {
                _local_3.setValue(_arg_2);
            };
            if (_arg_2.indexOf("%predefined%") >= 0){
                _local_3.registerParameter("predefined", this._SafeStr_8875);
            };
        }
        private function updateAllListeners():void
        {
            var _local_1:Localization;
            for each (_local_1 in this._localizations) {
                _local_1.updateListeners();
            };
        }
        public function registerListener(_arg_1:String, _arg_2:ILocalizable):Boolean
        {
            var _local_3:Localization = this._localizations[_arg_1];
            if (_local_3 == null){
                this._SafeStr_8876.push(_arg_1);
                _local_3 = new Localization(_arg_1, _arg_1);
                this._localizations[_arg_1] = _local_3;
            };
            _local_3.registerListener(_arg_2);
            return (true);
        }
        public function removeListener(_arg_1:String, _arg_2:ILocalizable):Boolean
        {
            var _local_3:Localization = this._localizations[_arg_1];
            if (_local_3 != null){
                _local_3.removeListener(_arg_2);
            };
            return (true);
        }
        public function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="%"):String
        {
            var _local_5:Localization = this._localizations[_arg_1];
            if (_local_5 == null){
                _local_5 = new Localization(_arg_1);
                this._localizations[_arg_1] = _local_5;
            };
            _local_5.registerParameter(_arg_2, _arg_3, _arg_4);
            return (_local_5.value);
        }
        public function getLocalization(_arg_1:String):ILocalization
        {
            return ((this._localizations[_arg_1] as ILocalization));
        }
        public function getKeys():Array
        {
            var _local_2:String;
            var _local_1:Array = new Array();
            for (_local_2 in this._localizations) {
                _local_1.push(_local_2);
            };
            return (_local_1);
        }
        public function printNonExistingKeys():void
        {
            var _local_2:String;
            var _local_1:String = "";
            for each (_local_2 in this._SafeStr_8876) {
                _local_1 = (_local_1 + (_local_2 + "\n"));
            };
            Logger.log(_local_1);
        }
        protected function parseLocalizationData(_arg_1:String):void
        {
            var _local_6:String;
            var _local_7:Array;
            var _local_8:String;
            var _local_9:String;
            var _local_2:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _local_3:RegExp = /^\s+|\s+$/g;
            var _local_4:Array = _arg_1.split(_local_2);
            var _local_5:RegExp = /\\n/mg;
            for each (_local_6 in _local_4) {
                if (_local_6.substr(0, 1) != "#"){
                    _local_7 = _local_6.split("=");
                    if (_local_7[0].length > 0){
                        if (_local_7.length > 1){
                            _local_8 = _local_7.shift();
                            _local_9 = _local_7.join("=");
                            _local_8 = _local_8.replace(_local_3, "");
                            _local_9 = _local_9.replace(_local_3, "");
                            _local_9 = _local_9.replace(_local_5, "\n");
                            if (_local_9.length > 0){
                                this.updateKey(_local_8, _local_9);
                            };
                        };
                    };
                };
            };
            this.updateAllListeners();
        }
        protected function setPredefinedUrl(_arg_1:String):void
        {
            var _local_2:Localization;
            this._SafeStr_8875 = _arg_1;
            for each (_local_2 in this._localizations) {
                if (_local_2.raw.indexOf("%predefined%") >= 0){
                    _local_2.registerParameter("predefined", this._SafeStr_8875);
                };
            };
        }

    }
}//package com.sulake.core.localization

// ILocalization = "_-2EY" (String#1839, DoABC#2)
// ILocalizable = "_-3Dn" (String#2024, DoABC#2)
// ILocalizationDefinition = "_-oS" (String#2194, DoABC#2)
// LocalizationEvent = "_-01S" (String#1388, DoABC#2)
// Localization = "_-1UB" (String#5436, DoABC#2)
// LocalizationDefinition = "_-1PB" (String#5336, DoABC#2)
// CoreLocalizationManager = "_-19t" (String#5076, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// LOCALIZATION_EVENT_LOCALIZATION_LOADED = "_-0nu" (String#15973, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// updateKey = "_-1LP" (String#5269, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// raw = "_-Xc" (String#8361, DoABC#2)
// updateListeners = "_-1i" (String#18210, DoABC#2)
// registerListener = "_-6e" (String#7798, DoABC#2)
// removeListener = "_-1Hc" (String#1653, DoABC#2)
// _SafeStr_8873 = "_-Zg" (String#23623, DoABC#2)
// _SafeStr_8874 = "_-2vG" (String#21288, DoABC#2)
// _SafeStr_8875 = "_-R7" (String#23288, DoABC#2)
// _SafeStr_8876 = "_-0T4" (String#15173, DoABC#2)
// registerLocalizationDefinition = "_-00S" (String#3573, DoABC#2)
// activateLocalization = "_-iU" (String#8569, DoABC#2)
// loadLocalizationFromURL = "_-rj" (String#8731, DoABC#2)
// getLocalizationDefinitions = "_-3A1" (String#7512, DoABC#2)
// getLocalizationDefinition = "_-2Ce" (String#6296, DoABC#2)
// getActiveLocalizationDefinition = "_-0n3" (String#4568, DoABC#2)
// parseLocalizationData = "_-2Sn" (String#20151, DoABC#2)
// _SafeStr_8884 = "_-01f" (String#14117, DoABC#2)
// hasKey = "_-0LB" (String#3985, DoABC#2)
// getRawValue = "_-BV" (String#7899, DoABC#2)
// updateAllListeners = "_-1pI" (String#18514, DoABC#2)
// printNonExistingKeys = "_-0jT" (String#4489, DoABC#2)
// setPredefinedUrl = "_-0yr" (String#16385, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


