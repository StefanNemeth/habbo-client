
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemDataUpdateMessageParser;

    public class ItemDataUpdateMessageEvent extends MessageEvent 
    {

        public function ItemDataUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ItemDataUpdateMessageParser);
        }
        public function getParser():ItemDataUpdateMessageParser
        {
            return ((_parser as ItemDataUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ItemDataUpdateMessageEvent = "_-2ga" (String#20714, DoABC#2)
// ItemDataUpdateMessageParser = "_-0t7" (String#4709, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


