
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomDimmerPresetsMessageParser;

    public class RoomDimmerPresetsMessageEvent extends MessageEvent 
    {

        public function RoomDimmerPresetsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomDimmerPresetsMessageParser);
        }
        public function getParser():RoomDimmerPresetsMessageParser
        {
            return ((_parser as RoomDimmerPresetsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// RoomDimmerPresetsMessageEvent = "_-gw" (String#23926, DoABC#2)
// RoomDimmerPresetsMessageParser = "_-1xY" (String#5982, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


