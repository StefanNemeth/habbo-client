
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IsOfferGiftableMessageParser implements IMessageParser 
    {

        private var _offerId:int;
        private var _isGiftable:Boolean;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._offerId = _arg_1.readInteger();
            this._isGiftable = _arg_1.readBoolean();
            return (true);
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get isGiftable():Boolean
        {
            return (this._isGiftable);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// _isGiftable = "_-2WS" (String#20303, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IsOfferGiftableMessageParser = "_-0cA" (String#4346, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// isGiftable = "_-38z" (String#21842, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


