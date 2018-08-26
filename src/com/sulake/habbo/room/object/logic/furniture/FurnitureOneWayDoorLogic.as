
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;

    public class FurnitureOneWayDoorLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectFurnitureActionEvent.ROFCAE_ENTER_ONEWAYDOOR];
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
                _local_3 = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_ENTER_ONEWAYDOOR, _local_1, _local_2);
                eventDispatcher.dispatchEvent(_local_3);
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureOneWayDoorLogic = "_-15q" (String#16690, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// ROFCAE_ENTER_ONEWAYDOOR = "_-1nd" (String#18446, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


