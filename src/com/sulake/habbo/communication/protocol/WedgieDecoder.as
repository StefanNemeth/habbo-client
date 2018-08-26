
package com.sulake.habbo.communication.protocol
{
    import com.sulake.core.communication.protocol.IProtocolDecoder;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.util.Short;

    public class WedgieDecoder implements IProtocolDecoder 
    {

        public function dispose():void
        {
        }
        public function getID(_arg_1:ByteArray):int
        {
            var _local_3:uint;
            var _local_4:uint;
            var _local_2:int = -1;
            _arg_1.position = 0;
            if (_arg_1.bytesAvailable){
                _local_3 = this.readWedgieByte(_arg_1);
                _local_4 = this.readWedgieByte(_arg_1);
                _local_2 = ((_local_3 << 6) | _local_4);
            };
            return (_local_2);
        }
        public function decode(_arg_1:ByteArray):void
        {
            _arg_1.position = 0;
            Logger.log("Wedgie Decoder");
            Logger.log(("Data Length: " + _arg_1.length));
            Logger.log(("Data: " + _arg_1));
        }
        public function readString(_arg_1:ByteArray):String
        {
            var _local_3:uint;
            var _local_2:ByteArray = new ByteArray();
            while (_arg_1.bytesAvailable) {
                _local_3 = _arg_1.readUnsignedByte();
                if (_local_3 == WedgieProtocol._SafeStr_8027) break;
                _local_2.writeByte(_local_3);
            };
            _local_2.position = 0;
            return (_local_2.readUTFBytes(_local_2.length));
        }
        public function readInteger(_arg_1:ByteArray):int
        {
            var _local_6:uint;
            var _local_7:int;
            var _local_8:uint;
            var _local_2:uint;
            if (_arg_1.bytesAvailable){
                _local_2 = this.readWedgieByte(_arg_1);
            }
            else {
                return (0);
            };
            var _local_3 = (((_local_2 & 56) >> 3) | 0);
            var _local_4:Boolean = ((((_local_2 & 4))==4) ? true : false);
            var _local_5 = (_local_2 & 3);
            if (_arg_1.bytesAvailable){
                _local_6 = 2;
                _local_7 = 1;
                while (_local_7 < _local_3) {
                    _local_8 = this.readWedgieByte(_arg_1);
                    _local_5 = ((_local_8 << _local_6) | _local_5);
                    _local_6 = (_local_6 + 6);
                    _local_7++;
                };
            };
            if (_local_4){
                _local_5 = (_local_5 * -1);
            };
            return (_local_5);
        }
        public function readBoolean(_arg_1:ByteArray):Boolean
        {
            var _local_2:int = this.readInteger(_arg_1);
            return (Boolean(_local_2));
        }
        public function readShort(_arg_1:ByteArray):Short
        {
            var _local_2:int = this.readInteger(_arg_1);
            return (Short(_local_2));
        }
        private function readWedgieByte(_arg_1:ByteArray):uint
        {
            return ((_arg_1.readUnsignedByte() & 63));
        }

    }
}//package com.sulake.habbo.communication.protocol

// WedgieProtocol = "_-18r" (String#5055, DoABC#2)
// IProtocolDecoder = "_-17h" (String#5031, DoABC#2)
// WedgieDecoder = "_-0Om" (String#4064, DoABC#2)
// Short = "_-0S7" (String#4139, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// decode = "_-1M7" (String#1666, DoABC#2)
// getID = "_-zL" (String#8865, DoABC#2)
// _SafeStr_8027 = "_-0Me" (String#14937, DoABC#2)
// readWedgieByte = "_-Ta" (String#23390, DoABC#2)


