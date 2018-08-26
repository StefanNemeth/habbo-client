
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserFigureUpdateEvent extends RoomSessionEvent 
    {

        public static const RWUTUE_USER_FIGURE:String = "RSUBE_FIGURE";

        private var _userId:int = 0;
        private var _figure:String = "";
        private var _gender:String = "";
        private var _customInfo:String = "";
        private var _achievementScore:int;

        public function RoomSessionUserFigureUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(RWUTUE_USER_FIGURE, _arg_1, _arg_7, _arg_8);
            this._userId = _arg_2;
            this._figure = _arg_3;
            this._gender = _arg_4;
            this._customInfo = _arg_5;
            this._achievementScore = _arg_6;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get gender():String
        {
            return (this._gender);
        }
        public function get customInfo():String
        {
            return (this._customInfo);
        }
        public function get achievementScore():int
        {
            return (this._achievementScore);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionUserFigureUpdateEvent = "_-387" (String#21808, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _customInfo = "_-290" (String#1821, DoABC#2)
// _achievementScore = "_-2Iu" (String#449, DoABC#2)
// customInfo = "_-2Mk" (String#19916, DoABC#2)
// RWUTUE_USER_FIGURE = "_-0QV" (String#15081, DoABC#2)


