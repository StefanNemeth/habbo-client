
package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingCloseParser implements IMessageParser 
    {

        private var _userId:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._userId = _arg_1.readInteger();
            return (true);
        }
        public function get userID():int
        {
            return (this._userId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.trading

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// TradingCloseParser = "_-1qf" (String#18570, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


