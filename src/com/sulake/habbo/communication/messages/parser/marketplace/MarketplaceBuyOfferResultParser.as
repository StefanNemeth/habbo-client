
package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceBuyOfferResultParser implements IMessageParser 
    {

        private var _result:int;
        private var _offerId:int = -1;
        private var _newPrice:int = -1;
        private var _requestedOfferId:int = -1;

        public function get result():int
        {
            return (this._result);
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get newPrice():int
        {
            return (this._newPrice);
        }
        public function get requestedOfferId():int
        {
            return (this._requestedOfferId);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._result = _arg_1.readInteger();
            this._offerId = _arg_1.readInteger();
            this._newPrice = _arg_1.readInteger();
            this._requestedOfferId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.marketplace

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MarketplaceBuyOfferResultParser = "_-2Ro" (String#6602, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _offerId = "_-3Ia" (String#22221, DoABC#2)
// _newPrice = "_-1zr" (String#18962, DoABC#2)
// _requestedOfferId = "_-0sB" (String#16130, DoABC#2)
// newPrice = "_-0sC" (String#16131, DoABC#2)
// requestedOfferId = "_-1R0" (String#17548, DoABC#2)


