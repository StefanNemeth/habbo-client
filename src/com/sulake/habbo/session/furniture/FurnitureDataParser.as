
package com.sulake.habbo.session.furniture
{
    import flash.events.EventDispatcher;
    import com.sulake.core.utils.Map;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.AssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;
    import com.sulake.habbo.utils.HabboWebTools;

    public class FurnitureDataParser extends EventDispatcher 
    {

        public static const _localization:String = "ready";

        private var _SafeStr_8133:Map;
        private var _wallItems:Map;
        private var _SafeStr_8134:Map;
        private var _localization:ICoreLocalizationManager;
        private var _SafeStr_5255:AssetLibrary;

        public function FurnitureDataParser(_arg_1:Map, _arg_2:Map, _arg_3:Map, _arg_4:ICoreLocalizationManager)
        {
            this._SafeStr_8133 = _arg_1;
            this._wallItems = _arg_2;
            this._SafeStr_8134 = _arg_3;
            this._localization = _arg_4;
            this._SafeStr_5255 = new AssetLibrary("FurniDataParserAssetLib");
        }
        public function dispose():void
        {
            if (this._SafeStr_5255){
                this._SafeStr_5255.dispose();
                this._SafeStr_5255 = null;
            };
            this._localization = null;
            this._SafeStr_8133 = null;
            this._wallItems = null;
            this._SafeStr_8134 = null;
        }
        public function loadData(_arg_1:String):void
        {
            var _local_2:AssetLoaderStruct = this._SafeStr_5255.loadAssetFromFile(_arg_1, new URLRequest(_arg_1), "text/plain");
            _local_2.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.parseFurnitureData);
            _local_2.addEventListener(AssetLoaderEvent._SafeStr_4221, this.furnitureDataError);
        }
        private function parseFurnitureData(_arg_1:AssetLoaderEvent):void
        {
            var _local_10:String;
            var _local_11:Array;
            var _local_12:String;
            var _local_13:Array;
            var _local_14:String;
            var _local_15:int;
            var _local_16:Array;
            var _local_17:String;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:Array;
            var _local_24:Array;
            var _local_25:int;
            var _local_26:String;
            var _local_27:String;
            var _local_28:String;
            var _local_29:int;
            var _local_30:int;
            var _local_31:FurnitureData;
            var _local_32:Array;
            var _local_33:String;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null){
                return;
            };
            if ((((_local_2.assetLoader == null)) || ((_local_2.assetLoader.content == null)))){
                return;
            };
            var _local_3:String = (_local_2.assetLoader.content as String);
            var _local_4:Array = new Array();
            var _local_5:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _local_6:RegExp = /^\s+|\s+$/g;
            var _local_7:RegExp = /\[+?((.)*?)\]/g;
            var _local_8:Array = _local_3.split(_local_5);
            var _local_9:int;
            for each (_local_10 in _local_8) {
                _local_11 = _local_10.match(_local_7);
                for each (_local_12 in _local_11) {
                    _local_12 = _local_12.replace(/\[{1,}/mg, "");
                    _local_12 = _local_12.replace(/\]{1,}/mg, "");
                    _local_13 = _local_12.split('"');
                    this.removePatternFrom(_local_13, ", ");
                    this.removePatternFrom(_local_13, ",");
                    _local_13.splice(0, 1);
                    _local_13.splice((_local_13.length - 1), 1);
                    _local_14 = _local_13[0];
                    _local_15 = parseInt(_local_13[1]);
                    _local_16 = String(_local_13[2]).split("*");
                    _local_17 = _local_16[0];
                    _local_18 = 0;
                    if (_local_16.length > 1){
                        _local_18 = parseInt(_local_16[1]);
                    };
                    _local_19 = parseInt(_local_13[3]);
                    _local_20 = parseInt(_local_13[4]);
                    _local_21 = parseInt(_local_13[5]);
                    _local_22 = parseInt(_local_13[6]);
                    _local_23 = new Array();
                    _local_24 = _local_13[7].split(",");
                    _local_25 = 0;
                    while (_local_25 < _local_24.length) {
                        _local_33 = _local_24[_local_25];
                        if (_local_33.charAt(0) == "#"){
                            _local_33 = _local_33.replace("#", "");
                            _local_23.push(parseInt(_local_33, 16));
                        }
                        else {
                            _local_23.push(-(parseInt(_local_33)));
                        };
                        _local_25++;
                    };
                    _local_26 = _local_13[8];
                    _local_27 = _local_13[9];
                    _local_28 = _local_13[10];
                    _local_29 = parseInt(_local_13[11]);
                    _local_30 = parseInt(_local_13[12]);
                    if (this._localization != null){
                        if (_local_14 == "s"){
                            this._localization.updateKey(("roomItem.name." + _local_15), _local_26);
                            this._localization.updateKey(("roomItem.desc." + _local_15), _local_27);
                        }
                        else {
                            if (_local_14 == "i"){
                                this._localization.updateKey(("wallItem.name." + _local_15), _local_26);
                                this._localization.updateKey(("wallItem.desc." + _local_15), _local_27);
                            };
                        };
                    };
                    _local_31 = new FurnitureData(_local_14, _local_15, _local_17, _local_18, _local_19, _local_20, _local_21, _local_22, _local_23, _local_26, _local_27, _local_28, _local_29, _local_30);
                    if (_local_14 == "s"){
                        this._SafeStr_8133.add(_local_15, _local_31);
                    }
                    else {
                        if (_local_14 == "i"){
                            this._wallItems.add(_local_15, _local_31);
                        };
                    };
                    _local_32 = this._SafeStr_8134[_local_17];
                    if (_local_32 == null){
                        _local_32 = [];
                        this._SafeStr_8134.add(_local_17, _local_32);
                    };
                    _local_32[_local_18] = _local_15;
                };
                _local_9++;
            };
            dispatchEvent(new Event(_localization));
        }
        private function furnitureDataError(_arg_1:AssetLoaderEvent):void
        {
            HabboWebTools.logEventLog(("furnituredata download error " + _arg_1.status));
        }
        public function registerFurnitureLocalizations():void
        {
            var _local_1:FurnitureData;
            if (!this._localization){
                return;
            };
            for each (_local_1 in this._SafeStr_8133.getValues()) {
                this._localization.updateKey(("roomItem.name." + _local_1.id), _local_1.title);
                this._localization.updateKey(("roomItem.desc." + _local_1.id), _local_1.description);
            };
            for each (_local_1 in this._wallItems.getValues()) {
                this._localization.updateKey(("wallItem.name." + _local_1.id), _local_1.title);
                this._localization.updateKey(("wallItem.desc." + _local_1.id), _local_1.description);
            };
        }
        private function removePatternFrom(_arg_1:Array, _arg_2:Object):void
        {
            var _local_3:int;
            while (_local_3 < _arg_1.length) {
                if (_arg_1[_local_3] == _arg_2){
                    _arg_1.splice(_local_3, 1);
                    _local_3--;
                };
                _local_3++;
            };
        }
        public function set localization(_arg_1:ICoreLocalizationManager):void
        {
            this._localization = _arg_1;
        }

    }
}//package com.sulake.habbo.session.furniture

// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// FurnitureDataParser = "_-06k" (String#14315, DoABC#2)
// FurnitureData = "_-sW" (String#2211, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// logEventLog = "_-1qw" (String#18578, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// _localization = "_-1" (String#16427, DoABC#2)
// _SafeStr_5255 = "_-U9" (String#2115, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// _SafeStr_8133 = "_-0VO" (String#4213, DoABC#2)
// _SafeStr_8134 = "_-kR" (String#24050, DoABC#2)
// loadData = "_-lE" (String#24078, DoABC#2)
// parseFurnitureData = "_-1km" (String#18321, DoABC#2)
// furnitureDataError = "_-2ub" (String#21263, DoABC#2)
// removePatternFrom = "_-0V4" (String#15244, DoABC#2)
// updateKey = "_-1LP" (String#5269, DoABC#2)
// registerFurnitureLocalizations = "_-2pu" (String#21078, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


