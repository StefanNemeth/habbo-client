
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;

    public class TradingAcceptEvent extends MessageEvent 
    {

        public function TradingAcceptEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function get userID():int
        {
            return (this.getParser().userID);
        }
        public function get userAccepts():Boolean
        {
            return (this.getParser().userAccepts);
        }
        public function getParser():TradingAcceptParser
        {
            return ((_parser as TradingAcceptParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingAcceptParser = "_-2oK" (String#21016, DoABC#2)
// TradingAcceptEvent = "_-38I" (String#7478, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// userAccepts = "_-sY" (String#24380, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


