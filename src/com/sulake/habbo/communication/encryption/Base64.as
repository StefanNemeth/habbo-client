
package com.sulake.habbo.communication.encryption
{
    import flash.utils.ByteArray;

    public class Base64 
    {

        public static const _SafeStr_4647:uint = 76;
        private static const _SafeStr_4641:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

        public static function encodeBytes(_arg_1:ByteArray, _arg_2:uint=76, _arg_3:Boolean=true):String
        {
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:int;
            var _local_9:uint;
            var _local_10:int;
            var _local_11:uint;
            var _local_12:uint;
            var _local_13:int;
            var _local_14:String;
            _arg_2 = Math.min(_arg_2, _SafeStr_4647);
            var _local_4:String = "";
            _arg_1.position = 0;
            while (_arg_1.bytesAvailable) {
                _local_5 = 0;
                _local_6 = 16;
                _local_7 = 0;
                _local_8 = 0;
                while (_local_8 < 3) {
                    if (_arg_1.bytesAvailable){
                        _local_11 = _arg_1.readUnsignedByte();
                        _local_5 = (_local_5 + (_local_11 << _local_6));
                    }
                    else {
                        _local_7++;
                    };
                    _local_6 = (_local_6 - 8);
                    _local_8++;
                };
                _local_6 = 18;
                _local_9 = (4 - _local_7);
                _local_10 = 0;
                while (_local_10 < _local_9) {
                    _local_12 = ((_local_5 >> _local_6) & 63);
                    _local_4 = (_local_4 + _SafeStr_4641.charAt(_local_12));
                    _local_6 = (_local_6 - 6);
                    _local_10++;
                };
                if ((((_local_7 > 0)) && (_arg_3))){
                    _local_13 = 0;
                    while (_local_13 < _local_7) {
                        _local_4 = (_local_4 + "=");
                        _local_13++;
                    };
                };
            };
            if (_arg_2 > 0){
                _local_14 = _local_4;
                _local_4 = "";
                while (_local_14.length > _arg_2) {
                    _local_4 = (_local_4 + (_local_14.substr(0, _arg_2) + "\n"));
                    _local_14 = _local_14.substr(_arg_2);
                };
                if (_local_14.length > 0){
                    _local_4 = (_local_4 + _local_14);
                };
            };
            return (_local_4);
        }
        public static function encode(_arg_1:String, _arg_2:uint=76, _arg_3:Boolean=true):String
        {
            _arg_2 = Math.min(_arg_2, _SafeStr_4647);
            var _local_4:String = "";
            var _local_5:ByteArray = new ByteArray();
            _local_5.writeMultiByte(_arg_1, "iso-8859-1");
            _local_5.position = 0;
            return (encodeBytes(_local_5, _arg_2, _arg_3));
        }
        public static function decode(_arg_1:String):String
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:int;
            var _local_8:int;
            var _local_9:uint;
            var _local_10:String;
            var _local_11:int;
            var _local_12:uint;
            _arg_1 = _arg_1.replace(/\s/g, "");
            var _local_2:String = "";
            var _local_3:int;
            while (_local_3 < _arg_1.length) {
                _local_4 = 0;
                _local_5 = 18;
                _local_6 = 0;
                _local_7 = 0;
                while (_local_7 < 4) {
                    _local_9 = (_local_3 + _local_7);
                    _local_10 = _arg_1.charAt(_local_9);
                    _local_11 = _SafeStr_4641.indexOf(_local_10);
                    if (_local_11 > -1){
                        _local_4 = (_local_4 + (_local_11 << _local_5));
                    }
                    else {
                        _local_6++;
                    };
                    _local_5 = (_local_5 - 6);
                    _local_7++;
                };
                _local_5 = 16;
                _local_8 = 0;
                while (_local_8 < (3 - _local_6)) {
                    _local_12 = ((_local_4 >> _local_5) & 0xFF);
                    _local_2 = (_local_2 + String.fromCharCode(_local_12));
                    _local_5 = (_local_5 - 8);
                    _local_8++;
                };
                _local_3 = (_local_3 + 3);
                _local_3++;
            };
            return (_local_2);
        }

    }
}//package com.sulake.habbo.communication.encryption

// Base64 = "_-Ak" (String#7882, DoABC#2)
// _SafeStr_4641 = "_-33X" (String#7376, DoABC#2)
// encodeBytes = "_-0wa" (String#16293, DoABC#2)
// _SafeStr_4647 = "_-Af" (String#22643, DoABC#2)
// encode = "_-31x" (String#7345, DoABC#2)
// decode = "_-1M7" (String#1666, DoABC#2)


