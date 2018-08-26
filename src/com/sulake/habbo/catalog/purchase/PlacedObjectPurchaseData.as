
package com.sulake.habbo.catalog.purchase
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public class PlacedObjectPurchaseData implements IDisposable 
    {

        private var _disposed:Boolean = false;
        private var _objectId:int;
        private var _category:int;
        private var _roomId:int;
        private var _roomCategory:int;
        private var _wallLocation:String = "";
        private var _x:int = 0;
        private var _y:int = 0;
        private var _direction:int = 0;
        private var _offerId:int;
        private var _productClassId:int;
        private var _productData:IProductData;
        private var _furniData:IFurnitureData;
        private var _extraParameter:String;

        public function PlacedObjectPurchaseData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:IPurchasableOffer)
        {
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
            this._objectId = _arg_3;
            this._category = _arg_4;
            this._wallLocation = _arg_5;
            this._x = _arg_6;
            this._y = _arg_7;
            this._direction = _arg_8;
            this.setOfferData(_arg_9);
        }
        public function dispose():void
        {
            this._disposed = true;
            this._productData = null;
            this._furniData = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        private function setOfferData(_arg_1:IPurchasableOffer):void
        {
            this._offerId = _arg_1.offerId;
            this._productClassId = _arg_1.productContainer.firstProduct.productClassId;
            this._productData = _arg_1.productContainer.firstProduct.productData;
            this._furniData = _arg_1.productContainer.firstProduct.furnitureData;
            this._extraParameter = _arg_1.productContainer.firstProduct.extraParam;
        }
        public function toString():String
        {
            return ([this._roomCategory, this._roomId, this._objectId, this._category, this._wallLocation, this._x, this._y, this._direction, this._offerId, this._productClassId].toString());
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get wallLocation():String
        {
            return (this._wallLocation);
        }
        public function get x():int
        {
            return (this._x);
        }
        public function get y():int
        {
            return (this._y);
        }
        public function get direction():int
        {
            return (this._direction);
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get productClassId():int
        {
            return (this._productClassId);
        }
        public function get extraParameter():String
        {
            return (this._extraParameter);
        }
        public function get furniData():IFurnitureData
        {
            return (this._furniData);
        }

    }
}//package com.sulake.habbo.catalog.purchase

// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// PlacedObjectPurchaseData = "_-0JL" (String#14815, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _wallLocation = "_-1p1" (String#1763, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// _productClassId = "_-0Gm" (String#3890, DoABC#2)
// _productData = "_-fz" (String#8511, DoABC#2)
// furnitureData = "_-2GE" (String#6370, DoABC#2)
// _extraParameter = "_-1eD" (String#1731, DoABC#2)
// _furniData = "_-13M" (String#1612, DoABC#2)
// setOfferData = "_-0mv" (String#15935, DoABC#2)
// wallLocation = "_-12C" (String#16544, DoABC#2)


