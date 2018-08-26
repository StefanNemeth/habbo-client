
package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRespectFailedParser implements IMessageParser 
    {

        private var _requiredDays:int;
        private var _avatarAgeInDays:int;

        public function get requiredDays():int
        {
            return (this._requiredDays);
        }
        public function get avatarAgeInDays():int
        {
            return (this._avatarAgeInDays);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._requiredDays = _arg_1.readInteger();
            this._avatarAgeInDays = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.pets

// PetRespectFailedParser = "_-0Ix" (String#3934, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _avatarAgeInDays = "_-bG" (String#23680, DoABC#2)
// requiredDays = "_-Ac" (String#22640, DoABC#2)
// avatarAgeInDays = "_-0Aw" (String#14486, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


