
package com.sulake.habbo.configuration
{
    import com.sulake.core.runtime.Component;
    import flash.utils.Dictionary;
    import com.sulake.habbo.configuration.enum.HabboConfigurationFlags;
    import com.sulake.core.assets.TextAsset;
    import flash.display.Stage;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.Core;
    import flash.events.Event;
    import flash.system.Security;

    public class HabboConfigurationManager extends Component implements IHabboConfigurationManager 
    {

        private static var _SafeStr_10847:String = "%";

        private var _SafeStr_10848:Dictionary;
        private var _initialized:Boolean = false;
        private var _SafeStr_10849:String = "";
        private var _SafeStr_10850:Array;

        public function HabboConfigurationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            var _local_8:String;
            var _local_9:String;
            this._SafeStr_10850 = [];
            super(_arg_1, _arg_2, _arg_3);
            this._initialized = ((_arg_2 & HabboConfigurationFlags._SafeStr_6565) > 0);
            this._SafeStr_10848 = new Dictionary();
            if (!this._initialized){
                lock();
            };
            var _local_4:TextAsset = (_arg_3.getAssetByName("default_configuration") as TextAsset);
            this.parseConfiguration(_local_4.content.toString());
            var _local_5:Stage = _arg_1.displayObjectContainer.stage;
            var _local_6:String = _local_5.loaderInfo.url;
            var _local_7:int = _local_6.lastIndexOf("/");
            _local_6 = _local_6.substring(0, (_local_7 + 1));
            this.setKey("flash.client.url", _local_6);
            for (_local_8 in _local_5.loaderInfo.parameters) {
                ErrorReportStorage.addDebugData("Parsing flashvars", "Parsing flasvars");
                _local_9 = _local_5.loaderInfo.parameters[_local_8];
                _local_8 = _local_8.replace(/[_]/g, ".");
                Logger.log(((("Habbo Configuration: Register HTML Parameter: " + _local_8) + " = ") + _local_9));
                this.setKey(_local_8, _local_9, true);
            };
            ErrorReportStorage.addDebugData("Flashvars/host", ("Host: " + this.getKey("connection.info.host", "not found!")));
            ErrorReportStorage.addDebugData("Flashvars/port", ("Port: " + this.getKey("connection.info.port", "not found!")));
            this._SafeStr_10849 = this.getKey("url.prefix");
            if (((!((this._SafeStr_10849 == null))) && ((this._SafeStr_10849.length > 0)))){
                this.setKey("client.fatal.error.url", (this._SafeStr_10849 + "/flash_client_error"));
            };
            this.init();
        }
        override public function dispose():void
        {
            super.dispose();
        }
        private function init():void
        {
            var _local_1:String;
            var _local_2:URLRequest;
            var _local_3:AssetLoaderStruct;
            if (!this._initialized){
                _local_1 = this.getKey("external.variables.txt", "external_variables.txt");
                Logger.log(("Configuration External Variables: " + _local_1));
                if (assets.hasAsset(_local_1)){
                    Logger.log(("[HabboConfigurationManager] reload configuration for url: " + _local_1));
                };
                _local_2 = new URLRequest(_local_1);
                _local_3 = assets.loadAssetFromFile(_local_1, _local_2, "text/plain");
                _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onInitConfiguration);
                _local_3.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onConfigurationError);
            };
        }
        private function onConfigurationError(_arg_1:Event=null):void
        {
            var _local_2:AssetLoaderEvent = (_arg_1 as AssetLoaderEvent);
            var _local_3:int;
            if (_local_2 != null){
                _local_3 = _local_2.status;
            };
            HabboWebTools.logEventLog(("external_variables download error " + _local_3));
            Core.error((((("Could not load external variables. Failed to load URL " + this.getKey("external.variables.txt")) + "HTTP status ") + _local_3) + ". Client startup failed!"), true, Core._SafeStr_9855);
        }
        private function onInitConfiguration(_arg_1:Event=null):void
        {
            var _local_5:int;
            var _local_6:URLRequest;
            var _local_7:AssetLoaderStruct;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null){
                return;
            };
            var _local_3:String = (_local_2.assetLoader.content as String);
            if (_local_3 != null){
                this.parseConfiguration(_local_3);
            };
            if ((((_local_3 == null)) || ((_local_3.length == 0)))){
                _local_5 = (((_local_3)!=null) ? _local_3.length : -1);
                Core.error((((("Could not load external variables, got empty data from URL " + this.getKey("external.variables.txt")) + " data length = ") + _local_5) + ". Client startup failed!"), false, Core._SafeStr_9855);
            };
            Logger.log(("Configuration check: " + this.getKey("connection.info.host")));
            var _local_4:String = this.getKey("external.override.variables.txt");
            if (((_local_4) && (!((_local_4 == ""))))){
                Logger.log(("Override External Variables: " + _local_4));
                if (assets.hasAsset(_local_4)){
                    Logger.log(("[HabboConfigurationManager] reload configuration for url: " + _local_4));
                };
                _local_6 = new URLRequest(_local_4);
                _local_7 = assets.loadAssetFromFile(_local_4, _local_6, "text/plain");
                _local_7.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onInitConfigurationOverride);
                _local_7.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onConfigurationOverrideError);
            }
            else {
                if (!this._initialized){
                    this._initialized = true;
                    if (locked){
                        unlock();
                    };
                };
            };
        }
        private function onConfigurationOverrideError(_arg_1:Event):void
        {
            var _local_2:AssetLoaderEvent = (_arg_1 as AssetLoaderEvent);
            var _local_3:int;
            if (_local_2 != null){
                _local_3 = _local_2.status;
            };
            Logger.log(("Could not load external variables override. HTTP status: " + _local_3));
            this._initialized = true;
            if (locked){
                unlock();
            };
        }
        private function onInitConfigurationOverride(_arg_1:Event):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null){
                return;
            };
            var _local_3:String = (_local_2.assetLoader.content as String);
            if (_local_3 != null){
                this.parseConfiguration(_local_3);
            };
            this._initialized = true;
            if (locked){
                unlock();
            };
        }
        private function parseConfiguration(data:String):void
        {
            var line:String;
            var pair:Array;
            var key:String;
            var value:String;
            var localKey:String;
            var index:int;
            var originalKey:String;
            var externalAccessDomain:String;
            var portIndex:int;
            var pattern_rows:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var pattern_trim:RegExp = /^\s+|\s+$/g;
            var rows:Array = data.split(pattern_rows);
            var readOnly:Boolean;
            for each (line in rows) {
                if (line.substr(0, 1) != "#"){
                    pair = line.split("=");
                    if ((((pair[0].length > 0)) && ((pair[1].length > 0)))){
                        key = pair.shift();
                        value = pair.join("=");
                        key = key.replace(pattern_trim, "");
                        value = value.replace(pattern_trim, "");
                        if ((((key == "configuration.readonly")) && ((value == "true")))){
                            readOnly = true;
                        };
                        this.setKey(key, value, readOnly);
                    };
                };
            };
            if (this.getKey("local.environment") == "true"){
                for (localKey in this._SafeStr_10848) {
                    index = localKey.indexOf(".local");
                    if (index != -1){
                        originalKey = localKey.substring(0, index);
                        this.setKey(originalKey, this.getKey(localKey));
                        Logger.log(((("Replacing " + originalKey) + " with value of ") + localKey));
                    };
                };
            };
            this._SafeStr_10849 = this.getKey("url.prefix");
            if (this._SafeStr_10849.length > 0){
                externalAccessDomain = this._SafeStr_10849.replace("http://", "");
                portIndex = externalAccessDomain.indexOf(":");
                if (portIndex != -1){
                    externalAccessDomain = externalAccessDomain.substring(0, portIndex);
                };
                try {
                    if (this.isValidDomain(externalAccessDomain)){
                        Logger.log(("Allowing external access from domain: " + externalAccessDomain));
                        Security.allowDomain(externalAccessDomain);
                    }
                    else {
                        Logger.log(("Will not allow external access from domain: " + externalAccessDomain));
                    };
                }
                catch(e:Error) {
                };
            };
        }
        private function isValidDomain(_arg_1:String):Boolean
        {
            return (true);
            return (false); //dead code
        }
        public function keyExists(_arg_1:String):Boolean
        {
            var _local_2:String = (this._SafeStr_10848[_arg_1] as String);
            return (!((_local_2 == null)));
        }
        public function getKey(_arg_1:String, _arg_2:String="", _arg_3:Dictionary=null):String
        {
            var _local_4:String = (this._SafeStr_10848[_arg_1] as String);
            if (_local_4 == null){
                _local_4 = _arg_2;
            };
            if (_local_4 != null){
                if (_local_4.indexOf("%predefined%") > -1){
                    _local_4 = _local_4.replace("%predefined%", this._SafeStr_10849);
                    _local_4 = _local_4.replace("http://http://", "http://");
                };
            };
            if (_arg_3 != null){
                _local_4 = this.fillParams(_local_4, _arg_3);
            };
            return (_local_4);
        }
        public function setKey(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            if (_arg_4){
                if (this._SafeStr_10848[_arg_1] == null){
                    Logger.log(((_arg_1 + "=") + _arg_2));
                };
            };
            if ((((this._SafeStr_10850.indexOf(_arg_1) < 0)) || (_arg_3))){
                this._SafeStr_10848[_arg_1] = _arg_2;
            };
            if (_arg_3){
                this._SafeStr_10850.push(_arg_1);
            };
        }
        private function fillParams(_arg_1:String, _arg_2:Dictionary):String
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_3:int;
            while (_local_3 < 10) {
                _local_4 = _arg_1.indexOf(_SafeStr_10847);
                if (_local_4 < 0) break;
                _local_5 = _arg_1.indexOf(_SafeStr_10847, (_local_4 + 1));
                if (_local_5 < 0) break;
                _local_6 = _arg_1.substring((_local_4 + 1), _local_5);
                _local_7 = _arg_2[_local_6];
                _arg_1 = _arg_1.replace((("%" + _local_6) + "%"), _local_7);
                _local_3++;
            };
            return (_arg_1);
        }
        public function getBoolean(_arg_1:String, _arg_2:Boolean):Boolean
        {
            var _local_3:String = (this._SafeStr_10848[_arg_1] as String);
            if (_local_3 == null){
                return (_arg_2);
            };
            return ((((_local_3 == "1")) || ((_local_3.toLowerCase() == "true"))));
        }

    }
}//package com.sulake.habbo.configuration

