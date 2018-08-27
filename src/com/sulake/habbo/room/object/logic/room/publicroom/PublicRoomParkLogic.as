
package com.sulake.habbo.room.object.logic.room.publicroom
{
    import com.sulake.habbo.room.events.RoomObjectRoomActionEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class PublicRoomParkLogic extends PublicRoomLogic 
    {

        private static const _SafeStr_5326:String = "goawaybus";
        private static const _SafeStr_5327:String = "bus";
        private static const _SafeStr_5328:String = "bus_oviopen_hidden";

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectRoomActionEvent.RORAE_CHANGE_ROOM, RoomObjectRoomActionEvent.RORAE_TRY_BUS];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            super.mouseEvent(_arg_1, _arg_2);
            var _local_3:RoomSpriteMouseEvent = _arg_1;
            if (_local_3 == null){
                return;
            };
            if (object == null){
                return;
            };
            var _local_4:int = object.getId();
            var _local_5:String = object.getType();
            var _local_6:RoomObjectEvent;
            switch (_local_3.type){
                case MouseEvent.CLICK:
                    switch (_local_3.spriteTag){
                        case _SafeStr_5326:
                            _local_6 = new RoomObjectRoomActionEvent(RoomObjectRoomActionEvent.RORAE_CHANGE_ROOM, 0, _local_4, _local_5);
                            break;
                        case _SafeStr_5327:
                        case _SafeStr_5328:
                            _local_6 = new RoomObjectRoomActionEvent(RoomObjectRoomActionEvent.RORAE_TRY_BUS, 0, _local_4, _local_5);
                            break;
                    };
                    break;
            };
            if (eventDispatcher != null){
                if (_local_6 != null){
                    eventDispatcher.dispatchEvent(_local_6);
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.room.publicroom

// PublicRoomLogic = "_-2QI" (String#6566, DoABC#2)
// PublicRoomParkLogic = "_-0Yp" (String#15393, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectRoomActionEvent = "_-2rh" (String#21144, DoABC#2)
// getAllEventTypes = "_-uN" (String#24466, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// _SafeStr_5326 = "_-2sN" (String#21175, DoABC#2)
// _SafeStr_5327 = "_-1oT" (String#18476, DoABC#2)
// _SafeStr_5328 = "_-2k-" (String#20845, DoABC#2)
// RORAE_CHANGE_ROOM = "_-1pw" (String#18539, DoABC#2)
// RORAE_TRY_BUS = "_-3A5" (String#21887, DoABC#2)


