
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedParser;

    public class TradingCompletedEvent extends MessageEvent 
    {

        public function TradingCompletedEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function getParser():TradingCompletedParser
        {
            return ((_parser as TradingCompletedParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingCompletedEvent = "_-2gA" (String#6872, DoABC#2)
// TradingCompletedParser = "_-1vy" (String#18795, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


