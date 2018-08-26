
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.logic.MovingObjectLogic;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;

    public class FurnitureLogic extends MovingObjectLogic 
    {

        private static const _SafeStr_12430:int = 8;
        private static const _FurnitureLogic:Number = (1 / 16);//0.0625

        private var _SafeStr_12432:Boolean = false;
        private var _sizeX:Number = 0;
        private var _sizeY:Number = 0;
        private var _SafeStr_12433:Number = 0;
        private var _SafeStr_12434:Number = 0;
        private var _SafeStr_12435:Number = 0;
        private var _SafeStr_12436:Number = 0;
        private var _SafeStr_12437:Boolean = false;
        private var _SafeStr_12438:int = 0;
        private var _SafeStr_12439:RoomObjectUpdateMessage;
        private var _SafeStr_12440:Vector3d;
        private var _SafeStr_12441:Array;

        public function FurnitureLogic()
        {
            this._SafeStr_12440 = new Vector3d();
            this._SafeStr_12441 = [];
            super();
        }
        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_SHOW, RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_HIDE, RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_DOUBLE_CLICK, RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, RoomObjectMouseEvent.ROE_MOUSE_CLICK, RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK, RoomObjectMouseEvent.ROE_MOUSE_DOWN];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function dispose():void
        {
            super.dispose();
            this._SafeStr_12439 = null;
            this._SafeStr_12441 = null;
        }
        override public function set object(_arg_1:IRoomObjectController):void
        {
            super.object = _arg_1;
            if (((!((_arg_1 == null))) && ((_arg_1.getLocation().length > 0)))){
                this._SafeStr_12437 = true;
            };
        }
        override public function initialize(_arg_1:XML):void
        {
            var _local_7:XML;
            var _local_8:int;
            if (_arg_1 == null){
                return;
            };
            this._sizeX = 0;
            this._sizeY = 0;
            this._SafeStr_12433 = 0;
            this._SafeStr_12441 = [];
            var _local_2:XMLList = _arg_1.model.dimensions;
            if (_local_2.length() == 0){
                return;
            };
            var _local_3:XMLList = _local_2.@x;
            if (_local_3.length() == 1){
                this._sizeX = Number(_local_3);
            };
            _local_3 = _local_2.@y;
            if (_local_3.length() == 1){
                this._sizeY = Number(_local_3);
            };
            _local_3 = _local_2.@z;
            if (_local_3.length() == 1){
                this._SafeStr_12433 = Number(_local_3);
            };
            this._SafeStr_12434 = (this._sizeX / 2);
            this._SafeStr_12435 = (this._sizeY / 2);
            _local_3 = _local_2.@centerZ;
            if (_local_3.length() == 1){
                this._SafeStr_12436 = Number(_local_3);
            }
            else {
                this._SafeStr_12436 = (this._SafeStr_12433 / 2);
            };
            var _local_4:XMLList = _arg_1.model.directions.direction;
            var _local_5:Array = ["id"];
            var _local_6:int;
            while (_local_6 < _local_4.length()) {
                _local_7 = _local_4[_local_6];
                if (XMLValidator.checkRequiredAttributes(_local_7, _local_5)){
                    _local_8 = parseInt(_local_7.@id);
                    this._SafeStr_12441.push(_local_8);
                };
                _local_6++;
            };
            this._SafeStr_12441.sort(Array.NUMERIC);
            if ((((object == null)) || ((object.getModelController() == null)))){
                return;
            };
            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12442, this._sizeX, true);
            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12443, this._sizeY, true);
            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_4992, this._SafeStr_12433, true);
            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12444, this._SafeStr_12434, true);
            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12445, this._SafeStr_12435, true);
            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_4993, this._SafeStr_12436, true);
            object.getModelController().setNumberArray(RoomObjectVariableEnum._SafeStr_12446, this._SafeStr_12441, true);
            object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_5760, 1);
        }
        protected function FurnitureVisualization(_arg_1:IRoomObjectModelController):String
        {
            return (_arg_1.getString(RoomObjectVariableEnum._SafeStr_12448));
        }
        protected function handleAdClick(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            if (eventDispatcher != null){
                eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK, _arg_1, _arg_2));
            };
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_4:int;
            var _local_5:String;
            var _local_6:RoomObjectEvent;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (_arg_1.type == MouseEvent.MOUSE_MOVE){
                return;
            };
            if (object == null){
                return;
            };
            var _local_3:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_3 == null){
                return;
            };
            var _local_7:String = this.FurnitureVisualization(_local_3);
            switch (_arg_1.type){
                case MouseEvent.ROLL_OVER:
                    if (!this._SafeStr_12432){
                        if (((((!((eventDispatcher == null))) && (!((_local_7 == null))))) && ((_local_7.indexOf("http") == 0)))){
                            _local_4 = object.getId();
                            _local_5 = object.getType();
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_SHOW, _local_4, _local_5));
                        };
                        this._SafeStr_12432 = true;
                    };
                    return;
                case MouseEvent.ROLL_OUT:
                    if (this._SafeStr_12432){
                        if (((((!((eventDispatcher == null))) && (!((_local_7 == null))))) && ((_local_7.indexOf("http") == 0)))){
                            _local_4 = object.getId();
                            _local_5 = object.getType();
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_HIDE, _local_4, _local_5));
                        };
                        this._SafeStr_12432 = false;
                    };
                    return;
                case MouseEvent.DOUBLE_CLICK:
                    this.useObject();
                    return;
                case MouseEvent.CLICK:
                    _local_4 = object.getId();
                    _local_5 = object.getType();
                    if (eventDispatcher != null){
                        _local_6 = new RoomObjectMouseEvent(RoomObjectMouseEvent.ROE_MOUSE_CLICK, _arg_1.eventId, _local_4, _local_5, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                        eventDispatcher.dispatchEvent(_local_6);
                    };
                    if (((((!((eventDispatcher == null))) && (!((_local_7 == null))))) && ((_local_7.indexOf("http") == 0)))){
                        this.handleAdClick(_local_4, _local_5, _local_7);
                    };
                    return;
                case MouseEvent.MOUSE_DOWN:
                    if (eventDispatcher != null){
                        _local_4 = object.getId();
                        _local_5 = object.getType();
                        _local_6 = new RoomObjectMouseEvent(RoomObjectMouseEvent.ROE_MOUSE_DOWN, _arg_1.eventId, _local_4, _local_5, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                        eventDispatcher.dispatchEvent(_local_6);
                    };
                    return;
            };
        }
        override public function useObject():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:IRoomObjectModelController;
            var _local_4:String;
            if (object != null){
                _local_1 = object.getId();
                _local_2 = object.getType();
                _local_3 = (object.getModel() as IRoomObjectModelController);
                if (_local_3 != null){
                    _local_4 = this.FurnitureVisualization(_local_3);
                    if (((((!((eventDispatcher == null))) && (!((_local_4 == null))))) && ((_local_4.indexOf("http") == 0)))){
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_DOUBLE_CLICK, _local_1, _local_2));
                    };
                };
                if (eventDispatcher != null){
                    eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_1, _local_2));
                };
            };
        }
        private function handleDataUpdateMessage(_arg_1:RoomObjectDataUpdateMessage):void
        {
            var _local_2:IRoomObjectModelController = object.getModelController();
            object.setState(_arg_1.state, 0);
            if (_local_2 != null){
                _local_2.setString(RoomObjectVariableEnum._SafeStr_7217, _arg_1.data);
                if (!isNaN(_arg_1.extra)){
                    _local_2.setString(RoomObjectVariableEnum._SafeStr_7295, String(_arg_1.extra));
                };
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_12451, lastUpdateTime);
            };
        }
        private function FurnitureLogic(_arg_1:RoomObjectItemDataUpdateMessage):void
        {
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (_local_2 != null){
                _local_2.setString(RoomObjectVariableEnum._SafeStr_7309, _arg_1.itemData);
            };
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_4:IVector3d;
            var _local_5:IVector3d;
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null){
                this.handleDataUpdateMessage(_local_2);
                return;
            };
            var _local_3:RoomObjectItemDataUpdateMessage = (_arg_1 as RoomObjectItemDataUpdateMessage);
            if (_local_3 != null){
                this.FurnitureLogic(_local_3);
                return;
            };
            this._SafeStr_12432 = false;
            if (((!((_arg_1.dir == null))) && (!((_arg_1.loc == null))))){
                if (!(_arg_1 is RoomObjectMoveUpdateMessage)){
                    _local_4 = object.getDirection();
                    _local_5 = object.getLocation();
                    if (((((((((((((!((_local_4 == null))) && (!((_local_4.x == _arg_1.dir.x))))) && (this._SafeStr_12437))) && (!((_local_5 == null))))) && ((_local_5.x == _arg_1.loc.x)))) && ((_local_5.y == _arg_1.loc.y)))) && ((_local_5.z == _arg_1.loc.z)))){
                        this._SafeStr_12438 = 1;
                        this._SafeStr_12439 = new RoomObjectUpdateMessage(_arg_1.loc, _arg_1.dir);
                        _arg_1 = null;
                    };
                };
                this._SafeStr_12437 = true;
            };
            super.processUpdateMessage(_arg_1);
        }
        override protected function FurnitureLogic():IVector3d
        {
            if (this._SafeStr_12438 > 0){
                this._SafeStr_12440.x = 0;
                this._SafeStr_12440.y = 0;
                if (this._SafeStr_12438 <= (_SafeStr_12430 / 2)){
                    this._SafeStr_12440.z = (_FurnitureLogic * this._SafeStr_12438);
                }
                else {
                    if (this._SafeStr_12438 <= _SafeStr_12430){
                        if (this._SafeStr_12439){
                            super.processUpdateMessage(this._SafeStr_12439);
                            this._SafeStr_12439 = null;
                        };
                        this._SafeStr_12440.z = (_FurnitureLogic * (_SafeStr_12430 - this._SafeStr_12438));
                    };
                };
                return (this._SafeStr_12440);
            };
            return (null);
        }
        override public function update(_arg_1:int):void
        {
            super.update(_arg_1);
            if (this._SafeStr_12438 > 0){
                this._SafeStr_12438++;
                if (this._SafeStr_12438 > _SafeStr_12430){
                    this._SafeStr_12438 = 0;
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12430 = "_-07E" (String#14334, DoABC#2)
// _FurnitureLogic = "_-0yQ" (String#16369, DoABC#2)
// _SafeStr_12432 = "_-1oF" (String#18469, DoABC#2)
// _SafeStr_12433 = "_-1qu" (String#18576, DoABC#2)
// _SafeStr_12434 = "_-2Qt" (String#6575, DoABC#2)
// _SafeStr_12435 = "_-Ql" (String#8221, DoABC#2)
// _SafeStr_12436 = "_-eN" (String#23817, DoABC#2)
// _SafeStr_12437 = "_-25v" (String#19255, DoABC#2)
// _SafeStr_12438 = "_-0Kw" (String#14874, DoABC#2)
// _SafeStr_12439 = "_-0eU" (String#15605, DoABC#2)
// _SafeStr_12440 = "_-1vz" (String#18796, DoABC#2)
// _SafeStr_12441 = "_-0pY" (String#1556, DoABC#2)
// _SafeStr_12442 = "_-0vN" (String#16252, DoABC#2)
// _SafeStr_12443 = "_-7h" (String#22530, DoABC#2)
// _SafeStr_12444 = "_-0U9" (String#15210, DoABC#2)
// _SafeStr_12445 = "_-1Xv" (String#17811, DoABC#2)
// _SafeStr_12446 = "_-1bD" (String#17943, DoABC#2)
// FurnitureVisualization = "_-0z5" (String#438, DoABC#2)
// _SafeStr_12448 = "_-0Jf" (String#14828, DoABC#2)
// handleAdClick = "_-2qp" (String#7093, DoABC#2)
// handleDataUpdateMessage = "_-4k" (String#2050, DoABC#2)
// _SafeStr_12451 = "_-3Gs" (String#22157, DoABC#2)
// FurnitureLogic = "_-1HY" (String#17172, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// MovingObjectLogic = "_-36D" (String#21738, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectItemDataUpdateMessage = "_-1yC" (String#18895, DoABC#2)
// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectMoveUpdateMessage = "_-2Es" (String#6339, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectStateChangeEvent = "_-2D1" (String#19524, DoABC#2)
// itemData = "_-1S3" (String#17584, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// _SafeStr_4992 = "_-0BD" (String#14494, DoABC#2)
// _SafeStr_4993 = "_-2qH" (String#21091, DoABC#2)
// _sizeX = "_-sQ" (String#946, DoABC#2)
// _sizeY = "_-36G" (String#912, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// RORAE_ROOM_AD_FURNI_CLICK = "_-0v3" (String#16239, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_SHOW = "_-1bW" (String#17956, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_HIDE = "_-37a" (String#21790, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// ROSCE_STATE_CHANGE = "_-RU" (String#23304, DoABC#2)
// RORAE_ROOM_AD_FURNI_DOUBLE_CLICK = "_-2bv" (String#20520, DoABC#2)
// _SafeStr_5760 = "_-2gS" (String#20707, DoABC#2)
// ROE_MOUSE_CLICK = "_-2sU" (String#21178, DoABC#2)
// eventId = "_-3ER" (String#22053, DoABC#2)
// ROE_MOUSE_DOWN = "_-va" (String#24512, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// _SafeStr_7295 = "_-2nE" (String#20969, DoABC#2)
// _SafeStr_7309 = "_-2Cm" (String#19516, DoABC#2)
// lastUpdateTime = "_-0US" (String#15222, DoABC#2)
// FurnitureLogic = "_-2EM" (String#6330, DoABC#2)
// RoomObjectRoomAdEvent = "_-mk" (String#24139, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


