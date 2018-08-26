
package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveParser;

    public class FurniListRemoveEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListRemoveEvent(_arg_1:Function)
        {
            super(_arg_1, FurniListRemoveParser);
        }
        public function getParser():FurniListRemoveParser
        {
            return ((this._parser as FurniListRemoveParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.furni

// FurniListRemoveEvent = "_-3Ij" (String#7684, DoABC#2)
// FurniListRemoveParser = "_-1Ep" (String#17062, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


