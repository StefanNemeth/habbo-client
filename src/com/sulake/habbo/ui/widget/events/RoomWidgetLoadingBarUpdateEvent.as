
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetLoadingBarUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWIUE_SHOW:String = "RWLBUE_SHOW_LOADING_BAR";
        public static const RWLBUW_HIDE_LOADING_BAR:String = "RWLBUW_HIDE_LOADING_BAR";

        public function RoomWidgetLoadingBarUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetLoadingBarUpdateEvent = "_-0ux" (String#4743, DoABC#2)
// RWIUE_SHOW = "_-32i" (String#21606, DoABC#2)
// RWLBUW_HIDE_LOADING_BAR = "_-0-1" (String#14011, DoABC#2)


