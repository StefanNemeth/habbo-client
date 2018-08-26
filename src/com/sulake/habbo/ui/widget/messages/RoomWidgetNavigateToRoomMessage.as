
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetNavigateToRoomMessage extends RoomWidgetMessage 
    {

        public static const RWGOI_MESSAGE_NAVIGATE_TO_ROOM:String = "RWGOI_MESSAGE_NAVIGATE_TO_ROOM";
        public static const RWGOI_MESSAGE_NAVIGATE_HOME:String = "RWGOI_MESSAGE_NAVIGATE_HOME";

        private var _roomId:int;

        public function RoomWidgetNavigateToRoomMessage(_arg_1:String, _arg_2:int=-1)
        {
            super(_arg_1);
            this._roomId = _arg_2;
        }
        public function get roomId():int
        {
            return (this._roomId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetNavigateToRoomMessage = "_-26Z" (String#6177, DoABC#2)
// RWGOI_MESSAGE_NAVIGATE_TO_ROOM = "_-1et" (String#18093, DoABC#2)
// RWGOI_MESSAGE_NAVIGATE_HOME = "_-0g" (String#15670, DoABC#2)


