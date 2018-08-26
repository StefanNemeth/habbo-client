
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsMessageParser;

    public class CallForHelpPendingCallsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpPendingCallsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CallForHelpPendingCallsMessageParser);
        }
        public function getParser():CallForHelpPendingCallsMessageParser
        {
            return ((_parser as CallForHelpPendingCallsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// CallForHelpPendingCallsMessageEvent = "_-2wx" (String#21346, DoABC#2)
// CallForHelpPendingCallsMessageParser = "_-32G" (String#7351, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


