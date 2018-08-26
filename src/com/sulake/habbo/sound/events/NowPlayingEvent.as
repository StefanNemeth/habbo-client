
package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class NowPlayingEvent extends Event 
    {

        public static const RWPLENPE_USER_PLAY_SONG:String = "NPE_USER_PLAY_SONG";
        public static const RWPLENPW_USER_STOP_SONG:String = "NPW_USER_STOP_SONG";
        public static const RWPLENPE_SONG_CHANGED:String = "NPE_SONG_CHANGED";

        private var _id:int;
        private var _position:int;
        private var _priority:int;

        public function NowPlayingEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            this._id = _arg_3;
            this._position = _arg_4;
            this._priority = _arg_2;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get position():int
        {
            return (this._position);
        }
        public function get priority():int
        {
            return (this._priority);
        }

    }
}//package com.sulake.habbo.sound.events

// NowPlayingEvent = "_-1nK" (String#5803, DoABC#2)
// _position = "_-0Pf" (String#433, DoABC#2)
// RWPLENPE_SONG_CHANGED = "_-5w" (String#22462, DoABC#2)
// RWPLENPE_USER_PLAY_SONG = "_-36w" (String#21763, DoABC#2)
// RWPLENPW_USER_STOP_SONG = "_-0Kk" (String#14870, DoABC#2)


