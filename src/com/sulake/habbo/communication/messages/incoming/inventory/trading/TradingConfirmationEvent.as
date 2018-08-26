
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;

    public class TradingConfirmationEvent extends MessageEvent 
    {

        public function TradingConfirmationEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function getParser():TradingConfirmationParser
        {
            return ((_parser as TradingConfirmationParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingConfirmationEvent = "_-j2" (String#8578, DoABC#2)
// TradingConfirmationParser = "_-0BB" (String#14493, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


