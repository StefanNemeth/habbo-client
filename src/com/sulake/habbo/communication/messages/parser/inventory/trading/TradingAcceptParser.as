
package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingAcceptParser implements IMessageParser 
    {

        private var _userID:int;
        private var _userAccepts:Boolean;

        public function get userID():int
        {
            return (this._userID);
        }
        public function get userAccepts():Boolean
        {
            return (this._userAccepts);
        }
        public function flush():Boolean
        {
            this._userID = -1;
            this._userAccepts = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._userID = _arg_1.readInteger();
            this._userAccepts = (_arg_1.readInteger() > 0);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.trading

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// TradingAcceptParser = "_-2oK" (String#21016, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// userAccepts = "_-sY" (String#24380, DoABC#2)
// _userAccepts = "_-0i6" (String#15753, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


