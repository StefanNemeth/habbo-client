
package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.hurlant.math.BigInteger;
    import com.hurlant.util.Memory;
    import flash.utils.ByteArray;
    import com.hurlant.crypto.prng.Random;
    import com.sulake.habbo.communication.messages.outgoing.handshake.*;

    class RSAKey 
    {

        public var e:int;
        public var n:BigInteger;
        public var d:BigInteger;
        public var p:BigInteger;
        public var q:BigInteger;
        public var dmp1:BigInteger;
        public var _SafeStr_4609:BigInteger;
        public var _SafeStr_4610:BigInteger;
        protected var _SafeStr_4611:Boolean;
        protected var _SafeStr_4612:Boolean;

        public function RSAKey(_arg_1:BigInteger, _arg_2:int, _arg_3:BigInteger=null, _arg_4:BigInteger=null, _arg_5:BigInteger=null, _arg_6:BigInteger=null, _arg_7:BigInteger=null, _arg_8:BigInteger=null)
        {
            this.n = _arg_1;
            this.e = _arg_2;
            this.d = _arg_3;
            this.p = _arg_4;
            this.q = _arg_5;
            this.dmp1 = _arg_6;
            this._SafeStr_4609 = _arg_7;
            this._SafeStr_4610 = _arg_8;
            this._SafeStr_4612 = ((!((this.n == null))) && (!((this.e == 0))));
            this._SafeStr_4611 = ((this._SafeStr_4612) && (!((this.d == null))));
        }
        static function parsePublicKey(_arg_1:String, _arg_2:String):RSAKey
        {
            return (new (RSAKey)(new BigInteger(_arg_1, 16), parseInt(_arg_2, 16)));
        }

        function getBlockSize():uint
        {
            return (((this.n.bitLength() + 7) / 8));
        }
        public function dispose():void
        {
            this.e = 0;
            this.n.dispose();
            this.n = null;
            Memory.gc();
        }
        function encrypt(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint, _arg_4:Function=null):void
        {
            this._encrypt(this.doPublic, _arg_1, _arg_2, _arg_3, _arg_4, 2);
        }
        function decrypt(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint, _arg_4:Function=null):void
        {
            this._decrypt(this.doPrivate2, _arg_1, _arg_2, _arg_3, _arg_4, 2);
        }
        private function _encrypt(_arg_1:Function, _arg_2:ByteArray, _arg_3:ByteArray, _arg_4:uint, _arg_5:Function, _arg_6:int):void
        {
            var _local_9:BigInteger;
            var _local_10:BigInteger;
            if (_arg_5 == null){
                _arg_5 = this.pkcs1pad;
            };
            if (_arg_2.position >= _arg_2.length){
                _arg_2.position = 0;
            };
            var _local_7:uint = this.getBlockSize();
            var _local_8:int = (_arg_2.position + _arg_4);
            while (_arg_2.position < _local_8) {
                _local_9 = new BigInteger(_arg_5(_arg_2, _local_8, _local_7, _arg_6), _local_7);
                _local_10 = _arg_1(_local_9);
                _local_10.toArray(_arg_3);
            };
        }
        private function _decrypt(_arg_1:Function, _arg_2:ByteArray, _arg_3:ByteArray, _arg_4:uint, _arg_5:Function, _arg_6:int):void
        {
            var _local_9:BigInteger;
            var _local_10:BigInteger;
            var _local_11:ByteArray;
            if (_arg_5 == null){
                _arg_5 = this.pkcs1unpad;
            };
            if (_arg_2.position >= _arg_2.length){
                _arg_2.position = 0;
            };
            var _local_7:uint = this.getBlockSize();
            var _local_8:int = (_arg_2.position + _arg_4);
            while (_arg_2.position < _local_8) {
                _local_9 = new BigInteger(_arg_2, _arg_4);
                _local_10 = _arg_1(_local_9);
                _local_11 = _arg_5(_local_10, _local_7);
                _arg_3.writeBytes(_local_11);
            };
        }
        private function pkcs1pad(_arg_1:ByteArray, _arg_2:int, _arg_3:uint, _arg_4:uint=2):ByteArray
        {
            var _local_9:int;
            var _local_5:ByteArray = new ByteArray();
            var _local_6:uint = _arg_1.position;
            _arg_2 = Math.min(_arg_2, _arg_1.length, ((_local_6 + _arg_3) - 11));
            _arg_1.position = _arg_2;
            var _local_7:int = (_arg_2 - 1);
            while ((((_local_7 >= _local_6)) && ((_arg_3 > 11)))) {
                var _local_10 = --_arg_3;
                _local_5[_local_10] = _arg_1[_local_7--];
            };
            _local_10 = --_arg_3;
            _local_5[_local_10] = 0;
            var _local_8:Random = new Random();
            while (_arg_3 > 2) {
                _local_9 = 0;
                while (_local_9 == 0) {
                    _local_9 = (((_arg_4)==2) ? _local_8.nextByte() : 0xFF);
                };
                var _local_11 = --_arg_3;
                _local_5[_local_11] = _local_9;
            };
            _local_11 = --_arg_3;
            _local_5[_local_11] = _arg_4;
            var _local_12 = --_arg_3;
            _local_5[_local_12] = 0;
            return (_local_5);
        }
        private function pkcs1unpad(_arg_1:BigInteger, _arg_2:uint, _arg_3:uint=2):ByteArray
        {
            var _local_4:ByteArray = _arg_1.toByteArray();
            var _local_5:ByteArray = new ByteArray();
            _local_4.position = 0;
            var _local_6:int;
            while ((((_local_6 < _local_4.length)) && ((_local_4[_local_6] == 0)))) {
                _local_6++;
            };
            if (((!(((_local_4.length - _local_6) == (_arg_2 - 1)))) || ((_local_4[_local_6] > 2)))){
                return (null);
            };
            _local_6++;
            while (_local_4[_local_6] != 0) {
                if (++_local_6 >= _local_4.length){
                    return (null);
                };
            };
            while (++_local_6 < _local_4.length) {
                _local_5.writeByte(_local_4[_local_6]);
            };
            _local_5.position = 0;
            return (_local_5);
        }
        public function toString():String
        {
            return ("rsa");
        }
        private function doPublic(_arg_1:BigInteger):BigInteger
        {
            return (_arg_1.modPowInt(this.e, this.n));
        }
        private function doPrivate2(_arg_1:BigInteger):BigInteger
        {
            if ((((this.p == null)) && ((this.q == null)))){
                return (_arg_1.modPow(this.d, this.n));
            };
            var _local_2:BigInteger = _arg_1.mod(this.p).modPow(this.dmp1, this.p);
            var _local_3:BigInteger = _arg_1.mod(this.q).modPow(this._SafeStr_4609, this.q);
            while (_local_2.compareTo(_local_3) < 0) {
                _local_2 = _local_2.add(this.p);
            };
            return (_local_2.subtract(_local_3).multiply(this._SafeStr_4610).mod(this.p).multiply(this.q).add(_local_3));
        }
        protected function doPrivate(_arg_1:BigInteger):BigInteger
        {
            if ((((this.p == null)) || ((this.q == null)))){
                return (_arg_1.modPow(this.d, this.n));
            };
            var _local_2:BigInteger = _arg_1.mod(this.p).modPow(this.dmp1, this.p);
            var _local_3:BigInteger = _arg_1.mod(this.q).modPow(this._SafeStr_4609, this.q);
            while (_local_2.compareTo(_local_3) < 0) {
                _local_2 = _local_2.add(this.p);
            };
            return (_local_2.subtract(_local_3).multiply(this._SafeStr_4610).mod(this.p).multiply(this.q).add(_local_3));
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.handshake

// Memory = "_-2zI" (String#7273, DoABC#2)
// Random = "_-1wQ" (String#5965, DoABC#2)
// RSAKey = "_-0Iu" (String#3932, DoABC#2)
// toArray = "_-3BW" (String#21943, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// parsePublicKey = "_-360" (String#21729, DoABC#2)
// encrypt = "_-0NA" (String#1460, DoABC#2)
// _SafeStr_4609 = "_-0W8" (String#15284, DoABC#2)
// _SafeStr_4610 = "_-1TV" (String#17645, DoABC#2)
// _SafeStr_4611 = "_-0nD" (String#15945, DoABC#2)
// _SafeStr_4612 = "_-12N" (String#16553, DoABC#2)
// getBlockSize = "_-2Xy" (String#1896, DoABC#2)
// bitLength = "_-1xj" (String#18877, DoABC#2)
// _encrypt = "_-Oh" (String#23194, DoABC#2)
// doPublic = "_-0YS" (String#15377, DoABC#2)
// decrypt = "_-0j-" (String#1535, DoABC#2)
// _decrypt = "_-1-W" (String#16448, DoABC#2)
// doPrivate2 = "_-2cm" (String#20556, DoABC#2)
// pkcs1pad = "_-3E0" (String#22034, DoABC#2)
// pkcs1unpad = "_-26J" (String#19265, DoABC#2)
// nextByte = "_-17N" (String#16751, DoABC#2)
// toByteArray = "_-Iq" (String#22961, DoABC#2)
// modPowInt = "_-1ji" (String#18272, DoABC#2)
// modPow = "_-37A" (String#21775, DoABC#2)
// multiply = "_-1H4" (String#17155, DoABC#2)
// doPrivate = "_-1Vv" (String#17740, DoABC#2)


