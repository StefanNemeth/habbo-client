
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;

    public class MarketplaceItemStatsEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceItemStatsEvent(_arg_1:Function)
        {
            super(_arg_1, MarketplaceItemStatsParser);
        }
        public function getParser():MarketplaceItemStatsParser
        {
            return ((_parser as MarketplaceItemStatsParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketplaceItemStatsParser = "_-Fz" (String#22851, DoABC#2)
// MarketplaceItemStatsEvent = "_-2iN" (String#6918, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


