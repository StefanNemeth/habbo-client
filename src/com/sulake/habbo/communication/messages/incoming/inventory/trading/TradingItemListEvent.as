
package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;

    public class TradingItemListEvent extends MessageEvent 
    {

        public function TradingItemListEvent(_arg_1:Function, _arg_2:Class)
        {
            super(_arg_1, _arg_2);
        }
        public function get firstUserID():int
        {
            return (this.getParser().firstUserID);
        }
        public function get secondUserID():int
        {
            return (this.getParser().secondUserID);
        }
        public function get firstUserItemArray():Array
        {
            return (this.getParser().firstUserItemArray);
        }
        public function get secondUserItemArray():Array
        {
            return (this.getParser().secondUserItemArray);
        }
        public function getParser():TradingItemListParser
        {
            return ((_parser as TradingItemListParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.trading

// TradingItemListEvent = "_-1LI" (String#5267, DoABC#2)
// TradingItemListParser = "_-1R6" (String#17550, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// firstUserID = "_-2QT" (String#20065, DoABC#2)
// secondUserID = "_-1i1" (String#18211, DoABC#2)
// firstUserItemArray = "_-1L1" (String#17314, DoABC#2)
// secondUserItemArray = "_-1KD" (String#17282, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


