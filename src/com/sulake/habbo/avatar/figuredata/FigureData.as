
package com.sulake.habbo.avatar.figuredata
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;

    public class FigureData implements IAvatarImageListener 
    {

        public static const M:String = "M";
        public static const FEMALE:String = "F";
        public static const U:String = "U";
        public static const _SafeStr_9963:String = "h";
        public static const _SafeStr_9964:String = "std";
        public static const 4:String = "4";
        public static const 0:String = "0";
        public static const _SafeStr_5401:String = "hd";
        public static const _SafeStr_6467:String = "hr";
        public static const _SafeStr_6468:String = "ha";
        public static const _SafeStr_6469:String = "he";
        public static const _SafeStr_6470:String = "ea";
        public static const _SafeStr_6471:String = "fa";
        public static const _SafeStr_6611:String = "cc";
        public static const _SafeStr_6612:String = "ch";
        public static const _SafeStr_6613:String = "ca";
        public static const CHEST_PRINTS:String = "cp";
        public static const _SafeStr_6463:String = "lg";
        public static const _SafeStr_6464:String = "sh";
        public static const _SafeStr_6465:String = "wa";

        private var _avatarEditor:HabboAvatarEditor;
        private var _view:FigureDataView;
        private var _data:Dictionary;
        private var _colors:Dictionary;
        private var _gender:String = "M";
        private var _disposed:Boolean;

        public function FigureData(_arg_1:HabboAvatarEditor)
        {
            this._avatarEditor = _arg_1;
            this._view = new FigureDataView(_arg_1.manager.windowManager, _arg_1.manager.assets);
        }
        public function loadAvatarData(_arg_1:String, _arg_2:String):void
        {
            this._data = new Dictionary();
            this._colors = new Dictionary();
            this._gender = _arg_2;
            this.parseFigureString(_arg_1);
            this.updateView();
        }
        public function dispose():void
        {
            this._avatarEditor = null;
            this._view = null;
            this._data = null;
            this._colors = null;
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        private function parseFigureString(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:String;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:int;
            if (_arg_1 == null){
                return;
            };
            for each (_local_2 in _arg_1.split(".")) {
                _local_3 = _local_2.split("-");
                if (_local_3.length > 0){
                    _local_4 = String(_local_3[0]);
                    _local_5 = parseInt(_local_3[1]);
                    _local_6 = new Array();
                    _local_7 = 2;
                    while (_local_7 < _local_3.length) {
                        _local_6.push(_local_3[_local_7]);
                        _local_7++;
                    };
                    if (_local_6.length == 0){
                        _local_6.push(0);
                    };
                    this.savePartSetId(_local_4, _local_5, false);
                    this.savePartSetColourId(_local_4, _local_6, false);
                };
            };
        }
        public function getPartSetId(_arg_1:String):int
        {
            if (this._data[_arg_1] != null){
                return (this._data[_arg_1]);
            };
            return (-1);
        }
        public function getColourIds(_arg_1:String):Array
        {
            if (this._colors[_arg_1] != null){
                return (this._colors[_arg_1]);
            };
            return ([this._avatarEditor.getDefaultColour(_arg_1)]);
        }
        public function getFigureString():String
        {
            var _local_3:String;
            var _local_4:int;
            var _local_5:String;
            var _local_6:Array;
            var _local_7:String;
            var _local_8:int;
            var _local_1:String = "";
            var _local_2:Array = [];
            for (_local_3 in this._data) {
                if (this._data[_local_3] != null){
                    _local_5 = this._data[_local_3];
                    _local_6 = (this._colors[_local_3] as Array);
                    _local_7 = ((_local_3 + "-") + _local_5);
                    if (_local_6){
                        _local_8 = 0;
                        while (_local_8 < _local_6.length) {
                            _local_7 = (_local_7 + ("-" + _local_6[_local_8]));
                            _local_8++;
                        };
                    };
                    _local_2.push(_local_7);
                };
            };
            _local_4 = 0;
            while (_local_4 < _local_2.length) {
                _local_1 = (_local_1 + _local_2[_local_4]);
                if (_local_4 < (_local_2.length - 1)){
                    _local_1 = (_local_1 + ".");
                };
                _local_4++;
            };
            return (_local_1);
        }
        public function savePartData(_arg_1:String, _arg_2:int, _arg_3:Array, _arg_4:Boolean=false):void
        {
            this.savePartSetId(_arg_1, _arg_2, _arg_4);
            this.savePartSetColourId(_arg_1, _arg_3, _arg_4);
        }
        private function savePartSetId(_arg_1:String, _arg_2:int, _arg_3:Boolean=true):void
        {
            switch (_arg_1){
                case _SafeStr_5401:
                case _SafeStr_6467:
                case _SafeStr_6468:
                case _SafeStr_6469:
                case _SafeStr_6470:
                case _SafeStr_6471:
                case _SafeStr_6612:
                case _SafeStr_6611:
                case _SafeStr_6613:
                case CHEST_PRINTS:
                case _SafeStr_6463:
                case _SafeStr_6464:
                case _SafeStr_6465:
                    if (_arg_2 >= 0){
                        this._data[_arg_1] = _arg_2;
                    }
                    else {
                        delete this._data[_arg_1];
                    };
                    break;
                default:
                    Logger.log(((("[FigureData] Unknown partset: " + _arg_1) + ", can not store id: ") + _arg_2));
            };
            if (_arg_3){
                this.updateView();
            };
        }
        public function savePartSetColourId(_arg_1:String, _arg_2:Array, _arg_3:Boolean=true):void
        {
            switch (_arg_1){
                case _SafeStr_5401:
                case _SafeStr_6467:
                case _SafeStr_6468:
                case _SafeStr_6469:
                case _SafeStr_6470:
                case _SafeStr_6471:
                case _SafeStr_6612:
                case _SafeStr_6611:
                case _SafeStr_6613:
                case CHEST_PRINTS:
                case _SafeStr_6463:
                case _SafeStr_6464:
                case _SafeStr_6465:
                    this._colors[_arg_1] = _arg_2;
                    break;
                default:
                    Logger.log((("[FigureData] Unknown partset: " + _arg_1) + ", can not store color-ids"));
            };
            if (_arg_3){
                this.updateView();
            };
        }
        public function getFigureStringWithFace(_arg_1:int):String
        {
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Array;
            var _local_9:String;
            var _local_10:int;
            var _local_2:Array = [];
            _local_2.push(_SafeStr_5401);
            var _local_3:String = "";
            var _local_4:Array = [];
            for each (_local_5 in _local_2) {
                if (this._colors[_local_5] != null){
                    _local_7 = this._data[_local_5];
                    _local_8 = (this._colors[_local_5] as Array);
                    if (_local_5 == _SafeStr_5401){
                        _local_7 = _arg_1;
                    };
                    _local_9 = ((_local_5 + "-") + _local_7);
                    if (_local_7 >= 0){
                        _local_10 = 0;
                        while (_local_10 < _local_8.length) {
                            _local_9 = (_local_9 + ("-" + _local_8[_local_10]));
                            _local_10++;
                        };
                    };
                    _local_4.push(_local_9);
                };
            };
            _local_6 = 0;
            while (_local_6 < _local_4.length) {
                _local_3 = (_local_3 + _local_4[_local_6]);
                if (_local_6 < (_local_4.length - 1)){
                    _local_3 = (_local_3 + ".");
                };
                _local_6++;
            };
            return (_local_3);
        }
        public function updateView():void
        {
            var _local_3:BitmapData;
            var _local_4:BitmapData;
            var _local_1:String = this.getFigureString();
            var _local_2:IAvatarImage = this._avatarEditor.manager.avatarRenderManager.createAvatarImage(_local_1, AvatarScaleType._SafeStr_4336, this.gender, this);
            if (_local_2){
                _local_2.setDirection(AvatarSetType._SafeStr_4457, int(4));
                _local_3 = _local_2.getImage(AvatarSetType._SafeStr_4457, true);
                this._view.udpate(_local_3);
                _local_2.dispose();
            }
            else {
                Logger.log("Unable to create avatar image for the preview in avatar editor!");
                _local_4 = new BitmapData(1, 1);
                this._view.udpate(_local_4);
            };
        }
        public function get view():FigureDataView
        {
            return (this._view);
        }
        public function get gender():String
        {
            return (this._gender);
        }
        public function avatarImageReady(_arg_1:String):void
        {
            this.updateView();
        }

    }
}//package com.sulake.habbo.avatar.figuredata

