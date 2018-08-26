
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetRoomTagSearchMessage extends RoomWidgetMessage 
    {

        public static const RWRTSM_ROOM_TAG_SEARCH:String = "RWRTSM_ROOM_TAG_SEARCH";

        private var _tag:String = "";

        public function RoomWidgetRoomTagSearchMessage(_arg_1:String)
        {
            super(RWRTSM_ROOM_TAG_SEARCH);
            this._tag = _arg_1;
        }
        public function get tag():String
        {
            return (this._tag);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetRoomTagSearchMessage = "_-2ev" (String#6850, DoABC#2)
// RWRTSM_ROOM_TAG_SEARCH = "_-1oq" (String#18491, DoABC#2)
// _tag = "_-1Gy" (String#601, DoABC#2)


