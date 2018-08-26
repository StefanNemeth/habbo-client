
package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageParser;

    public class PetReceivedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetReceivedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PetReceivedMessageParser);
        }
        public function getParser():PetReceivedMessageParser
        {
            return ((_parser as PetReceivedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.pets

// PetReceivedMessageEvent = "_-Cf" (String#22711, DoABC#2)
// PetReceivedMessageParser = "_-iL" (String#8563, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


