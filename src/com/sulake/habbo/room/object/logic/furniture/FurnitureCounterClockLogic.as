
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureCounterClockLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_5:RoomObjectEvent;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            var _local_3:int = object.getId();
            var _local_4:String = object.getType();
            switch (_arg_1.type){
                case MouseEvent.DOUBLE_CLICK:
                    switch (_arg_1.spriteTag){
                        case "start_stop":
                            _local_5 = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_3, _local_4, 1);
                            break;
                        case "reset":
                            _local_5 = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_3, _local_4, 2);
                            break;
                    };
                    if (((!((eventDispatcher == null))) && (!((_local_5 == null))))){
                        eventDispatcher.dispatchEvent(_local_5);
                        return;
                    };
                    break;
            };
            super.mouseEvent(_arg_1, _arg_2);
        }
        override public function useObject():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:RoomObjectEvent;
            if (object != null){
                _local_1 = object.getId();
                _local_2 = object.getType();
                _local_3 = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_1, _local_2, 1);
                if (eventDispatcher != null){
                    eventDispatcher.dispatchEvent(_local_3);
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureCounterClockLogic = "_-2Hi" (String#19713, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectStateChangeEvent = "_-2D1" (String#19524, DoABC#2)
// getAllEventTypes = "_-uN" (String#24466, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// ROSCE_STATE_CHANGE = "_-RU" (String#23304, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


