
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import flash.display.Sprite;
    import flash.display.Bitmap;

    public class CatalogObjectMover implements IGetImageListener 
    {

        private static const _SafeStr_5077:String = "CatalogOverlaySprite";

        private var _roomEngine:IRoomEngine;
        private var _mainContainer:IWindowContainer;
        private var _state:Boolean = false;

        public function set roomEngine(_arg_1:IRoomEngine):void
        {
            this._roomEngine = _arg_1;
        }
        public function set mainContainer(_arg_1:IWindowContainer):void
        {
            this._mainContainer = _arg_1;
        }
        public function get state():Boolean
        {
            return (this._state);
        }
        public function dispose():void
        {
            this.releaseOverlaySprite();
            this._mainContainer = null;
            this._roomEngine = null;
            this._state = false;
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
        }
        public function onMainContainerEvent(_arg_1:WindowEvent, _arg_2:IWindow, _arg_3:ISelectedRoomObjectData):void
        {
            var _local_4:WindowMouseEvent;
            var _local_5:int;
            var _local_6:int;
            var _local_7:ImageResult;
            if (this._roomEngine == null){
                return;
            };
            _local_4 = (_arg_1 as WindowMouseEvent);
            switch (_arg_1.type){
                case WindowMouseEvent.WME_MOVE:
                    if ((((_arg_3 == null)) || (!((_arg_3.operation == RoomObjectOperationEnum.OBJECT_PLACE))))){
                        return;
                    };
                    _local_5 = _local_4.stageX;
                    _local_6 = _local_4.stageY;
                    if (this.getIconSprite() == null){
                        _local_7 = this.getFurniImageResult(_arg_3);
                        if (_local_7 == null){
                            return;
                        };
                        this.createOverlaySprite(_local_7.data);
                    };
                    this._state = true;
                    this.moveOverlaySprite(_local_5, _local_6);
                    return;
                case WindowMouseEvent.WME_OUT:
                    if (this._state){
                        if ((((((((_local_4.localX >= 0)) && ((_local_4.localX < _arg_1.target.width)))) && ((_local_4.localY >= 0)))) && ((_local_4.localY < _arg_1.target.height)))){
                            return;
                        };
                        this.resetIcon();
                    };
                    return;
            };
        }
        public function resetIcon():void
        {
            if (this._state){
                this.releaseOverlaySprite();
                this._state = false;
            };
        }
        private function getFurniImageResult(_arg_1:ISelectedRoomObjectData):ImageResult
        {
            var _local_2:ImageResult;
            if ((((_arg_1 == null)) || ((this._roomEngine == null)))){
                return (null);
            };
            if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4329){
                return (this._roomEngine.getFurnitureIcon(_arg_1.typeId, this));
            };
            if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4330){
                return (this._roomEngine.getWallItemIcon(_arg_1.typeId, this, _arg_1.instanceData));
            };
            return (null);
        }
        private function createOverlaySprite(_arg_1:BitmapData):void
        {
            if ((((((((_arg_1 == null)) || ((this._mainContainer == null)))) || ((this._mainContainer.desktop == null)))) || (!((this.getIconSprite() == null))))){
                return;
            };
            var _local_2:Sprite = (this._mainContainer.desktop.getDisplayObject() as Sprite);
            var _local_3:Sprite = new Sprite();
            _local_3.name = _SafeStr_5077;
            _local_3.mouseEnabled = false;
            _local_3.visible = true;
            var _local_4:Bitmap = new Bitmap(_arg_1);
            _local_3.addChild(_local_4);
            _local_2.addChild(_local_3);
        }
        private function getIconSprite():Sprite
        {
            if ((((this._mainContainer == null)) || ((this._mainContainer.desktop == null)))){
                return (null);
            };
            var _local_1:Sprite = (this._mainContainer.desktop.getDisplayObject() as Sprite);
            return ((_local_1.getChildByName(_SafeStr_5077) as Sprite));
        }
        private function moveOverlaySprite(_arg_1:int, _arg_2:int):void
        {
            var _local_3:Sprite = this.getIconSprite();
            if (_local_3 == null){
                return;
            };
            _local_3.x = (_arg_1 - Math.round((_local_3.width / 2)));
            _local_3.y = (_arg_2 - Math.round((_local_3.height / 2)));
        }
        private function releaseOverlaySprite():void
        {
            if ((((((this._mainContainer == null)) || ((this._mainContainer.desktop == null)))) || ((this.getIconSprite() == null)))){
                return;
            };
            var _local_1:Sprite = (this._mainContainer.desktop.getDisplayObject() as Sprite);
            var _local_2:Sprite = (_local_1.getChildByName(_SafeStr_5077) as Sprite);
            if (_local_2 == null){
                return;
            };
            var _local_3:Bitmap = (_local_2.removeChildAt(0) as Bitmap);
            if (((!((_local_3 == null))) && (!((_local_3.bitmapData == null))))){
                _local_3.bitmapData.dispose();
            };
            _local_1.removeChild(_local_1.getChildByName(_SafeStr_5077));
        }

    }
}//package com.sulake.habbo.catalog.viewer

// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// RoomObjectOperationEnum = "_-0Zp" (String#15436, DoABC#2)
// CatalogObjectMover = "_-2Op" (String#6538, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// _SafeStr_5077 = "_-137" (String#16585, DoABC#2)
// releaseOverlaySprite = "_-1rD" (String#18591, DoABC#2)
// onMainContainerEvent = "_-09V" (String#3748, DoABC#2)
// operation = "_-0Ag" (String#3770, DoABC#2)
// getIconSprite = "_-2cF" (String#20533, DoABC#2)
// getFurniImageResult = "_-2ST" (String#889, DoABC#2)
// createOverlaySprite = "_-22q" (String#19126, DoABC#2)
// moveOverlaySprite = "_-1L4" (String#17317, DoABC#2)
// resetIcon = "_-1SZ" (String#17604, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


