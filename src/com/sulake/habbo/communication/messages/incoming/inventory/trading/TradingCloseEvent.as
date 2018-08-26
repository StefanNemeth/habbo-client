
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;

    public class TradingCloseEvent extends MessageEvent 
    {

        public function TradingCloseEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function get userID():int
        {
            return (this.getParser().userID);
        }
        public function getParser():TradingCloseParser
        {
            return ((_parser as TradingCloseParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingCloseParser = "_-1qf" (String#18570, DoABC#2)
// TradingCloseEvent = "_-WD" (String#8328, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


