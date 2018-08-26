
package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetRespectFailedParser;

    public class PetRespectFailedEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRespectFailedEvent(_arg_1:Function)
        {
            super(_arg_1, PetRespectFailedParser);
        }
        public function getParser():PetRespectFailedParser
        {
            return ((_parser as PetRespectFailedParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.pets

// PetRespectFailedParser = "_-0Ix" (String#3934, DoABC#2)
// PetRespectFailedEvent = "_-1Pw" (String#17506, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


