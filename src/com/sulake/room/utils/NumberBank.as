
package com.sulake.room.utils
{
    public class NumberBank 
    {

        private var _SafeStr_12740:int = 0;
        private var _SafeStr_14507:Array;
        private var _freeNumbers:Array;

        public function NumberBank(_arg_1:int)
        {
            this._SafeStr_14507 = [];
            this._freeNumbers = [];
            super();
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            var _local_2:int;
            while (_local_2 < _arg_1) {
                this._freeNumbers.push(_local_2);
                _local_2++;
            };
        }
        public function dispose():void
        {
            this._SafeStr_14507 = null;
            this._freeNumbers = null;
            this._SafeStr_12740 = 0;
        }
        public function reserveNumber():int
        {
            var _local_1:int;
            if (this._freeNumbers.length > 0){
                _local_1 = (this._freeNumbers.pop() as int);
                this._SafeStr_14507.push(_local_1);
                return (_local_1);
            };
            return (-1);
        }
        public function freeNumber(_arg_1:int):void
        {
            var _local_2:int = this._SafeStr_14507.indexOf(_arg_1);
            if (_local_2 >= 0){
                this._SafeStr_14507.splice(_local_2, 1);
                this._freeNumbers.push(_arg_1);
            };
        }

    }
}//package com.sulake.room.utils

// _SafeStr_12740 = "_-iM" (String#8564, DoABC#2)
// reserveNumber = "_-2zo" (String#21453, DoABC#2)
// freeNumber = "_-PP" (String#23222, DoABC#2)
// _SafeStr_14507 = "_-rx" (String#24360, DoABC#2)
// NumberBank = "_-28b" (String#19355, DoABC#2)


