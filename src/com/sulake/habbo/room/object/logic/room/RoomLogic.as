
package com.sulake.habbo.room.object.logic.room
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.ColorConverter;
    import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskData;
    import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage;
    import flash.utils.getTimer;
    import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.object.RoomPlaneData;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class RoomLogic extends ObjectLogicBase 
    {

        protected var _planeParser:RoomPlaneParser = null;
        private var _SafeStr_5763:RoomPlaneBitmapMaskParser = null;
        private var _color:uint = 0xFFFFFF;
        private var _light:int = 0xFF;
        private var _SafeStr_5764:uint = 0xFFFFFF;
        private var _SafeStr_5765:int = 0xFF;
        private var _SafeStr_5766:uint = 0xFFFFFF;
        private var _SafeStr_5767:int = 0xFF;
        private var _SafeStr_5768:int = 0;
        private var _SafeStr_5769:int = 1500;
        private var _SafeStr_5770:Boolean;

        public function RoomLogic()
        {
            this._planeParser = new RoomPlaneParser();
            this._SafeStr_5763 = new RoomPlaneBitmapMaskParser();
        }
        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectMouseEvent.ROE_MOUSE_MOVE, RoomObjectMouseEvent.ROE_MOUSE_CLICK];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function dispose():void
        {
            super.dispose();
            if (this._planeParser != null){
                this._planeParser.dispose();
                this._planeParser = null;
            };
            if (this._SafeStr_5763 != null){
                this._SafeStr_5763.dispose();
                this._SafeStr_5763 = null;
            };
        }
        override public function initialize(_arg_1:XML):void
        {
            if ((((_arg_1 == null)) || ((object == null)))){
                return;
            };
            if (!this._planeParser.initializeFromXML(_arg_1)){
                return;
            };
            var _local_2:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_2 != null){
                _local_2.setString(RoomObjectVariableEnum._SafeStr_5774, _arg_1.toString());
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5775, 0xFFFFFF);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5776, 1);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5777, 1);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5778, 1);
            };
        }
        override public function update(_arg_1:int):void
        {
            var _local_2:IRoomObjectModelController;
            var _local_3:XML;
            super.update(_arg_1);
            this.updateBackgroundColor(_arg_1);
            if (this._SafeStr_5770){
                if (object != null){
                    _local_2 = (object.getModel() as IRoomObjectModelController);
                    if (_local_2 != null){
                        _local_3 = this._planeParser.getXML();
                        _local_2.setString(RoomObjectVariableEnum._SafeStr_5774, _local_3.toString());
                        _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5780, _arg_1);
                        this._planeParser.initializeFromXML(_local_3);
                    };
                };
                this._SafeStr_5770 = false;
            };
        }
        private function updateBackgroundColor(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:IRoomObjectModelController;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:Number;
            if (object == null){
                return;
            };
            if (this._SafeStr_5768){
                _local_2 = _arg_1;
                _local_3 = this._color;
                _local_4 = this._light;
                if ((_local_2 - this._SafeStr_5768) >= this._SafeStr_5769){
                    _local_3 = this._SafeStr_5766;
                    _local_4 = this._SafeStr_5767;
                    this._SafeStr_5768 = 0;
                }
                else {
                    _local_7 = ((this._SafeStr_5764 >> 16) & 0xFF);
                    _local_8 = ((this._SafeStr_5764 >> 8) & 0xFF);
                    _local_9 = (this._SafeStr_5764 & 0xFF);
                    _local_10 = ((this._SafeStr_5766 >> 16) & 0xFF);
                    _local_11 = ((this._SafeStr_5766 >> 8) & 0xFF);
                    _local_12 = (this._SafeStr_5766 & 0xFF);
                    _local_13 = ((_local_2 - this._SafeStr_5768) / this._SafeStr_5769);
                    _local_7 = (_local_7 + ((_local_10 - _local_7) * _local_13));
                    _local_8 = (_local_8 + ((_local_11 - _local_8) * _local_13));
                    _local_9 = (_local_9 + ((_local_12 - _local_9) * _local_13));
                    _local_3 = (((_local_7 << 16) + (_local_8 << 8)) + _local_9);
                    _local_4 = (this._SafeStr_5765 + ((this._SafeStr_5767 - this._SafeStr_5765) * _local_13));
                    this._color = _local_3;
                    this._light = _local_4;
                };
                _local_5 = ColorConverter.rgbToHSL(_local_3);
                _local_5 = ((_local_5 & 0xFFFF00) + _local_4);
                _local_3 = ColorConverter.hslToRGB(_local_5);
                _local_6 = (object.getModel() as IRoomObjectModelController);
                if (_local_6 == null){
                    return;
                };
                _local_6.setNumber(RoomObjectVariableEnum._SafeStr_5775, _local_3);
            };
        }
        private function updatePlaneTypes(_arg_1:RoomObjectRoomUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            switch (_arg_1.type){
                case RoomObjectRoomUpdateMessage.RORUM_ROOM_FLOOR_UPDATE:
                    _arg_2.setString(RoomObjectVariableEnum._SafeStr_5784, _arg_1.value);
                    return;
                case RoomObjectRoomUpdateMessage.RORUM_ROOM_WALL_UPDATE:
                    _arg_2.setString(RoomObjectVariableEnum._SafeStr_5786, _arg_1.value);
                    return;
                case RoomObjectRoomUpdateMessage.RORUM_ROOM_LANDSCAPE_UPDATE:
                    _arg_2.setString(RoomObjectVariableEnum._SafeStr_5788, _arg_1.value);
                    return;
            };
        }
        private function RoomVisualization(_arg_1:RoomObjectRoomMaskUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            var _local_5:String;
            var _local_6:XML;
            var _local_7:String;
            var _local_3:RoomPlaneBitmapMaskData;
            var _local_4:Boolean;
            switch (_arg_1.type){
                case RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK:
                    _local_5 = RoomPlaneBitmapMaskData._SafeStr_5791;
                    if (_arg_1.maskCategory == RoomObjectRoomMaskUpdateMessage._SafeStr_5793){
                        _local_5 = RoomPlaneBitmapMaskData._SafeStr_5793;
                    };
                    this._SafeStr_5763.RoomPlaneBitmapMaskParser(_arg_1.maskId, _arg_1.maskType, _arg_1.maskLocation, _local_5);
                    _local_4 = true;
                    break;
                case RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK:
                    _local_4 = this._SafeStr_5763.RoomPlaneBitmapMaskParser(_arg_1.maskId);
                    break;
            };
            if (_local_4){
                _local_6 = this._SafeStr_5763.getXML();
                _local_7 = _local_6.toXMLString();
                _arg_2.setString(RoomObjectVariableEnum._SafeStr_5801, _local_7);
            };
        }
        private function updatePlaneVisibilities(_arg_1:RoomObjectRoomPlaneVisibilityUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            var _local_3:int;
            if (_arg_1.visible){
                _local_3 = 1;
            };
            switch (_arg_1.type){
                case RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_FLOOR_VISIBILITY:
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_5776, _local_3);
                    return;
                case RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_WALL_VISIBILITY:
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_5777, _local_3);
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_5778, _local_3);
                    return;
            };
        }
        private function updatePlaneProperties(_arg_1:RoomObjectRoomPlanePropertyUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            switch (_arg_1.type){
                case RoomObjectRoomPlanePropertyUpdateMessage.RORPVUM_FLOOR_THICKNESS:
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_5806, _arg_1.value);
                    return;
                case RoomObjectRoomPlanePropertyUpdateMessage.RORPPUM_WALL_THICKNESS:
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_5808, _arg_1.value);
                    return;
            };
        }
        private function RoomVisualization(_arg_1:RoomObjectRoomFloorHoleUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            switch (_arg_1.type){
                case RoomObjectRoomFloorHoleUpdateMessage.RORPFHUM_ADD:
                    this._planeParser.RoomEngine(_arg_1.id, _arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
                    this._SafeStr_5770 = true;
                    return;
                case RoomObjectRoomFloorHoleUpdateMessage.RORPFHUM_REMOVE:
                    this._planeParser.RoomEngine(_arg_1.id);
                    this._SafeStr_5770 = true;
                    return;
            };
        }
        private function updateColors(_arg_1:RoomObjectRoomColorUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            var _local_3:int = _arg_1.color;
            var _local_4:int = _arg_1.light;
            _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_5814, int(_arg_1.bgOnly));
            this._SafeStr_5764 = this._color;
            this._SafeStr_5765 = this._light;
            this._SafeStr_5766 = _local_3;
            this._SafeStr_5767 = _local_4;
            this._SafeStr_5768 = getTimer();
            this._SafeStr_5769 = 1500;
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            if ((((_arg_1 == null)) || ((object == null)))){
                return;
            };
            var _local_2:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_2 == null){
                return;
            };
            var _local_3:RoomObjectRoomUpdateMessage = (_arg_1 as RoomObjectRoomUpdateMessage);
            if (_local_3 != null){
                this.updatePlaneTypes(_local_3, _local_2);
                return;
            };
            var _local_4:RoomObjectRoomMaskUpdateMessage = (_arg_1 as RoomObjectRoomMaskUpdateMessage);
            if (_local_4 != null){
                this.RoomVisualization(_local_4, _local_2);
                return;
            };
            var _local_5:RoomObjectRoomPlaneVisibilityUpdateMessage = (_arg_1 as RoomObjectRoomPlaneVisibilityUpdateMessage);
            if (_local_5 != null){
                this.updatePlaneVisibilities(_local_5, _local_2);
                return;
            };
            var _local_6:RoomObjectRoomPlanePropertyUpdateMessage = (_arg_1 as RoomObjectRoomPlanePropertyUpdateMessage);
            if (_local_6 != null){
                this.updatePlaneProperties(_local_6, _local_2);
                return;
            };
            var _local_7:RoomObjectRoomFloorHoleUpdateMessage = (_arg_1 as RoomObjectRoomFloorHoleUpdateMessage);
            if (_local_7 != null){
                this.RoomVisualization(_local_7, _local_2);
            };
            var _local_8:RoomObjectRoomColorUpdateMessage = (_arg_1 as RoomObjectRoomColorUpdateMessage);
            if (_local_8 != null){
                this.updateColors(_local_8, _local_2);
                return;
            };
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_25:String;
            var _local_26:Number;
            var _local_27:Number;
            var _local_28:Number;
            if (_arg_2 == null){
                return;
            };
            var _local_3:RoomSpriteMouseEvent = _arg_1;
            if (_local_3 == null){
                return;
            };
            if ((((object == null)) || ((_arg_1 == null)))){
                return;
            };
            var _local_4:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_4 == null){
                return;
            };
            var _local_5:int;
            var _local_6:String = _local_3.spriteTag;
            if (_local_6.indexOf("@") >= 0){
                _local_5 = parseInt(_local_6.substr((_local_6.indexOf("@") + 1)));
            };
            if ((((_local_5 < 1)) || ((_local_5 > this._planeParser.planeCount)))){
                if (_arg_1.type == MouseEvent.ROLL_OUT){
                    _local_4.setNumber(RoomObjectVariableEnum._SafeStr_5816, 0);
                };
                return;
            };
            _local_5--;
            var _local_7:Point;
            var _local_8:IVector3d = this._planeParser.getPlaneLocation(_local_5);
            var _local_9:IVector3d = this._planeParser.getPlaneLeftSide(_local_5);
            var _local_10:IVector3d = this._planeParser.getPlaneRightSide(_local_5);
            var _local_11:IVector3d = this._planeParser.getPlaneNormalDirection(_local_5);
            var _local_12:int = this._planeParser.getPlaneType(_local_5);
            if ((((((((_local_8 == null)) || ((_local_9 == null)))) || ((_local_10 == null)))) || ((_local_11 == null)))){
                return;
            };
            var _local_13:Number = _local_9.length;
            var _local_14:Number = _local_10.length;
            if ((((_local_13 == 0)) || ((_local_14 == 0)))){
                return;
            };
            var _local_15:Number = _local_3.screenX;
            var _local_16:Number = _local_3.screenY;
            var _local_17:Point = new Point(_local_15, _local_16);
            _local_7 = _arg_2.RoomGeometry(_local_17, _local_8, _local_9, _local_10);
            if (_local_7 == null){
                _local_4.setNumber(RoomObjectVariableEnum._SafeStr_5816, 0);
                return;
            };
            var _local_18:Vector3d = Vector3d.product(_local_9, (_local_7.x / _local_13));
            _local_18.add(Vector3d.product(_local_10, (_local_7.y / _local_14)));
            _local_18.add(_local_8);
            var _local_19:Number = _local_18.x;
            var _local_20:Number = _local_18.y;
            var _local_21:Number = _local_18.z;
            if ((((((((_local_7.x >= 0)) && ((_local_7.x < _local_13)))) && ((_local_7.y >= 0)))) && ((_local_7.y < _local_14)))){
                _local_4.setNumber(RoomObjectVariableEnum._SafeStr_5826, _local_19);
                _local_4.setNumber(RoomObjectVariableEnum._SafeStr_5827, _local_20);
                _local_4.setNumber(RoomObjectVariableEnum._SafeStr_5828, _local_21);
                _local_4.setNumber(RoomObjectVariableEnum._SafeStr_5816, (_local_5 + 1));
            }
            else {
                _local_4.setNumber(RoomObjectVariableEnum._SafeStr_5816, 0);
                return;
            };
            var _local_22:String = "";
            var _local_23:int;
            var _local_24:RoomObjectEvent;
            switch (_arg_1.type){
                case MouseEvent.MOUSE_MOVE:
                case MouseEvent.ROLL_OVER:
                case MouseEvent.CLICK:
                    _local_25 = "";
                    if ((((_arg_1.type == MouseEvent.MOUSE_MOVE)) || ((_arg_1.type == MouseEvent.ROLL_OVER)))){
                        _local_25 = RoomObjectMouseEvent.ROE_MOUSE_MOVE;
                    }
                    else {
                        if (_arg_1.type == MouseEvent.CLICK){
                            _local_25 = RoomObjectMouseEvent.ROE_MOUSE_CLICK;
                        };
                    };
                    _local_23 = object.getId();
                    _local_22 = object.getType();
                    if (eventDispatcher != null){
                        if (_local_12 == RoomPlaneData._SafeStr_5829){
                            _local_24 = new RoomObjectTileMouseEvent(_local_25, _arg_1.eventId, _local_23, _local_22, _local_19, _local_20, _local_21);
                        }
                        else {
                            if ((((_local_12 == RoomPlaneData._SafeStr_5832)) || ((_local_12 == RoomPlaneData._SafeStr_5831)))){
                                _local_26 = 90;
                                if (_local_11 != null){
                                    _local_26 = (_local_11.x + 90);
                                    if (_local_26 > 360){
                                        _local_26 = (_local_26 - 360);
                                    };
                                };
                                _local_27 = ((_local_9.length * _local_7.x) / _local_13);
                                _local_28 = ((_local_10.length * _local_7.y) / _local_14);
                                _local_24 = new RoomObjectWallMouseEvent(_local_25, _arg_1.eventId, _local_23, _local_22, _local_8, _local_9, _local_10, _local_27, _local_28, _local_26);
                            };
                        };
                        if (_local_24 != null){
                            eventDispatcher.dispatchEvent(_local_24);
                        };
                    };
                    return;
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.room

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// ObjectLogicBase = "_-VT" (String#8310, DoABC#2)
// RoomLogic = "_-Qn" (String#8222, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectRoomPlaneVisibilityUpdateMessage = "_-1Hj" (String#17179, DoABC#2)
// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectRoomColorUpdateMessage = "_-0hz" (String#15748, DoABC#2)
// RoomObjectRoomUpdateMessage = "_-L4" (String#23049, DoABC#2)
// RoomObjectRoomFloorHoleUpdateMessage = "_-208" (String#19017, DoABC#2)
// RoomObjectRoomMaskUpdateMessage = "_-0S6" (String#15141, DoABC#2)
// RoomObjectRoomPlanePropertyUpdateMessage = "_-14L" (String#16629, DoABC#2)
// RoomPlaneParser = "_-2Ya" (String#6737, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-27E" (String#6188, DoABC#2)
// ColorConverter = "_-3Km" (String#7717, DoABC#2)
// RoomObjectWallMouseEvent = "_-2ed" (String#20631, DoABC#2)
// RoomPlaneData = "_-1iF" (String#5716, DoABC#2)
// RoomObjectTileMouseEvent = "_-0QU" (String#15080, DoABC#2)
// RoomPlaneBitmapMaskData = "_-2dh" (String#6826, DoABC#2)
// bgOnly = "_-320" (String#21580, DoABC#2)
// _light = "_-dT" (String#462, DoABC#2)
// getXML = "_-2Oe" (String#6532, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// RORPFHUM_ADD = "_-wb" (String#24555, DoABC#2)
// RORPFHUM_REMOVE = "_-0CG" (String#14540, DoABC#2)
// _SafeStr_5763 = "_-5-" (String#7764, DoABC#2)
// _SafeStr_5764 = "_-0YW" (String#15381, DoABC#2)
// _SafeStr_5765 = "_-1hH" (String#18184, DoABC#2)
// _SafeStr_5766 = "_-1ui" (String#18746, DoABC#2)
// _SafeStr_5767 = "_-2F-" (String#19603, DoABC#2)
// _SafeStr_5768 = "_-2y4" (String#21396, DoABC#2)
// _SafeStr_5769 = "_-0xW" (String#16333, DoABC#2)
// _SafeStr_5770 = "_-1X" (String#17777, DoABC#2)
// ROE_MOUSE_MOVE = "_-f9" (String#23852, DoABC#2)
// ROE_MOUSE_CLICK = "_-2sU" (String#21178, DoABC#2)
// initializeFromXML = "_-00L" (String#14068, DoABC#2)
// _SafeStr_5774 = "_-19Y" (String#16839, DoABC#2)
// _SafeStr_5775 = "_-M3" (String#23084, DoABC#2)
// _SafeStr_5776 = "_-9N" (String#22594, DoABC#2)
// _SafeStr_5777 = "_-1rI" (String#18595, DoABC#2)
// _SafeStr_5778 = "_-qL" (String#24285, DoABC#2)
// updateBackgroundColor = "_-Cq" (String#22720, DoABC#2)
// _SafeStr_5780 = "_-0kL" (String#15843, DoABC#2)
// rgbToHSL = "_-TY" (String#23388, DoABC#2)
// hslToRGB = "_-sE" (String#24369, DoABC#2)
// updatePlaneTypes = "_-q2" (String#24275, DoABC#2)
// _SafeStr_5784 = "_-2G-" (String#19644, DoABC#2)
// RORUM_ROOM_FLOOR_UPDATE = "_-2uz" (String#21276, DoABC#2)
// _SafeStr_5786 = "_-1SC" (String#17588, DoABC#2)
// RORUM_ROOM_WALL_UPDATE = "_-0DM" (String#14584, DoABC#2)
// _SafeStr_5788 = "_-Nt" (String#23160, DoABC#2)
// RORUM_ROOM_LANDSCAPE_UPDATE = "_-G8" (String#22858, DoABC#2)
// RoomVisualization = "_-7g" (String#7817, DoABC#2)
// _SafeStr_5791 = "_-2fX" (String#20670, DoABC#2)
// maskCategory = "_-0Eb" (String#14628, DoABC#2)
// _SafeStr_5793 = "_-3En" (String#22068, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-0SM" (String#15149, DoABC#2)
// maskId = "_-0KY" (String#14862, DoABC#2)
// maskType = "_-2Ek" (String#19595, DoABC#2)
// maskLocation = "_-0I8" (String#14763, DoABC#2)
// RORMUM_ADD_MASK = "_-0tl" (String#16193, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-07G" (String#14336, DoABC#2)
// RORMUM_ADD_MASK = "_-0LP" (String#14892, DoABC#2)
// _SafeStr_5801 = "_-Yf" (String#23585, DoABC#2)
// updatePlaneVisibilities = "_-2o6" (String#21006, DoABC#2)
// RORPVUM_FLOOR_VISIBILITY = "_-0u0" (String#16203, DoABC#2)
// RORPVUM_WALL_VISIBILITY = "_-1sU" (String#18653, DoABC#2)
// updatePlaneProperties = "_-08v" (String#14403, DoABC#2)
// _SafeStr_5806 = "_-2B8" (String#19450, DoABC#2)
// RORPVUM_FLOOR_THICKNESS = "_-2pM" (String#7067, DoABC#2)
// _SafeStr_5808 = "_-08p" (String#14398, DoABC#2)
// RORPPUM_WALL_THICKNESS = "_-GT" (String#8005, DoABC#2)
// RoomVisualization = "_-1mt" (String#5796, DoABC#2)
// RoomEngine = "_-u-" (String#8766, DoABC#2)
// RoomEngine = "_-1hN" (String#5693, DoABC#2)
// updateColors = "_-Fc" (String#22835, DoABC#2)
// _SafeStr_5814 = "_-2v1" (String#21279, DoABC#2)
// planeCount = "_-2lv" (String#20913, DoABC#2)
// _SafeStr_5816 = "_-0NT" (String#14971, DoABC#2)
// getPlaneLocation = "_-dB" (String#23767, DoABC#2)
// getPlaneLeftSide = "_-IZ" (String#22950, DoABC#2)
// getPlaneRightSide = "_-1a4" (String#17897, DoABC#2)
// getPlaneNormalDirection = "_-2FH" (String#19615, DoABC#2)
// getPlaneType = "_-3BR" (String#21940, DoABC#2)
// screenX = "_-2jN" (String#20819, DoABC#2)
// screenY = "_-1oK" (String#18472, DoABC#2)
// RoomGeometry = "_-eX" (String#8492, DoABC#2)
// product = "_-Bd" (String#22675, DoABC#2)
// _SafeStr_5826 = "_-rc" (String#24344, DoABC#2)
// _SafeStr_5827 = "_-2Zy" (String#20438, DoABC#2)
// _SafeStr_5828 = "_-Bv" (String#22685, DoABC#2)
// _SafeStr_5829 = "_-dd" (String#23787, DoABC#2)
// eventId = "_-3ER" (String#22053, DoABC#2)
// _SafeStr_5831 = "_-1Gc" (String#17138, DoABC#2)
// _SafeStr_5832 = "_-0IL" (String#14772, DoABC#2)


