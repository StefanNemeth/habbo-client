
package com.sulake.habbo.room.events
{
    public class RoomEngineDimmerStateEvent extends RoomEngineEvent 
    {

        public static const RWDSUE_DIMMER_STATE:String = "REDSE_ROOM_COLOR";

        private var _state:int;
        private var _presetId:int;
        private var _effectId:int;
        private var _color:uint;
        private var _brightness:int;

        public function RoomEngineDimmerStateEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:uint, _arg_7:uint, _arg_8:Boolean=false, _arg_9:Boolean=false)
        {
            super(RWDSUE_DIMMER_STATE, _arg_1, _arg_2, _arg_8, _arg_9);
            this._state = _arg_3;
            this._presetId = _arg_4;
            this._effectId = _arg_5;
            this._color = _arg_6;
            this._brightness = _arg_7;
        }
        public function get state():int
        {
            return (this._state);
        }
        public function get presetId():int
        {
            return (this._presetId);
        }
        public function get effectId():int
        {
            return (this._effectId);
        }
        public function get color():uint
        {
            return (this._color);
        }
        public function get brightness():uint
        {
            return (this._brightness);
        }

    }
}//package com.sulake.habbo.room.events

// RoomEngineDimmerStateEvent = "_-kD" (String#24044, DoABC#2)
// _brightness = "_-2Jm" (String#450, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)
// RWDSUE_DIMMER_STATE = "_-0A5" (String#14451, DoABC#2)
// _presetId = "_-1ik" (String#861, DoABC#2)
// _effectId = "_-06d" (String#580, DoABC#2)
// presetId = "_-37i" (String#21795, DoABC#2)
// effectId = "_-0jW" (String#15809, DoABC#2)


