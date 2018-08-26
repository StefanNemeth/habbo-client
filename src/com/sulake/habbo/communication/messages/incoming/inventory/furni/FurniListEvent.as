
package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;

    public class FurniListEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListEvent(_arg_1:Function)
        {
            super(_arg_1, FurniListParser);
        }
        public function getParser():FurniListParser
        {
            return ((this._parser as FurniListParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.furni

// FurniListParser = "_-1q6" (String#18548, DoABC#2)
// FurniListEvent = "_-1DK" (String#5131, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


