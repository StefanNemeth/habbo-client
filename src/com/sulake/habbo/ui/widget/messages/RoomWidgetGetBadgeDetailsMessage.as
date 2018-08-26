
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetBadgeDetailsMessage extends RoomWidgetMessage 
    {

        public static const RWGOI_MESSAGE_GET_BADGE_DETAILS:String = "RWGOI_MESSAGE_GET_BADGE_DETAILS";

        private var _groupId:int = 0;

        public function RoomWidgetGetBadgeDetailsMessage(_arg_1:int)
        {
            super(RWGOI_MESSAGE_GET_BADGE_DETAILS);
            this._groupId = _arg_1;
        }
        public function get groupId():int
        {
            return (this._groupId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetGetBadgeDetailsMessage = "_-3AO" (String#7522, DoABC#2)
// RWGOI_MESSAGE_GET_BADGE_DETAILS = "_-1LU" (String#17332, DoABC#2)
// _groupId = "_-nB" (String#641, DoABC#2)


