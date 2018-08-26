
package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;

    public class PetInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, PetInventoryMessageParser);
        }
        public function getParser():PetInventoryMessageParser
        {
            return ((_parser as PetInventoryMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.pets

// PetInventoryMessageParser = "_-0OD" (String#14997, DoABC#2)
// PetInventoryEvent = "_-2t6" (String#7140, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


