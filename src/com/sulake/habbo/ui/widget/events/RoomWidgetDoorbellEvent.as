
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDoorbellEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWDE_RINGING:String = "RWDE_RINGING";
        public static const RWDE_REJECTED:String = "RWDE_REJECTED";
        public static const RWDE_ACCEPTED:String = "RWDE_ACCEPTED";

        private var _userName:String = "";
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function RoomWidgetDoorbellEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._userName = _arg_2;
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetDoorbellEvent = "_-3CX" (String#7566, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// RWDE_REJECTED = "_-1MV" (String#17378, DoABC#2)
// RWDE_RINGING = "_-3FK" (String#22090, DoABC#2)


