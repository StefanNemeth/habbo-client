
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageParser;

    public class RoomQueueStatusMessageEvent extends MessageEvent 
    {

        public function RoomQueueStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomQueueStatusMessageParser);
        }
        public function getParser():RoomQueueStatusMessageParser
        {
            return ((_parser as RoomQueueStatusMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// RoomQueueStatusMessageParser = "_-1qx" (String#5873, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


