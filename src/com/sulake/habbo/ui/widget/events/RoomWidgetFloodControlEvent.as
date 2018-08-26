
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWFCE_FLOOD_CONTROL:String = "RWFCE_FLOOD_CONTROL";

        private var _seconds:int = 0;

        public function RoomWidgetFloodControlEvent(_arg_1:int)
        {
            super(RWFCE_FLOOD_CONTROL, false, false);
            this._seconds = _arg_1;
        }
        public function get seconds():int
        {
            return (this._seconds);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetFloodControlEvent = "_-23V" (String#19155, DoABC#2)
// RWFCE_FLOOD_CONTROL = "_-1qL" (String#18556, DoABC#2)
// _seconds = "_-098" (String#3741, DoABC#2)


