
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDanceUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUE_DANCE:String = "RWUE_DANCE";

        private var _style:int;

        public function RoomWidgetDanceUpdateEvent(_arg_1:int, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(RWUE_DANCE, _arg_2, _arg_3);
            this._style = _arg_1;
        }
        public function get style():int
        {
            return (this._style);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetDanceUpdateEvent = "_-268" (String#6166, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)
// RWUE_DANCE = "_-0kM" (String#15844, DoABC#2)


