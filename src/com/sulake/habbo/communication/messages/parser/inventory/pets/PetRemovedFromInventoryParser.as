
package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRemovedFromInventoryParser implements IMessageParser 
    {

        private var _id:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._id = _arg_1.readInteger();
            return (true);
        }
        public function get petId():int
        {
            return (this._id);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.pets

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetRemovedFromInventoryParser = "_-1Ra" (String#17567, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


