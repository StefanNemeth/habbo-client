
package com.sulake.habbo.communication.messages.parser.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenLockerRoomMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.publicroom

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// OpenLockerRoomMessageParser = "_-03m" (String#3642, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


