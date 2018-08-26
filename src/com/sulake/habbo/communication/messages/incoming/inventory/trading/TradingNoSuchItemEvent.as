
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNoSuchItemParser;

    public class TradingNoSuchItemEvent extends MessageEvent 
    {

        public function TradingNoSuchItemEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function getParser():TradingNoSuchItemParser
        {
            return ((_parser as TradingNoSuchItemParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingNoSuchItemEvent = "_-FO" (String#22828, DoABC#2)
// TradingNoSuchItemParser = "_-go" (String#8528, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


