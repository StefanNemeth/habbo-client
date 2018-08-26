
package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetExperienceParser;

    public class PetExperienceEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetExperienceEvent(_arg_1:Function)
        {
            super(_arg_1, PetExperienceParser);
        }
        public function getParser():PetExperienceParser
        {
            return ((_parser as PetExperienceParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.pets

// PetExperienceEvent = "_-1NJ" (String#17410, DoABC#2)
// PetExperienceParser = "_-1-V" (String#4858, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


