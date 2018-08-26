
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageParser;

    public class ItemUpdateMessageEvent extends MessageEvent 
    {

        public function ItemUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemUpdateMessageParser);
        }
        public function getParser():ItemUpdateMessageParser
        {
            return ((_parser as ItemUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ItemUpdateMessageEvent = "_-39z" (String#21884, DoABC#2)
// ItemUpdateMessageParser = "_-1-a" (String#4859, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


