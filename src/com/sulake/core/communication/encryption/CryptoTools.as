
package com.sulake.core.communication.encryption
{
    import flash.utils.ByteArray;

    public class CryptoTools 
    {

        public static function byteArrayToString(_arg_1:ByteArray):String
        {
            _arg_1.position = 0;
            var _local_2:String = "";
            while (_arg_1.bytesAvailable) {
                _local_2 = (_local_2 + String.fromCharCode(_arg_1.readByte()));
            };
            return (_local_2);
        }
        public static function stringToByteArray(_arg_1:String):ByteArray
        {
            var _local_2:ByteArray = new ByteArray();
            var _local_3:int;
            while (_local_3 < _arg_1.length) {
                _local_2.writeByte(_arg_1.charCodeAt(_local_3));
                _local_3++;
            };
            _local_2.position = 0;
            return (_local_2);
        }
        public static function byteArrayToHexString(_arg_1:ByteArray, _arg_2:Boolean=false):String
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            _arg_1.position = 0;
            var _local_3:String = "";
            while (_arg_1.bytesAvailable) {
                _local_4 = _arg_1.readUnsignedByte();
                _local_5 = (_local_4 >> 4);
                _local_6 = (_local_4 & 15);
                _local_3 = (_local_3 + _local_5.toString(16));
                _local_3 = (_local_3 + _local_6.toString(16));
            };
            if (_arg_2){
                _local_3 = _local_3.toUpperCase();
            };
            return (_local_3);
        }
        public static function hexStringToByteArray(_arg_1:String):ByteArray
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_2:ByteArray = new ByteArray();
            if ((_arg_1.length % 2) != 0){
                _arg_1 = ("0" + _arg_1);
            };
            var _local_3:int;
            while (_local_3 < (_arg_1.length - 1)) {
                _local_4 = parseInt(_arg_1.charAt((_local_3 + 0)), 16);
                _local_5 = parseInt(_arg_1.charAt((_local_3 + 1)), 16);
                _local_6 = ((_local_4 << 4) | _local_5);
                _local_2.writeByte(_local_6);
                _local_3++;
                _local_3++;
            };
            return (_local_2);
        }
        public static function BigIntegerToRadix(_arg_1:ByteArray, _arg_2:uint=16):String
        {
            return ("");
        }

    }
}//package com.sulake.core.communication.encryption

// CryptoTools = "_-1UR" (String#17682, DoABC#2)
// byteArrayToHexString = "_-2jw" (String#20842, DoABC#2)
// stringToByteArray = "_-0A6" (String#14452, DoABC#2)
// byteArrayToString = "_-12-" (String#16537, DoABC#2)
// hexStringToByteArray = "_-0Rb" (String#15124, DoABC#2)
// BigIntegerToRadix = "_-0Qq" (String#15095, DoABC#2)


