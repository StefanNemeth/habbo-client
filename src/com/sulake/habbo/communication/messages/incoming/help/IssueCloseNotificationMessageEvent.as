
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageParser;

    public class IssueCloseNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssueCloseNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IssueCloseNotificationMessageParser);
        }
        public function getParser():IssueCloseNotificationMessageParser
        {
            return ((_parser as IssueCloseNotificationMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// IssueCloseNotificationMessageParser = "_-02p" (String#3626, DoABC#2)
// IssueCloseNotificationMessageEvent = "_-SY" (String#23348, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


