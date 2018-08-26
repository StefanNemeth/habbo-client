
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;

    public class FurnitureStickieLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_STICKIE, RoomObjectFurnitureActionEvent.ROFCAE_STICKIE];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            this.setColorIndexFromItemData();
            if (object != null){
                object.getModelController().setString(RoomObjectVariableEnum._SafeStr_12459, "");
            };
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectWidgetRequestEvent;
            super.processUpdateMessage(_arg_1);
            if ((_arg_1 is RoomObjectItemDataUpdateMessage)){
                _local_2 = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_STICKIE, object.getId(), object.getType());
                if (_local_2 != null){
                    eventDispatcher.dispatchEvent(_local_2);
                };
            };
            this.setColorIndexFromItemData();
        }
        protected function setColorIndexFromItemData():void
        {
            var _local_1:String;
            var _local_2:Array;
            var _local_3:int;
            if (object != null){
                _local_1 = object.getModel().getString(RoomObjectVariableEnum._SafeStr_7217);
                _local_2 = new Array("9CCEFF", "FF9CFF", "9CFF9C", "FFFF33");
                _local_3 = _local_2.indexOf(_local_1);
                if (_local_3 < 0){
                    _local_3 = 3;
                };
                object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_7220, (_local_3 + 1));
            };
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
                _local_3 = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_STICKIE, _local_1, _local_2);
                eventDispatcher.dispatchEvent(_local_3);
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// setColorIndexFromItemData = "_-FY" (String#22833, DoABC#2)
// _SafeStr_12459 = "_-2sB" (String#21166, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureStickieLogic = "_-1Zz" (String#17890, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectItemDataUpdateMessage = "_-1yC" (String#18895, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// REOE_WIDGET_REQUEST_STICKIE = "_-IJ" (String#22941, DoABC#2)
// ROFCAE_STICKIE = "_-28f" (String#19358, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// _SafeStr_7220 = "_-1eF" (String#18068, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


