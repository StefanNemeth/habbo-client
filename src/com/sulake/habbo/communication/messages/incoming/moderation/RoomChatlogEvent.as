
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomChatlogMessageParser;

    public class RoomChatlogEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomChatlogEvent(_arg_1:Function)
        {
            super(_arg_1, RoomChatlogMessageParser);
        }
        public function getParser():RoomChatlogMessageParser
        {
            return ((_parser as RoomChatlogMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// RoomChatlogEvent = "_-13V" (String#16599, DoABC#2)
// RoomChatlogMessageParser = "_-0Iw" (String#3933, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


