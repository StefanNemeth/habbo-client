
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;

    public class TradingNotOpenEvent extends MessageEvent 
    {

        public function TradingNotOpenEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function getParser():TradingNotOpenParser
        {
            return ((_parser as TradingNotOpenParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingNotOpenEvent = "_-2Du" (String#6318, DoABC#2)
// TradingNotOpenParser = "_-22T" (String#19108, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


