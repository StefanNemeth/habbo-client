
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DiceValueMessageParser;

    public class DiceValueMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DiceValueMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DiceValueMessageParser);
        }
        public function getParser():DiceValueMessageParser
        {
            return ((_parser as DiceValueMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// DiceValueMessageEvent = "_-1xp" (String#18881, DoABC#2)
// DiceValueMessageParser = "_-2pq" (String#7073, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


