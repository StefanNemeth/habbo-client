
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class SingleProductContainer extends ProductContainer 
    {

        public function SingleProductContainer(_arg_1:Offer, _arg_2:Array)
        {
            super(_arg_1, _arg_2);
        }
        override public function initProductIcon(_arg_1:IRoomEngine):void
        {
            var _local_2:IProduct = firstProduct;
            var _local_3:BitmapData = _local_2.initIcon(this, this, (offer as IPurchasableOffer), _icon, this.PendingImage);
            this.ProductGridItem(_local_3, true);
        }
        private function PendingImage(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            if (((!(disposed)) && (!((offer.page.viewer.catalog == null))))){
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2 != null){
                    (offer.page.viewer.catalog as HabboCatalog).PendingImage(_icon, _local_2.assetName, null);
                };
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer

// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ProductContainer = "_-X-" (String#8349, DoABC#2)
// SingleProductContainer = "_-1RF" (String#5380, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// ProductGridItem = "_-0p8" (String#16022, DoABC#2)
// initIcon = "_-0Fm" (String#1437, DoABC#2)
// PendingImage = "_-1q7" (String#18549, DoABC#2)
// PendingImage = "_-30x" (String#625, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


