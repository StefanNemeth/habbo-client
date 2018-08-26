
package com.sulake.habbo.catalog.recycler
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class PrizeViewer implements IGetImageListener 
    {

        private var _SafeStr_10373:IBitmapWrapperWindow;

        public function dispose():void
        {
            this._SafeStr_10373 = null;
        }
        public function viewProduct(_arg_1:IRoomEngine, _arg_2:IWindowContainer, _arg_3:String, _arg_4:int, _arg_5:String, _arg_6:String, _arg_7:String=""):void
        {
            var _local_8:ImageResult;
            this._SafeStr_10373 = (_arg_2.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
            switch (_arg_3){
                case ProductTypeEnum._SafeStr_5017:
                    _local_8 = _arg_1.getFurnitureImage(_arg_4, new Vector3d(90, 0, 0), 64, this, 0, _arg_7);
                    break;
                case ProductTypeEnum._SafeStr_5019:
                    _local_8 = _arg_1.getWallItemImage(_arg_4, new Vector3d(90, 0, 0), 64, this, 0, _arg_7);
                    break;
                default:
                    return;
            };
            if (_local_8 != null){
                this.setPreviewImage(_local_8.data, true);
            };
            var _local_9:ITextWindow = (_arg_2.findChildByName("ctlg_product_name") as ITextWindow);
            if (_local_9 != null){
                _local_9.text = _arg_5;
            };
            _local_9 = (_arg_2.findChildByName("ctlg_description") as ITextWindow);
            if (_local_9 != null){
                _local_9.text = _arg_6;
            };
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            this.setPreviewImage(_arg_2, true);
        }
        private function setPreviewImage(_arg_1:BitmapData, _arg_2:Boolean):void
        {
            var _local_3:Point;
            if (((!((this._SafeStr_10373 == null))) && (!(this._SafeStr_10373.disposed)))){
                if (_arg_1 == null){
                    _arg_1 = new BitmapData(1, 1);
                    _arg_2 = true;
                };
                this._SafeStr_10373.bitmap = new BitmapData(this._SafeStr_10373.width, this._SafeStr_10373.height, true, 0xFFFFFF);
                this._SafeStr_10373.bitmap.fillRect(this._SafeStr_10373.bitmap.rect, 0xFFFFFF);
                _local_3 = new Point(((this._SafeStr_10373.width - _arg_1.width) / 2), ((this._SafeStr_10373.height - _arg_1.height) / 2));
                this._SafeStr_10373.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3, null, null, true);
            };
            if (((_arg_2) && (!((_arg_1 == null))))){
                _arg_1.dispose();
            };
        }

    }
}//package com.sulake.habbo.catalog.recycler

// _SafeStr_10373 = "_-0lc" (String#15885, DoABC#2)
// viewProduct = "_-26X" (String#19273, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// PrizeViewer = "_-2TM" (String#6630, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// setPreviewImage = "_-27B" (String#448, DoABC#2)


