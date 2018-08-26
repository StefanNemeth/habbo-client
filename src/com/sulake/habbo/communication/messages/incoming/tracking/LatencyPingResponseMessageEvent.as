
package com.sulake.habbo.communication.messages.incoming.tracking
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;

    public class LatencyPingResponseMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function LatencyPingResponseMessageEvent(_arg_1:Function)
        {
            super(_arg_1, LatencyPingResponseMessageParser);
        }
        public function getParser():LatencyPingResponseMessageParser
        {
            return ((_parser as LatencyPingResponseMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.tracking

// LatencyPingResponseMessageEvent = "_-0pM" (String#4621, DoABC#2)
// LatencyPingResponseMessageParser = "_-1iU" (String#5722, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


