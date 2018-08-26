
package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceCancelOfferResultParser implements IMessageParser 
    {

        private var _result:int;
        private var _offerId:int;

        public function get result():int
        {
            return (this._result);
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._offerId = _arg_1.readInteger();
            this._result = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.marketplace

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MarketplaceCancelOfferResultParser = "_-23v" (String#6120, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


