
package com.sulake.habbo.utils
{
    public class FixedSizeStack 
    {

        private var _data:Array;
        private var _SafeStr_4587:int = 0;
        private var _index:int = 0;

        public function FixedSizeStack(_arg_1:int)
        {
            this._data = [];
            super();
            this._SafeStr_4587 = _arg_1;
        }
        public function reset():void
        {
            this._data = [];
            this._index = 0;
        }
        public function addValue(_arg_1:int):void
        {
            if (this._data.length < this._SafeStr_4587){
                this._data.push(_arg_1);
            }
            else {
                this._data[this._index] = _arg_1;
            };
            this._index = ((this._index + 1) % this._SafeStr_4587);
        }
        public function getMax():int
        {
            var _local_1:int = int.MIN_VALUE;
            var _local_2:int;
            while (_local_2 < this._SafeStr_4587) {
                if (this._data[_local_2] > _local_1){
                    _local_1 = this._data[_local_2];
                };
                _local_2++;
            };
            return (_local_1);
        }
        public function getMin():int
        {
            var _local_1:int = int.MAX_VALUE;
            var _local_2:int;
            while (_local_2 < this._SafeStr_4587) {
                if (this._data[_local_2] < _local_1){
                    _local_1 = this._data[_local_2];
                };
                _local_2++;
            };
            return (_local_1);
        }

    }
}//package com.sulake.habbo.utils

// FixedSizeStack = "_-0Ks" (String#3972, DoABC#2)
// _SafeStr_4587 = "_-3Kf" (String#22310, DoABC#2)
// addValue = "_-0YF" (String#15367, DoABC#2)
// getMax = "_-pu" (String#24268, DoABC#2)
// getMin = "_-0Kn" (String#14871, DoABC#2)


