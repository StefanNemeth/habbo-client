
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAlreadyOpenParser;

    public class TradingAlreadyOpenEvent extends MessageEvent 
    {

        public function TradingAlreadyOpenEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function getParser():TradingAlreadyOpenParser
        {
            return ((_parser as TradingAlreadyOpenParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingAlreadyOpenParser = "_-2FW" (String#19624, DoABC#2)
// TradingAlreadyOpenEvent = "_-QK" (String#8207, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


