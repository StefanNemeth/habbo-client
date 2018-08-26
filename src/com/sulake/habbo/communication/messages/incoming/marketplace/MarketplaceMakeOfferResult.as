
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;

    public class MarketplaceMakeOfferResult extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceMakeOfferResult(_arg_1:Function)
        {
            super(_arg_1, MarketplaceMakeOfferResultParser);
        }
        public function getParser():MarketplaceMakeOfferResultParser
        {
            return ((_parser as MarketplaceMakeOfferResultParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketplaceMakeOfferResult = "_-0tP" (String#4715, DoABC#2)
// MarketplaceMakeOfferResultParser = "_-G-" (String#22853, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


