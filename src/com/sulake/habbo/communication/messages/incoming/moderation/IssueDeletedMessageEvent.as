
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueDeletedMessageParser;

    public class IssueDeletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssueDeletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IssueDeletedMessageParser);
        }
        public function getParser():IssueDeletedMessageParser
        {
            return ((_parser as IssueDeletedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IssueDeletedMessageEvent = "_-0By" (String#14525, DoABC#2)
// IssueDeletedMessageParser = "_-1t1" (String#5902, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


