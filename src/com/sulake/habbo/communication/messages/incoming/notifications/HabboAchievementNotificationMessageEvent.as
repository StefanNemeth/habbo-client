
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;

    public class HabboAchievementNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboAchievementNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboAchievementNotificationMessageParser);
        }
        public function getParser():HabboAchievementNotificationMessageParser
        {
            return ((_parser as HabboAchievementNotificationMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// HabboAchievementNotificationMessageParser = "_-Zs" (String#8418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)
// HabboAchievementNotificationMessageEvent = "_-2LH" (String#6465, DoABC#2)


