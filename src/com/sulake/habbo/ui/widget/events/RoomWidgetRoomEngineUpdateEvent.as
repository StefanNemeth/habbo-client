
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomEngineUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_3911:String = "RWREUE_GAME_MODE";
        public static const RWREUE_NORMAL_MODE:String = "RWREUE_NORMAL_MODE";

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function RoomWidgetRoomEngineUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this._roomId = _arg_2;
            this._roomCategory = _arg_3;
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetRoomEngineUpdateEvent = "_-x9" (String#8828, DoABC#2)
// RWREUE_NORMAL_MODE = "_-w-" (String#24530, DoABC#2)
// _SafeStr_3911 = "native" (String#46040, DoABC#2)


