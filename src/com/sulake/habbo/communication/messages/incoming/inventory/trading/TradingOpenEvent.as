
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;

    public class TradingOpenEvent extends MessageEvent 
    {

        public function TradingOpenEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function get userID():int
        {
            return (this.getParser().userID);
        }
        public function get userCanTrade():Boolean
        {
            return (this.getParser().userCanTrade);
        }
        public function get otherUserID():int
        {
            return (this.getParser().otherUserID);
        }
        public function get otherUserCanTrade():Boolean
        {
            return (this.getParser().otherUserCanTrade);
        }
        public function getParser():TradingOpenParser
        {
            return ((_parser as TradingOpenParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingOpenParser = "_-0we" (String#16297, DoABC#2)
// TradingOpenEvent = "_-3JK" (String#7692, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// userCanTrade = "_-6P" (String#22480, DoABC#2)
// otherUserID = "_-5F" (String#22431, DoABC#2)
// otherUserCanTrade = "_-0wj" (String#16300, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


