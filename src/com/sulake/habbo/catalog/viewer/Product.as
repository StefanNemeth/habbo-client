
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.ImageResult;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;

    public class Product extends ProductGridItem implements IProduct, IGetImageListener 
    {

        private var _productType:String;
        private var _productClassId:int;
        private var _extraParam:String;
        private var _productCount:int;
        private var _expiration:int;
        private var _productData:IProductData;
        private var _furnitureData:IFurnitureData;

        public function Product(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:IProductData, _arg_7:IFurnitureData)
        {
            this._productType = _arg_1;
            this._productClassId = _arg_2;
            this._extraParam = _arg_3;
            this._productCount = _arg_4;
            this._expiration = _arg_5;
            this._productData = _arg_6;
            this._furnitureData = _arg_7;
        }
        public function get productType():String
        {
            return (this._productType);
        }
        public function get productClassId():int
        {
            return (this._productClassId);
        }
        public function set extraParam(_arg_1:String):void
        {
            this._extraParam = _arg_1;
        }
        public function get extraParam():String
        {
            return (this._extraParam);
        }
        public function get productCount():int
        {
            return (this._productCount);
        }
        public function get expiration():int
        {
            return (this._expiration);
        }
        public function get productData():IProductData
        {
            return (this._productData);
        }
        public function get furnitureData():IFurnitureData
        {
            return (this._furnitureData);
        }
        override public function dispose():void
        {
            if (disposed){
                return;
            };
            this._productType = "";
            this._productClassId = 0;
            this._extraParam = "";
            this._productCount = 0;
            this._expiration = 0;
            this._productData = null;
            super.dispose();
        }
        public function initIcon(_arg_1:IProductContainer, _arg_2:IGetImageListener=null, _arg_3:IPurchasableOffer=null, _arg_4:IBitmapWrapperWindow=null, _arg_5:Function=null):BitmapData
        {
            var _local_9:ImageResult;
            var _local_10:String;
            if (disposed){
                return (null);
            };
            var _local_6:BitmapData;
            if (_arg_2 == null){
                _arg_2 = this;
            };
            var _local_7:IRoomEngine = (_arg_1 as ProductContainer).offer.page.viewer.roomEngine;
            var _local_8:HabboCatalog = ((_arg_1 as ProductContainer).offer.page.viewer.catalog as HabboCatalog);
            switch (this._productType){
                case ProductTypeEnum._SafeStr_5017:
                    _local_9 = _local_7.getFurnitureIcon(this.productClassId, _arg_2);
                    break;
                case ProductTypeEnum._SafeStr_5019:
                    if (_arg_3){
                        _local_10 = "";
                        switch (this._furnitureData.name){
                            case "floor":
                                _local_10 = ["th", this._furnitureData.name, _arg_3.productContainer.firstProduct.extraParam].join("_");
                                break;
                            case "wallpaper":
                                _local_10 = ["th", "wall", _arg_3.productContainer.firstProduct.extraParam].join("_");
                                break;
                            case "landscape":
                                _local_10 = ["th", this._furnitureData.name, _arg_3.productContainer.firstProduct.extraParam.replace(".", "_"), "001"].join("_");
                                break;
                            default:
                                _local_9 = _local_7.getWallItemIcon(this.productClassId, _arg_2, this._extraParam);
                        };
                        _local_8.PendingImage(_arg_4, _local_10, _arg_5);
                    }
                    else {
                        _local_9 = _local_7.getWallItemIcon(this.productClassId, _arg_2, this._extraParam);
                    };
                    break;
                case ProductTypeEnum._SafeStr_5021:
                    _local_6 = _local_8.getPixelEffectIcon(this.productClassId);
                    if (_arg_2 == this){
                        this.ProductGridItem(_local_6, true);
                    };
                    break;
                case ProductTypeEnum._SafeStr_5023:
                    _local_6 = _local_8.getSubscriptionProductIcon(this.productClassId);
                    break;
                default:
                    Logger.log(("[Product] Can not yet handle this type of product: " + this.productType));
            };
            if (_local_9 != null){
                _local_6 = _local_9.data;
                if (_arg_2 == this){
                    this.ProductGridItem(_local_6, true);
                };
            };
            return (_local_6);
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            Logger.log(("[Product] Bundle Icon Image Ready!" + _arg_1));
            ProductGridItem(_arg_2, true);
        }
        override public function set view(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindow;
            var _local_3:ITextWindow;
            if (!_arg_1){
                return;
            };
            super.view = _arg_1;
            if (this._productCount > 1){
                _local_2 = _view.findChildByName("multiContainer");
                if (_local_2){
                    _local_2.visible = true;
                };
                _local_3 = (_view.findChildByName("multiCounter") as ITextWindow);
                if (_local_3){
                    _local_3.text = ("x" + this.productCount);
                };
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer

// ImageResult = "_-31w" (String#21576, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// ProductGridItem = "_-24U" (String#6129, DoABC#2)
// Product = "_-2z8" (String#7267, DoABC#2)
// ProductContainer = "_-X-" (String#8349, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// ProductGridItem = "_-0p8" (String#16022, DoABC#2)
// _productType = "_-1TF" (String#5419, DoABC#2)
// _productClassId = "_-0Gm" (String#3890, DoABC#2)
// _extraParam = "_-2Ad" (String#880, DoABC#2)
// _productCount = "_-1K0" (String#5242, DoABC#2)
// _expiration = "_-2ZN" (String#1901, DoABC#2)
// _productData = "_-fz" (String#8511, DoABC#2)
// furnitureData = "_-2GE" (String#6370, DoABC#2)
// initIcon = "_-0Fm" (String#1437, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// PendingImage = "_-1q7" (String#18549, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// getPixelEffectIcon = "_-1HA" (String#5192, DoABC#2)
// _SafeStr_5021 = "_-h-" (String#23930, DoABC#2)
// getSubscriptionProductIcon = "_-dz" (String#8484, DoABC#2)
// _SafeStr_5023 = "_-hJ" (String#23942, DoABC#2)


