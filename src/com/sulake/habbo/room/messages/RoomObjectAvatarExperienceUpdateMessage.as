
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarExperienceUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _gainedExperience:int;

        public function RoomObjectAvatarExperienceUpdateMessage(_arg_1:int)
        {
            this._gainedExperience = _arg_1;
        }
        public function get gainedExperience():int
        {
            return (this._gainedExperience);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarExperienceUpdateMessage = "_-2al" (String#20478, DoABC#2)
// _gainedExperience = "_-1BG" (String#5099, DoABC#2)
// gainedExperience = "_-7m" (String#22533, DoABC#2)


