
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.IgnoredUsersMessageParser;

    public class IgnoredUsersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IgnoredUsersMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IgnoredUsersMessageParser);
        }
        public function get ignoredUsers():Array
        {
            return ((_parser as IgnoredUsersMessageParser).ignoredUsers);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// IgnoredUsersMessageEvent = "_-Ca" (String#7928, DoABC#2)
// IgnoredUsersMessageParser = "_-1h9" (String#5688, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// ignoredUsers = "_-2n0" (String#20962, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


