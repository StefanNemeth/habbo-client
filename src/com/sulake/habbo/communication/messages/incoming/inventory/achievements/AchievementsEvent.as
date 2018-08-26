
package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;

    public class AchievementsEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementsEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementsMessageParser);
        }
        public function getParser():AchievementsMessageParser
        {
            return ((_parser as AchievementsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.achievements

// AchievementsEvent = "_-3FG" (String#7617, DoABC#2)
// AchievementsMessageParser = "_-Rf" (String#8241, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


