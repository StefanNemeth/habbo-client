
package com.hurlant.math
{
    public class NullReduction implements IReduction 
    {

        public function revert(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1);
        }
        public function mulTo(_arg_1:BigInteger, _arg_2:BigInteger, _arg_3:BigInteger):void
        {
            _arg_1.multiplyTo(_arg_2, _arg_3);
        }
        public function sqrTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            _arg_1.squareTo(_arg_2);
        }
        public function convert(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1);
        }
        public function reduce(_arg_1:BigInteger):void
        {
        }

    }
}//package com.hurlant.math

// IReduction = "_-0Nl" (String#4038, DoABC#2)
// NullReduction = "_-0p9" (String#4615, DoABC#2)
// convert = "_-1Vy" (String#5472, DoABC#2)
// revert = "_-0zg" (String#4840, DoABC#2)
// reduce = "_-29l" (String#6246, DoABC#2)
// mulTo = "_-1bm" (String#5595, DoABC#2)
// sqrTo = "_-3Gd" (String#7640, DoABC#2)
// squareTo = "_-0gT" (String#15691, DoABC#2)
// multiplyTo = "_-0M" (String#14913, DoABC#2)


