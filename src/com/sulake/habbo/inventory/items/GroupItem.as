
package com.sulake.habbo.inventory.items
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;

    public class GroupItem implements IGetImageListener 
    {

        private static const _SafeStr_8489:int = 0xCCCCCC;
        private static const _hasUnseenItems:int = 10275685;

        private const _SafeStr_11506:Number = 1;
        private const _SafeStr_11507:Number = 0.2;

        protected var _type:int;
        protected var _items:Map;
        protected var _window:IWindowContainer;
        private var _SafeStr_8491:IWindow;
        private var _SafeStr_8492:IWindow;
        protected var _roomEngine:IRoomEngine;
        protected var _locked:Boolean;
        protected var _selected:Boolean;
        protected var _mainCategory:String;
        protected var _category:int;
        protected var _stuffData:String;
        protected var _extra:Number;
        protected var _iconCallbackId:int = 0;
        protected var _iconImage:BitmapData;
        protected var _previewCallbackId:int;
        protected var _isImageInited:Boolean;
        protected var _SafeStr_11511:Boolean;
        protected var _SafeStr_11512:BitmapData;
        private var _SafeStr_11513:Boolean;

        public function GroupItem(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:IWindowContainer, _arg_5:IRoomEngine, _arg_6:BitmapData, _arg_7:Boolean, _arg_8:String=null, _arg_9:Number=NaN, _arg_10:BitmapData=null, _arg_11:Boolean=false)
        {
            var _local_12:ImageResult;
            super();
            this._type = _arg_1;
            this._window = _arg_4;
            this._SafeStr_8491 = this._window.findChildByTag("BG_COLOR");
            this._SafeStr_8492 = this._window.findChildByName("outline");
            this._roomEngine = _arg_5;
            this._SafeStr_11512 = _arg_6;
            this._SafeStr_11511 = _arg_7;
            this._items = new Map();
            this._mainCategory = _arg_2;
            this._category = _arg_3;
            this._stuffData = _arg_8;
            this._extra = _arg_9;
            if (_arg_10 != null){
                this.setFinalImage(_arg_10);
            }
            else {
                if (!_arg_11){
                    this.initImage();
                };
            };
        }
        public function get mainCategory():String
        {
            return (this._mainCategory);
        }
        private function setFinalImage(_arg_1:BitmapData):void
        {
            this._iconImage = _arg_1;
            this._isImageInited = true;
            this._iconCallbackId = -1;
            this.updateThumbData();
        }
        private function setLoadingImage(_arg_1:BitmapData):void
        {
            this._iconImage = _arg_1;
            this._isImageInited = true;
            this.updateThumbData();
        }
        public function initImage(_arg_1:Boolean=true):void
        {
            var _local_2:ImageResult;
            if (this._iconImage != null){
                return;
            };
            if (this._mainCategory == FurniModelCategory.S){
                _local_2 = this._roomEngine.getFurnitureIcon(this._type, this, String(this._extra));
            }
            else {
                _local_2 = this._roomEngine.getWallItemIcon(this._type, this, this._stuffData);
            };
            if (_local_2.id > 0){
                if (_arg_1){
                    this.setLoadingImage(_local_2.data);
                };
                this._iconCallbackId = _local_2.id;
            }
            else {
                this.setFinalImage(_local_2.data);
                this._iconCallbackId = -1;
            };
            this._isImageInited = true;
        }
        public function get isImageInited():Boolean
        {
            return (this._isImageInited);
        }
        public function get isImageFinished():Boolean
        {
            return ((this._iconCallbackId == -1));
        }
        public function set isSelected(_arg_1:Boolean):void
        {
            if (this._selected != _arg_1){
                this._selected = _arg_1;
                this.updateThumbData();
            };
        }
        public function get window():IWindowContainer
        {
            if (this._window == null){
                return (null);
            };
            if (this._window.disposed){
                return (null);
            };
            return (this._window);
        }
        public function set isLocked(_arg_1:Boolean):void
        {
            this._locked = _arg_1;
        }
        public function get isLocked():Boolean
        {
            return (this._locked);
        }
        public function get isSelected():Boolean
        {
            return (this._selected);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get iconImage():BitmapData
        {
            return (this._iconImage);
        }
        public function set iconImage(_arg_1:BitmapData):void
        {
            this._iconImage = _arg_1;
        }
        public function get iconCallbackId():int
        {
            return (this._iconCallbackId);
        }
        public function set iconCallbackId(_arg_1:int):void
        {
            this._iconCallbackId = _arg_1;
        }
        public function get previewCallbackId():int
        {
            return (this._previewCallbackId);
        }
        public function set previewCallbackId(_arg_1:int):void
        {
            this._previewCallbackId = _arg_1;
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get stuffData():String
        {
            return (this._stuffData);
        }
        public function get extra():Number
        {
            return (this._extra);
        }
        public function set showRecyclable(_arg_1:Boolean):void
        {
            this._SafeStr_11511 = _arg_1;
            this.updateThumbData();
        }
        public function push(_arg_1:IItem, _arg_2:Boolean=false):void
        {
            var _local_3:IItem = this._items.getValue(_arg_1.id);
            if (_local_3 == null){
                this._items.add(_arg_1.id, _arg_1);
            }
            else {
                _local_3.locked = false;
            };
            if (_arg_2){
                this._SafeStr_11513 = true;
            };
            this.updateThumbData();
        }
        public function unshift(_arg_1:IItem):void
        {
            var _local_2:IItem = this._items.getValue(_arg_1.id);
            if (_local_2 == null){
                this._items.unshift(_arg_1.id, _arg_1);
            }
            else {
                _local_2.locked = false;
            };
            this.updateThumbData();
        }
        public function pop():IItem
        {
            var _local_1:IItem;
            if (this._items.length > 0){
                _local_1 = (this._items.getWithIndex((this._items.length - 1)) as IItem);
                this._items.remove(_local_1.id);
            };
            this.updateThumbData();
            return (_local_1);
        }
        public function _SafeStr_7867():IItem
        {
            var _local_1:IItem;
            if (this._items.length > 0){
                _local_1 = (this._items.getWithIndex((this._items.length - 1)) as IItem);
            };
            return (_local_1);
        }
        public function getAt(_arg_1:int):IItem
        {
            return (this._items.getWithIndex(_arg_1));
        }
        public function getOneForTrade():IItem
        {
            var _local_2:IItem;
            var _local_1:int;
            while (_local_1 < this._items.length) {
                _local_2 = this._items.getWithIndex(_local_1);
                if (((!(_local_2.locked)) && (_local_2.tradeable))){
                    return (_local_2);
                };
                _local_1++;
            };
            return (null);
        }
        public function getOneForRecycle():IItem
        {
            var _local_2:IItem;
            var _local_1:int;
            while (_local_1 < this._items.length) {
                _local_2 = this._items.getWithIndex(_local_1);
                if (((!(_local_2.locked)) && (_local_2.recyclable))){
                    this.addLockTo(_local_2.id);
                    return (_local_2);
                };
                _local_1++;
            };
            return (null);
        }
        public function getOneForSelling():IItem
        {
            var _local_2:IItem;
            var _local_1:int;
            while (_local_1 < this._items.length) {
                _local_2 = this._items.getWithIndex(_local_1);
                if (((!(_local_2.locked)) && (_local_2.sellable))){
                    return (_local_2);
                };
                _local_1++;
            };
            return (null);
        }
        public function getFurniIds():Array
        {
            var _local_2:IItem;
            var _local_1:Array = [];
            for each (_local_2 in this._items) {
                _local_1.push(_local_2.ref);
            };
            return (_local_1);
        }
        public function addLockTo(_arg_1:int):Boolean
        {
            var _local_3:IItem;
            var _local_2:int;
            while (_local_2 < this._items.length) {
                _local_3 = this._items.getWithIndex(_local_2);
                if (_local_3.id == _arg_1){
                    _local_3.locked = true;
                    this.updateThumbData();
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }
        public function addLocksFromData(_arg_1:Array):void
        {
            var _local_3:IItem;
            var _local_2:int = (this._items.length - 1);
            while (_local_2 >= 0) {
                _local_3 = this._items.getWithIndex(_local_2);
                if (_arg_1.indexOf(_local_3.ref) >= 0){
                    _local_3.locked = true;
                }
                else {
                    _local_3.locked = false;
                };
                _local_2--;
            };
            this.updateThumbData();
        }
        public function removeLockFrom(_arg_1:int):Boolean
        {
            var _local_3:IItem;
            var _local_2:int;
            while (_local_2 < this._items.length) {
                _local_3 = this._items.getWithIndex(_local_2);
                if (_local_3.id == _arg_1){
                    _local_3.locked = false;
                    this.updateThumbData();
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }
        public function removeAllLocks():void
        {
            var _local_2:IItem;
            var _local_1:int = (this._items.length - 1);
            while (_local_1 >= 0) {
                _local_2 = this._items.getWithIndex(_local_1);
                _local_2.locked = false;
                _local_1--;
            };
            this.updateThumbData();
        }
        public function getTotalCount():int
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:IItem;
            if (this.category == FurniCategory._SafeStr_7054){
                _local_1 = 0;
                _local_2 = 0;
                while (_local_2 < this._items.length) {
                    _local_3 = (this._items.getWithIndex(_local_2) as IItem);
                    _local_1 = (_local_1 + int(_local_3.stuffData));
                    _local_2++;
                };
                return (_local_1);
            };
            return (this._items.length);
        }
        public function getRecyclableCount():int
        {
            var _local_3:IItem;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this._items.length) {
                _local_3 = (this._items.getWithIndex(_local_2) as IItem);
                if (((_local_3.recyclable) && (!(_local_3.locked)))){
                    _local_1++;
                };
                _local_2++;
            };
            return (_local_1);
        }
        public function getTradeableCount():int
        {
            var _local_3:IItem;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this._items.length) {
                _local_3 = (this._items.getWithIndex(_local_2) as IItem);
                if (((_local_3.tradeable) && (!(_local_3.locked)))){
                    _local_1++;
                };
                _local_2++;
            };
            return (_local_1);
        }
        public function remove(_arg_1:int):IItem
        {
            var _local_2:IItem = this._items.getValue(_arg_1);
            if (_local_2){
                this._items.remove(_arg_1);
                this.updateThumbData();
                return (_local_2);
            };
            return (null);
        }
        public function getItem(_arg_1:int):IItem
        {
            return (this._items.getValue(_arg_1));
        }
        public function replaceItem(_arg_1:int, _arg_2:IItem):void
        {
            this._items.add(_arg_1, _arg_2);
            this.updateThumbData();
        }
        public function getUnlockedCount():int
        {
            var _local_1:IItem;
            if (this.category == FurniCategory._SafeStr_7054){
                return (this.getTotalCount());
            };
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < this._items.length) {
                _local_1 = this._items.getWithIndex(_local_3);
                if (!_local_1.locked){
                    _local_2++;
                };
                _local_3++;
            };
            return (_local_2);
        }
        public function updateThumbData():void
        {
            var _local_6:BitmapData;
            var _local_7:BitmapData;
            if (this._window == null){
                return;
            };
            if (this._window.disposed){
                return;
            };
            var _local_1:IBitmapWrapperWindow = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            var _local_2:int = this.getUnlockedCount();
            if (_local_1){
                if (this._iconImage != null){
                    _local_6 = this._iconImage;
                    _local_7 = ((_local_1.bitmap) ? _local_1.bitmap : new BitmapData(_local_1.width, _local_1.height));
                    _local_7.fillRect(_local_7.rect, 0);
                    _local_7.copyPixels(_local_6, _local_6.rect, new Point(((_local_7.width / 2) - (_local_6.width / 2)), ((_local_7.height / 2) - (_local_6.height / 2))));
                    _local_1.bitmap = _local_7;
                };
                if (_local_2 <= 0){
                    this._window.blend = this._SafeStr_11507;
                    _local_1.blend = this._SafeStr_11507;
                }
                else {
                    this._window.blend = this._SafeStr_11506;
                    _local_1.blend = this._SafeStr_11506;
                };
            };
            this._SafeStr_8491.color = ((this._SafeStr_11513) ? _hasUnseenItems : _SafeStr_8489);
            this._SafeStr_8492.visible = this.isSelected;
            var _local_3:IWindow = this._window.findChildByName("number_container");
            var _local_4:ITextWindow = (this._window.findChildByName("number") as ITextWindow);
            if (_local_3){
                _local_3.visible = (_local_2 > 1);
            };
            if (_local_4){
                _local_4.text = String(_local_2);
            };
            var _local_5:IBitmapWrapperWindow = (this._window.findChildByName("recyclable_container") as IBitmapWrapperWindow);
            if (_local_5){
                if (((this._SafeStr_11511) && ((this.getRecyclableCount() > 0)))){
                    _local_5.bitmap = this._SafeStr_11512;
                    _local_5.visible = true;
                }
                else {
                    _local_5.visible = false;
                };
            };
            this._window.invalidate();
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (this._iconCallbackId != _arg_1){
                return;
            };
            this._iconImage = _arg_2;
            this.updateThumbData();
        }
        public function set hasUnseenItems(_arg_1:Boolean):void
        {
            if (this._SafeStr_11513 != _arg_1){
                this._SafeStr_11513 = _arg_1;
                this.updateThumbData();
            };
        }

    }
}//package com.sulake.habbo.inventory.items

// recyclable = "_-A8" (String#7868, DoABC#2)
// _SafeStr_11506 = "_-1U4" (String#17669, DoABC#2)
// _SafeStr_11507 = "_-0WT" (String#15298, DoABC#2)
// _mainCategory = "_-5i" (String#22450, DoABC#2)
// _iconCallbackId = "_-uG" (String#24462, DoABC#2)
// _isImageInited = "_-Kf" (String#23030, DoABC#2)
// _SafeStr_11511 = "_-2qJ" (String#21093, DoABC#2)
// _SafeStr_11512 = "_-3FP" (String#22094, DoABC#2)
// _SafeStr_11513 = "_-1ZV" (String#17871, DoABC#2)
// setFinalImage = "_-35r" (String#21725, DoABC#2)
// setLoadingImage = "_-2N1" (String#19926, DoABC#2)
// isLocked = "_-1W2" (String#17745, DoABC#2)
// iconCallbackId = "_-2dD" (String#20572, DoABC#2)
// getOneForSelling = "_-yg" (String#24639, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// GroupItem = "_-0qS" (String#4647, DoABC#2)
// FurniModelCategory = "_-1a8" (String#5563, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// _stuffData = "_-1XY" (String#365, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// _previewCallbackId = "_-0gN" (String#4431, DoABC#2)
// previewCallbackId = "_-2QR" (String#20063, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// showRecyclable = "_-38g" (String#21829, DoABC#2)
// removeLockFrom = "_-2FC" (String#19612, DoABC#2)
// _SafeStr_7054 = "_-1LD" (String#17322, DoABC#2)
// S = "_-Ch" (String#22713, DoABC#2)
// isImageInited = "_-03j" (String#14191, DoABC#2)
// initImage = "_-2Hp" (String#19719, DoABC#2)
// isImageFinished = "_-0rt" (String#16118, DoABC#2)
// removeAllLocks = "_-O5" (String#23172, DoABC#2)
// addLocksFromData = "_-2gP" (String#20704, DoABC#2)
// addLockTo = "_-oD" (String#24199, DoABC#2)
// ref = "_-Jx" (String#8081, DoABC#2)
// getTotalCount = "_-1uB" (String#18723, DoABC#2)
// replaceItem = "_-1qs" (String#18574, DoABC#2)
// getUnlockedCount = "_-2rq" (String#21148, DoABC#2)
// _SafeStr_7867 = "catch" (String#25155, DoABC#2)
// getOneForTrade = "_-1OC" (String#17442, DoABC#2)
// getOneForRecycle = "_-2GC" (String#19650, DoABC#2)
// getAt = "_-0yu" (String#16388, DoABC#2)
// getFurniIds = "_-2Rv" (String#20115, DoABC#2)
// hasUnseenItems = "_-t0" (String#24406, DoABC#2)
// mainCategory = "_-JH" (String#22977, DoABC#2)
// getTradeableCount = "_-0fV" (String#15650, DoABC#2)
// getRecyclableCount = "_-0sX" (String#16143, DoABC#2)
// tradeable = "_-3E5" (String#7597, DoABC#2)
// _iconImage = "_-bc" (String#2138, DoABC#2)
// _SafeStr_8489 = "_-1YT" (String#1708, DoABC#2)
// _hasUnseenItems = "_-ZF" (String#2132, DoABC#2)
// _SafeStr_8491 = "_-2y0" (String#903, DoABC#2)
// _SafeStr_8492 = "_-zz" (String#2236, DoABC#2)
// _locked = "_-2vv" (String#902, DoABC#2)
// updateThumbData = "_-rZ" (String#8730, DoABC#2)


