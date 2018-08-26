
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomChatlogMessageParser implements IMessageParser 
    {

        private var _data:RoomChatlogData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomChatlogData(_arg_1);
            return (true);
        }
        public function get data():RoomChatlogData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomChatlogMessageParser = "_-0Iw" (String#3933, DoABC#2)
// RoomChatlogData = "_-2h1" (String#6893, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


