
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.UserChatlogMessageParser;

    public class UserChatlogEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserChatlogEvent(_arg_1:Function)
        {
            super(_arg_1, UserChatlogMessageParser);
        }
        public function getParser():UserChatlogMessageParser
        {
            return ((_parser as UserChatlogMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// UserChatlogEvent = "_-1AF" (String#16869, DoABC#2)
// UserChatlogMessageParser = "_-2Oi" (String#6535, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


