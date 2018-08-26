
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageParser;

    public class ItemsMessageEvent extends MessageEvent 
    {

        public function ItemsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemsMessageParser);
        }
        public function getParser():ItemsMessageParser
        {
            return ((_parser as ItemsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ItemsMessageEvent = "_-2YD" (String#20365, DoABC#2)
// ItemsMessageParser = "_-0XF" (String#4254, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


