
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftSelectedParser implements IMessageParser 
    {

        private var _productCode:String;
        private var _products:Array;

        public function flush():Boolean
        {
            this._products = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._products = new Array();
            this._productCode = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._products.push(new CatalogPageMessageProductData(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function get productCode():String
        {
            return (this._productCode);
        }
        public function get products():Array
        {
            return (this._products);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// ClubGiftSelectedParser = "_-03J" (String#3634, DoABC#2)
// CatalogPageMessageProductData = "_-2mz" (String#7020, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// _products = "_-f0" (String#640, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


