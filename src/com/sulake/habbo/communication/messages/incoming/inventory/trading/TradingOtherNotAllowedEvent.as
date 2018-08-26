
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedParser;

    public class TradingOtherNotAllowedEvent extends MessageEvent 
    {

        public function TradingOtherNotAllowedEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function getParser():TradingOtherNotAllowedParser
        {
            return ((_parser as TradingOtherNotAllowedParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingOtherNotAllowedParser = "_-0Lk" (String#14903, DoABC#2)
// TradingOtherNotAllowedEvent = "_-PA" (String#8187, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


