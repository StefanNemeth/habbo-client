
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementShareIdMessageParser;

    public class HabboAchievementShareIdMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboAchievementShareIdMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboAchievementShareIdMessageParser);
        }
        public function get badgeID():String
        {
            return ((_parser as HabboAchievementShareIdMessageParser).badgeID);
        }
        public function get shareID():String
        {
            return ((_parser as HabboAchievementShareIdMessageParser).shareID);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// HabboAchievementShareIdMessageEvent = "_-0CV" (String#3800, DoABC#2)
// HabboAchievementShareIdMessageParser = "_-ju" (String#8599, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// badgeID = "_-Cm" (String#22716, DoABC#2)
// shareID = "_-02x" (String#14159, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


