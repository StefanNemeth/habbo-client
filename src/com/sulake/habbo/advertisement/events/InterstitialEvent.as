
package com.sulake.habbo.advertisement.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class InterstitialEvent extends Event 
    {

        public static const AE_INTERSTITIAL_SHOW:String = "AE_INTERSTITIAL_SHOW";
        public static const AE_INTERSTITIAL_COMPLETE:String = "AE_INTERSTITIAL_COMPLETE";

        private var _image:BitmapData;
        private var _clickURL:String;

        public function InterstitialEvent(_arg_1:String, _arg_2:BitmapData=null, _arg_3:String="", _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get clickURL():String
        {
            return (this._clickURL);
        }

    }
}//package com.sulake.habbo.advertisement.events

// InterstitialEvent = "_-2PZ" (String#6552, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// AE_INTERSTITIAL_SHOW = "_-2Fx" (String#19641, DoABC#2)
// AE_INTERSTITIAL_COMPLETE = "_-7z" (String#22543, DoABC#2)
// _clickURL = "_-00g" (String#3575, DoABC#2)
// clickURL = "_-0-5" (String#14015, DoABC#2)


