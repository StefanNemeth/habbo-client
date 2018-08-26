
package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetAddedToInventoryParser implements IMessageParser 
    {

        private var _pet:PetData;
        private var _purchased:Boolean;

        public function flush():Boolean
        {
            this._pet = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._pet = new PetData(_arg_1);
            this._purchased = _arg_1.readBoolean();
            return (true);
        }
        public function get pet():PetData
        {
            return (this._pet);
        }
        public function get purchased():Boolean
        {
            return (this._purchased);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.pets

// PetData = "_-01G" (String#1387, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetAddedToInventoryParser = "_-0Y8" (String#15363, DoABC#2)
// _pet = "_-004" (String#3565, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _purchased = "_-S0" (String#23326, DoABC#2)
// purchased = "_-1d0" (String#18015, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


