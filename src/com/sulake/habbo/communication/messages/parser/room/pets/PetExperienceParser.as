
package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetExperienceParser implements IMessageParser 
    {

        private var _id:int = -1;
        private var _petRoomIndex:int = -1;
        private var _gainedExperience:int = 0;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function get petId():int
        {
            return (this._id);
        }
        public function get petRoomIndex():int
        {
            return (this._petRoomIndex);
        }
        public function get gainedExperience():int
        {
            return (this._gainedExperience);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._id = _arg_1.readInteger();
            this._petRoomIndex = _arg_1.readInteger();
            this._gainedExperience = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.pets

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetExperienceParser = "_-1-V" (String#4858, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// _gainedExperience = "_-1BG" (String#5099, DoABC#2)
// petRoomIndex = "_-ij" (String#23987, DoABC#2)
// gainedExperience = "_-7m" (String#22533, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


