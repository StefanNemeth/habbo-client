
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.room.IRoomEngine;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;

    public class ProductContainer extends ProductGridItem implements IGetImageListener, IProductContainer, IGridItem 
    {

        protected var _offer:Offer;
        private var _products:Array;

        public function ProductContainer(_arg_1:Offer, _arg_2:Array)
        {
            this._offer = _arg_1;
            this._products = _arg_2;
        }
        public function get products():Array
        {
            return (this._products);
        }
        public function get firstProduct():IProduct
        {
            return ((this._products[0] as IProduct));
        }
        public function get offer():Offer
        {
            return (this._offer);
        }
        override public function dispose():void
        {
            var _local_1:Product;
            if (disposed){
                return;
            };
            for each (_local_1 in this._products) {
                _local_1.dispose();
            };
            this._products = null;
            super.dispose();
        }
        public function initProductIcon(_arg_1:IRoomEngine):void
        {
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            ProductGridItem(_arg_2, true);
        }
        public function setClubIconLevel(_arg_1:int):void
        {
            if (view == null){
                return;
            };
            var _local_2:IBorderWindow = (view.findChildByName("bg") as IBorderWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:IIconWindow = (_local_2.findChildByName("clubLevelIcon") as IIconWindow);
            if (_local_3 == null){
                return;
            };
            switch (this.offer.clubLevel){
                case HabboClubLevelEnum._SafeStr_3942:
                    _local_3.visible = false;
                    return;
                case HabboClubLevelEnum._SafeStr_3943:
                    _local_3.visible = true;
                    _local_3.style = 11;
                    _local_3.x = (_local_3.x + 3);
                    return;
                case HabboClubLevelEnum._SafeStr_3939:
                    _local_3.visible = true;
                    _local_3.style = 12;
                    return;
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer

// Offer = "_-0m2" (String#4550, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// ProductGridItem = "_-24U" (String#6129, DoABC#2)
// Product = "_-2z8" (String#7267, DoABC#2)
// ProductContainer = "_-X-" (String#8349, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// setClubIconLevel = "_-09M" (String#3745, DoABC#2)
// ProductGridItem = "_-0p8" (String#16022, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// _products = "_-f0" (String#640, DoABC#2)


