
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseNotAllowedMessageParser;

    public class PurchaseNotAllowedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PurchaseNotAllowedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PurchaseNotAllowedMessageParser);
        }
        public function getParser():PurchaseNotAllowedMessageParser
        {
            return ((this._parser as PurchaseNotAllowedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// PurchaseNotAllowedMessageParser = "_-1D6" (String#5128, DoABC#2)
// PurchaseNotAllowedMessageEvent = "_-2I7" (String#19731, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


