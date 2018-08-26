
package com.hurlant.math
{
    import com.hurlant.math.BigInteger;
    import com.hurlant.math.bi_internal;
    use namespace bi_internal;

    class BarrettReduction implements IReduction 
    {

        private var m:BigInteger;
        private var r2:BigInteger;
        private var q3:BigInteger;
        private var _SafeStr_8687:BigInteger;

        public function BarrettReduction(_arg_1:BigInteger)
        {
            this.r2 = new BigInteger();
            this.q3 = new BigInteger();
            BigInteger._SafeStr_8688.dlShiftTo((2 * _arg_1.t), this.r2);
            this._SafeStr_8687 = this.r2.divide(_arg_1);
            this.m = _arg_1;
        }
        public function revert(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1);
        }
        public function mulTo(_arg_1:BigInteger, _arg_2:BigInteger, _arg_3:BigInteger):void
        {
            _arg_1.multiplyTo(_arg_2, _arg_3);
            this.reduce(_arg_3);
        }
        public function sqrTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            _arg_1.squareTo(_arg_2);
            this.reduce(_arg_2);
        }
        public function convert(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger;
            if ((((_arg_1.s < 0)) || ((_arg_1.t > (2 * this.m.t))))){
                return (_arg_1.mod(this.m));
            };
            if (_arg_1.compareTo(this.m) < 0){
                return (_arg_1);
            };
            _local_2 = new BigInteger();
            _arg_1.copyTo(_local_2);
            this.reduce(_local_2);
            return (_local_2);
        }
        public function reduce(_arg_1:BigInteger):void
        {
            var _local_2:BigInteger = (_arg_1 as BigInteger);
            _local_2.drShiftTo((this.m.t - 1), this.r2);
            if (_local_2.t > (this.m.t + 1)){
                _local_2.t = (this.m.t + 1);
                _local_2.clamp();
            };
            this._SafeStr_8687.multiplyUpperTo(this.r2, (this.m.t + 1), this.q3);
            this.m.multiplyLowerTo(this.q3, (this.m.t + 1), this.r2);
            while (_local_2.compareTo(this.r2) < 0) {
                _local_2.dAddOffset(1, (this.m.t + 1));
            };
            _local_2.subTo(this.r2, _local_2);
            while (_local_2.compareTo(this.m) >= 0) {
                _local_2.subTo(this.m, _local_2);
            };
        }

    }
}//package com.hurlant.math

// IReduction = "_-0Nl" (String#4038, DoABC#2)
// BarrettReduction = "_-bu" (String#8453, DoABC#2)
// convert = "_-1Vy" (String#5472, DoABC#2)
// revert = "_-0zg" (String#4840, DoABC#2)
// reduce = "_-29l" (String#6246, DoABC#2)
// mulTo = "_-1bm" (String#5595, DoABC#2)
// sqrTo = "_-3Gd" (String#7640, DoABC#2)
// dlShiftTo = "_-2sf" (String#21187, DoABC#2)
// subTo = "_-tY" (String#24429, DoABC#2)
// clamp = "_-0g2" (String#15674, DoABC#2)
// drShiftTo = "_-1Ae" (String#16886, DoABC#2)
// squareTo = "_-0gT" (String#15691, DoABC#2)
// multiplyTo = "_-0M" (String#14913, DoABC#2)
// _SafeStr_8687 = "_-25O" (String#19234, DoABC#2)
// _SafeStr_8688 = "_-fA" (String#23853, DoABC#2)
// divide = "_-PO" (String#23221, DoABC#2)
// multiplyUpperTo = "_-ct" (String#23750, DoABC#2)
// multiplyLowerTo = "_-0Lj" (String#14902, DoABC#2)
// dAddOffset = "_-1Rp" (String#17575, DoABC#2)


