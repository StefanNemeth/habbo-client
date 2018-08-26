
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageParser;

    public class ItemAddMessageEvent extends MessageEvent 
    {

        public function ItemAddMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemAddMessageParser);
        }
        public function getParser():ItemAddMessageParser
        {
            return ((_parser as ItemAddMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ItemAddMessageEvent = "_-1TD" (String#17633, DoABC#2)
// ItemAddMessageParser = "_-2kB" (String#6957, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


