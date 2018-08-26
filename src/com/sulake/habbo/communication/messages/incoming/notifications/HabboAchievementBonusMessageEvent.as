
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementBonusMessageParser;

    public class HabboAchievementBonusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboAchievementBonusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboAchievementBonusMessageParser);
        }
        public function get bonusPoints():int
        {
            return ((_parser as HabboAchievementBonusMessageParser).bonusPoints);
        }
        public function get realName():String
        {
            return ((_parser as HabboAchievementBonusMessageParser).realName);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// HabboAchievementBonusMessageEvent = "_-2wf" (String#21333, DoABC#2)
// HabboAchievementBonusMessageParser = "_-rm" (String#8732, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// bonusPoints = "_-0xr" (String#16347, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


