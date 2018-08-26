
package com.sulake.habbo.sound.music
{
    import flash.utils.getTimer;

    public class SongStartRequestData 
    {

        private var _songId:int;
        private var _SafeStr_7753:Number;
        private var _playLength:Number;
        private var _SafeStr_7755:int;
        private var _fadeInSeconds:Number;
        private var _fadeOutSeconds:Number;

        public function SongStartRequestData(_arg_1:int, _arg_2:Number, _arg_3:Number, _arg_4:Number=2, _arg_5:Number=1)
        {
            this._songId = _arg_1;
            this._SafeStr_7753 = _arg_2;
            this._playLength = _arg_3;
            this._fadeInSeconds = _arg_4;
            this._fadeOutSeconds = _arg_5;
            this._SafeStr_7755 = getTimer();
        }
        public function get songId():int
        {
            return (this._songId);
        }
        public function get startPos():Number
        {
            if (this._SafeStr_7753 < 0){
                return (0);
            };
            return ((this._SafeStr_7753 + ((getTimer() - this._SafeStr_7755) / 1000)));
        }
        public function get playLength():Number
        {
            return (this._playLength);
        }
        public function get fadeInSeconds():Number
        {
            return (this._fadeInSeconds);
        }
        public function get fadeOutSeconds():Number
        {
            return (this._fadeOutSeconds);
        }

    }
}//package com.sulake.habbo.sound.music

// SongStartRequestData = "_-1Gb" (String#5178, DoABC#2)
// fadeOutSeconds = "_-0GD" (String#3874, DoABC#2)
// fadeInSeconds = "_-2FB" (String#6346, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// startPos = "_-2Wm" (String#20315, DoABC#2)
// playLength = "_-1gr" (String#18169, DoABC#2)
// _SafeStr_7753 = "_-2fi" (String#20681, DoABC#2)
// _playLength = "_-2bB" (String#20497, DoABC#2)
// _SafeStr_7755 = "_-2Hj" (String#19714, DoABC#2)
// _fadeInSeconds = "_-2mP" (String#20935, DoABC#2)
// _fadeOutSeconds = "_-1q5" (String#18547, DoABC#2)


