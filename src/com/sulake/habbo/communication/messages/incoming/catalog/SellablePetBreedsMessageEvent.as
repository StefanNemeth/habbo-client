
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.SellablePetBreedsParser;

    public class SellablePetBreedsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SellablePetBreedsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SellablePetBreedsParser);
        }
        public function getParser():SellablePetBreedsParser
        {
            return ((this._parser as SellablePetBreedsParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// SellablePetBreedsParser = "_-0eF" (String#4395, DoABC#2)
// SellablePetBreedsMessageEvent = "_-07I" (String#14338, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


