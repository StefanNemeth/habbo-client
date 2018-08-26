
package com.sulake.habbo.communication.messages.incoming.room.publicroom
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusCannotEnterMessageParser;

    public class ParkBusCannotEnterMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ParkBusCannotEnterMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ParkBusCannotEnterMessageParser);
        }
        public function getParser():ParkBusCannotEnterMessageParser
        {
            return ((_parser as ParkBusCannotEnterMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.publicroom

// ParkBusCannotEnterMessageParser = "_-2iL" (String#6917, DoABC#2)
// ParkBusCannotEnterMessageEvent = "_-2yf" (String#21416, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


