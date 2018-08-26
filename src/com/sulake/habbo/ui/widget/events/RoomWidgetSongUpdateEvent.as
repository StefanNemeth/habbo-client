
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSongUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWSUE_PLAYING_CHANGED:String = "RWSUE_PLAYING_CHANGED";
        public static const RWSUE_DATA_RECEIVED:String = "RWSUE_DATA_RECEIVED";

        private var _songId:int;
        private var _songName:String;
        private var _songAuthor:String;

        public function RoomWidgetSongUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            this._songId = _arg_2;
            this._songName = _arg_3;
            this._songAuthor = _arg_4;
        }
        public function get songId():int
        {
            return (this._songId);
        }
        public function get songName():String
        {
            return (this._songName);
        }
        public function get songAuthor():String
        {
            return (this._songAuthor);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _songAuthor = "_-36O" (String#7438, DoABC#2)
// songAuthor = "_-0Jg" (String#14829, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetSongUpdateEvent = "_-0rz" (String#16120, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// songName = "_-uT" (String#24469, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// RWSUE_PLAYING_CHANGED = "_-3LG" (String#22337, DoABC#2)
// RWSUE_DATA_RECEIVED = "_-0BQ" (String#14503, DoABC#2)


