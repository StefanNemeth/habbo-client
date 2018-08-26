
package com.sulake.habbo.communication.messages.incoming.room.publicroom
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.OpenLockerRoomMessageParser;

    public class OpenLockerRoomMessageEvent extends MessageEvent 
    {

        public function OpenLockerRoomMessageEvent(_arg_1:Function)
        {
            super(_arg_1, OpenLockerRoomMessageParser);
        }
        public function getParser():OpenLockerRoomMessageParser
        {
            return ((_parser as OpenLockerRoomMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.publicroom

// OpenLockerRoomMessageEvent = "_-2yd" (String#21415, DoABC#2)
// OpenLockerRoomMessageParser = "_-03m" (String#3642, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


