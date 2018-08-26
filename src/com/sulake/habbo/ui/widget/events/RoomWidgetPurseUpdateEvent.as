
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPurseUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWPUE_CREDIT_BALANCE:String = "RWPUE_CREDIT_BALANCE";
        public static const RWPUE_PIXEL_BALANCE:String = "RWPUE_PIXEL_BALANCE";
        public static const RWPUE_SHELL_BALANCE:String = "RWPUE_SHELL_BALANCE";

        private var _balance:int;

        public function RoomWidgetPurseUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._balance = _arg_2;
        }
        public function get balance():int
        {
            return (this._balance);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetPurseUpdateEvent = "_-2mA" (String#7009, DoABC#2)
// RWPUE_CREDIT_BALANCE = "_-31Q" (String#21556, DoABC#2)
// RWPUE_SHELL_BALANCE = "_-0Se" (String#15158, DoABC#2)
// RWPUE_PIXEL_BALANCE = "_-16-" (String#16697, DoABC#2)
// _balance = "_-8R" (String#927, DoABC#2)


