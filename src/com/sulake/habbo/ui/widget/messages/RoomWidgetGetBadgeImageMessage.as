
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetBadgeImageMessage extends RoomWidgetMessage 
    {

        public static const RWGOI_MESSAGE_GET_BADGE_IMAGE:String = "RWGOI_MESSAGE_GET_BADGE_IMAGE";

        private var _badgeId:String = "";

        public function RoomWidgetGetBadgeImageMessage(_arg_1:String)
        {
            super(RWGOI_MESSAGE_GET_BADGE_IMAGE);
            this._badgeId = _arg_1;
        }
        public function get badgeId():String
        {
            return (this._badgeId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetGetBadgeImageMessage = "_-0U-" (String#4182, DoABC#2)
// RWGOI_MESSAGE_GET_BADGE_IMAGE = "_-1w2" (String#18800, DoABC#2)
// _badgeId = "_-rf" (String#642, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)


