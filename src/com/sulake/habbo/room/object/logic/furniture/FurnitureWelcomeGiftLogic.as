
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureWelcomeGiftLogic extends FurnitureMultiStateLogic 
    {

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
                case MouseEvent.CLICK:
                    _local_3 = object.getId();
                    _local_4 = object.getType();
                    if (eventDispatcher != null){
                        eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_3, _local_4));
                    };
                    break;
            };
            super.mouseEvent(_arg_1, _arg_2);
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurnitureWelcomeGiftLogic = "_-1hA" (String#18181, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectStateChangeEvent = "_-2D1" (String#19524, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// ROSCE_STATE_CHANGE = "_-RU" (String#23304, DoABC#2)


