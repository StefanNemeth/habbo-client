
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWBIUE_HABBO_CLUB:String = "RWBIUE_HABBO_CLUB";

        private var _daysLeft:int = 0;
        private var _periodsLeft:int = 0;
        private var _pastPeriods:int = 0;
        private var _allowClubDances:Boolean = false;
        private var _clubLevel:int;

        public function RoomWidgetHabboClubUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(RWBIUE_HABBO_CLUB, _arg_6, _arg_7);
            this._daysLeft = _arg_1;
            this._periodsLeft = _arg_2;
            this._pastPeriods = _arg_3;
            this._allowClubDances = _arg_4;
            this._clubLevel = _arg_5;
        }
        public function get daysLeft():int
        {
            return (this._daysLeft);
        }
        public function get periodsLeft():int
        {
            return (this._periodsLeft);
        }
        public function get pastPeriods():int
        {
            return (this._pastPeriods);
        }
        public function get allowClubDances():Boolean
        {
            return (this._allowClubDances);
        }
        public function get clubLevel():int
        {
            return (this._clubLevel);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _daysLeft = "_-37X" (String#21787, DoABC#2)
// _periodsLeft = "_-2Ck" (String#19514, DoABC#2)
// _pastPeriods = "_-0N9" (String#14962, DoABC#2)
// _allowClubDances = "_-11U" (String#16517, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetHabboClubUpdateEvent = "_-2ZL" (String#6751, DoABC#2)
// RWBIUE_HABBO_CLUB = "_-0ji" (String#15815, DoABC#2)
// daysLeft = "_-0Qt" (String#15097, DoABC#2)
// periodsLeft = "_-24W" (String#19201, DoABC#2)
// pastPeriods = "_-1Ue" (String#17690, DoABC#2)
// allowClubDances = "_-1V7" (String#17708, DoABC#2)


