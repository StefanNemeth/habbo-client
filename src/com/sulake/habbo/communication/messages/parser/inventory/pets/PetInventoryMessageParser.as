
package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInventoryMessageParser implements IMessageParser 
    {

        private var _pets:Array;

        public function flush():Boolean
        {
            this._pets = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:PetData;
            this._pets = [];
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = new PetData(_arg_1);
                this._pets.push(_local_4);
                _local_3++;
            };
            return (true);
        }
        public function get pets():Array
        {
            return (this._pets);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.pets

// PetData = "_-01G" (String#1387, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetInventoryMessageParser = "_-0OD" (String#14997, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


