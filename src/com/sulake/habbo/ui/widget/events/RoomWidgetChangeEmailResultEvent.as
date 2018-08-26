
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetChangeEmailResultEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_8013:String = "rwcere_change_email_result";

        private var _result:int;

        public function RoomWidgetChangeEmailResultEvent(_arg_1:int, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_SafeStr_8013, _arg_2, _arg_3);
            this._result = _arg_1;
        }
        public function get result():int
        {
            return (this._result);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetChangeEmailResultEvent = "_-1i2" (String#5710, DoABC#2)
// _SafeStr_8013 = "_-nY" (String#24173, DoABC#2)


