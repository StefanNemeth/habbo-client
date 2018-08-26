
package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetReceivedMessageParser implements IMessageParser 
    {

        private var _boughtAsGift:Boolean;
        private var _pet:PetData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._boughtAsGift = _arg_1.readBoolean();
            this._pet = new PetData(_arg_1);
            Logger.log(((((((((((("Got PetReceived: " + this._boughtAsGift) + ", ") + this._pet.id) + ", ") + this._pet.name) + ", ") + this._pet.type) + ", ") + this._pet.breed) + ", ") + this.pet.color));
            return (true);
        }
        public function get boughtAsGift():Boolean
        {
            return (this._boughtAsGift);
        }
        public function get pet():PetData
        {
            return (this._pet);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.pets

// PetData = "_-01G" (String#1387, DoABC#2)
// PetReceivedMessageParser = "_-iL" (String#8563, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _boughtAsGift = "_-1ES" (String#17046, DoABC#2)
// _pet = "_-004" (String#3565, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// boughtAsGift = "_-0XW" (String#15335, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


