
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectMoveEvent extends RoomObjectEvent 
    {

        public static const ROME_POSITION_CHANGED:String = "ROME_POSITION_CHANGED";
        public static const ROME_OBJECT_REMOVED:String = "ROME_OBJECT_REMOVED";

        public function RoomObjectMoveEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }
    }
}//package com.sulake.habbo.room.events

// RoomObjectMoveEvent = "_-2gn" (String#20720, DoABC#2)
// ROME_POSITION_CHANGED = "_-114" (String#16501, DoABC#2)
// ROME_OBJECT_REMOVED = "_-0PW" (String#15043, DoABC#2)


