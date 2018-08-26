
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SellablePetBreedData 
    {

        private var _type:int;
        private var _breed:int;
        private var _sellable:Boolean;
        private var _rare:Boolean;

        public function SellablePetBreedData(_arg_1:IMessageDataWrapper)
        {
            this._type = _arg_1.readInteger();
            this._breed = _arg_1.readInteger();
            this._sellable = _arg_1.readBoolean();
            this._rare = _arg_1.readBoolean();
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get breed():int
        {
            return (this._breed);
        }
        public function get sellable():Boolean
        {
            return (this._sellable);
        }
        public function get rare():Boolean
        {
            return (this._rare);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// _sellable = "_-1dK" (String#1726, DoABC#2)
// _rare = "_-0Ct" (String#14567, DoABC#2)
// rare = "_-3LH" (String#22338, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// SellablePetBreedData = "_-r" (String#8724, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)


