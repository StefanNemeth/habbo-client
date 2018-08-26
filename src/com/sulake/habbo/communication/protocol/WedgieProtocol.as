
package com.sulake.habbo.communication.protocol
{
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.protocol.IProtocolEncoder;
    import com.sulake.core.communication.protocol.IProtocolDecoder;
    import flash.utils.ByteArray;

    public class WedgieProtocol implements IProtocol 
    {

        public static const _SafeStr_8026:uint = 1;
        public static const _SafeStr_8027:uint = 2;

        private var _encoder:IProtocolEncoder;
        private var _decoder:IProtocolDecoder;

        public function WedgieProtocol()
        {
            this._encoder = new WedgieEncoder();
            this._decoder = new WedgieDecoder();
        }
        public function dispose():void
        {
            this._encoder.dispose();
            this._decoder.dispose();
            this._encoder = null;
            this._decoder = null;
        }
        public function get encoder():IProtocolEncoder
        {
            return (this._encoder);
        }
        public function get decoder():IProtocolDecoder
        {
            return (this._decoder);
        }
        public function getMessages(_arg_1:ByteArray, _arg_2:Array):uint
        {
            var _local_5:uint;
            var _local_6:int;
            _arg_1.position = 0;
            var _local_3:uint = _arg_1.position;
            var _local_4:ByteArray = new ByteArray();
            while (_arg_1.bytesAvailable) {
                _local_5 = _arg_1.readUnsignedByte();
                if (_local_5 == _SafeStr_8026){
                    _local_4.position = 0;
                    _local_6 = this._decoder.getID(_local_4);
                    _arg_2.push([_local_6, _local_4]);
                    _local_4 = new ByteArray();
                    _local_3 = _arg_1.position;
                }
                else {
                    _local_4.writeByte(_local_5);
                };
            };
            return (_local_3);
        }

    }
}//package com.sulake.habbo.communication.protocol

// IProtocol = "_-2N9" (String#6505, DoABC#2)
// WedgieProtocol = "_-18r" (String#5055, DoABC#2)
// IProtocolDecoder = "_-17h" (String#5031, DoABC#2)
// WedgieDecoder = "_-0Om" (String#4064, DoABC#2)
// WedgieEncoder = "_-2Ij" (String#6414, DoABC#2)
// encoder = "_-29H" (String#6235, DoABC#2)
// decoder = "_-IU" (String#8050, DoABC#2)
// getMessages = "_-gT" (String#8521, DoABC#2)
// getID = "_-zL" (String#8865, DoABC#2)
// _SafeStr_8026 = "_-0LH" (String#14885, DoABC#2)
// _SafeStr_8027 = "_-0Me" (String#14937, DoABC#2)
// _encoder = "_-gE" (String#23902, DoABC#2)
// _decoder = "_-1IL" (String#5211, DoABC#2)


