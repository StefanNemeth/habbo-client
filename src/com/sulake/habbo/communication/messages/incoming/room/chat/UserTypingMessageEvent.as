
package com.sulake.habbo.communication.messages.incoming.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageParser;

    public class UserTypingMessageEvent extends MessageEvent 
    {

        public function UserTypingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserTypingMessageParser);
        }
        public function getParser():UserTypingMessageParser
        {
            return ((_parser as UserTypingMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.chat

// UserTypingMessageEvent = "_-2Q8" (String#20050, DoABC#2)
// UserTypingMessageParser = "_-0cL" (String#4351, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


