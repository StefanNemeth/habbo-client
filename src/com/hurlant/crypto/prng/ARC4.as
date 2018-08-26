
package com.hurlant.crypto.prng
{
    import com.hurlant.crypto.symmetric.IStreamCipher;
    import flash.utils.ByteArray;
    import com.hurlant.util.Memory;

    public class ARC4 implements IPRNG, IStreamCipher 
    {

        private const psize:uint = 0x0100;

        private var i:int = 0;
        private var j:int = 0;
        private var S:ByteArray;

        public function ARC4(_arg_1:ByteArray=null)
        {
            this.S = new ByteArray();
            if (_arg_1){
                this.init(_arg_1);
            };
        }
        public function getPoolSize():uint
        {
            return (this.psize);
        }
        public function init(_arg_1:ByteArray):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            _local_2 = 0;
            while (_local_2 < 0x0100) {
                this.S[_local_2] = _local_2;
                _local_2++;
            };
            _local_3 = 0;
            _local_2 = 0;
            while (_local_2 < 0x0100) {
                _local_3 = (((_local_3 + this.S[_local_2]) + _arg_1[(_local_2 % _arg_1.length)]) & 0xFF);
                _local_4 = this.S[_local_2];
                this.S[_local_2] = this.S[_local_3];
                this.S[_local_3] = _local_4;
                _local_2++;
            };
            this.i = 0;
            this.j = 0;
        }
        public function next():uint
        {
            var _local_1:int;
            this.i = ((this.i + 1) & 0xFF);
            this.j = ((this.j + this.S[this.i]) & 0xFF);
            _local_1 = this.S[this.i];
            this.S[this.i] = this.S[this.j];
            this.S[this.j] = _local_1;
            return (this.S[((_local_1 + this.S[this.i]) & 0xFF)]);
        }
        public function getBlockSize():uint
        {
            return (1);
        }
        public function encrypt(_arg_1:ByteArray):void
        {
            var _local_2:uint;
            while (_local_2 < _arg_1.length) {
                var _local_3 = _local_2++;
                _arg_1[_local_3] = (_arg_1[_local_3] ^ this.next());
            };
        }
        public function decrypt(_arg_1:ByteArray):void
        {
            this.encrypt(_arg_1);
        }
        public function dispose():void
        {
            var _local_1:uint;
            if (this.S != null){
                _local_1 = 0;
                while (_local_1 < this.S.length) {
                    this.S[_local_1] = (Math.random() * 0x0100);
                    _local_1++;
                };
                this.S.length = 0;
                this.S = null;
            };
            this.i = 0;
            this.j = 0;
            Memory.gc();
        }
        public function toString():String
        {
            return ("rc4");
        }

    }
}//package com.hurlant.crypto.prng

// Memory = "_-2zI" (String#7273, DoABC#2)
// IPRNG = "_-28k" (String#6218, DoABC#2)
// IStreamCipher = "_-1BA" (String#5097, DoABC#2)
// ARC4 = "_-27q" (String#6198, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// encrypt = "_-0NA" (String#1460, DoABC#2)
// getBlockSize = "_-2Xy" (String#1896, DoABC#2)
// decrypt = "_-0j-" (String#1535, DoABC#2)
// getPoolSize = "_-1bA" (String#5580, DoABC#2)


