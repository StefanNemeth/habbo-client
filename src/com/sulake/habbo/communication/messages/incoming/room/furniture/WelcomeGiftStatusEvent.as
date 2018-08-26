
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.WelcomeGiftStatusParser;

    public class WelcomeGiftStatusEvent extends MessageEvent 
    {

        public function WelcomeGiftStatusEvent(_arg_1:Function)
        {
            super(_arg_1, WelcomeGiftStatusParser);
        }
        public function getParser():WelcomeGiftStatusParser
        {
            return ((_parser as WelcomeGiftStatusParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// WelcomeGiftStatusEvent = "_-gn" (String#23923, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