// U = "_-2LT" (String#19866, DoABC#2)
// _avatarEditor = "_-28H" (String#1820, DoABC#2)
// loadAvatarData = "_-DD" (String#22738, DoABC#2)
// parseFigureString = "_-tr" (String#8765, DoABC#2)
// savePartSetId = "_-0lZ" (String#15883, DoABC#2)
// getDefaultColour = "_-1PO" (String#17483, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// getImage = "_-eg" (String#2150, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// _SafeStr_5401 = "_-06A" (String#14290, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// _SafeStr_6463 = "_-0JA" (String#14807, DoABC#2)
// _SafeStr_6464 = "_-2cW" (String#20545, DoABC#2)
// _SafeStr_6465 = "_-0Z2" (String#15404, DoABC#2)
// _SafeStr_6467 = "_-3o" (String#22367, DoABC#2)
// _SafeStr_6468 = "_-1Pm" (String#17499, DoABC#2)
// _SafeStr_6469 = "_-2xX" (String#21374, DoABC#2)
// _SafeStr_6470 = "_-2IJ" (String#19739, DoABC#2)
// _SafeStr_6471 = "_-2o2" (String#21003, DoABC#2)
// _SafeStr_6611 = "_-1bM" (String#17951, DoABC#2)
// _SafeStr_6612 = "_-0AK" (String#14460, DoABC#2)
// _SafeStr_6613 = "_-Os" (String#23200, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// 0 = "_-2pg" (String#21067, DoABC#2)
// 4 = "_-2P4" (String#20005, DoABC#2)
// getFigureString = "_-0-z" (String#3563, DoABC#2)
// udpate = "_-Rw" (String#23322, DoABC#2)
// savePartData = "_-15W" (String#16676, DoABC#2)
// _SafeStr_9963 = "_-u2" (String#24451, DoABC#2)
// _SafeStr_9964 = "_-1Rs" (String#17577, DoABC#2)


