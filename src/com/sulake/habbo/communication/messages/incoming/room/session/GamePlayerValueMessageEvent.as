
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.GamePlayerValueMessageParser;

    public class GamePlayerValueMessageEvent extends MessageEvent 
    {

        public function GamePlayerValueMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GamePlayerValueMessageParser);
        }
        public function getParser():GamePlayerValueMessageParser
        {
            return ((_parser as GamePlayerValueMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// GamePlayerValueMessageEvent = "_-Y5" (String#23566, DoABC#2)
// GamePlayerValueMessageParser = "_-2M3" (String#6485, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


