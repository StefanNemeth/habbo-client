
package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListInsertParser;

    public class FurniListInsertEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListInsertEvent(_arg_1:Function)
        {
            super(_arg_1, FurniListInsertParser);
        }
        public function getParser():FurniListInsertParser
        {
            return ((this._parser as FurniListInsertParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.furni

// FurniListInsertParser = "_-2oG" (String#21013, DoABC#2)
// FurniListInsertEvent = "_-0Ey" (String#3848, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


