
package com.sulake.habbo.communication.messages.incoming.room.publicroom
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusDoorMessageParser;

    public class ParkBusDoorMessageEvent extends MessageEvent 
    {

        public function ParkBusDoorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ParkBusDoorMessageParser);
        }
        public function getParser():ParkBusDoorMessageParser
        {
            return ((_parser as ParkBusDoorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.publicroom

// ParkBusDoorMessageEvent = "_-2UD" (String#20208, DoABC#2)
// ParkBusDoorMessageParser = "_-1pC" (String#5843, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


