
package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryUpdatedParser;

    public class PetInventoryUpdatedEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInventoryUpdatedEvent(_arg_1:Function)
        {
            super(_arg_1, PetInventoryUpdatedParser);
        }
    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.pets

// PetInventoryUpdatedEvent = "_-0UN" (String#4191, DoABC#2)
// PetInventoryUpdatedParser = "_-rR" (String#8729, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


