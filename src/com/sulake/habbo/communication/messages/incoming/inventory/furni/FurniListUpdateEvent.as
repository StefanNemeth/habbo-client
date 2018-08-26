
package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListUpdateParser;

    public class FurniListUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, FurniListUpdateParser);
        }
        public function getParser():FurniListUpdateParser
        {
            return ((this._parser as FurniListUpdateParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.furni

// FurniListUpdateEvent = "_-0Xr" (String#4265, DoABC#2)
// FurniListUpdateParser = "_-0qK" (String#4645, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


