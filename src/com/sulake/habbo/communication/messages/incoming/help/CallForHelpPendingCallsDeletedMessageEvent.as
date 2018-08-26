
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsDeletedMessageParser;

    public class CallForHelpPendingCallsDeletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpPendingCallsDeletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CallForHelpPendingCallsDeletedMessageParser);
        }
        public function getParser():CallForHelpPendingCallsDeletedMessageParser
        {
            return ((_parser as CallForHelpPendingCallsDeletedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// CallForHelpPendingCallsDeletedMessageEvent = "_-342" (String#21659, DoABC#2)
// CallForHelpPendingCallsDeletedMessageParser = "_-28q" (String#6220, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


