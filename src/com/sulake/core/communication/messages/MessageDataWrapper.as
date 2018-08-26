
package com.sulake.core.communication.messages
{
    import flash.utils.ByteArray;
    import com.sulake.core.communication.protocol.IProtocolDecoder;
    import com.sulake.core.communication.util.Short;

    public class MessageDataWrapper implements IMessageDataWrapper 
    {

        private var _data:ByteArray;
        private var _decoder:IProtocolDecoder;

        public function MessageDataWrapper(_arg_1:ByteArray, _arg_2:IProtocolDecoder)
        {
            this._data = _arg_1;
            this._decoder = _arg_2;
        }
        public function readString():String
        {
            return (this._decoder.readString(this._data));
        }
        public function readInteger():int
        {
            return (this._decoder.readInteger(this._data));
        }
        public function readBoolean():Boolean
        {
            return (this._decoder.readBoolean(this._data));
        }
        public function readShort():Short
        {
            return (this._decoder.readShort(this._data));
        }
        public function get bytesAvailable():uint
        {
            return (this._data.bytesAvailable);
        }

    }
}//package com.sulake.core.communication.messages

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IProtocolDecoder = "_-17h" (String#5031, DoABC#2)
// Short = "_-0S7" (String#4139, DoABC#2)
// MessageDataWrapper = "_-17g" (String#16762, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _decoder = "_-1IL" (String#5211, DoABC#2)


