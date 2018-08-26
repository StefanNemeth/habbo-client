
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserBadgesEvent extends RoomSessionEvent 
    {

        public static const RWUBUE_USER_BADGES:String = "RSUBE_BADGES";

        private var _userId:int = 0;
        private var _badges:Array;

        public function RoomSessionUserBadgesEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:Array, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            this._badges = [];
            super(RWUBUE_USER_BADGES, _arg_1, _arg_4, _arg_5);
            this._userId = _arg_2;
            this._badges = _arg_3;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get badges():Array
        {
            return (this._badges);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionUserBadgesEvent = "_-0-O" (String#14028, DoABC#2)
// RWUBUE_USER_BADGES = "_-21B" (String#19059, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)


