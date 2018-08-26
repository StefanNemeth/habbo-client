
package com.sulake.habbo.room.events
{
    import flash.events.Event;

    public class RoomEngineEvent extends Event 
    {

        public static const REE_ENGINE_INITIALIZED:String = "REE_ENGINE_INITIALIZED";
        public static const REE_INITIALIZED:String = "REE_INITIALIZED";
        public static const REE_DISPOSED:String = "REE_DISPOSED";
        public static const REE_GAME_MODE:String = "REE_GAME_MODE";
        public static const REE_NORMAL_MODE:String = "REE_NORMAL_MODE";

        private var _roomId:int;
        private var _roomCategory:int;

        public function RoomEngineEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
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
}//package com.sulake.habbo.room.events

// REE_INITIALIZED = "_-0c3" (String#15515, DoABC#2)
// REE_ENGINE_INITIALIZED = "_-2KW" (String#19823, DoABC#2)
// REE_DISPOSED = "_-rn" (String#24352, DoABC#2)
// REE_GAME_MODE = "_-131" (String#16581, DoABC#2)
// REE_NORMAL_MODE = "_-1fp" (String#18130, DoABC#2)


