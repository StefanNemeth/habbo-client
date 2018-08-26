
package com.sulake.habbo.catalog.recycler
{
    import com.sulake.habbo.catalog.viewer.ProductGridItem;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.room.ImageResult;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.habbo.room.IRoomEngine;

    public class PrizeGridItem extends ProductGridItem implements IGetImageListener, IGridItem 
    {

        protected function initProductIcon(_arg_1:IRoomEngine, _arg_2:String, _arg_3:int, _arg_4:String=""):void
        {
            var _local_6:ImageResult;
            var _local_5:BitmapData;
            switch (_arg_2){
                case ProductTypeEnum._SafeStr_5017:
                    _local_6 = _arg_1.getFurnitureIcon(_arg_3, this);
                    break;
                case ProductTypeEnum._SafeStr_5019:
                    _local_6 = _arg_1.getWallItemIcon(_arg_3, this, _arg_4);
                    break;
                default:
                    Logger.log(("[PrizeItemContainer] Can not yet handle this type of product: " + _arg_2));
                    return;
            };
            if (_local_6 != null){
                _local_5 = _local_6.data;
                ProductGridItem(_local_5, true);
            };
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (disposed){
                return;
            };
            ProductGridItem(_arg_2, true);
        }

    }
}//package com.sulake.habbo.catalog.recycler

// ImageResult = "_-31w" (String#21576, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// ProductGridItem = "_-24U" (String#6129, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// PrizeGridItem = "_-0tB" (String#4710, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// ProductGridItem = "_-0p8" (String#16022, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)


