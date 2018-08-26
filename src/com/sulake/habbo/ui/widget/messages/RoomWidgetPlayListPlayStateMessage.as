
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPlayListPlayStateMessage extends RoomWidgetMessage 
    {

        public static const RWPLPS_TOGGLE_PLAY_PAUSE:String = "RWPLPS_TOGGLE_PLAY_PAUSE";

        private var _furniId:int;
        private var _position:int;

        public function RoomWidgetPlayListPlayStateMessage(_arg_1:String, _arg_2:int, _arg_3:int=-1)
        {
            super(_arg_1);
            this._furniId = _arg_2;
            this._position = _arg_3;
        }
        public function get furniId():int
        {
            return (this._furniId);
        }
        public function get position():int
        {
            return (this._position);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetPlayListPlayStateMessage = "_-3CO" (String#7559, DoABC#2)
// RWPLPS_TOGGLE_PLAY_PAUSE = "_-0GS" (String#14699, DoABC#2)
// _position = "_-0Pf" (String#433, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)


