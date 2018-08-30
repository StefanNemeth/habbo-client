
package com.sulake.habbo.inventory.common
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class ThumbListManager 
    {

        private var _assets:IAssetLibrary;
        private var _SafeStr_5101:IThumbListDataProvider;
        private var _SafeStr_5102:int;
        private var _SafeStr_5103:int = 1;
        private var _listImage:BitmapData;
        private var _SafeStr_5105:int;
        private var _SafeStr_5106:int;
        private var _SafeStr_5107:int;
        private var _SafeStr_5108:int;
        private var _thumbWidth:int;
        private var _SafeStr_5109:int;
        private var _SafeStr_5110:BitmapData;
        private var _itemBgImageSelected:BitmapData;

        public function ThumbListManager(_arg_1:IAssetLibrary, _arg_2:IThumbListDataProvider, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:int)
        {
            this._assets = _arg_1;
            this._SafeStr_5101 = _arg_2;
            var _local_7:BitmapDataAsset = BitmapDataAsset(this._assets.getAssetByName(_arg_3));
            if (_local_7 != null){
                this._SafeStr_5110 = BitmapData(_local_7.content);
            };
            var _local_8:BitmapDataAsset = BitmapDataAsset(this._assets.getAssetByName(_arg_4));
            if (_local_8 != null){
                this._itemBgImageSelected = BitmapData(_local_8.content);
            };
            this._thumbWidth = this._SafeStr_5110.width;
            this._SafeStr_5109 = this._SafeStr_5110.height;
            this._SafeStr_5107 = _arg_5;
            this._SafeStr_5108 = _arg_6;
            this._SafeStr_5102 = Math.floor((this._SafeStr_5107 / this._thumbWidth));
            this._listImage = new BitmapData(this._SafeStr_5107, this._SafeStr_5108);
        }
        public function dispose():void
        {
            this._SafeStr_5101 = null;
            this._listImage = null;
        }
        public function updateImageFromList():void
        {
            var _local_4:int;
            var _local_5:IThumbListDrawableItem;
            var _local_6:BitmapData;
            this._SafeStr_5103 = this.resolveRowCountFromList();
            if (this._SafeStr_5103 == 0){
                this._listImage = new BitmapData(this._SafeStr_5107, this._SafeStr_5108);
                return;
            };
            this._listImage = new BitmapData(Math.max((this._SafeStr_5102 * this._thumbWidth), this._SafeStr_5107), Math.max((this._SafeStr_5103 * this._SafeStr_5109), this._SafeStr_5108), true, 0xFFFFFF);
            this._listImage.fillRect(this._listImage.rect, 0xFFFFFFFF);
            var _local_1:int;
            var _local_2:Array = this.getList();
            var _local_3:int;
            while (_local_3 < this._SafeStr_5103) {
                _local_4 = 0;
                while (_local_4 < this._SafeStr_5102) {
                    if (_local_1 < _local_2.length){
                        _local_5 = _local_2[_local_1];
                        if (_local_5 != null){
                            _local_6 = this.createThumbImage(_local_5.iconImage, _local_5.isSelected);
                            this._listImage.copyPixels(_local_6, _local_6.rect, new Point((_local_4 * this._thumbWidth), (_local_3 * this._SafeStr_5109)), null, null, true);
                        };
                        _local_1++;
                    };
                    _local_4++;
                };
                _local_3++;
            };
        }
        public function addItemAsFirst(_arg_1:IThumbListDrawableItem):void
        {
            var _local_2:BitmapData;
            var _local_4:Rectangle;
            if (_arg_1 == null){
                return;
            };
            var _local_3:Point = this.resolveLastItemGridLoc();
            if ((((_local_3.x == this._SafeStr_5102)) && ((this._listImage.height < (_local_3.y * this._SafeStr_5109))))){
                _local_2 = new BitmapData(this._listImage.width, (this._listImage.height + this._SafeStr_5109));
            }
            else {
                _local_2 = new BitmapData(this._listImage.width, this._listImage.height);
            };
            var _local_5:BitmapData = this.createThumbImage(_arg_1.iconImage, _arg_1.isSelected);
            _local_2.copyPixels(_local_5, _local_5.rect, new Point(0, 0), null, null, true);
            _local_4 = new Rectangle(0, 0, (this._thumbWidth * (this._SafeStr_5102 - 1)), this._SafeStr_5109);
            _local_2.copyPixels(this._listImage, _local_4, new Point(this._thumbWidth, 0), null, null, true);
            _local_4 = new Rectangle((this._thumbWidth * (this._SafeStr_5102 - 1)), 0, this._thumbWidth, this._listImage.height);
            _local_2.copyPixels(this._listImage, _local_4, new Point(0, this._SafeStr_5109), null, null, true);
            _local_4 = new Rectangle(0, this._SafeStr_5109, (this._thumbWidth * (this._SafeStr_5102 - 1)), (this._listImage.height - this._SafeStr_5109));
            _local_2.copyPixels(this._listImage, _local_4, new Point(this._thumbWidth, this._SafeStr_5109), null, null, true);
            this._listImage = _local_2;
        }
        public function replaceItemImage(_arg_1:int, _arg_2:IThumbListDrawableItem):void
        {
            if (_arg_2 == null){
                return;
            };
            var _local_3:Point = this.resolveGridLocationFromIndex(_arg_1);
            var _local_4:Point = new Point((_local_3.x * this._thumbWidth), (_local_3.y * this._SafeStr_5109));
            var _local_5:BitmapData = this.createThumbImage(_arg_2.iconImage, _arg_2.isSelected);
            this._listImage.copyPixels(_local_5, _local_5.rect, _local_4, null, null, true);
        }
        public function getListImage():BitmapData
        {
            return (this._listImage);
        }
        public function removeItemInIndex(_arg_1:int):void
        {
            var _local_2:Point = this.resolveGridLocationFromIndex(_arg_1);
            this.removeItemInImage(_local_2);
        }
        public function removeItemInLocation(_arg_1:Point):void
        {
            var _local_2:Point = this.resolveGridLocationFromImage(_arg_1);
            this.removeItemInImage(_local_2);
        }
        public function updateListItem(_arg_1:int):void
        {
            var _local_2:IThumbListDrawableItem = this.getDrawableItem(_arg_1);
            this.replaceItemImage(_arg_1, _local_2);
        }
        private function getList():Array
        {
            var _local_1:Array;
            if (this._SafeStr_5101 != null){
                _local_1 = this._SafeStr_5101.getDrawableList();
            };
            return (((_local_1) ? _local_1 : new Array()));
        }
        private function getDrawableItem(_arg_1:int):IThumbListDrawableItem
        {
            var _local_2:Array = this.getList();
            if ((((_arg_1 >= 0)) && ((_arg_1 < _local_2.length)))){
                return ((_local_2[_arg_1] as IThumbListDrawableItem));
            };
            return (null);
        }
        private function resolveRowCountFromList():int
        {
            var _local_1:Array = this.getList();
            return (Math.ceil((_local_1.length / this._SafeStr_5102)));
        }
        private function resolveLastItemGridLoc():Point
        {
            var _local_1:Array = this.getList();
            return (this.resolveGridLocationFromIndex((_local_1.length - 1)));
        }
        public function resolveIndexFromImageLocation(_arg_1:Point):int
        {
            var _local_2:Point = this.resolveGridLocationFromImage(_arg_1);
            return (((_local_2.y * this._SafeStr_5102) + _local_2.x));
        }
        private function resolveGridLocationFromImage(_arg_1:Point):Point
        {
            var _local_2:int = Math.floor((_arg_1.y / this._SafeStr_5109));
            var _local_3:int = Math.floor((_arg_1.x / this._thumbWidth));
            return (new Point(_local_3, _local_2));
        }
        private function resolveGridLocationFromIndex(_arg_1:int):Point
        {
            var _local_2:int = Math.floor((_arg_1 / this._SafeStr_5102));
            var _local_3:int = (_arg_1 % this._SafeStr_5102);
            return (new Point(_local_3, _local_2));
        }
        private function removeItemInImage(_arg_1:Point):void
        {
            var _local_2:Rectangle;
            var _local_3:Point;
            var _local_7:int;
            var _local_8:int;
            var _local_9:BitmapData;
            var _local_10:BitmapData;
            var _local_11:BitmapData;
            var _local_12:BitmapData;
            if (_arg_1.x >= this._SafeStr_5102){
                return;
            };
            if (_arg_1.y >= this._SafeStr_5103){
                return;
            };
            var _local_4:int = ((this._SafeStr_5102 - _arg_1.x) - 1);
            _local_2 = new Rectangle(((_arg_1.x + 1) * this._thumbWidth), (_arg_1.y * this._SafeStr_5109), (_local_4 * this._thumbWidth), this._SafeStr_5109);
            _local_3 = new Point((_arg_1.x * this._thumbWidth), (_arg_1.y * this._SafeStr_5109));
            var _local_5:BitmapData = new BitmapData((_local_2.width + this._thumbWidth), _local_2.height);
            _local_5.fillRect(_local_5.rect, 0xFFFFFFFF);
            _local_5.copyPixels(this._listImage, _local_2, new Point(0, 0), null, null, true);
            this._listImage.copyPixels(_local_5, _local_5.rect, _local_3, null, null, true);
            if (_arg_1.y < (this._SafeStr_5103 - 1)){
                _local_7 = (this._listImage.width - this._thumbWidth);
                _local_8 = (this._listImage.height - ((_arg_1.y + 1) * this._SafeStr_5109));
                _local_9 = new BitmapData(_local_7, _local_8);
                _local_2 = new Rectangle(this._thumbWidth, ((_arg_1.y + 1) * this._SafeStr_5109), _local_9.width, _local_9.height);
                _local_9.copyPixels(this._listImage, _local_2, new Point(0, 0), null, null, true);
                _local_10 = new BitmapData(this._thumbWidth, _local_2.height);
                _local_2.x = 0;
                _local_2.width = this._thumbWidth;
                _local_10.copyPixels(this._listImage, _local_2, new Point(0, 0), null, null, true);
                this._listImage.fillRect(new Rectangle(0, (this._listImage.height - this._SafeStr_5109), this._listImage.width, this._SafeStr_5109), 0xFFFFFFFF);
                _local_3 = new Point((this._listImage.width - this._thumbWidth), (_local_2.y - this._SafeStr_5109));
                this._listImage.copyPixels(_local_10, _local_10.rect, _local_3, null, null, true);
                _local_3 = new Point(0, _local_2.y);
                this._listImage.copyPixels(_local_9, _local_9.rect, _local_3, null, null, true);
            };
            var _local_6:int = (this.getList().length - 1);
            if (_local_6 > 0){
                _arg_1 = this.resolveGridLocationFromIndex(_local_6);
                if (_arg_1.x == (this._SafeStr_5102 - 1)){
                    _local_11 = new BitmapData(this._listImage.width, (this._listImage.height - this._SafeStr_5109));
                    _local_2 = new Rectangle(0, 0, this._listImage.width, (this._listImage.height - this._SafeStr_5109));
                    _local_11.copyPixels(this._listImage, _local_2, new Point(0, 0), null, null, true);
                    this._listImage = _local_11;
                    this._SafeStr_5103--;
                };
            };
            if (this._listImage.height < this._SafeStr_5108){
                _local_12 = new BitmapData(this._listImage.width, this._SafeStr_5108);
                _local_12.fillRect(_local_12.rect, 0xFFFFFFFF);
                _local_12.copyPixels(this._listImage, this._listImage.rect, new Point(0, 0), null, null, true);
                this._listImage = _local_12;
            };
        }
        private function createThumbImage(_arg_1:BitmapData=null, _arg_2:Boolean=false):BitmapData
        {
            var _local_4:Point;
            var _local_3:BitmapData = new BitmapData(this._SafeStr_5110.width, this._SafeStr_5110.height);
            if (_arg_2){
                _local_3.copyPixels(this._itemBgImageSelected, this._SafeStr_5110.rect, new Point(0, 0), null, null, false);
            }
            else {
                _local_3.copyPixels(this._SafeStr_5110, this._SafeStr_5110.rect, new Point(0, 0), null, null, false);
            };
            if (_arg_1 != null){
                _local_4 = new Point(((_local_3.width - _arg_1.width) / 2), ((_local_3.height - _arg_1.height) / 2));
                _local_3.copyPixels(_arg_1, _arg_1.rect, _local_4, null, null, true);
            };
            return (_local_3);
        }

    }
}//package com.sulake.habbo.inventory.common

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IThumbListDrawableItem = "_-Sg" (String#8260, DoABC#2)
// IThumbListDataProvider = "_-2SK" (String#6616, DoABC#2)
// ThumbListManager = "_-1u4" (String#18719, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// getDrawableList = "_-1QO" (String#5357, DoABC#2)
// _SafeStr_5101 = "_-2hR" (String#20749, DoABC#2)
// _SafeStr_5102 = "_-3Jj" (String#22273, DoABC#2)
// _SafeStr_5103 = "_-1C" (String#16941, DoABC#2)
// _listImage = "_-0TL" (String#15184, DoABC#2)
// _SafeStr_5105 = "_-pA" (String#24240, DoABC#2)
// _SafeStr_5106 = "_-Ja" (String#22987, DoABC#2)
// _SafeStr_5107 = "_-2ii" (String#20795, DoABC#2)
// _SafeStr_5108 = "_-07V" (String#14345, DoABC#2)
// _SafeStr_5109 = "_-td" (String#24432, DoABC#2)
// _SafeStr_5110 = "_-0za" (String#16410, DoABC#2)
// updateImageFromList = "_-eL" (String#23815, DoABC#2)
// resolveRowCountFromList = "_-1ga" (String#18162, DoABC#2)
// getList = "_-10L" (String#16476, DoABC#2)
// createThumbImage = "_-3JY" (String#22265, DoABC#2)
// addItemAsFirst = "_-29M" (String#19379, DoABC#2)
// resolveLastItemGridLoc = "_-0ww" (String#16308, DoABC#2)
// replaceItemImage = "_-C1" (String#22692, DoABC#2)
// resolveGridLocationFromIndex = "_-26q" (String#19284, DoABC#2)
// getListImage = "_-2gm" (String#20719, DoABC#2)
// removeItemInIndex = "_-2qM" (String#21096, DoABC#2)
// removeItemInImage = "_-2wo" (String#21337, DoABC#2)
// removeItemInLocation = "_-2h-" (String#20727, DoABC#2)
// resolveGridLocationFromImage = "_-2Z-" (String#20396, DoABC#2)
// updateListItem = "_-nE" (String#24162, DoABC#2)
// getDrawableItem = "_-0eB" (String#15594, DoABC#2)
// resolveIndexFromImageLocation = "_-0fW" (String#15651, DoABC#2)


