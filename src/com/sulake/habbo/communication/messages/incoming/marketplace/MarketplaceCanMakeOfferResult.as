
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResultParser;

    public class MarketplaceCanMakeOfferResult extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceCanMakeOfferResult(_arg_1:Function)
        {
            super(_arg_1, MarketplaceCanMakeOfferResultParser);
        }
        public function getParser():MarketplaceCanMakeOfferResultParser
        {
            return ((_parser as MarketplaceCanMakeOfferResultParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketplaceCanMakeOfferResultParser = "_-RY" (String#23306, DoABC#2)
// MarketplaceCanMakeOfferResult = "_-1OM" (String#5320, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


