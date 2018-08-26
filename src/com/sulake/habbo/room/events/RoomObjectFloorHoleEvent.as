
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectFloorHoleEvent extends RoomObjectEvent 
    {

        public static const RORPFHUM_ADD:String = "ROFHO_ADD_HOLE";
        public static const RORPFHUM_REMOVE:String = "ROFHO_REMOVE_HOLE";

        public function RoomObjectFloorHoleEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }
    }
}//package com.sulake.habbo.room.events

// RoomObjectFloorHoleEvent = "_-2j-" (String#20806, DoABC#2)
// RORPFHUM_ADD = "_-wb" (String#24555, DoABC#2)
// RORPFHUM_REMOVE = "_-0CG" (String#14540, DoABC#2)


