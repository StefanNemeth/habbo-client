
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageProductData 
    {

        public static const _SafeStr_5019:String = "i";
        public static const _SafeStr_5017:String = "s";
        public static const _SafeStr_5021:String = "e";

        private var _productType:String;
        private var _furniClassId:int;
        private var _extraParam:String;
        private var _productCount:int;
        private var _expiration:int;

        public function CatalogPageMessageProductData(_arg_1:IMessageDataWrapper)
        {
            this._productType = _arg_1.readString();
            this._furniClassId = _arg_1.readInteger();
            this._extraParam = _arg_1.readString();
            this._productCount = _arg_1.readInteger();
            this._expiration = _arg_1.readInteger();
        }
        public function get productType():String
        {
            return (this._productType);
        }
        public function get furniClassId():int
        {
            return (this._furniClassId);
        }
        public function get extraParam():String
        {
            return (this._extraParam);
        }
        public function get productCount():int
        {
            return (this._productCount);
        }
        public function get expiration():int
        {
            return (this._expiration);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// CatalogPageMessageProductData = "_-2mz" (String#7020, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// _productType = "_-1TF" (String#5419, DoABC#2)
// _extraParam = "_-2Ad" (String#880, DoABC#2)
// _productCount = "_-1K0" (String#5242, DoABC#2)
// _expiration = "_-2ZN" (String#1901, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// _SafeStr_5021 = "_-h-" (String#23930, DoABC#2)
// furniClassId = "_-1lo" (String#18367, DoABC#2)
// _furniClassId = "_-0xK" (String#16324, DoABC#2)


