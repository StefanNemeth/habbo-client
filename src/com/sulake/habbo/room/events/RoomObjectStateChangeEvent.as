
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectStateChangeEvent extends RoomObjectEvent 
    {

        public static const ROSCE_STATE_CHANGE:String = "ROSCE_STATE_CHANGE";
        public static const ROSCE_STATE_RANDOM:String = "ROSCE_STATE_RANDOM";

        private var _param:int = 0;

        public function RoomObjectStateChangeEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int=0, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6);
            this._param = _arg_4;
        }
        public function get param():int
        {
            return (this._param);
        }

    }
}//package com.sulake.habbo.room.events

// RoomObjectStateChangeEvent = "_-2D1" (String#19524, DoABC#2)
// _param = "_-2d3" (String#306, DoABC#2)
// ROSCE_STATE_CHANGE = "_-RU" (String#23304, DoABC#2)
// ROSCE_STATE_RANDOM = "_-0Ov" (String#15021, DoABC#2)


