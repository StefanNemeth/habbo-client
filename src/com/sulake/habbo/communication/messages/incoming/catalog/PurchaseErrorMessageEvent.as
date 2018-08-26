
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseErrorMessageParser;

    public class PurchaseErrorMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PurchaseErrorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PurchaseErrorMessageParser);
        }
        public function getParser():PurchaseErrorMessageParser
        {
            return ((this._parser as PurchaseErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// PurchaseErrorMessageEvent = "_-Gq" (String#22884, DoABC#2)
// PurchaseErrorMessageParser = "_-10X" (String#4882, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


