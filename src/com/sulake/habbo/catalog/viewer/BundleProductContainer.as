
package com.sulake.habbo.catalog.viewer
{
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class BundleProductContainer extends ProductContainer implements IItemGrid 
    {

        private static const _SafeStr_5027:int = 6;

        private var _SafeStr_5028:BitmapData;

        public function BundleProductContainer(_arg_1:Offer, _arg_2:Array)
        {
            super(_arg_1, _arg_2);
            var _local_3:BitmapDataAsset = (_arg_1.page.viewer.catalog.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset);
            if (_local_3 != null){
                this._SafeStr_5028 = (_local_3.content as BitmapData);
            }
            else {
                this._SafeStr_5028 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
        }
        override public function dispose():void
        {
            if (disposed){
                return;
            };
            this._SafeStr_5028 = null;
            super.dispose();
        }
        override public function initProductIcon(_arg_1:IRoomEngine):void
        {
            setIconImage(this._SafeStr_5028.clone(), true);
        }
        public function populateItemGrid(_arg_1:IItemGridWindow, _arg_2:IScrollbarWindow, _arg_3:XML):void
        {
            var _local_4:IProduct;
            var _local_5:IWindowContainer;
            var _local_6:IBorderWindow;
            var _local_7:BitmapData;
            var _local_8:IIconWindow;
            for each (_local_4 in offer.productContainer.products) {
                _local_5 = (offer.page.viewer.catalog.windowManager.buildFromXML(_arg_3) as IWindowContainer);
                _local_6 = (_local_5.findChildByName("bg") as IBorderWindow);
                if (_local_6 != null){
                    _local_8 = (_local_6.findChildByName("clubLevelIcon") as IIconWindow);
                    if (_local_8 != null){
                        _local_8.visible = false;
                    };
                };
                _arg_1.addGridItem(_local_5);
                _local_4.view = _local_5;
                _local_7 = _local_4.initIcon(this);
                if (_local_7 != null){
                    _local_7.dispose();
                };
                _local_4.grid = this;
            };
            if (_arg_2 != null){
                _arg_2.visible = (offer.productContainer.products.length > _SafeStr_5027);
            };
        }
        public function setBundleCounter(_arg_1:int):void
        {
            var _local_2:ITextWindow = (_view.findChildByName("bundleCounter") as ITextWindow);
            if (_local_2 != null){
                _local_2.text = (_arg_1 + "");
            };
        }
        public function select(_arg_1:IGridItem):void
        {
            Logger.log(("Product Bundle, select item: " + _arg_1));
        }
        public function startDragAndDrop(_arg_1:IGridItem):Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.catalog.viewer

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// ProductContainer = "_-X-" (String#8349, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// BundleProductContainer = "_-1p3" (String#5839, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// startDragAndDrop = "_-Di" (String#7945, DoABC#2)
// setIconImage = "_-0p8" (String#16022, DoABC#2)
// initIcon = "_-0Fm" (String#1437, DoABC#2)
// _SafeStr_5027 = "_-1Ls" (String#17352, DoABC#2)
// _SafeStr_5028 = "_-2Ho" (String#19718, DoABC#2)
// populateItemGrid = "_-2Ws" (String#892, DoABC#2)
// setBundleCounter = "_-0U2" (String#15206, DoABC#2)


