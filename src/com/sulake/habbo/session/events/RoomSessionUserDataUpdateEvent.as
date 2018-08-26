
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserDataUpdateEvent extends RoomSessionEvent 
    {

        public static const _SafeStr_4720:String = "rsudue_user_data_updated";

        public function RoomSessionUserDataUpdateEvent(_arg_1:IRoomSession, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_SafeStr_4720, _arg_1, _arg_2, _arg_3);
        }
    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionUserDataUpdateEvent = "_-10F" (String#16473, DoABC#2)
// _SafeStr_4720 = "_-XT" (String#23542, DoABC#2)


