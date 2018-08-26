
package com.sulake.habbo.communication.protocol
{
    import com.sulake.core.communication.protocol.IProtocolEncoder;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.util.Short;
    import com.sulake.habbo.communication.enum.HabboProtocolOption;

    public class WedgieEncoder implements IProtocolEncoder 
    {

        private static const WEDGIE_BYTE_MASK:uint = 64;

        public function dispose():void
        {
        }
        public function encode(_arg_1:int, _arg_2:Array, _arg_3:int=-1):ByteArray
        {
            var _local_5:Object;
            var _local_6:uint;
            var _local_7:ByteArray;
            var _local_4:ByteArray = new ByteArray();
            _local_4.writeByte((WEDGIE_BYTE_MASK | (_arg_1 >> 6)));
            _local_4.writeByte((WEDGIE_BYTE_MASK | (63 & _arg_1)));
            for each (_local_5 in _arg_2) {
                if ((_local_5 is String)){
                    this.writeString(_local_4, (_local_5 as String), _arg_3);
                }
                else {
                    if ((_local_5 is int)){
                        this.writeWedgieInt(_local_4, (_local_5 as int), _arg_3);
                    }
                    else {
                        if ((_local_5 is Boolean)){
                            this.writeBoolean(_local_4, (_local_5 as Boolean), _arg_3);
                        }
                        else {
                            if ((_local_5 is Short)){
                                this.writeShort(_local_4, (_local_5 as Short), _arg_3);
                            };
                        };
                    };
                };
            };
            _local_6 = _local_4.length;
            _local_7 = new ByteArray();
            _local_7.writeByte((WEDGIE_BYTE_MASK | (_local_6 >> 12)));
            _local_7.writeByte((WEDGIE_BYTE_MASK | (_local_6 >> 6)));
            _local_7.writeByte((WEDGIE_BYTE_MASK | (63 & _local_6)));
            _local_7.writeBytes(_local_4);
            return (_local_7);
        }
        private function writeWedgieInt(_arg_1:ByteArray, _arg_2:int, _arg_3:int=-1):void
        {
            var _local_4:ByteArray = new ByteArray();
            var _local_5:Boolean = (((_arg_2)<0) ? true : false);
            var _local_6:int = (((_arg_2)<0) ? 4 : 0);
            _arg_2 = Math.abs(_arg_2);
            var _local_7:uint = 1;
            var _local_8:ByteArray = new ByteArray();
            _local_8.writeByte((64 | (_arg_2 & 3)));
            _arg_2 = (_arg_2 >>> 2);
            while (_arg_2 != 0) {
                _local_7++;
                _local_8.writeByte((64 | (_arg_2 & 63)));
                _arg_2 = (_arg_2 >>> 6);
            };
            _local_8.position = 0;
            var _local_9:uint = _local_8.readByte();
            _local_8.position = 0;
            _local_8.writeByte(((_local_9 | (_local_7 << 3)) | _local_6));
            _arg_1.writeBytes(_local_8);
        }
        private function writeString(_arg_1:ByteArray, _arg_2:String, _arg_3:int=-1):void
        {
            var _local_5:uint;
            var _local_4:ByteArray = new ByteArray();
            _local_4.writeUTFBytes(_arg_2);
            if (_arg_3 != HabboProtocolOption.OLD_STYLE){
                _local_5 = _local_4.length;
                _arg_1.writeByte((WEDGIE_BYTE_MASK | (_local_5 >> 6)));
                _arg_1.writeByte((WEDGIE_BYTE_MASK | (63 & _local_5)));
            };
            _arg_1.writeBytes(_local_4);
        }
        private function writeBoolean(_arg_1:ByteArray, _arg_2:Boolean, _arg_3:int=-1):void
        {
            _arg_1.writeByte((64 | (int(_arg_2) & 63)));
        }
        private function writeShort(_arg_1:ByteArray, _arg_2:Short, _arg_3:int=-1):void
        {
            var _local_4:int = _arg_2.value;
            _arg_1.writeByte((WEDGIE_BYTE_MASK | (_local_4 >> 6)));
            _arg_1.writeByte((WEDGIE_BYTE_MASK | (63 & _local_4)));
        }

    }
}//package com.sulake.habbo.communication.protocol

// HabboProtocolOption = "_-9Z" (String#7855, DoABC#2)
// WedgieEncoder = "_-2Ij" (String#6414, DoABC#2)
// Short = "_-0S7" (String#4139, DoABC#2)
// encode = "_-31x" (String#7345, DoABC#2)
// writeString = "_-2g4" (String#20695, DoABC#2)
// writeWedgieInt = "_-22i" (String#19120, DoABC#2)
// writeBoolean = "_-2mV" (String#20941, DoABC#2)


