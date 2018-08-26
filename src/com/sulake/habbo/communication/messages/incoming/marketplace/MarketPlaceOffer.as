
package com.sulake.habbo.communication.messages.incoming.marketplace
{
    public class MarketPlaceOffer 
    {

        private var _offerId:int;
        private var _furniId:int;
        private var _furniType:int;
        private var _stuffData:String;
        private var _price:int;
        private var _status:int;
        private var _timeLeftMinutes:int = -1;
        private var _averagePrice:int;
        private var _offerCount:int;

        public function MarketPlaceOffer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int=-1)
        {
            this._offerId = _arg_1;
            this._furniId = _arg_2;
            this._furniType = _arg_3;
            this._stuffData = _arg_4;
            this._price = _arg_5;
            this._status = _arg_6;
            this._timeLeftMinutes = _arg_7;
            this._averagePrice = _arg_8;
            this._offerCount = _arg_9;
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get furniId():int
        {
            return (this._furniId);
        }
        public function get furniType():int
        {
            return (this._furniType);
        }
        public function get stuffData():String
        {
            return (this._stuffData);
        }
        public function get price():int
        {
            return (this._price);
        }
        public function get status():int
        {
            return (this._status);
        }
        public function get timeLeftMinutes():int
        {
            return (this._timeLeftMinutes);
        }
        public function get averagePrice():int
        {
            return (this._averagePrice);
        }
        public function get offerCount():int
        {
            return (this._offerCount);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.marketplace

// MarketPlaceOffer = "_-1BB" (String#5098, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// _stuffData = "_-1XY" (String#365, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _price = "_-35-" (String#631, DoABC#2)
// _furniType = "_-mO" (String#8651, DoABC#2)
// _timeLeftMinutes = "_-0gq" (String#4442, DoABC#2)
// _averagePrice = "_-53" (String#925, DoABC#2)
// _offerCount = "_-0HU" (String#3906, DoABC#2)
// furniType = "_-26P" (String#6173, DoABC#2)
// timeLeftMinutes = "_-09A" (String#3743, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)


