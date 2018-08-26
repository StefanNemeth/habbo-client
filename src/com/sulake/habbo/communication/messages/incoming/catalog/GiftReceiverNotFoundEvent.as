
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.GiftReceiverNotFoundParser;

    public class GiftReceiverNotFoundEvent extends MessageEvent implements IMessageEvent 
    {

        public function GiftReceiverNotFoundEvent(_arg_1:Function)
        {
            super(_arg_1, GiftReceiverNotFoundParser);
        }
        public function getParser():GiftReceiverNotFoundParser
        {
            return ((this._parser as GiftReceiverNotFoundParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// GiftReceiverNotFoundParser = "_-1N6" (String#5294, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


