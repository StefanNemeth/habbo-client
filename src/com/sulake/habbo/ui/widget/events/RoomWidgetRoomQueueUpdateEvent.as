
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWRQUE_VISITOR_QUEUE_STATUS:String = "RWRQUE_VISITOR_QUEUE_STATUS";
        public static const RWRQUE_SPECTATOR_QUEUE_STATUS:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";

        private var _position:int;
        private var _hasHabboClub:Boolean;
        private var _isActive:Boolean;
        private var _isClubQueue:Boolean;

        public function RoomWidgetRoomQueueUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            this._position = _arg_2;
            this._hasHabboClub = _arg_3;
            this._isActive = _arg_4;
            this._isClubQueue = _arg_5;
        }
        public function get position():int
        {
            return (this._position);
        }
        public function get hasHabboClub():Boolean
        {
            return (this._hasHabboClub);
        }
        public function get isActive():Boolean
        {
            return (this._isActive);
        }
        public function get isClubQueue():Boolean
        {
            return (this._isClubQueue);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _hasHabboClub = "_-0Uy" (String#15240, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetRoomQueueUpdateEvent = "_-0Dx" (String#3826, DoABC#2)
// _position = "_-0Pf" (String#433, DoABC#2)
// _isActive = "_-Aj" (String#929, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// _isClubQueue = "_-2vy" (String#7200, DoABC#2)
// RWRQUE_VISITOR_QUEUE_STATUS = "_-mB" (String#24117, DoABC#2)
// RWRQUE_SPECTATOR_QUEUE_STATUS = "_-UO" (String#23426, DoABC#2)
// hasHabboClub = "_-1pE" (String#18510, DoABC#2)
// isClubQueue = "_-Gv" (String#22888, DoABC#2)


