
package com.sulake.habbo.communication.encryption
{
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.encryption.CryptoTools;
    import flash.utils.ByteArray;

    public class RC4_R27 extends _SafeStr_1870 implements IEncryption 
    {

        private static const WEDGIE_BYTE_MASK:uint = 64;
        private static const _SafeStr_4639:String = "mWxFRJnGJ5T9Si0OMVvEBBm8laihXkN8GmH6fuv7ldZhLyGRRKCcGzziPYBaJom";
        private static const _SafeStr_4640:int = 52;
        private static const PREMIX_STRING:String = "NV6VVFPoC7FLDlzDUri3qcOAg9cRoFOmsYR9ffDGy5P8HfF6eekX40SFSVfJ1mDb3lcpYRqdg28sp61eHkPukKbqTu1JsVEKiRavi04YtSzUsLXaYSa5BEGwg5G2OF";
        private static const _SafeStr_4641:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

        private var _SafeStr_4642:IEncryption;
        private var _SafeStr_4643:PseudoRandom;

        public function RC4_R27(_arg_1:IEncryption, _arg_2:PseudoRandom)
        {
            this._SafeStr_4642 = _arg_1;
            this._SafeStr_4643 = _arg_2;
        }
        public static function getEncodedSize(_arg_1:int):int
        {
            var _local_2:int = (_arg_1 % 3);
            switch (_local_2){
                case 0:
                    return (((_arg_1 / 3) * 4));
                case 1:
                    return (((((_arg_1 - 1) / 3) * 4) + 2));
                case 2:
                    return (((((_arg_1 - 2) / 3) * 4) + 3));
            };
            return (0);
        }
        public static function getDecodedSize(_arg_1:int):int
        {
            var _local_2:int = (_arg_1 % 4);
            switch (_local_2){
                case 0:
                    return (((_arg_1 / 4) * 3));
                case 2:
                    return (((((_arg_1 - 2) / 4) * 3) + 1));
                case 3:
                    return (((((_arg_1 - 3) / 4) * 3) + 2));
            };
            return (0);
        }

        override public function init(_arg_1:ByteArray):void
        {
            var _local_2:int;
            var _local_3:ByteArray = CryptoTools.stringToByteArray(_SafeStr_4639);
            var _local_4:int;
            while (_local_4 < _arg_1.length) {
                _arg_1[_local_4] = (_arg_1[_local_4] ^ _local_3[_local_2]);
                _local_2 = (((_local_2)>=(_local_3.length - 1)) ? 0 : (_local_2 + 1));
                _local_4++;
            };
            super.init(_arg_1);
            var _local_5:ByteArray = CryptoTools.stringToByteArray(PREMIX_STRING);
            var _local_6:int;
            while (_local_6 < _SafeStr_4640) {
                super.encipher(_local_5, true);
                _local_6++;
            };
        }
        override public function encipher(_arg_1:ByteArray, _arg_2:Boolean=false):ByteArray
        {
            var _local_3:ByteArray;
            var _local_4:String;
            var _local_5:ByteArray;
            var _local_6:int;
            var _local_7:ByteArray;
            var _local_8:ByteArray;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            if (this._SafeStr_4642 != null){
                _local_7 = new ByteArray();
                _local_8 = new ByteArray();
                _local_6 = (this._SafeStr_4643.nextInt() % 5);
                _local_9 = (_arg_1.length - 3);
                _local_10 = (_local_6 + _local_9);
                _local_11 = RC4_R27.getEncodedSize(_local_10);
                _local_7.writeByte(Math.floor((Math.random() * 0xFF)));
                _local_7.writeByte((WEDGIE_BYTE_MASK | ((_local_11 >> 12) & 63)));
                _local_7.writeByte((WEDGIE_BYTE_MASK | ((_local_11 >> 6) & 63)));
                _local_7.writeByte((WEDGIE_BYTE_MASK | (63 & _local_11)));
                _local_5 = this._SafeStr_4642.encipher(_local_7, true);
                while (_local_8.length < _local_6) {
                    _local_8.writeByte(Math.floor((Math.random() * 0xFF)));
                };
                _local_8.position = _local_6;
                _local_8.writeBytes(_arg_1, 3);
                _local_3 = super.encipher(_local_8, true);
                _local_4 = Base64.encodeBytes(_local_3, 0, false);
                _local_5.position = _local_5.length;
                _local_5.writeBytes(CryptoTools.stringToByteArray(_local_4));
            }
            else {
                _local_3 = super.encipher(_arg_1, true);
                _local_4 = Base64.encodeBytes(_local_3, 0, false);
                _local_5 = CryptoTools.stringToByteArray(_local_4);
            };
            return (_local_5);
        }
        override protected function customHackScramble(_arg_1:Array, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            if ((_arg_2 & 63) == 63){
                _local_4 = (((_arg_2 + 67) * 297) & 0xFF);
                _local_5 = ((_arg_3 + _arg_1[_local_4]) & 0xFF);
                _local_6 = _arg_1[_local_4];
                _arg_1[_local_4] = _arg_1[_local_5];
                _arg_1[_local_5] = _local_6;
            };
        }

    }
}//package com.sulake.habbo.communication.encryption

// IEncryption = "_-0kE" (String#4505, DoABC#2)
// PseudoRandom = "_-ji" (String#24023, DoABC#2)
// _SafeStr_1870 = "function" (String#9520, DoABC#2)
// RC4_R27 = "_-1bx" (String#17969, DoABC#2)
// CryptoTools = "_-1UR" (String#17682, DoABC#2)
// Base64 = "_-Ak" (String#7882, DoABC#2)
// nextInt = "_-0fc" (String#15656, DoABC#2)
// encipher = "_-15G" (String#4982, DoABC#2)
// customHackScramble = "_-0Dn" (String#3822, DoABC#2)
// _SafeStr_4639 = "_-2FV" (String#19623, DoABC#2)
// _SafeStr_4640 = "_-aJ" (String#23645, DoABC#2)
// _SafeStr_4641 = "_-33X" (String#7376, DoABC#2)
// _SafeStr_4642 = "_-1pN" (String#18518, DoABC#2)
// _SafeStr_4643 = "_-YQ" (String#23577, DoABC#2)
// getDecodedSize = "_-0Dl" (String#14598, DoABC#2)
// stringToByteArray = "_-0A6" (String#14452, DoABC#2)
// encodeBytes = "_-0wa" (String#16293, DoABC#2)


