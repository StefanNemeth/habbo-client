
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionFavouriteGroupUpdateEvent extends RoomSessionEvent 
    {

        public static const _SafeStr_4800:String = "rsfgue_favourite_group_update";

        private var _roomIndex:int;
        private var _habboGroupId:int;
        private var _status:int;

        public function RoomSessionFavouriteGroupUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_SafeStr_4800, _arg_1, _arg_5, _arg_6);
            this._roomIndex = _arg_2;
            this._habboGroupId = _arg_3;
            this._status = _arg_4;
        }
        public function get roomIndex():int
        {
            return (this._roomIndex);
        }
        public function get habboGroupId():int
        {
            return (this._habboGroupId);
        }
        public function get status():int
        {
            return (this._status);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionFavouriteGroupUpdateEvent = "_-0xo" (String#16346, DoABC#2)
// _roomIndex = "_-1S2" (String#362, DoABC#2)
// _habboGroupId = "_-2IT" (String#6412, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// habboGroupId = "_-PC" (String#23215, DoABC#2)
// _SafeStr_4800 = "_-F" (String#22812, DoABC#2)


