
package com.sulake.habbo.communication.encryption
{
    import com.sulake.core.communication.encryption.IEncryption;
    import flash.utils.ByteArray;

    public class _SafeStr_1870 implements IEncryption 
    {

        private var i:uint = 0;
        private var j:uint = 0;
        private var _SafeStr_4633:Array;

        public function _SafeStr_1870()
        {
            this._SafeStr_4633 = new Array(0x0100);
        }
        public function init(_arg_1:ByteArray):void
        {
            var _local_2:uint = _arg_1.length;
            this.i = 0;
            while (this.i < 0x0100) {
                this._SafeStr_4633[this.i] = this.i;
                this.i++;
            };
            this.j = 0;
            this.i = 0;
            while (this.i < 0x0100) {
                this.j = (((this.j + this._SafeStr_4633[this.i]) + _arg_1[(this.i % _local_2)]) % 0x0100);
                this.swap(this.i, this.j);
                this.i++;
            };
            this.i = 0;
            this.j = 0;
        }
        public function initFromState(_arg_1:IEncryption):void
        {
            var _local_2:_SafeStr_1870 = (_arg_1 as _SafeStr_1870);
            this._SafeStr_4633 = _local_2._SafeStr_4633.concat();
            this.i = _local_2.i;
            this.j = _local_2.j;
        }
        public function encipher(_arg_1:ByteArray, _arg_2:Boolean=false):ByteArray
        {
            var _local_4:uint;
            var _local_3:ByteArray = new ByteArray();
            _arg_1.position = 0;
            while (_arg_1.bytesAvailable) {
                this.i = ((this.i + 1) % 0x0100);
                this.j = ((this.j + this._SafeStr_4633[this.i]) % 0x0100);
                this.swap(this.i, this.j);
                if (_arg_2){
                    this.customHackScramble(this._SafeStr_4633, this.i, this.j);
                };
                _local_4 = ((this._SafeStr_4633[this.i] + this._SafeStr_4633[this.j]) % 0x0100);
                _local_3.writeByte((this._SafeStr_4633[_local_4] ^ _arg_1.readByte()));
            };
            _local_3.position = 0;
            return (_local_3);
        }
        protected function customHackScramble(_arg_1:Array, _arg_2:int, _arg_3:int):void
        {
        }
        public function decipher(_arg_1:ByteArray):ByteArray
        {
            var _local_3:uint;
            var _local_2:ByteArray = new ByteArray();
            _arg_1.position = 0;
            while (_arg_1.bytesAvailable) {
                this.i = ((this.i + 1) % 0x0100);
                this.j = ((this.j + this._SafeStr_4633[this.i]) % 0x0100);
                this.swap(this.i, this.j);
                _local_3 = ((this._SafeStr_4633[this.i] + this._SafeStr_4633[this.j]) % 0x0100);
                _local_2.writeByte((_arg_1.readUnsignedByte() ^ this._SafeStr_4633[_local_3]));
            };
            _local_2.position = 0;
            return (_local_2);
        }
        protected function swap(_arg_1:uint, _arg_2:uint):void
        {
            var _local_3:Object = this._SafeStr_4633[_arg_1];
            this._SafeStr_4633[_arg_1] = this._SafeStr_4633[_arg_2];
            this._SafeStr_4633[_arg_2] = _local_3;
        }

    }
}//package com.sulake.habbo.communication.encryption

// IEncryption = "_-0kE" (String#4505, DoABC#2)
// _SafeStr_1870 = "function" (String#9520, DoABC#2)
// _SafeStr_4633 = "_-2rE" (String#21127, DoABC#2)
// swap = "_-jV" (String#24018, DoABC#2)
// initFromState = "_-12G" (String#4921, DoABC#2)
// encipher = "_-15G" (String#4982, DoABC#2)
// customHackScramble = "_-0Dn" (String#3822, DoABC#2)
// decipher = "_-2tX" (String#7148, DoABC#2)


