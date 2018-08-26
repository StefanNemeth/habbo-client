
package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingOpenParser implements IMessageParser 
    {

        private var _userID:int;
        private var _userCanTrade:Boolean;
        private var _otherUserID:int;
        private var _otherUserCanTrade:Boolean;

        public function get userID():int
        {
            return (this._userID);
        }
        public function get userCanTrade():Boolean
        {
            return (this._userCanTrade);
        }
        public function get otherUserID():int
        {
            return (this._otherUserID);
        }
        public function get otherUserCanTrade():Boolean
        {
            return (this._otherUserCanTrade);
        }
        public function flush():Boolean
        {
            this._userID = -1;
            this._userCanTrade = false;
            this._otherUserID = -1;
            this._otherUserCanTrade = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._userID = _arg_1.readInteger();
            this._userCanTrade = (_arg_1.readInteger() == 1);
            this._otherUserID = _arg_1.readInteger();
            this._otherUserCanTrade = (_arg_1.readInteger() == 1);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.trading

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// TradingOpenParser = "_-0we" (String#16297, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// userCanTrade = "_-6P" (String#22480, DoABC#2)
// otherUserID = "_-5F" (String#22431, DoABC#2)
// otherUserCanTrade = "_-0wj" (String#16300, DoABC#2)
// _userCanTrade = "_-1dz" (String#18057, DoABC#2)
// _otherUserID = "_-2xE" (String#21359, DoABC#2)
// _otherUserCanTrade = "_-1As" (String#5089, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


