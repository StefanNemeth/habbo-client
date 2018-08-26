
package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;

    public class BadgesEvent extends MessageEvent 
    {

        public function BadgesEvent(_arg_1:Function)
        {
            super(_arg_1, BadgesParser);
        }
        public function getParser():BadgesParser
        {
            return ((_parser as BadgesParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.badges

// BadgesParser = "_-14Z" (String#16638, DoABC#2)
// BadgesEvent = "_-3HC" (String#7652, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


