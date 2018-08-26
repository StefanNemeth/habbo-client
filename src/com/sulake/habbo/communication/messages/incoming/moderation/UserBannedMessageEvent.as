
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageParser;

    public class UserBannedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserBannedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserBannedMessageParser);
        }
        public function getParser():UserBannedMessageParser
        {
            return ((_parser as UserBannedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// UserBannedMessageParser = "_-0bm" (String#4342, DoABC#2)
// UserBannedMessageEvent = "_-uX" (String#24472, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


