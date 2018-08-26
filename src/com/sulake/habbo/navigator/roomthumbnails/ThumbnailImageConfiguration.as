
package com.sulake.habbo.navigator.roomthumbnails
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class ThumbnailImageConfiguration 
    {

        private var _navigator:HabboNavigator;
        private var _id:int;
        private var _type:int;
        private var _picName:String;
        private var _SafeStr_6047:BitmapData;
        private var _selected:Boolean;
        private var _SafeStr_6042:BitmapData;
        private var _SafeStr_6048:IBitmapWrapperWindow;
        private var _SafeStr_6049:Rectangle;
        private var _SafeStr_6050:int = 1;

        public function ThumbnailImageConfiguration(_arg_1:HabboNavigator, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:BitmapData)
        {
            this._navigator = _arg_1;
            this._id = _arg_2;
            this._type = _arg_3;
            this._picName = _arg_4;
            this._SafeStr_6042 = _arg_5;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get picName():String
        {
            return (this._picName);
        }
        public function getImg():BitmapData
        {
            if (this._SafeStr_6047 == null){
                this._SafeStr_6047 = this._navigator.getButtonImage(this._picName);
            };
            return (this._SafeStr_6047);
        }
        public function registerListImg(_arg_1:IBitmapWrapperWindow):void
        {
            this._SafeStr_6048 = _arg_1;
            this.refreshListImg();
        }
        public function copyTo(_arg_1:BitmapData):void
        {
            var _local_2:BitmapData = this.getImg();
            _arg_1.copyPixels(_local_2, _local_2.rect, new Point(((_arg_1.width - _local_2.width) / 2), (_arg_1.height - _local_2.height)), null, null, true);
        }
        public function setSelected(_arg_1:Boolean):void
        {
            if (this._selected == _arg_1){
                return;
            };
            this._selected = _arg_1;
            this.refreshListImg();
        }
        private function refreshListImg():void
        {
            var _local_1:Rectangle;
            if (this._SafeStr_6049 == null){
                _local_1 = this._SafeStr_6048.bitmap.rect;
                this._SafeStr_6049 = new Rectangle(this._SafeStr_6050, this._SafeStr_6050, (_local_1.width - (2 * this._SafeStr_6050)), (_local_1.height - (2 * this._SafeStr_6050)));
            };
            this._SafeStr_6048.bitmap.fillRect(this._SafeStr_6048.bitmap.rect, 4281545523);
            this._SafeStr_6048.bitmap.fillRect(this._SafeStr_6049, 4284900966);
            this.copyTo(this._SafeStr_6048.bitmap);
            if (this._selected){
                this._SafeStr_6048.bitmap.copyPixels(this._SafeStr_6042, this._SafeStr_6042.rect, new Point(0, 0), null, null, true);
            };
            this._SafeStr_6048.invalidate();
        }

    }
}//package com.sulake.habbo.navigator.roomthumbnails

// ThumbnailImageConfiguration = "_-1Ew" (String#5156, DoABC#2)
// getImg = "_-sM" (String#24375, DoABC#2)
// _SafeStr_6042 = "_-1jt" (String#5751, DoABC#2)
// _picName = "_-1PD" (String#17477, DoABC#2)
// _SafeStr_6047 = "_-0ON" (String#15003, DoABC#2)
// _SafeStr_6048 = "_-oM" (String#24207, DoABC#2)
// _SafeStr_6049 = "_-31f" (String#21565, DoABC#2)
// _SafeStr_6050 = "_-2f" (String#20644, DoABC#2)
// picName = "_-2e6" (String#20607, DoABC#2)
// registerListImg = "_-1ca" (String#17993, DoABC#2)
// refreshListImg = "_-1yN" (String#18904, DoABC#2)


