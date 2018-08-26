
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageParser;

    public class ItemRemoveMessageEvent extends MessageEvent 
    {

        public function ItemRemoveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemRemoveMessageParser);
        }
        public function getParser():ItemRemoveMessageParser
        {
            return ((_parser as ItemRemoveMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ItemRemoveMessageEvent = "_-ex" (String#23842, DoABC#2)
// ItemRemoveMessageParser = "_-01N" (String#3589, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


