
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetBadgeImageUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWBIUE_BADGE_IMAGE:String = "RWBIUE_BADGE_IMAGE";

        private var _badgeID:String;
        private var _badgeImage:BitmapData;

        public function RoomWidgetBadgeImageUpdateEvent(_arg_1:String, _arg_2:BitmapData, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(RWBIUE_BADGE_IMAGE, _arg_3, _arg_4);
            this._badgeID = _arg_1;
            this._badgeImage = _arg_2;
        }
        public function get badgeID():String
        {
            return (this._badgeID);
        }
        public function get badgeImage():BitmapData
        {
            return (this._badgeImage);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RWBIUE_BADGE_IMAGE = "_-1qO" (String#18558, DoABC#2)
// _badgeImage = "_-35a" (String#21715, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetBadgeImageUpdateEvent = "_-1Sg" (String#17609, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// badgeID = "_-Cm" (String#22716, DoABC#2)
// _badgeID = "_-1Vx" (String#5471, DoABC#2)


