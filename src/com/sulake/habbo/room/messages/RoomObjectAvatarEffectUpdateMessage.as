
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _effect:int;
        private var _delayMilliSeconds:int;

        public function RoomObjectAvatarEffectUpdateMessage(_arg_1:int=0, _arg_2:int=0)
        {
            this._effect = _arg_1;
            this._delayMilliSeconds = _arg_2;
        }
        public function get effect():int
        {
            return (this._effect);
        }
        public function get delayMilliSeconds():int
        {
            return (this._delayMilliSeconds);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarEffectUpdateMessage = "_-Tq" (String#23400, DoABC#2)
// effect = "_-rk" (String#24350, DoABC#2)
// delayMilliSeconds = "_-Rk" (String#23313, DoABC#2)
// _effect = "_-22d" (String#6099, DoABC#2)
// _delayMilliSeconds = "_-1N0" (String#5292, DoABC#2)


