
package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;

    public class AchievementsScoreEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementsScoreEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementsScoreMessageParser);
        }
        public function getParser():AchievementsScoreMessageParser
        {
            return ((_parser as AchievementsScoreMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.achievements

// AchievementsScoreEvent = "_-JF" (String#8067, DoABC#2)
// AchievementsScoreMessageParser = "_-hH" (String#23941, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


