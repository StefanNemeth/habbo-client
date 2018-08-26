
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;

    public class MarketPlaceOffersEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketPlaceOffersEvent(_arg_1:Function)
        {
            super(_arg_1, MarketPlaceOffersParser);
        }
        public function getParser():MarketPlaceOffersParser
        {
            return ((_parser as MarketPlaceOffersParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketPlaceOffersEvent = "_-sl" (String#24391, DoABC#2)
// MarketPlaceOffersParser = "_-Z6" (String#8394, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


