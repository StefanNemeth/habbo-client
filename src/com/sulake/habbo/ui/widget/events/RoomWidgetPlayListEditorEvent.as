
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPlayListEditorEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWPLEE_SHOW_PLAYLIST_EDITOR:String = "RWPLEE_SHOW_PLAYLIST_EDITOR";
        public static const RWPLEE_HIDE_PLAYLIST_EDITOR:String = "RWPLEE_HIDE_PLAYLIST_EDITOR";
        public static const RWPLEE_INVENTORY_UPDATED:String = "RWPLEE_INVENTORY_UPDATED";
        public static const RWPLEE_SONG_DISK_INVENTORY_UPDATED:String = "RWPLEE_SONG_DISK_INVENTORY_UPDATED";
        public static const RWPLEE_PLAY_LIST_UPDATED:String = "RWPLEE_PLAY_LIST_UPDATED";
        public static const RWPLEE_PLAY_LIST_FULL:String = "RWPLEE_PLAY_LIST_FULL";

        private var _furniId:int;

        public function RoomWidgetPlayListEditorEvent(_arg_1:String, _arg_2:int=-1, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._furniId = _arg_2;
        }
        public function get furniId():int
        {
            return (this._furniId);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetPlayListEditorEvent = "_-1hD" (String#5690, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// RWPLEE_SHOW_PLAYLIST_EDITOR = "_-KD" (String#23013, DoABC#2)
// RWPLEE_HIDE_PLAYLIST_EDITOR = "_-1d" (String#18013, DoABC#2)
// RWPLEE_INVENTORY_UPDATED = "_-3z" (String#22376, DoABC#2)
// RWPLEE_SONG_DISK_INVENTORY_UPDATED = "_-0Yd" (String#15385, DoABC#2)
// RWPLEE_PLAY_LIST_UPDATED = "_-0WY" (String#15300, DoABC#2)
// RWPLEE_PLAY_LIST_FULL = "_-1li" (String#18362, DoABC#2)


