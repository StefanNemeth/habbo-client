
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SellablePetBreedsParser implements IMessageParser 
    {

        private var _productCode:String = "";
        private var _sellableBreeds:Array;

        public function SellablePetBreedsParser()
        {
            this._sellableBreeds = [];
            super();
        }
        public function get productCode():String
        {
            return (this._productCode);
        }
        public function get sellableBreeds():Array
        {
            return (this._sellableBreeds.slice());
        }
        public function flush():Boolean
        {
            this._productCode = "";
            this._sellableBreeds = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._productCode = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._sellableBreeds.push(new SellablePetBreedData(_arg_1));
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// _sellableBreeds = "_-15E" (String#1618, DoABC#2)
// sellableBreeds = "_-2ie" (String#6923, DoABC#2)
// SellablePetBreedsParser = "_-0eF" (String#4395, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// SellablePetBreedData = "_-r" (String#8724, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


