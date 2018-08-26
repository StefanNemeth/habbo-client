
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssuePickFailedMessageParser;

    public class IssuePickFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssuePickFailedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IssuePickFailedMessageParser);
        }
        public function getParser():IssuePickFailedMessageParser
        {
            return ((_parser as IssuePickFailedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IssuePickFailedMessageEvent = "_-3Ej" (String#22064, DoABC#2)
// IssuePickFailedMessageParser = "_-Bc" (String#7903, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


