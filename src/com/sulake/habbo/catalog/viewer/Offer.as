
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;

    public class Offer implements IPurchasableOffer 
    {

        public static const _SafeStr_4885:String = "pricing_model_unknown";
        public static const _SafeStr_4886:String = "pricing_model_single";
        public static const _SafeStr_4887:String = "pricing_model_multi";
        public static const _SafeStr_4888:String = "pricing_model_bundle";
        public static const _SafeStr_4889:String = "price_type_none";
        public static const _SafeStr_4890:String = "price_type_credits";
        public static const _SafeStr_4891:String = "price_type_activitypoints";
        public static const _SafeStr_4892:String = "price_type_credits_and_activitypoints";

        private var _pricingModel:String;
        private var _priceType:String;
        private var _offerId:int;
        private var _localizationId:String;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;
        private var _page:ICatalogPage;
        private var _productContainer:IProductContainer;
        private var _disposed:Boolean = false;
        private var _clubLevel:int = 0;
        private var _previewCallbackId:int;

        public function Offer(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:Array, _arg_8:ICatalogPage)
        {
            this._offerId = _arg_1;
            this._localizationId = _arg_2;
            this._priceInCredits = _arg_3;
            this._priceInActivityPoints = _arg_4;
            this._activityPointType = _arg_5;
            this._page = _arg_8;
            this._clubLevel = _arg_6;
            this.Offer(_arg_7);
            this.Offer();
            this.Offer(_arg_7);
        }
        public function get clubLevel():int
        {
            return (this._clubLevel);
        }
        public function get page():ICatalogPage
        {
            return (this._page);
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
        public function get activityPointType():int
        {
            return (this._activityPointType);
        }
        public function get productContainer():IProductContainer
        {
            return (this._productContainer);
        }
        public function get pricingModel():String
        {
            return (this._pricingModel);
        }
        public function get priceType():String
        {
            return (this._priceType);
        }
        public function get previewCallbackId():int
        {
            return (this._previewCallbackId);
        }
        public function set previewCallbackId(_arg_1:int):void
        {
            this._previewCallbackId = _arg_1;
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._disposed = true;
            this._offerId = 0;
            this._localizationId = "";
            this._priceInCredits = 0;
            this._priceInActivityPoints = 0;
            this._activityPointType = 0;
            this._page = null;
            if (this._productContainer != null){
                this._productContainer.dispose();
                this._productContainer = null;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        private function Offer(_arg_1:Array):void
        {
            switch (this._pricingModel){
                case _SafeStr_4886:
                    this._productContainer = new SingleProductContainer(this, _arg_1);
                    return;
                case _SafeStr_4887:
                    this._productContainer = new MultiProductContainer(this, _arg_1);
                    return;
                case _SafeStr_4888:
                    this._productContainer = new BundleProductContainer(this, _arg_1);
                    return;
                default:
                    Logger.log(("[Offer] Unknown pricing model" + this._pricingModel));
            };
        }
        private function Offer(_arg_1:Array):void
        {
            var _local_2:Product;
            if (_arg_1.length == 1){
                _local_2 = _arg_1[0];
                if (_local_2.productCount == 1){
                    this._pricingModel = _SafeStr_4886;
                }
                else {
                    this._pricingModel = _SafeStr_4887;
                };
            }
            else {
                if (_arg_1.length > 1){
                    this._pricingModel = _SafeStr_4888;
                }
                else {
                    this._pricingModel = _SafeStr_4885;
                };
            };
        }
        private function Offer():void
        {
            if ((((this._priceInCredits > 0)) && ((this._priceInActivityPoints > 0)))){
                this._priceType = _SafeStr_4892;
            }
            else {
                if (this._priceInCredits > 0){
                    this._priceType = _SafeStr_4890;
                }
                else {
                    if (this._priceInActivityPoints > 0){
                        this._priceType = _SafeStr_4891;
                    }
                    else {
                        this._priceType = _SafeStr_4889;
                    };
                };
            };
        }
        public function clone():Offer
        {
            var _local_3:Product;
            var _local_4:IFurnitureData;
            var _local_5:Product;
            var _local_1:Array = new Array();
            var _local_2:IProductData = this._page.viewer.catalog.getProductData(this.localizationId);
            for each (_local_3 in this._productContainer.products) {
                _local_4 = this._page.viewer.catalog.getFurnitureData(_local_3.productClassId, _local_3.productType);
                _local_5 = new Product(_local_3.productType, _local_3.productClassId, _local_3.extraParam, _local_3.productCount, _local_3.expiration, _local_2, _local_4);
                _local_1.push(_local_5);
            };
            return (new Offer(this.offerId, this.localizationId, this.priceInCredits, this.priceInActivityPoints, this.activityPointType, this.clubLevel, _local_1, this.page));
        }

    }
}//package com.sulake.habbo.catalog.viewer

// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// Product = "_-2z8" (String#7267, DoABC#2)
// SingleProductContainer = "_-1RF" (String#5380, DoABC#2)
// MultiProductContainer = "_-2MD" (String#6486, DoABC#2)
// BundleProductContainer = "_-1p3" (String#5839, DoABC#2)
// _SafeStr_4885 = "_-0Hx" (String#14756, DoABC#2)
// _SafeStr_4886 = "_-04Q" (String#14220, DoABC#2)
// _SafeStr_4887 = "_-0F0" (String#14645, DoABC#2)
// _SafeStr_4888 = "_-2gY" (String#20713, DoABC#2)
// _SafeStr_4889 = "_-1g4" (String#18142, DoABC#2)
// _SafeStr_4890 = "_-29q" (String#19397, DoABC#2)
// _SafeStr_4891 = "_-2mH" (String#20930, DoABC#2)
// _SafeStr_4892 = "_-1hh" (String#18198, DoABC#2)
// _pricingModel = "_-3H0" (String#22165, DoABC#2)
// _priceType = "_-01X" (String#14112, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// _localizationId = "_-0Ls" (String#3999, DoABC#2)
// _priceInCredits = "_-29s" (String#1823, DoABC#2)
// _priceInActivityPoints = "_-2WT" (String#1892, DoABC#2)
// _activityPointType = "_-1gC" (String#610, DoABC#2)
// _page = "_-1VJ" (String#607, DoABC#2)
// _productContainer = "_-Zb" (String#23620, DoABC#2)
// _previewCallbackId = "_-0gN" (String#4431, DoABC#2)
// Offer = "_-PI" (String#23218, DoABC#2)
// Offer = "_-1i3" (String#18212, DoABC#2)
// Offer = "_-uQ" (String#24468, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// pricingModel = "_-1Lx" (String#17355, DoABC#2)
// priceType = "_-2ty" (String#7160, DoABC#2)
// previewCallbackId = "_-2QR" (String#20063, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)


