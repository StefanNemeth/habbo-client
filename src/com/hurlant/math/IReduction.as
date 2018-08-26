
package com.hurlant.math
{
    import com.hurlant.math.BigInteger;

    interface IReduction 
    {

        function convert(_arg_1:BigInteger):BigInteger;
        function revert(_arg_1:BigInteger):BigInteger;
        function reduce(_arg_1:BigInteger):void;
        function mulTo(_arg_1:BigInteger, _arg_2:BigInteger, _arg_3:BigInteger):void;
        function sqrTo(_arg_1:BigInteger, _arg_2:BigInteger):void;

    }
}//package com.hurlant.math

// IReduction = "_-0Nl" (String#4038, DoABC#2)
// convert = "_-1Vy" (String#5472, DoABC#2)
// revert = "_-0zg" (String#4840, DoABC#2)
// reduce = "_-29l" (String#6246, DoABC#2)
// mulTo = "_-1bm" (String#5595, DoABC#2)
// sqrTo = "_-3Gd" (String#7640, DoABC#2)


