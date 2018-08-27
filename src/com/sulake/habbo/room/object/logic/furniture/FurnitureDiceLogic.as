
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureDiceLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectFurnitureActionEvent.ROFCAE_DICE_ACTIVATE, RoomObjectFurnitureActionEvent.ROFCAE_DICE_OFF];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:RoomObjectEvent;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            switch (_arg_1.type){
                case MouseEvent.DOUBLE_CLICK:
                    if (eventDispatcher != null){
                        _local_3 = object.getId();
                        _local_4 = object.getType();
                        if ((((((_arg_1.spriteTag == "activate")) || ((object.getState(0) == 0)))) || ((object.getState(0) == 100)))){
                            _local_5 = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_DICE_ACTIVATE, _local_3, _local_4);
                        }
                        else {
                            if (_arg_1.spriteTag == "deactivate"){
                                _local_5 = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_DICE_OFF, _local_3, _local_4);
                            };
                        };
                        if (_local_5 != null){
                            eventDispatcher.dispatchEvent(_local_5);
                        };
                    };
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureDiceLogic = "_-QR" (String#23266, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// getAllEventTypes = "_-uN" (String#24466, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// ROFCAE_DICE_OFF = "_-2dW" (String#20585, DoABC#2)
// ROFCAE_DICE_ACTIVATE = "_-HX" (String#22914, DoABC#2)


