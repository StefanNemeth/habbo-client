
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;

    public class MarketPlaceOwnOffersEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketPlaceOwnOffersEvent(_arg_1:Function)
        {
            super(_arg_1, MarketPlaceOwnOffersParser);
        }
        public function getParser():MarketPlaceOwnOffersParser
        {
            return ((_parser as MarketPlaceOwnOffersParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketPlaceOwnOffersEvent = "_-2c-" (String#20524, DoABC#2)
// MarketPlaceOwnOffersParser = "_-mo" (String#8656, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


