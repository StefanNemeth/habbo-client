
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureRoomDimmerLogic extends FurnitureLogic 
    {

        private var _SafeStr_12496:Boolean = false;

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_DIMMER, RoomObjectWidgetRequestEvent.REOR_REMOVE_DIMMER, RoomObjectDimmerStateUpdateEvent.RWDSUE_DIMMER_STATE];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            switch (_arg_1.type){
                case MouseEvent.DOUBLE_CLICK:
                    this.useObject();
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
            };
        }
        override public function useObject():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:RoomObjectEvent;
            if (((!((eventDispatcher == null))) && (!((object == null))))){
                _local_1 = object.getId();
                _local_2 = object.getType();
                _local_3 = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_DIMMER, _local_1, _local_2);
                eventDispatcher.dispatchEvent(_local_3);
            };
        }
        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:RoomObjectDimmerStateUpdateEvent;
            var _local_4:int;
            var _local_5:uint;
            var _local_6:int;
            var _local_7:RoomObjectEvent;
            if (this._SafeStr_12496){
                if (((!((eventDispatcher == null))) && (!((object == null))))){
                    _local_1 = object.getId();
                    _local_2 = object.getType();
                    _local_4 = 0;
                    _local_5 = 0xFFFFFF;
                    _local_6 = 0xFF;
                    _local_3 = new RoomObjectDimmerStateUpdateEvent(_local_1, _local_2, 0, 1, 1, _local_5, _local_6);
                    eventDispatcher.dispatchEvent(_local_3);
                    _local_7 = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.REOR_REMOVE_DIMMER, _local_1, _local_2);
                    eventDispatcher.dispatchEvent(_local_7);
                };
                this._SafeStr_12496 = false;
            };
            super.dispose();
        }
        private function dispatchColorUpdateEvent(_arg_1:String):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:uint;
            var _local_8:int;
            var _local_9:int;
            var _local_10:String;
            var _local_11:RoomObjectDimmerStateUpdateEvent;
            if (_arg_1 == null){
                return;
            };
            var _local_2:Array = _arg_1.split(",");
            if (_local_2.length >= 5){
                _local_3 = this.readState(_arg_1);
                _local_4 = parseInt(_local_2[1]);
                _local_5 = parseInt(_local_2[2]);
                _local_6 = _local_2[3];
                _local_7 = parseInt(_local_6.substr(1), 16);
                _local_8 = parseInt(_local_2[4]);
                if (_local_3 == 0){
                    _local_7 = 0xFFFFFF;
                    _local_8 = 0xFF;
                };
                if (((!((eventDispatcher == null))) && (!((object == null))))){
                    _local_9 = object.getId();
                    _local_10 = object.getType();
                    _local_11 = null;
                    _local_11 = new RoomObjectDimmerStateUpdateEvent(_local_9, _local_10, _local_3, _local_4, _local_5, _local_7, _local_8);
                    eventDispatcher.dispatchEvent(_local_11);
                    this._SafeStr_12496 = true;
                };
            };
        }
        private function readState(_arg_1:String):int
        {
            var _local_3:int;
            if (_arg_1 == null){
                return (0);
            };
            var _local_2:Array = _arg_1.split(",");
            if (_local_2.length >= 5){
                return ((parseInt(_local_2[0]) - 1));
            };
            return (0);
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_4:int;
            var _local_2:IRoomObjectModelController = object.getModelController();
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null){
                if (_local_3.data != null){
                    this.dispatchColorUpdateEvent(_local_3.data);
                    _local_4 = this.readState(_local_3.data);
                    _local_3 = new RoomObjectDataUpdateMessage(_local_4, _local_3.data);
                    super.processUpdateMessage(_local_3);
                };
                return;
            };
            super.processUpdateMessage(_arg_1);
        }
        override public function update(_arg_1:int):void
        {
            var _local_2:String;
            super.update(_arg_1);
            if (((!((object == null))) && (!((object.getModelController() == null))))){
                _local_2 = object.getModelController().getString(RoomObjectVariableEnum._SafeStr_7217);
                if (((!((_local_2 == null))) && ((_local_2.length > 0)))){
                    object.getModelController().setString(RoomObjectVariableEnum._SafeStr_7217, "");
                    this.dispatchColorUpdateEvent(_local_2);
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12496 = "_-wO" (String#24550, DoABC#2)
// dispatchColorUpdateEvent = "_-1YD" (String#17824, DoABC#2)
// readState = "_-135" (String#16584, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureRoomDimmerLogic = "_-1rc" (String#18613, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// RoomObjectDimmerStateUpdateEvent = "_-08I" (String#14375, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// REOE_WIDGET_REQUEST_DIMMER = "_-2Sl" (String#20149, DoABC#2)
// REOR_REMOVE_DIMMER = "_-1pt" (String#18537, DoABC#2)
// RWDSUE_DIMMER_STATE = "_-0A5" (String#14451, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


