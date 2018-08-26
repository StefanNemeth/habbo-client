
package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryParser;

    public class PetAddedToInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetAddedToInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, PetAddedToInventoryParser);
        }
        public function getParser():PetAddedToInventoryParser
        {
            return ((_parser as PetAddedToInventoryParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.pets

// PetAddedToInventoryEvent = "_-2W" (String#6683, DoABC#2)
// PetAddedToInventoryParser = "_-0Y8" (String#15363, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


