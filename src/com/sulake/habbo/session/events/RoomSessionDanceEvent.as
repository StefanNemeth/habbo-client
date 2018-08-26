
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDanceEvent extends RoomSessionEvent 
    {

        public static const RSDE_DANCE:String = "RSDE_DANCE";

        private var _userId:int;
        private var _danceStyle:int;

        public function RoomSessionDanceEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(RSDE_DANCE, _arg_1, _arg_4, _arg_5);
            this._userId = _arg_2;
            this._danceStyle = _arg_3;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get danceStyle():int
        {
            return (this._danceStyle);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionDanceEvent = "_-nx" (String#24188, DoABC#2)
// RSDE_DANCE = "_-0-n" (String#14045, DoABC#2)
// danceStyle = "_-0M0" (String#14915, DoABC#2)


