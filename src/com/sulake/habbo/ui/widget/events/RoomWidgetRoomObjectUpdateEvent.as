
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomObjectUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWROUE_OBJECT_SELECTED:String = "RWROUE_OBJECT_SELECTED";
        public static const RWROUE_OBJECT_DESELECTED:String = "RWROUE_OBJECT_DESELECTED";
        public static const RWROUE_USER_REMOVED:String = "RWROUE_USER_REMOVED";
        public static const RWROUE_FURNI_REMOVED:String = "RWROUE_FURNI_REMOVED";
        public static const RWROUE_FURNI_ADDED:String = "RWROUE_FURNI_ADDED";
        public static const RWROUE_USER_ADDED:String = "RWROUE_USER_ADDED";
        public static const RWROUE_OBJECT_ROLL_OVER:String = "RWROUE_OBJECT_ROLL_OVER";
        public static const RWROUE_OBJECT_ROLL_OUT:String = "RWROUE_OBJECT_ROLL_OUT";

        private var _id:int = 0;
        private var _category:int = 0;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function RoomWidgetRoomObjectUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            this._id = _arg_2;
            this._category = _arg_3;
            this._roomId = _arg_4;
            this._roomCategory = _arg_5;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get category():int
        {
            return (this._category);
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
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RWROUE_FURNI_REMOVED = "_-2L6" (String#19851, DoABC#2)
// RWROUE_OBJECT_DESELECTED = "_-8G" (String#22552, DoABC#2)
// RWROUE_FURNI_ADDED = "_-2ER" (String#19583, DoABC#2)
// RWROUE_USER_REMOVED = "_-02u" (String#14156, DoABC#2)
// RWROUE_USER_ADDED = "_-0wr" (String#16305, DoABC#2)
// RWROUE_OBJECT_SELECTED = "_-0Yn" (String#15392, DoABC#2)
// RWROUE_OBJECT_ROLL_OVER = "_-2vE" (String#21287, DoABC#2)
// RWROUE_OBJECT_ROLL_OUT = "_-2K0" (String#19807, DoABC#2)


