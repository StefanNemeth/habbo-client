
package com.sulake.habbo.session.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class BadgeImageReadyEvent extends Event 
    {

        public static const BIRE_BADGE_IMAGE_READY:String = "BIRE_BADGE_IMAGE_READY";

        private var _badgeId:String;
        private var _image:BitmapData;

        public function BadgeImageReadyEvent(_arg_1:String, _arg_2:BitmapData, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(BIRE_BADGE_IMAGE_READY, _arg_3, _arg_4);
            this._badgeId = _arg_1;
            this._image = _arg_2;
        }
        public function get badgeId():String
        {
            return (this._badgeId);
        }
        public function get badgeImage():BitmapData
        {
            return (this._image);
        }

    }
}//package com.sulake.habbo.session.events

// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// _badgeId = "_-rf" (String#642, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// BIRE_BADGE_IMAGE_READY = "_-38f" (String#21828, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)


