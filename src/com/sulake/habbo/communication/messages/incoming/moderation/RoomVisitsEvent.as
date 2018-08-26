
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomVisitsMessageParser;

    public class RoomVisitsEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomVisitsEvent(_arg_1:Function)
        {
            super(_arg_1, RoomVisitsMessageParser);
        }
        public function getParser():RoomVisitsMessageParser
        {
            return ((_parser as RoomVisitsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// RoomVisitsEvent = "_-L-" (String#23046, DoABC#2)
// RoomVisitsMessageParser = "_-2zM" (String#7274, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


