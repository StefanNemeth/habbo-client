
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNotificationParser;

    public class UserNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserNotificationParser);
        }
        public function get title():String
        {
            return (UserNotificationParser(_parser).title);
        }
        public function get message():String
        {
            return (UserNotificationParser(_parser).message);
        }
        public function get parameters():Array
        {
            return (UserNotificationParser(_parser).parameters);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// UserNotificationMessageEvent = "_-1WK" (String#17755, DoABC#2)
// UserNotificationParser = "_-6X" (String#7796, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


