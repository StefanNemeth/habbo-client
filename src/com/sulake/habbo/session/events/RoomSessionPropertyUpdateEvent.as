
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPropertyUpdateEvent extends RoomSessionEvent 
    {

        public static const RSDUE_ALLOW_PETS:String = "RSDUE_ALLOW_PETS";

        public function RoomSessionPropertyUpdateEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionPropertyUpdateEvent = "_-2-m" (String#19003, DoABC#2)
// RSDUE_ALLOW_PETS = "_-1md" (String#18406, DoABC#2)


