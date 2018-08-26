
package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryParser;

    public class PetRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRemovedFromInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, PetRemovedFromInventoryParser);
        }
        public function getParser():PetRemovedFromInventoryParser
        {
            return ((_parser as PetRemovedFromInventoryParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.pets

// PetRemovedFromInventoryParser = "_-1Ra" (String#17567, DoABC#2)
// PetRemovedFromInventoryEvent = "_-0LF" (String#3986, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


