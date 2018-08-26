
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDanceMessage extends RoomWidgetMessage 
    {

        public static const RWCM_MESSAGE_DANCE:String = "RWCM_MESSAGE_DANCE";
        public static const _SafeStr_3577:int = 0;
        public static const _SafeStr_3578:Array = [2, 3, 4];

        private var _style:int = 0;

        public function RoomWidgetDanceMessage(_arg_1:int)
        {
            super(RWCM_MESSAGE_DANCE);
            this._style = _arg_1;
        }
        public function get style():int
        {
            return (this._style);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetDanceMessage = "_-1CY" (String#5117, DoABC#2)
// RWCM_MESSAGE_DANCE = "_-3In" (String#22229, DoABC#2)
// _SafeStr_3577 = "_-Fb" (String#22834, DoABC#2)
// _SafeStr_3578 = "_-2CA" (String#19490, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)


