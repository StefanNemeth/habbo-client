
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubOfferExtendData extends ClubOfferData 
    {

        private var _originalPrice:int;
        private var _subscriptionDaysLeft:int;

        public function ClubOfferExtendData(_arg_1:IMessageDataWrapper)
        {
            super(_arg_1);
            this._originalPrice = _arg_1.readInteger();
            this._subscriptionDaysLeft = _arg_1.readInteger();
        }
        public function get originalPrice():int
        {
            return (this._originalPrice);
        }
        public function get discountAmount():int
        {
            return ((this._originalPrice - this.price));
        }
        public function get subscriptionDaysLeft():int
        {
            return (this._subscriptionDaysLeft);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ClubOfferData = "_-0TZ" (String#4170, DoABC#2)
// originalPrice = "_-39g" (String#21870, DoABC#2)
// discountAmount = "_-0sy" (String#16160, DoABC#2)
// subscriptionDaysLeft = "_-2yY" (String#21412, DoABC#2)
// _originalPrice = "_-1LL" (String#17327, DoABC#2)
// _subscriptionDaysLeft = "_-0Dz" (String#14606, DoABC#2)


