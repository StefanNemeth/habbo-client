
package com.sulake.habbo.room.object.visualization.room.utils
{
    public class Randomizer 
    {

        public static const _SafeStr_6579:int = 1;
        public static const _SafeStr_6580:int = 16777216;
        private static var _randomizer:Randomizer = null;

        private var _seed:int = 1;
        private var _modulus:int = 16777216;
        private var _SafeStr_6583:int = 69069;
        private var _SafeStr_6584:int = 5;

        public static function setSeed(_arg_1:int=1):void
        {
            if (_randomizer == null){
                _randomizer = new (Randomizer)();
            };
            _randomizer.seed = _arg_1;
        }
        public static function setModulus(_arg_1:int=16777216):void
        {
            if (_randomizer == null){
                _randomizer = new (Randomizer)();
            };
            _randomizer.modulus = _arg_1;
        }
        public static function Map(_arg_1:int, _arg_2:int, _arg_3:int):Array
        {
            if (_randomizer == null){
                _randomizer = new (Randomizer)();
            };
            return (_randomizer.getRandomValues(_arg_1, _arg_2, _arg_3));
        }
        public static function getArray(_arg_1:int, _arg_2:int):Array
        {
            if (_randomizer == null){
                _randomizer = new (Randomizer)();
            };
            return (_randomizer.getRandomArray(_arg_1, _arg_2));
        }

        public function set seed(_arg_1:int):void
        {
            this._seed = _arg_1;
        }
        public function set modulus(_arg_1:int):void
        {
            if (_arg_1 < 1){
                _arg_1 = 1;
            };
            this._modulus = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getRandomValues(_arg_1:int, _arg_2:int, _arg_3:int):Array
        {
            var _local_4:Array = [];
            var _local_5:int;
            while (_local_5 < _arg_1) {
                _local_4.push(this.iterateScaled(_arg_2, (_arg_3 - _arg_2)));
                _local_5++;
            };
            return (_local_4);
        }
        public function getRandomArray(_arg_1:int, _arg_2:int):Array
        {
            var _local_7:int;
            if ((((_arg_1 > _arg_2)) || ((_arg_2 > 1000)))){
                return (null);
            };
            var _local_3:Array = [];
            var _local_4:int;
            while (_local_4 <= _arg_2) {
                _local_3.push(_local_4);
                _local_4++;
            };
            var _local_5:Array = [];
            var _local_6:int;
            while (_local_6 < _arg_1) {
                _local_7 = this.iterateScaled(0, (_local_3.length - 1));
                _local_5.push(_local_3[_local_7]);
                _local_3.splice(_local_7, 1);
                _local_6++;
            };
            return (_local_5);
        }
        private function iterate():int
        {
            var _local_1:int = ((this._SafeStr_6583 * this._seed) + this._SafeStr_6584);
            if (_local_1 < 0){
                _local_1 = -(_local_1);
            };
            _local_1 = (_local_1 % this._modulus);
            this._seed = _local_1;
            return (_local_1);
        }
        private function iterateScaled(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = this.iterate();
            if (_arg_2 < 1){
                return (_arg_1);
            };
            return ((_arg_1 + ((_local_3 / this._modulus) * _arg_2)));
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.utils

// Randomizer = "_-FS" (String#7982, DoABC#2)
// seed = "_-1iE" (String#5715, DoABC#2)
// modulus = "_-1sq" (String#5898, DoABC#2)
// setSeed = "_-2fM" (String#20662, DoABC#2)
// Map = "_-2U9" (String#20205, DoABC#2)
// _SafeStr_6579 = "_-1RP" (String#17562, DoABC#2)
// _SafeStr_6580 = "_-ca" (String#23736, DoABC#2)
// _seed = "_-0vJ" (String#16249, DoABC#2)
// _modulus = "_-2gJ" (String#20703, DoABC#2)
// _SafeStr_6583 = "_-1Pk" (String#17497, DoABC#2)
// _SafeStr_6584 = "_-1Sr" (String#17617, DoABC#2)
// setModulus = "_-0Bw" (String#14524, DoABC#2)
// getRandomValues = "_-2LX" (String#19869, DoABC#2)
// getArray = "_-fJ" (String#23860, DoABC#2)
// getRandomArray = "_-0uP" (String#16216, DoABC#2)
// iterateScaled = "_-0tJ" (String#16172, DoABC#2)
// iterate = "_-0jn" (String#15819, DoABC#2)


