
package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageParser;

    public class AvailabilityStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AvailabilityStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvailabilityStatusMessageParser);
        }
        public function getParser():AvailabilityStatusMessageParser
        {
            return ((_parser as AvailabilityStatusMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.availability

// AvailabilityStatusMessageEvent = "_-09L" (String#14423, DoABC#2)
// AvailabilityStatusMessageParser = "_-h8" (String#23936, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


