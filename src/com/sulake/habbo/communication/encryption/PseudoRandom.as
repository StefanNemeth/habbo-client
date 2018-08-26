
package com.sulake.habbo.communication.encryption
{
    public class PseudoRandom 
    {

        private static const _SafeStr_4628:int = 19979;
        private static const _SafeStr_4629:int = 5;

        private var seed:int;
        private var modulus:int;

        public function PseudoRandom(_arg_1:int, _arg_2:int):void
        {
            this.seed = _arg_1;
            this.modulus = _arg_2;
        }
        public function nextInt():int
        {
            var _local_1:int = (Math.abs(((_SafeStr_4628 * this.seed) + _SafeStr_4629)) % this.modulus);
            this.seed = _local_1;
            return (_local_1);
        }

    }
}//package com.sulake.habbo.communication.encryption

// PseudoRandom = "_-ji" (String#24023, DoABC#2)
// _SafeStr_4628 = "_-2x7" (String#21354, DoABC#2)
// _SafeStr_4629 = "_-Ku" (String#23040, DoABC#2)
// seed = "_-1iE" (String#5715, DoABC#2)
// modulus = "_-1sq" (String#5898, DoABC#2)
// nextInt = "_-0fc" (String#15656, DoABC#2)


