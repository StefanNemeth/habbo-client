
package com.sulake.habbo.communication.encryption
{
    import com.sulake.core.communication.handshake.IKeyExchange;
    import com.hurlant.math.BigInteger;
    import com.sulake.core.utils.ErrorReportStorage;

    public class DiffieHellman implements IKeyExchange 
    {

        private var _SafeStr_4650:BigInteger;
        private var _SafeStr_4605:BigInteger;
        private var _SafeStr_4651:BigInteger;
        private var _SafeStr_4652:BigInteger;
        private var _SafeStr_4653:BigInteger;
        private var _SafeStr_4654:BigInteger;

        public function DiffieHellman(_arg_1:BigInteger, _arg_2:BigInteger)
        {
            this._SafeStr_4653 = _arg_1;
            this._SafeStr_4654 = _arg_2;
        }
        public function init(_arg_1:String, _arg_2:uint=16):Boolean
        {
            ErrorReportStorage.addDebugData("DiffieHellman", ((((("Prime: " + this._SafeStr_4653.toString()) + ",generator: ") + this._SafeStr_4654.toString()) + ",secret: ") + _arg_1));
            this._SafeStr_4650 = new BigInteger();
            this._SafeStr_4650.fromRadix(_arg_1, _arg_2);
            this._SafeStr_4605 = this._SafeStr_4654.modPow(this._SafeStr_4650, this._SafeStr_4653);
            return (true);
        }
        public function generateSharedKey(_arg_1:String, _arg_2:uint=16):String
        {
            this._SafeStr_4651 = new BigInteger();
            this._SafeStr_4651.fromRadix(_arg_1, _arg_2);
            this._SafeStr_4652 = this._SafeStr_4651.modPow(this._SafeStr_4650, this._SafeStr_4653);
            return (this.getSharedKey(_arg_2));
        }
        public function getPublicKey(_arg_1:uint=16):String
        {
            return (this._SafeStr_4605.toRadix(_arg_1));
        }
        public function getSharedKey(_arg_1:uint=16):String
        {
            return (this._SafeStr_4652.toRadix(_arg_1));
        }

    }
}//package com.sulake.habbo.communication.encryption

// IKeyExchange = "_-26Q" (String#6174, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// generateSharedKey = "_-3D7" (String#7578, DoABC#2)
// getSharedKey = "_-1-f" (String#4862, DoABC#2)
// getPublicKey = "_-0XQ" (String#4257, DoABC#2)
// _SafeStr_4605 = "_-kS" (String#8611, DoABC#2)
// modPow = "_-37A" (String#21775, DoABC#2)
// _SafeStr_4650 = "_-16X" (String#5004, DoABC#2)
// _SafeStr_4651 = "_-3-W" (String#21482, DoABC#2)
// _SafeStr_4652 = "_-29T" (String#19383, DoABC#2)
// _SafeStr_4653 = "_-0rY" (String#16104, DoABC#2)
// _SafeStr_4654 = "_-oo" (String#24229, DoABC#2)
// fromRadix = "_-2e9" (String#20609, DoABC#2)
// toRadix = "_-Yu" (String#23596, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)


