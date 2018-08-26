
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;

    public class MarketplaceBuyOfferResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceBuyOfferResultEvent(_arg_1:Function)
        {
            super(_arg_1, MarketplaceBuyOfferResultParser);
        }
        public function getParser():MarketplaceBuyOfferResultParser
        {
            return ((_parser as MarketplaceBuyOfferResultParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketplaceBuyOfferResultEvent = "_-0Q7" (String#15066, DoABC#2)
// MarketplaceBuyOfferResultParser = "_-2Ro" (String#6602, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


