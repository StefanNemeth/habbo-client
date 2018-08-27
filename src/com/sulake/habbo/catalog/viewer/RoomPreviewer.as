
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IRoomEngine;
    import flash.geom.Rectangle;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.room.utils.Vector3d;
    import flash.utils.getTimer;
    import com.sulake.room.utils.IVector3d;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.geom.Point;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class RoomPreviewer 
    {

        private static const _SafeStr_4926:int = -100;
        private static const _SafeStr_4927:int = 1;
        private static const _SafeStr_4928:int = 1;
        private static const _SafeStr_4929:int = 1;
        private static const _SafeStr_4930:int = 2;
        private static const _SafeStr_4931:int = 2;
        private static const _SafeStr_4932:Number = 0.25;
        private static const _SafeStr_4933:int = 64;
        private static const _SafeStr_4934:int = 32;
        private static const _SafeStr_4935:int = 2500;

        private var _roomEngine:IRoomEngine;
        private var _SafeStr_4936:int = 0;
        private var _SafeStr_4937:int = 0;
        private var _SafeStr_4938:String = "";
        private var _SafeStr_4939:Rectangle = null;
        private var _SafeStr_4940:int = 0;
        private var _SafeStr_4941:int = 0;
        private var _SafeStr_4942:int = 64;
        private var _SafeStr_4943:Boolean;
        private var _SafeStr_4944:Boolean;
        private var _SafeStr_4945:int;

        public function RoomPreviewer(_arg_1:IRoomEngine)
        {
            this._roomEngine = _arg_1;
            if (this._roomEngine != null){
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_ADDED, this.onRoomObjectAdded);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_CONTENT_UPDATED, this.onRoomObjectAdded);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_INITIALIZED, this.onRoomInitialized);
            };
            this.createRoomForPreviews();
        }
        public function dispose():void
        {
            this.reset();
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.events == null))))){
                this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.REOB_OBJECT_ADDED, this.onRoomObjectAdded);
                this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.REOB_OBJECT_CONTENT_UPDATED, this.onRoomObjectAdded);
                this._roomEngine.events.removeEventListener(RoomEngineEvent.REE_INITIALIZED, this.onRoomInitialized);
            };
        }
        private function createRoomForPreviews():void
        {
            var _local_1:int;
            var _local_2:RoomPlaneParser;
            var _local_3:int;
            var _local_4:int;
            if (this._roomEngine != null){
                _local_1 = 7;
                _local_2 = new RoomPlaneParser();
                _local_2.initializeTileMap((_local_1 + 2), (_local_1 + 2));
                _local_3 = 1;
                while (_local_3 < (1 + _local_1)) {
                    _local_4 = 1;
                    while (_local_4 < (1 + _local_1)) {
                        _local_2.setTileHeight(_local_4, _local_3, 0);
                        _local_4++;
                    };
                    _local_3++;
                };
                _local_2.initializeFromTileData();
                this._roomEngine.initializeRoom(_SafeStr_4927, _SafeStr_4926, _local_2.getXML());
                _local_2.dispose();
            };
        }
        public function reset():void
        {
            var _local_1:int;
            var _local_2:int;
            if (this._roomEngine != null){
                _local_1 = this._roomEngine.activeRoomId;
                _local_2 = this._roomEngine.activeRoomCategory;
                this._roomEngine.setActiveRoom(_SafeStr_4927, _SafeStr_4926);
                this._roomEngine.disposeObjectFurniture(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929);
                this._roomEngine.disposeObjectWallItem(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929);
                this._roomEngine.disposeObjectUser(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929);
                this.updatePreviewRoomView();
                this._roomEngine.setActiveRoom(_local_1, _local_2);
            };
            this._SafeStr_4937 = RoomObjectCategoryEnum._SafeStr_4962;
        }
        public function addFurnitureIntoRoom(_arg_1:int, _arg_2:IVector3d):int
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:int = -1;
            if (this._roomEngine != null){
                if ((((this._SafeStr_4937 == RoomObjectCategoryEnum._SafeStr_4329)) && ((this._SafeStr_4936 == _arg_1)))){
                    return (_SafeStr_4929);
                };
                this.reset();
                this._SafeStr_4936 = _arg_1;
                this._SafeStr_4937 = RoomObjectCategoryEnum._SafeStr_4329;
                this._SafeStr_4938 = "";
                _local_4 = this._roomEngine.activeRoomId;
                _local_5 = this._roomEngine.activeRoomCategory;
                this._roomEngine.setActiveRoom(_SafeStr_4927, _SafeStr_4926);
                if (this._roomEngine.addObjectFurniture(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, _arg_1, new Vector3d(_SafeStr_4930, _SafeStr_4931, 0), _arg_2, 0, "")){
                    this._SafeStr_4945 = getTimer();
                    this._SafeStr_4944 = true;
                    _local_3 = _SafeStr_4929;
                    this.updatePreviewRoomView();
                };
                this._roomEngine.setActiveRoom(_local_4, _local_5);
            };
            return (_local_3);
        }
        public function addWallItemIntoRoom(_arg_1:int, _arg_2:IVector3d, _arg_3:String):int
        {
            var _local_4:int = -1;
            if (this._roomEngine != null){
                if ((((((this._SafeStr_4937 == RoomObjectCategoryEnum._SafeStr_4330)) && ((this._SafeStr_4936 == _arg_1)))) && ((this._SafeStr_4938 == _arg_3)))){
                    return (_SafeStr_4929);
                };
                this.reset();
                this._SafeStr_4936 = _arg_1;
                this._SafeStr_4937 = RoomObjectCategoryEnum._SafeStr_4330;
                this._SafeStr_4938 = _arg_3;
                if (this._roomEngine.addObjectWallItem(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, _arg_1, new Vector3d(0.5, 2.3, 1.8), _arg_2, 0, _arg_3)){
                    this._SafeStr_4945 = getTimer();
                    this._SafeStr_4944 = true;
                    return (_SafeStr_4929);
                };
            };
            return (_local_4);
        }
        public function addAvatarIntoRoom(_arg_1:String, _arg_2:int):int
        {
            if (this._roomEngine != null){
                this.reset();
                this._SafeStr_4936 = 1;
                this._SafeStr_4937 = RoomObjectCategoryEnum.OBJECT_CATEGORY_USER;
                this._SafeStr_4938 = _arg_1;
                if (this._roomEngine.addObjectUser(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, new Vector3d(_SafeStr_4930, _SafeStr_4931, 0), new Vector3d(90, 0, 0), 135, 1, _arg_1)){
                    this._SafeStr_4945 = getTimer();
                    this._SafeStr_4944 = true;
                    this._roomEngine.updateObjectUserGesture(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, 1);
                    this._roomEngine.updateObjectUserEffect(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, _arg_2);
                    this._roomEngine.updateObjectUserPosture(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, "std");
                };
                return (_SafeStr_4929);
            };
            return (-1);
        }
        public function changeRoomObjectState():void
        {
            if (this._roomEngine != null){
                this._SafeStr_4944 = false;
                if (this._SafeStr_4937 != RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                    this._roomEngine.changeObjectState(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, this._SafeStr_4937);
                };
            };
        }
        private function checkAutomaticRoomObjectStateChange():void
        {
            var _local_1:int;
            if (this._SafeStr_4944){
                _local_1 = getTimer();
                if (_local_1 > (this._SafeStr_4945 + _SafeStr_4935)){
                    this._SafeStr_4945 = _local_1;
                    if (this._roomEngine != null){
                        this._roomEngine.changeObjectState(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, this._SafeStr_4937);
                    };
                };
            };
        }
        public function getRoomCanvas(_arg_1:int, _arg_2:int):DisplayObject
        {
            var _local_3:DisplayObject;
            var _local_4:IRoomGeometry;
            if (this._roomEngine != null){
                _local_3 = this._roomEngine.createRoomCanvas(_SafeStr_4927, _SafeStr_4926, _SafeStr_4928, _arg_1, _arg_2, this._SafeStr_4942);
                this._roomEngine.setRoomCanvasMask(_SafeStr_4927, _SafeStr_4926, _SafeStr_4928, true);
                _local_4 = this._roomEngine.getRoomCanvasGeometry(_SafeStr_4927, _SafeStr_4926, _SafeStr_4928);
                if (_local_4 != null){
                    _local_4.adjustLocation(new Vector3d(_SafeStr_4930, _SafeStr_4931, 0), 30);
                };
                this._SafeStr_4940 = _arg_1;
                this._SafeStr_4941 = _arg_2;
                return (_local_3);
            };
            return (null);
        }
        private function updatePreviewObjectBoundingRectangle(_arg_1:Point):void
        {
            var _local_3:Rectangle;
            var _local_2:Rectangle = this._roomEngine.getRoomObjectBoundingRectangle(_SafeStr_4927, _SafeStr_4926, _SafeStr_4929, this._SafeStr_4937, _SafeStr_4928);
            if (((!((_local_2 == null))) && (!((_arg_1 == null))))){
                _local_2.offset(-((this._SafeStr_4940 >> 1)), -((this._SafeStr_4941 >> 1)));
                _local_2.offset(-(_arg_1.x), -(_arg_1.y));
                if (this._SafeStr_4939 == null){
                    this._SafeStr_4939 = _local_2;
                }
                else {
                    _local_3 = this._SafeStr_4939.union(_local_2);
                    if (((((((((_local_3.width - this._SafeStr_4939.width) > ((this._SafeStr_4940 - this._SafeStr_4939.width) >> 1))) || (((_local_3.height - this._SafeStr_4939.height) > ((this._SafeStr_4941 - this._SafeStr_4939.height) >> 1))))) || ((this._SafeStr_4939.width < 1)))) || ((this._SafeStr_4939.height < 1)))){
                        this._SafeStr_4939 = _local_3;
                    };
                };
            };
        }
        private function validatePreviewSize(_arg_1:Point):Point
        {
            if ((((this._SafeStr_4939.width < 1)) || ((this._SafeStr_4939.height < 1)))){
                return (_arg_1);
            };
            var _local_2:IRoomGeometry = this._roomEngine.getRoomCanvasGeometry(_SafeStr_4927, _SafeStr_4926, _SafeStr_4928);
            if ((((this._SafeStr_4939.width > (this._SafeStr_4940 * (1 + _SafeStr_4932)))) || ((this._SafeStr_4939.height > (this._SafeStr_4941 * (1 + _SafeStr_4932)))))){
                if (_local_2.isZoomedIn()){
                    _local_2.performZoomOut();
                    this._SafeStr_4942 = _SafeStr_4934;
                    this._SafeStr_4943 = true;
                    _arg_1.x = (_arg_1.x >> 1);
                    _arg_1.y = (_arg_1.y >> 1);
                    this._SafeStr_4939.left = (this._SafeStr_4939.left >> 2);
                    this._SafeStr_4939.right = (this._SafeStr_4939.right >> 2);
                    this._SafeStr_4939.top = (this._SafeStr_4939.top >> 2);
                    this._SafeStr_4939.bottom = (this._SafeStr_4939.bottom >> 2);
                };
            }
            else {
                if (((((this._SafeStr_4939.width << 1) < ((this._SafeStr_4940 * (1 + _SafeStr_4932)) - 5))) && (((this._SafeStr_4939.height << 1) < ((this._SafeStr_4941 * (1 + _SafeStr_4932)) - 5))))){
                    if (((!(_local_2.isZoomedIn())) && (!(this._SafeStr_4943)))){
                        _local_2.performZoomIn();
                        this._SafeStr_4942 = _SafeStr_4933;
                        _arg_1.x = (_arg_1.x << 1);
                        _arg_1.y = (_arg_1.y << 1);
                    };
                };
            };
            return (_arg_1);
        }
        private function getCanvasOffset(_arg_1:Point):Point
        {
            var _local_7:Number;
            if ((((this._SafeStr_4939.width < 1)) || ((this._SafeStr_4939.height < 1)))){
                return (_arg_1);
            };
            var _local_2 = (-((this._SafeStr_4939.left + this._SafeStr_4939.right)) >> 1);
            var _local_3 = (-((this._SafeStr_4939.top + this._SafeStr_4939.bottom)) >> 1);
            var _local_4 = ((this._SafeStr_4941 - this._SafeStr_4939.height) >> 1);
            if (_local_4 > 10){
                _local_3 = (_local_3 + Math.min(15, (_local_4 - 10)));
            }
            else {
                if (this._SafeStr_4937 != RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                    _local_3 = (_local_3 + (5 - Math.max(0, (_local_4 / 2))));
                }
                else {
                    _local_3 = (_local_3 - (5 - Math.min(0, (_local_4 / 2))));
                };
            };
            var _local_5:int = (_local_2 - _arg_1.x);
            var _local_6:int = (_local_3 - _arg_1.y);
            if (((!((_local_5 == 0))) || (!((_local_6 == 0))))){
                _local_7 = Math.sqrt(((_local_5 * _local_5) + (_local_6 * _local_6)));
                if (_local_7 > 10){
                    _local_2 = (_arg_1.x + ((_local_5 * 10) / _local_7));
                    _local_3 = (_arg_1.y + ((_local_6 * 10) / _local_7));
                };
                return (new Point(_local_2, _local_3));
            };
            return (null);
        }
        public function updatePreviewRoomView():void
        {
            var _local_1:Point;
            var _local_2:int;
            var _local_3:Point;
            this.checkAutomaticRoomObjectStateChange();
            if (this._roomEngine != null){
                _local_1 = this._roomEngine.getRoomCanvasScreenOffset(_SafeStr_4927, _SafeStr_4926, _SafeStr_4928);
                if (_local_1 != null){
                    this.updatePreviewObjectBoundingRectangle(_local_1);
                    if (this._SafeStr_4939 != null){
                        _local_2 = this._SafeStr_4942;
                        _local_1 = this.validatePreviewSize(_local_1);
                        _local_3 = this.getCanvasOffset(_local_1);
                        if (_local_3 != null){
                            this._roomEngine.setRoomCanvasScreenOffset(_SafeStr_4927, _SafeStr_4926, _SafeStr_4928, _local_3);
                        };
                        if (this._SafeStr_4942 != _local_2){
                            this._SafeStr_4939 = null;
                        };
                    };
                };
            };
        }
        private function onRoomInitialized(_arg_1:RoomEngineEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            switch (_arg_1.type){
                case RoomEngineEvent.REE_INITIALIZED:
                    if ((((_arg_1.roomCategory == _SafeStr_4926)) && ((_arg_1.roomId == _SafeStr_4927)))){
                        this._roomEngine.updateObjectRoomColor(_SafeStr_4927, _SafeStr_4926, 0xFFFFFF, 176, true);
                        this._roomEngine.updateObjectRoom(_SafeStr_4927, _SafeStr_4926, "306", "1401");
                    };
                    return;
            };
        }
        private function onRoomObjectAdded(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:IRoomObject;
            var _local_3:Number;
            var _local_4:Number;
            if ((((((((_arg_1.roomId == _SafeStr_4927)) && ((_arg_1.roomCategory == _SafeStr_4926)))) && ((_arg_1.objectId == _SafeStr_4929)))) && ((_arg_1.category == this._SafeStr_4937)))){
                this._SafeStr_4939 = null;
                this._SafeStr_4943 = false;
                _local_2 = this._roomEngine.getRoomObject(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _arg_1.category);
                if (((((!((_local_2 == null))) && (!((_local_2.getModel() == null))))) && ((_arg_1.category == RoomObjectCategoryEnum._SafeStr_4330)))){
                    _local_3 = _local_2.getModel().getNumber(RoomObjectVariableEnum._SafeStr_4992);
                    _local_4 = _local_2.getModel().getNumber(RoomObjectVariableEnum._SafeStr_4993);
                    if (((!(isNaN(_local_3))) && (!(isNaN(_local_4))))){
                        this._roomEngine.updateObjectWallItemLocation(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, new Vector3d(0.5, 2.3, (((3.6 - _local_3) / 2) + _local_4)));
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// RoomPreviewer = "_-fc" (String#23871, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomPlaneParser = "_-2Ya" (String#6737, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// _SafeStr_4926 = "_-2eQ" (String#20621, DoABC#2)
// _SafeStr_4927 = "_-3JA" (String#22247, DoABC#2)
// _SafeStr_4928 = "_-1Xy" (String#17813, DoABC#2)
// _SafeStr_4929 = "_-1OL" (String#17446, DoABC#2)
// _SafeStr_4930 = "_-0jh" (String#15814, DoABC#2)
// _SafeStr_4931 = "_-0DK" (String#14582, DoABC#2)
// _SafeStr_4932 = "_-fl" (String#23878, DoABC#2)
// _SafeStr_4933 = "_-0X7" (String#15319, DoABC#2)
// _SafeStr_4934 = "_-2un" (String#21268, DoABC#2)
// _SafeStr_4935 = "_-25e" (String#19243, DoABC#2)
// _SafeStr_4936 = "_-0K" (String#14841, DoABC#2)
// _SafeStr_4937 = "_-2tR" (String#21218, DoABC#2)
// _SafeStr_4938 = "_-0xU" (String#16332, DoABC#2)
// _SafeStr_4939 = "_-24b" (String#19206, DoABC#2)
// _SafeStr_4940 = "_-0-M" (String#14027, DoABC#2)
// _SafeStr_4941 = "_-151" (String#16655, DoABC#2)
// _SafeStr_4942 = "_-1U3" (String#17668, DoABC#2)
// _SafeStr_4943 = "_-1AD" (String#16867, DoABC#2)
// _SafeStr_4944 = "_-05O" (String#14259, DoABC#2)
// _SafeStr_4945 = "_-1dw" (String#18054, DoABC#2)
// REOB_OBJECT_ADDED = "_-rY" (String#24341, DoABC#2)
// onRoomObjectAdded = "_-wW" (String#8812, DoABC#2)
// REOB_OBJECT_CONTENT_UPDATED = "_-31j" (String#21568, DoABC#2)
// REE_INITIALIZED = "_-0c3" (String#15515, DoABC#2)
// onRoomInitialized = "_-2u1" (String#21239, DoABC#2)
// createRoomForPreviews = "_-3Cv" (String#21993, DoABC#2)
// initializeTileMap = "_-yM" (String#24629, DoABC#2)
// initializeFromTileData = "_-34W" (String#21678, DoABC#2)
// initializeRoom = "_-1SM" (String#1690, DoABC#2)
// getXML = "_-2Oe" (String#6532, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// disposeObjectFurniture = "_-0Sj" (String#1477, DoABC#2)
// disposeObjectWallItem = "_-0aH" (String#1502, DoABC#2)
// disposeObjectUser = "_-Jw" (String#2086, DoABC#2)
// updatePreviewRoomView = "_-3-F" (String#21472, DoABC#2)
// _SafeStr_4962 = "_-1WC" (String#17750, DoABC#2)
// addFurnitureIntoRoom = "_-2hJ" (String#20743, DoABC#2)
// addObjectFurniture = "_-0G1" (String#1439, DoABC#2)
// addWallItemIntoRoom = "_-0bD" (String#15485, DoABC#2)
// addObjectWallItem = "_-J0" (String#2084, DoABC#2)
// addAvatarIntoRoom = "_-03t" (String#14198, DoABC#2)
// addObjectUser = "_-0kK" (String#1540, DoABC#2)
// updateObjectUserGesture = "_-0Yi" (String#1498, DoABC#2)
// updateObjectUserEffect = "_-3-m" (String#1983, DoABC#2)
// updateObjectUserPosture = "_-356" (String#1995, DoABC#2)
// changeRoomObjectState = "_-W1" (String#8322, DoABC#2)
// changeObjectState = "_-3Dq" (String#2025, DoABC#2)
// checkAutomaticRoomObjectStateChange = "_-yp" (String#24644, DoABC#2)
// getRoomCanvas = "_-HZ" (String#8028, DoABC#2)
// createRoomCanvas = "_-vj" (String#8798, DoABC#2)
// setRoomCanvasMask = "_-0uE" (String#4728, DoABC#2)
// getRoomCanvasGeometry = "_-1Qw" (String#5373, DoABC#2)
// adjustLocation = "_-9w" (String#7863, DoABC#2)
// updatePreviewObjectBoundingRectangle = "_-05B" (String#14251, DoABC#2)
// getRoomObjectBoundingRectangle = "_-0PC" (String#4075, DoABC#2)
// validatePreviewSize = "_-3G" (String#22114, DoABC#2)
// isZoomedIn = "_-1S5" (String#5398, DoABC#2)
// performZoomOut = "_-2Z0" (String#6746, DoABC#2)
// performZoomIn = "_-10E" (String#4875, DoABC#2)
// getCanvasOffset = "_-xD" (String#24577, DoABC#2)
// getRoomCanvasScreenOffset = "_-3FD" (String#7616, DoABC#2)
// setRoomCanvasScreenOffset = "_-2P0" (String#6544, DoABC#2)
// updateObjectRoomColor = "_-o" (String#2192, DoABC#2)
// updateObjectRoom = "_-DR" (String#2076, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// _SafeStr_4992 = "_-0BD" (String#14494, DoABC#2)
// _SafeStr_4993 = "_-2qH" (String#21091, DoABC#2)
// updateObjectWallItemLocation = "_-26n" (String#1814, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


