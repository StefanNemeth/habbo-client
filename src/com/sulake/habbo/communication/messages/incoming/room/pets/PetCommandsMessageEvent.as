
package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetCommandsMessageParser;

    public class PetCommandsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetCommandsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PetCommandsMessageParser);
        }
        public function getParser():PetCommandsMessageParser
        {
            return ((_parser as PetCommandsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.pets

// PetCommandsMessageEvent = "_-V3" (String#23451, DoABC#2)
// PetCommandsMessageParser = "_-fp" (String#8509, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


