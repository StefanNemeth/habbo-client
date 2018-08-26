
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUserBadgesUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUBUE_USER_BADGES:String = "RWUBUE_USER_BADGES";

        private var _userId:int;
        private var _badges:Array;

        public function RoomWidgetUserBadgesUpdateEvent(_arg_1:int, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(RWUBUE_USER_BADGES, _arg_3, _arg_4);
            this._userId = _arg_1;
            this._badges = _arg_2;
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
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetUserBadgesUpdateEvent = "_-18I" (String#16786, DoABC#2)
// RWUBUE_USER_BADGES = "_-21B" (String#19059, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)


