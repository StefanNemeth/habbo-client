
package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetInfoMessageParser;

    public class PetInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PetInfoMessageParser);
        }
        public function getParser():PetInfoMessageParser
        {
            return ((_parser as PetInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.pets

// PetInfoMessageParser = "_-0zJ" (String#4833, DoABC#2)
// PetInfoMessageEvent = "_-94" (String#22583, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


