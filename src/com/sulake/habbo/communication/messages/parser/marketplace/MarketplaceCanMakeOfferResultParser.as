
package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceCanMakeOfferResultParser implements IMessageParser 
    {

        private var _tokenCount:int;
        private var _result:int;

        public function get tokenCount():int
        {
            return (this._tokenCount);
        }
        public function get resultCode():int
        {
            return (this._result);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._result = _arg_1.readInteger();
            this._tokenCount = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.marketplace

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MarketplaceCanMakeOfferResultParser = "_-RY" (String#23306, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// tokenCount = "_-pY" (String#24255, DoABC#2)


