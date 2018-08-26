
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseOKMessageParser;

    public class PurchaseOKMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PurchaseOKMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PurchaseOKMessageParser);
        }
        public function getParser():PurchaseOKMessageParser
        {
            return ((this._parser as PurchaseOKMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// PurchaseOKMessageEvent = "_-38y" (String#21841, DoABC#2)
// PurchaseOKMessageParser = "_-2DV" (String#6312, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


