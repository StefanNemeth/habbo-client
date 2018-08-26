
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageParser;

    public class FurnitureAliasesMessageEvent extends MessageEvent 
    {

        public function FurnitureAliasesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FurnitureAliasesMessageParser);
        }
        public function getParser():FurnitureAliasesMessageParser
        {
            return ((_parser as FurnitureAliasesMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// FurnitureAliasesMessageEvent = "_-11g" (String#16524, DoABC#2)
// FurnitureAliasesMessageParser = "_-1bc" (String#5591, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


