
package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementMessageParser;

    public class AchievementEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementMessageParser);
        }
        public function getParser():AchievementMessageParser
        {
            return ((_parser as AchievementMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.achievements

// AchievementEvent = "_-12h" (String#4929, DoABC#2)
// AchievementMessageParser = "_-fU" (String#8507, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


