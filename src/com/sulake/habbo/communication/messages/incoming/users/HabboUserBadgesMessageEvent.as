
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboUserBadgesMessageParser;

    public class HabboUserBadgesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboUserBadgesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboUserBadgesMessageParser);
        }
        public function get badges():Array
        {
            return ((_parser as HabboUserBadgesMessageParser).badges);
        }
        public function get userId():int
        {
            return ((_parser as HabboUserBadgesMessageParser).userId);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// HabboUserBadgesMessageEvent = "_-1fc" (String#5656, DoABC#2)
// HabboUserBadgesMessageParser = "_-ZC" (String#8398, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


