
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.ChangeEmailResultParser;

    public class ChangeEmailResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function ChangeEmailResultEvent(_arg_1:Function)
        {
            super(_arg_1, ChangeEmailResultParser);
        }
        public function getParser():ChangeEmailResultParser
        {
            return ((_parser as ChangeEmailResultParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// ChangeEmailResultEvent = "_-1v9" (String#18763, DoABC#2)
// ChangeEmailResultParser = "_-1nm" (String#5814, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