// onConfigurationError = "_-2n1" (String#7021, DoABC#2)
// keyExists = "_-2ME" (String#6487, DoABC#2)
// _SafeStr_10847 = "_-1ja" (String#5746, DoABC#2)
// _SafeStr_10848 = "_-3IU" (String#22218, DoABC#2)
// _SafeStr_10849 = "_-1A6" (String#16861, DoABC#2)
// _SafeStr_10850 = "_-2aS" (String#20461, DoABC#2)
// parseConfiguration = "_-1LV" (String#17333, DoABC#2)
// onInitConfiguration = "_-2oA" (String#21009, DoABC#2)
// onInitConfigurationOverride = "_-T2" (String#23367, DoABC#2)
// onConfigurationOverrideError = "_-gL" (String#23908, DoABC#2)
// isValidDomain = "_-2Zp" (String#20433, DoABC#2)
// fillParams = "_-0Ij" (String#3929, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// TextAsset = "_-0HX" (String#14738, DoABC#2)
// HabboConfigurationFlags = "_-1Gp" (String#17144, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// logEventLog = "_-1qw" (String#18578, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// _SafeStr_6565 = "_-04l" (String#14230, DoABC#2)
// setKey = "_-0sz" (String#1567, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// _SafeStr_9855 = "_-0yb" (String#16378, DoABC#2)


