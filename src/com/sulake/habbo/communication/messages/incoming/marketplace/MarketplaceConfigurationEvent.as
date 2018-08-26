
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;

    public class MarketplaceConfigurationEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceConfigurationEvent(_arg_1:Function)
        {
            super(_arg_1, MarketplaceConfigurationParser);
        }
        public function getParser():MarketplaceConfigurationParser
        {
            return ((_parser as MarketplaceConfigurationParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketplaceConfigurationEvent = "_-2eI" (String#6839, DoABC#2)
// MarketplaceConfigurationParser = "_-0-L" (String#14026, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


