
package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetPlacingErrorParser;

    public class PetPlacingErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetPlacingErrorEvent(_arg_1:Function)
        {
            super(_arg_1, PetPlacingErrorParser);
        }
        public function getParser():PetPlacingErrorParser
        {
            return ((_parser as PetPlacingErrorParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.pets

// PetPlacingErrorEvent = "_-1XB" (String#17784, DoABC#2)
// PetPlacingErrorParser = "_-30n" (String#7322, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


