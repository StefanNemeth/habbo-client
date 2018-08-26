
package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomForwardMessageParser implements IMessageParser 
    {

        private var _publicRoom:Boolean;
        private var _roomId:int;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get publicRoom():Boolean
        {
            return (this._publicRoom);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._publicRoom = _arg_1.readBoolean();
            this._roomId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.session

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomForwardMessageParser = "_-0s2" (String#4687, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _publicRoom = "_-0bn" (String#15503, DoABC#2)
// publicRoom = "_-1f-" (String#18098, DoABC#2)


