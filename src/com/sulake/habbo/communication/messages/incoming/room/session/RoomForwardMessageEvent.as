
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageParser;

    public class RoomForwardMessageEvent extends MessageEvent 
    {

        public function RoomForwardMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomForwardMessageParser);
        }
        public function getParser():RoomForwardMessageParser
        {
            return ((_parser as RoomForwardMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// RoomForwardMessageParser = "_-0s2" (String#4687, DoABC#2)
// RoomForwardMessageEvent = "_-33g" (String#21648, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


