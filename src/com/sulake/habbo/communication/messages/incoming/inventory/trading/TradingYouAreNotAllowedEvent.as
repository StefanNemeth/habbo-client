
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;

    public class TradingYouAreNotAllowedEvent extends MessageEvent 
    {

        public function TradingYouAreNotAllowedEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function getParser():TradingYouAreNotAllowedParser
        {
            return ((_parser as TradingYouAreNotAllowedParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingYouAreNotAllowedParser = "_-43" (String#22379, DoABC#2)
// TradingYouAreNotAllowedEvent = "_-2vg" (String#7191, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


