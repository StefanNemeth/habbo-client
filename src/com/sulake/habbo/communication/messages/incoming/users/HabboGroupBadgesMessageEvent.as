
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupBadgesMessageParser;
    import com.sulake.core.utils.Map;

    public class HabboGroupBadgesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupBadgesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboGroupBadgesMessageParser);
        }
        public function get badges():Map
        {
            return ((_parser as HabboGroupBadgesMessageParser).badges);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// HabboGroupBadgesMessageEvent = "_-3L2" (String#7723, DoABC#2)
// HabboGroupBadgesMessageParser = "_-3Cn" (String#7571, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


