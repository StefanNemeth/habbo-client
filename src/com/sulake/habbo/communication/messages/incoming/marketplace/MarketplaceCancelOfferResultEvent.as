
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultParser;

    public class MarketplaceCancelOfferResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceCancelOfferResultEvent(_arg_1:Function)
        {
            super(_arg_1, MarketplaceCancelOfferResultParser);
        }
        public function getParser():MarketplaceCancelOfferResultParser
        {
            return ((_parser as MarketplaceCancelOfferResultParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketplaceCancelOfferResultEvent = "_-2jK" (String#20816, DoABC#2)
// MarketplaceCancelOfferResultParser = "_-23v" (String#6120, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


