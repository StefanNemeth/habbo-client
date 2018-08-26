
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueInfoMessageParser;

    public class IssueInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssueInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IssueInfoMessageParser);
        }
        public function getParser():IssueInfoMessageParser
        {
            return ((_parser as IssueInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IssueInfoMessageEvent = "_-Ab" (String#22639, DoABC#2)
// IssueInfoMessageParser = "_-2NS" (String#6511, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


