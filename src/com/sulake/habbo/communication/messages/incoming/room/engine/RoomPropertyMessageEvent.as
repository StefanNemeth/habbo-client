
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomPropertyMessageParser;

    public class RoomPropertyMessageEvent extends MessageEvent 
    {

        public function RoomPropertyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomPropertyMessageParser);
        }
        public function getParser():RoomPropertyMessageParser
        {
            return ((_parser as RoomPropertyMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// RoomPropertyMessageEvent = "_-1oS" (String#18475, DoABC#2)
// RoomPropertyMessageParser = "_-fP" (String#8503, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


