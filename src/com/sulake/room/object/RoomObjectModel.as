
package com.sulake.room.object
{
    import flash.utils.Dictionary;

    public class RoomObjectModel implements IRoomObjectModelController 
    {

        private var _SafeStr_14407:Dictionary;
        private var _SafeStr_14408:Dictionary;
        private var _SafeStr_14409:Dictionary;
        private var _SafeStr_14410:Dictionary;
        private var _SafeStr_14411:Array;
        private var _SafeStr_14412:Array;
        private var _numberArrayReadOnlyList:Array;
        private var _stringArrayReadOnlyList:Array;
        private var _updateID:int;

        public function RoomObjectModel()
        {
            this._SafeStr_14407 = new Dictionary();
            this._SafeStr_14408 = new Dictionary();
            this._SafeStr_14409 = new Dictionary();
            this._SafeStr_14410 = new Dictionary();
            this._SafeStr_14411 = [];
            this._SafeStr_14412 = [];
            this._numberArrayReadOnlyList = [];
            this._stringArrayReadOnlyList = [];
            this._updateID = 0;
        }
        public function dispose():void
        {
            var _local_1:String;
            if (this._SafeStr_14407 != null){
                for (_local_1 in this._SafeStr_14407) {
                    delete this._SafeStr_14407[_local_1];
                };
                this._SafeStr_14407 = null;
            };
            if (this._SafeStr_14408 != null){
                for (_local_1 in this._SafeStr_14408) {
                    delete this._SafeStr_14408[_local_1];
                };
                this._SafeStr_14408 = null;
            };
            if (this._SafeStr_14409 != null){
                for (_local_1 in this._SafeStr_14409) {
                    delete this._SafeStr_14409[_local_1];
                };
                this._SafeStr_14409 = null;
            };
            if (this._SafeStr_14410 != null){
                for (_local_1 in this._SafeStr_14410) {
                    delete this._SafeStr_14410[_local_1];
                };
                this._SafeStr_14410 = null;
            };
            this._SafeStr_14412 = [];
            this._SafeStr_14411 = [];
            this._stringArrayReadOnlyList = [];
            this._numberArrayReadOnlyList = [];
        }
        public function getNumber(_arg_1:String):Number
        {
            return (this._SafeStr_14407[_arg_1]);
        }
        public function getString(_arg_1:String):String
        {
            return (this._SafeStr_14408[_arg_1]);
        }
        public function getNumberArray(_arg_1:String):Array
        {
            var _local_2:Array = this._SafeStr_14409[_arg_1];
            if (_local_2 != null){
                _local_2 = _local_2.slice();
            };
            return (_local_2);
        }
        public function getStringArray(_arg_1:String):Array
        {
            var _local_2:Array = this._SafeStr_14410[_arg_1];
            if (_local_2 != null){
                _local_2 = _local_2.slice();
            };
            return (_local_2);
        }
        public function setNumber(_arg_1:String, _arg_2:Number, _arg_3:Boolean=false):void
        {
            if (this._SafeStr_14411.indexOf(_arg_1) >= 0){
                return;
            };
            if (_arg_3){
                this._SafeStr_14411.push(_arg_1);
            };
            if (this._SafeStr_14407[_arg_1] != _arg_2){
                this._SafeStr_14407[_arg_1] = _arg_2;
                this._updateID++;
            };
        }
        public function setString(_arg_1:String, _arg_2:String, _arg_3:Boolean=false):void
        {
            if (this._SafeStr_14412.indexOf(_arg_1) >= 0){
                return;
            };
            if (_arg_3){
                this._SafeStr_14412.push(_arg_1);
            };
            if (this._SafeStr_14408[_arg_1] != _arg_2){
                this._SafeStr_14408[_arg_1] = _arg_2;
                this._updateID++;
            };
        }
        public function setNumberArray(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):void
        {
            if (_arg_2 == null){
                return;
            };
            if (this._numberArrayReadOnlyList.indexOf(_arg_1) >= 0){
                return;
            };
            if (_arg_3){
                this._numberArrayReadOnlyList.push(_arg_1);
            };
            var _local_4:Array = [];
            var _local_5:int;
            _local_5 = 0;
            while (_local_5 < _arg_2.length) {
                if ((_arg_2[_local_5] is Number)){
                    _local_4.push(_arg_2[_local_5]);
                };
                _local_5++;
            };
            var _local_6:Array = this._SafeStr_14409[_arg_1];
            var _local_7:Boolean = true;
            if (((!((_local_6 == null))) && ((_local_6.length == _local_4.length)))){
                _local_5 = (_local_4.length - 1);
                while (_local_5 >= 0) {
                    if ((_local_4[_local_5] as Number) != (_local_6[_local_5] as Number)){
                        _local_7 = false;
                        break;
                    };
                    _local_5--;
                };
            }
            else {
                _local_7 = false;
            };
            if (_local_7){
                return;
            };
            this._SafeStr_14409[_arg_1] = _local_4;
            this._updateID++;
        }
        public function setStringArray(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):void
        {
            if (_arg_2 == null){
                return;
            };
            if (this._stringArrayReadOnlyList.indexOf(_arg_1) >= 0){
                return;
            };
            if (_arg_3){
                this._stringArrayReadOnlyList.push(_arg_1);
            };
            var _local_4:Array = [];
            var _local_5:int;
            _local_5 = 0;
            while (_local_5 < _arg_2.length) {
                if ((_arg_2[_local_5] is String)){
                    _local_4.push(_arg_2[_local_5]);
                };
                _local_5++;
            };
            var _local_6:Array = this._SafeStr_14410[_arg_1];
            var _local_7:Boolean = true;
            if (((!((_local_6 == null))) && ((_local_6.length == _local_4.length)))){
                _local_5 = (_local_4.length - 1);
                while (_local_5 >= 0) {
                    if ((_local_4[_local_5] as String) != (_local_6[_local_5] as String)){
                        _local_7 = false;
                        break;
                    };
                    _local_5--;
                };
            }
            else {
                _local_7 = false;
            };
            if (_local_7){
                return;
            };
            this._SafeStr_14410[_arg_1] = _local_4;
            this._updateID++;
        }
        public function getUpdateID():int
        {
            return (this._updateID);
        }

    }
}//package com.sulake.room.object

// getStringArray = "_-1l3" (String#5767, DoABC#2)
// setStringArray = "_-1by" (String#5598, DoABC#2)
// _SafeStr_14407 = "_-0fZ" (String#4416, DoABC#2)
// _SafeStr_14408 = "_-1Kj" (String#5257, DoABC#2)
// _SafeStr_14409 = "_-2WN" (String#20299, DoABC#2)
// _SafeStr_14410 = "_-2Hl" (String#19716, DoABC#2)
// _SafeStr_14411 = "_-lX" (String#8634, DoABC#2)
// _SafeStr_14412 = "_-0O1" (String#4047, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)


