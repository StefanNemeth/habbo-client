
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageParser;

    public class CallForHelpReplyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpReplyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CallForHelpReplyMessageParser);
        }
        public function getParser():CallForHelpReplyMessageParser
        {
            return ((_parser as CallForHelpReplyMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// CallForHelpReplyMessageParser = "_-1RQ" (String#5384, DoABC#2)
// CallForHelpReplyMessageEvent = "_-0-F" (String#14022, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


