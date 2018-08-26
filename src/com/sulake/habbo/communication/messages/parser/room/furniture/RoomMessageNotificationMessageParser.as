
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomMessageNotificationMessageParser implements IMessageParser 
    {

        private var _roomId:int;
        private var _roomName:String;
        private var _messageCount:int;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomName():String
        {
            return (this._roomName);
        }
        public function get messageCount():int
        {
            return (this._messageCount);
        }
        public function flush():Boolean
        {
            this._roomId = -1;
            this._roomName = "";
            this._messageCount = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._roomId = _arg_1.readInteger();
            this._roomName = _arg_1.readString();
            this._messageCount = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// _messageCount = "_-sn" (String#8750, DoABC#2)
// messageCount = "_-Qs" (String#23280, DoABC#2)
// RoomMessageNotificationMessageParser = "_-1RL" (String#5382, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


