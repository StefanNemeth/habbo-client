
package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsParser;

    public class BadgePointLimitsEvent extends MessageEvent 
    {

        public function BadgePointLimitsEvent(_arg_1:Function)
        {
            super(_arg_1, BadgePointLimitsParser);
        }
        public function getParser():BadgePointLimitsParser
        {
            return ((_parser as BadgePointLimitsParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.badges

// BadgePointLimitsParser = "_-2ak" (String#20477, DoABC#2)
// BadgePointLimitsEvent = "_-1hx" (String#5705, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


