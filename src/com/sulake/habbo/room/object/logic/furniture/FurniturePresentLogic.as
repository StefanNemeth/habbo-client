
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;

    public class FurniturePresentLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_PRESENT];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_3:int;
            var _local_4:String;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            switch (_arg_1.type){
                case MouseEvent.ROLL_OVER:
                    _local_3 = object.getId();
                    _local_4 = object.getType();
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_BUTTON, _local_3, _local_4));
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
                case MouseEvent.ROLL_OUT:
                    _local_3 = object.getId();
                    _local_4 = object.getType();
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_ARROW, _local_3, _local_4));
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
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
                _local_3 = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_PRESENT, _local_1, _local_2);
                eventDispatcher.dispatchEvent(_local_3);
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurniturePresentLogic = "_-1BH" (String#16909, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// REOE_WIDGET_REQUEST_PRESENT = "_-3D0" (String#21997, DoABC#2)
// ROFCAE_MOUSE_BUTTON = "_-Sz" (String#23363, DoABC#2)
// ROFCAE_MOUSE_ARROW = "_-2VP" (String#20258, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


