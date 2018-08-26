
package com.hurlant.math
{
    import com.hurlant.math.BigInteger;
    import com.hurlant.math.bi_internal;
    import com.hurlant.math.*;
    use namespace bi_internal;

    class MontgomeryReduction implements IReduction 
    {

        private var m:BigInteger;
        private var _SafeStr_8669:int;
        private var _SafeStr_8670:int;
        private var _SafeStr_8671:int;
        private var _SafeStr_8672:int;
        private var _SafeStr_8673:int;

        public function MontgomeryReduction(_arg_1:BigInteger)
        {
            this.m = _arg_1;
            this._SafeStr_8669 = _arg_1.invDigit();
            this._SafeStr_8670 = (this._SafeStr_8669 & 32767);
            this._SafeStr_8671 = (this._SafeStr_8669 >> 15);
            this._SafeStr_8672 = ((1 << (BigInteger._SafeStr_8675 - 15)) - 1);
            this._SafeStr_8673 = (2 * _arg_1.t);
        }
        public function convert(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            _arg_1.abs().dlShiftTo(this.m.t, _local_2);
            _local_2.divRemTo(this.m, null, _local_2);
            if ((((_arg_1.s < 0)) && ((_local_2.compareTo(BigInteger.0) > 0)))){
                this.m.subTo(_local_2, _local_2);
            };
            return (_local_2);
        }
        public function revert(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            _arg_1.copyTo(_local_2);
            this.reduce(_local_2);
            return (_local_2);
        }
        public function reduce(_arg_1:BigInteger):void
        {
            var _local_3:int;
            var _local_4:int;
            while (_arg_1.t <= this._SafeStr_8673) {
                var _local_5 = _arg_1.t++;
                _arg_1.a[_local_5] = 0;
            };
            var _local_2:int;
            while (_local_2 < this.m.t) {
                _local_3 = (_arg_1.a[_local_2] & 32767);
                _local_4 = (((_local_3 * this._SafeStr_8670) + ((((_local_3 * this._SafeStr_8671) + ((_arg_1.a[_local_2] >> 15) * this._SafeStr_8670)) & this._SafeStr_8672) << 15)) & BigInteger._SafeStr_8680);
                _local_3 = (_local_2 + this.m.t);
                _arg_1.a[_local_3] = (_arg_1.a[_local_3] + this.m.am(0, _local_4, _arg_1, _local_2, 0, this.m.t));
                while (_arg_1.a[_local_3] >= BigInteger._SafeStr_8682) {
                    _arg_1.a[_local_3] = (_arg_1.a[_local_3] - BigInteger._SafeStr_8682);
                    _local_5 = _arg_1.a;
                    var _local_6 = ++_local_3;
                    var _local_7 = (_local_5[_local_6] + 1);
                    _local_5[_local_6] = _local_7;
                };
                _local_2++;
            };
            _arg_1.clamp();
            _arg_1.drShiftTo(this.m.t, _arg_1);
            if (_arg_1.compareTo(this.m) >= 0){
                _arg_1.subTo(this.m, _arg_1);
            };
        }
        public function sqrTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            _arg_1.squareTo(_arg_2);
            this.reduce(_arg_2);
        }
        public function mulTo(_arg_1:BigInteger, _arg_2:BigInteger, _arg_3:BigInteger):void
        {
            _arg_1.multiplyTo(_arg_2, _arg_3);
            this.reduce(_arg_3);
        }

    }
}//package com.hurlant.math

// IReduction = "_-0Nl" (String#4038, DoABC#2)
// MontgomeryReduction = "_-aj" (String#8432, DoABC#2)
// convert = "_-1Vy" (String#5472, DoABC#2)
// revert = "_-0zg" (String#4840, DoABC#2)
// reduce = "_-29l" (String#6246, DoABC#2)
// mulTo = "_-1bm" (String#5595, DoABC#2)
// sqrTo = "_-3Gd" (String#7640, DoABC#2)
// _SafeStr_8669 = "_-1vI" (String#18769, DoABC#2)
// _SafeStr_8670 = "_-1xz" (String#18886, DoABC#2)
// _SafeStr_8671 = "_-rd" (String#24345, DoABC#2)
// _SafeStr_8672 = "_-R9" (String#23290, DoABC#2)
// _SafeStr_8673 = "_-My" (String#23123, DoABC#2)
// invDigit = "_-1ih" (String#18234, DoABC#2)
// _SafeStr_8675 = "_-1xv" (String#18883, DoABC#2)
// dlShiftTo = "_-2sf" (String#21187, DoABC#2)
// divRemTo = "_-1lB" (String#18338, DoABC#2)
// 0 = "_-1fe" (String#5657, DoABC#2)
// subTo = "_-tY" (String#24429, DoABC#2)
// _SafeStr_8680 = "_-k7" (String#24040, DoABC#2)
// am = "_-36t" (String#21760, DoABC#2)
// _SafeStr_8682 = "_-lz" (String#24109, DoABC#2)
// clamp = "_-0g2" (String#15674, DoABC#2)
// drShiftTo = "_-1Ae" (String#16886, DoABC#2)
// squareTo = "_-0gT" (String#15691, DoABC#2)
// multiplyTo = "_-0M" (String#14913, DoABC#2)


