
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubOfferData 
    {

        private var _offerId:int;
        private var _productCode:String;
        private var _price:int;
        private var _upgrade:Boolean;
        private var _vip:Boolean;
        private var _periods:int;
        private var _daysLeftAfterPurchase:int;
        private var _year:int;
        private var _month:int;
        private var _day:int;

        public function ClubOfferData(_arg_1:IMessageDataWrapper)
        {
            this._offerId = _arg_1.readInteger();
            this._productCode = _arg_1.readString();
            this._price = _arg_1.readInteger();
            this._upgrade = _arg_1.readBoolean();
            this._vip = _arg_1.readBoolean();
            this._periods = _arg_1.readInteger();
            this._daysLeftAfterPurchase = _arg_1.readInteger();
            this._year = _arg_1.readInteger();
            this._month = _arg_1.readInteger();
            this._day = _arg_1.readInteger();
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

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ClubOfferData = "_-0TZ" (String#4170, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// upgrade = "_-2mZ" (String#20944, DoABC#2)
// periods = "_-0cr" (String#15546, DoABC#2)
// daysLeftAfterPurchase = "_-2JK" (String#19782, DoABC#2)
// _price = "_-35-" (String#631, DoABC#2)
// _vip = "_-32c" (String#7361, DoABC#2)
// _periods = "_-0Df" (String#3820, DoABC#2)
// _daysLeftAfterPurchase = "_-2Mu" (String#6496, DoABC#2)
// _year = "_-0M5" (String#4002, DoABC#2)
// _month = "_-3X" (String#7737, DoABC#2)
// _day = "_-We" (String#8340, DoABC#2)


