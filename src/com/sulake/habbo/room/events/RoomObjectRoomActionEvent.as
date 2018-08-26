
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectRoomActionEvent extends RoomObjectEvent 
    {

        public static const RORAE_LEAVE_ROOM:String = "RORAE_LEAVE_ROOM";
        public static const RORAE_CHANGE_ROOM:String = "RORAE_CHANGE_ROOM";
        public static const RORAE_TRY_BUS:String = "RORAE_TRY_BUS";

        private var _param:int = 0;

        public function RoomObjectRoomActionEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6);
            this._param = _arg_2;
        }
        public function get param():int
        {
            return (this._param);
        }

    }
}//package com.sulake.habbo.room.events

// RoomObjectRoomActionEvent = "_-2rh" (String#21144, DoABC#2)
// _param = "_-2d3" (String#306, DoABC#2)
// RORAE_CHANGE_ROOM = "_-1pw" (String#18539, DoABC#2)
// RORAE_TRY_BUS = "_-3A5" (String#21887, DoABC#2)
// RORAE_LEAVE_ROOM = "_-38d" (String#21827, DoABC#2)


