
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetInterstitialUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWIUE_SHOW:String = "RWIUE_SHOW";
        public static const COMPLETE:String = "RWIUE_COMPLETE";

        private var _image:BitmapData;
        private var _clickUrl:String;

        public function RoomWidgetInterstitialUpdateEvent(_arg_1:String, _arg_2:BitmapData, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this._image = _arg_2;
            this._clickUrl = _arg_3;
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get clickUrl():String
        {
            return (this._clickUrl);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetInterstitialUpdateEvent = "_-198" (String#5059, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _clickUrl = "_-2-C" (String#303, DoABC#2)
// RWIUE_SHOW = "_-32i" (String#21606, DoABC#2)


