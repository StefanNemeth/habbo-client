
package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityTimeMessageParser;

    public class AvailabilityTimeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AvailabilityTimeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvailabilityTimeMessageParser);
        }
        public function getParser():AvailabilityTimeMessageParser
        {
            return ((_parser as AvailabilityTimeMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.availability

// AvailabilityTimeMessageEvent = "_-0CU" (String#14548, DoABC#2)
// AvailabilityTimeMessageParser = "_-eJ" (String#8489, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


