
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoucherRedeemOkMessageParser implements IMessageParser 
    {

        private var _productName:String = "";
        private var _productDescription:String = "";

        public function flush():Boolean
        {
            this._productDescription = "";
            this._productName = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._productDescription = _arg_1.readString();
            this._productName = _arg_1.readString();
            return (true);
        }
        public function get productName():String
        {
            return (this._productName);
        }
        public function get productDescription():String
        {
            return (this._productDescription);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// _productDescription = "_-65" (String#7783, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// VoucherRedeemOkMessageParser = "_-3A8" (String#7515, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _productName = "_-09X" (String#1413, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


