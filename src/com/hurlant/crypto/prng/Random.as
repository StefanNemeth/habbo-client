
package com.hurlant.crypto.prng
{
    import flash.utils.ByteArray;
    import flash.text.Font;
    import flash.system.System;
    import flash.system.Capabilities;
    import flash.utils.getTimer;
    import com.hurlant.util.Memory;

    public class Random 
    {

        private var state:IPRNG;
        private var ready:Boolean = false;
        private var _SafeStr_8363:ByteArray;
        private var psize:int;
        private var _SafeStr_8364:int;
        private var _SafeStr_8365:Boolean = false;

        public function Random(_arg_1:Class=null)
        {
            var _local_2:uint;
            super();
            if (_arg_1 == null){
                _arg_1 = ARC4;
            };
            this.state = (new (_arg_1)() as IPRNG);
            this.psize = this.state.getPoolSize();
            this._SafeStr_8363 = new ByteArray();
            this._SafeStr_8364 = 0;
            while (this._SafeStr_8364 < this.psize) {
                _local_2 = (65536 * Math.random());
                var _local_3 = this._SafeStr_8364++;
                this._SafeStr_8363[_local_3] = (_local_2 >>> 8);
                var _local_4 = this._SafeStr_8364++;
                this._SafeStr_8363[_local_4] = (_local_2 & 0xFF);
            };
            this._SafeStr_8364 = 0;
            this.seed();
        }
        public function seed(_arg_1:int=0):void
        {
            if (_arg_1 == 0){
                _arg_1 = new Date().getTime();
            };
            var _local_2 = this._SafeStr_8364++;
            this._SafeStr_8363[_local_2] = (this._SafeStr_8363[_local_2] ^ (_arg_1 & 0xFF));
            var _local_3 = this._SafeStr_8364++;
            this._SafeStr_8363[_local_3] = (this._SafeStr_8363[_local_3] ^ ((_arg_1 >> 8) & 0xFF));
            var _local_4 = this._SafeStr_8364++;
            this._SafeStr_8363[_local_4] = (this._SafeStr_8363[_local_4] ^ ((_arg_1 >> 16) & 0xFF));
            var _local_5 = this._SafeStr_8364++;
            this._SafeStr_8363[_local_5] = (this._SafeStr_8363[_local_5] ^ ((_arg_1 >> 24) & 0xFF));
            this._SafeStr_8364 = (this._SafeStr_8364 % this.psize);
            this._SafeStr_8365 = true;
        }
        public function autoSeed():void
        {
            var _local_3:Font;
            var _local_1:ByteArray = new ByteArray();
            _local_1.writeUnsignedInt(System.totalMemory);
            _local_1.writeUTF(Capabilities.serverString);
            _local_1.writeUnsignedInt(getTimer());
            _local_1.writeUnsignedInt(new Date().getTime());
            var _local_2:Array = Font.enumerateFonts(true);
            for each (_local_3 in _local_2) {
                _local_1.writeUTF(_local_3.fontName);
                _local_1.writeUTF(_local_3.fontStyle);
                _local_1.writeUTF(_local_3.fontType);
            };
            _local_1.position = 0;
            while (_local_1.bytesAvailable >= 4) {
                this.seed(_local_1.readUnsignedInt());
            };
        }
        public function nextBytes(_arg_1:ByteArray, _arg_2:int):void
        {
            while (_arg_2--) {
                _arg_1.writeByte(this.nextByte());
            };
        }
        public function nextByte():int
        {
            if (!this.ready){
                if (!this._SafeStr_8365){
                    this.autoSeed();
                };
                this.state.init(this._SafeStr_8363);
                this._SafeStr_8363.length = 0;
                this._SafeStr_8364 = 0;
                this.ready = true;
            };
            return (this.state.next());
        }
        public function dispose():void
        {
            var _local_1:uint;
            while (_local_1 < this._SafeStr_8363.length) {
                this._SafeStr_8363[_local_1] = (Math.random() * 0x0100);
                _local_1++;
            };
            this._SafeStr_8363.length = 0;
            this._SafeStr_8363 = null;
            this.state.dispose();
            this.state = null;
            this.psize = 0;
            this._SafeStr_8364 = 0;
            Memory.gc();
        }
        public function toString():String
        {
            return (("random-" + this.state.toString()));
        }

    }
}//package com.hurlant.crypto.prng

// Memory = "_-2zI" (String#7273, DoABC#2)
// Random = "_-1wQ" (String#5965, DoABC#2)
// IPRNG = "_-28k" (String#6218, DoABC#2)
// ARC4 = "_-27q" (String#6198, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// nextByte = "_-17N" (String#16751, DoABC#2)
// seed = "_-1iE" (String#5715, DoABC#2)
// _SafeStr_8363 = "_-0jz" (String#15827, DoABC#2)
// _SafeStr_8364 = "_-0HI" (String#14731, DoABC#2)
// _SafeStr_8365 = "_-0kz" (String#15864, DoABC#2)
// getPoolSize = "_-1bA" (String#5580, DoABC#2)
// autoSeed = "_-en" (String#23835, DoABC#2)
// nextBytes = "_-0fg" (String#15659, DoABC#2)


