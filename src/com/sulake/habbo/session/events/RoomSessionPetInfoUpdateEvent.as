
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IPetInfo;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetInfoUpdateEvent extends RoomSessionEvent 
    {

        public static const PET_INFO:String = "RSPIUE_PET_INFO";

        private var _petInfo:IPetInfo;

        public function RoomSessionPetInfoUpdateEvent(_arg_1:IRoomSession, _arg_2:IPetInfo, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(RoomSessionPetInfoUpdateEvent.PET_INFO, _arg_1, _arg_3, _arg_4);
            this._petInfo = _arg_2;
        }
        public function get petInfo():IPetInfo
        {
            return (this._petInfo);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionPetInfoUpdateEvent = "_-Xz" (String#23559, DoABC#2)
// IPetInfo = "_-1od" (String#5834, DoABC#2)
// _petInfo = "_-Lf" (String#23068, DoABC#2)
// petInfo = "_-YX" (String#23581, DoABC#2)


