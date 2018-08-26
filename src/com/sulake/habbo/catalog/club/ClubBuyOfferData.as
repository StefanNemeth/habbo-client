
package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public class ClubBuyOfferData implements IPurchasableOffer 
    {

        private var _offerId:int;
        private var _productCode:String;
        private var _price:int;
        private var _upgrade:Boolean;
        private var _vip:Boolean;
        private var _periods:int;
        private var _daysLeftAfterPurchase:int;
        private var _page:ICatalogPage;
        private var _year:int;
        private var _month:int;
        private var _day:int;
        private var _extraParameter:String;
        private var _upgradeHcPeriodToVip:Boolean = false;
        private var _disposed:Boolean = false;

        public function ClubBuyOfferData(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:Boolean, _arg_5:Boolean, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int)
        {
            this._offerId = _arg_1;
            this._productCode = _arg_2;
            this._price = _arg_3;
            this._upgrade = _arg_4;
            this._vip = _arg_5;
            this._periods = _arg_6;
            this._daysLeftAfterPurchase = _arg_7;
            this._year = _arg_8;
            this._month = _arg_9;
            this._day = _arg_10;
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._disposed = true;
            this._page = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get extraParameter():String
        {
            return (this._extraParameter);
        }
        public function set extraParameter(_arg_1:String):void
        {
            this._extraParameter = _arg_1;
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get productCode():String
        {
            return (this._productCode);
        }
        public function get price():int
        {
            return (this._price);
        }
        public function get upgrade():Boolean
        {
            return (this._upgrade);
        }
        public function get vip():Boolean
        {
            return (this._vip);
        }
        public function get periods():int
        {
            return (this._periods);
        }
        public function get daysLeftAfterPurchase():int
        {
            return (this._daysLeftAfterPurchase);
        }
        public function get year():int
        {
            return (this._year);
        }
        public function get month():int
        {
            return (this._month);
        }
        public function get day():int
        {
            return (this._day);
        }
        public function get priceInActivityPoints():int
        {
            return (0);
        }
        public function get activityPointType():int
        {
            return (ActivityPointTypeEnum.PIXEL);
        }
        public function get priceInCredits():int
        {
            return (this._price);
        }
        public function get page():ICatalogPage
        {
            return (this._page);
        }
        public function get priceType():String
        {
            return (Offer._SafeStr_4890);
        }
        public function get productContainer():IProductContainer
        {
            return (null);
        }
        public function get localizationId():String
        {
            return (this._productCode);
        }
        public function set page(_arg_1:ICatalogPage):void
        {
            this._page = _arg_1;
        }
        public function get upgradeHcPeriodToVip():Boolean
        {
            return (this._upgradeHcPeriodToVip);
        }
        public function set upgradeHcPeriodToVip(_arg_1:Boolean):void
        {
            this._upgradeHcPeriodToVip = _arg_1;
        }

    }
}//package com.sulake.habbo.catalog.club

// ActivityPointTypeEnum = "_-11n" (String#16529, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// ClubBuyOfferData = "_-2XP" (String#6709, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// _SafeStr_4890 = "_-29q" (String#19397, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// _page = "_-1VJ" (String#607, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// priceType = "_-2ty" (String#7160, DoABC#2)
// upgrade = "_-2mZ" (String#20944, DoABC#2)
// periods = "_-0cr" (String#15546, DoABC#2)
// daysLeftAfterPurchase = "_-2JK" (String#19782, DoABC#2)
// upgradeHcPeriodToVip = "_-1Gg" (String#17139, DoABC#2)
// _price = "_-35-" (String#631, DoABC#2)
// _vip = "_-32c" (String#7361, DoABC#2)
// _periods = "_-0Df" (String#3820, DoABC#2)
// _daysLeftAfterPurchase = "_-2Mu" (String#6496, DoABC#2)
// _year = "_-0M5" (String#4002, DoABC#2)
// _month = "_-3X" (String#7737, DoABC#2)
// _day = "_-We" (String#8340, DoABC#2)
// _extraParameter = "_-1eD" (String#1731, DoABC#2)
// _upgradeHcPeriodToVip = "_-0TC" (String#15178, DoABC#2)


