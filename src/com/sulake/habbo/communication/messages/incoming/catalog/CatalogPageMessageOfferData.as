
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageOfferData 
    {

        private var _offerId:int;
        private var _localizationId:String;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;
        private var _clubLevel:int;
        private var _products:Array;

        public function CatalogPageMessageOfferData(_arg_1:IMessageDataWrapper)
        {
            this._offerId = _arg_1.readInteger();
            this._localizationId = _arg_1.readString();
            this._priceInCredits = _arg_1.readInteger();
            this._priceInActivityPoints = _arg_1.readInteger();
            this._activityPointType = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            this._products = new Array();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._products.push(new CatalogPageMessageProductData(_arg_1));
                _local_3++;
            };
            this._clubLevel = _arg_1.readInteger();
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get localizationId():String
        {
            return (this._localizationId);
        }
        public function get priceInCredits():int
        {
            return (this._priceInCredits);
        }
        public function get priceInActivityPoints():int
        {
            return (this._priceInActivityPoints);
        }
        public function get products():Array
        {
            return (this._products);
        }
        public function get activityPointType():int
        {
            return (this._activityPointType);
        }
        public function get clubLevel():int
        {
            return (this._clubLevel);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// CatalogPageMessageOfferData = "_-1vw" (String#5957, DoABC#2)
// CatalogPageMessageProductData = "_-2mz" (String#7020, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// _localizationId = "_-0Ls" (String#3999, DoABC#2)
// _priceInCredits = "_-29s" (String#1823, DoABC#2)
// _priceInActivityPoints = "_-2WT" (String#1892, DoABC#2)
// _activityPointType = "_-1gC" (String#610, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// _products = "_-f0" (String#640, DoABC#2)


