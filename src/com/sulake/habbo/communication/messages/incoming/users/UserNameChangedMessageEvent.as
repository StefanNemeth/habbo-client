
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;

    public class UserNameChangedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserNameChangedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserNameChangedMessageParser);
        }
        public function getParser():UserNameChangedMessageParser
        {
            return ((_parser as UserNameChangedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// UserNameChangedMessageParser = "_-1TI" (String#17637, DoABC#2)
// UserNameChangedMessageEvent = "_-1J2" (String#17238, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


