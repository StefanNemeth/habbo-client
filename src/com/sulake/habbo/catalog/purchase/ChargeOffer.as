
package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public class ChargeOffer implements IPurchasableOffer 
    {

        private var _info:ChargeInfo;
        private var _disposed:Boolean = false;

        public function ChargeOffer(_arg_1:ChargeInfo)
        {
            this._info = _arg_1;
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._disposed = true;
            this._info = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get offerId():int
        {
            return (0);
        }
        public function get priceInActivityPoints():int
        {
            return ((((this._info)!=null) ? this._info.priceInActivityPoints : 0));
        }
        public function get activityPointType():int
        {
            return ((((this._info)!=null) ? this._info.activityPointType : 0));
        }
        public function get priceInCredits():int
        {
            return ((((this._info)!=null) ? this._info.priceInCredits : 0));
        }
        public function get page():ICatalogPage
        {
            return (null);
        }
        public function get priceType():String
        {
            return (null);
        }
        public function get productContainer():IProductContainer
        {
            return (null);
        }
        public function get localizationId():String
        {
            return (null);
        }

    }
}//package com.sulake.habbo.catalog.purchase

// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// ChargeInfo = "_-1bU" (String#5587, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// ChargeOffer = "_-0nk" (String#4586, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// priceType = "_-2ty" (String#7160, DoABC#2)
// _info = "_-0ry" (String#4686, DoABC#2)


