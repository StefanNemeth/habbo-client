
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoucherRedeemErrorMessageParser implements IMessageParser 
    {

        private var _errorCode:String = "";

        public function flush():Boolean
        {
            this._errorCode = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._errorCode = _arg_1.readString();
            return (true);
        }
        public function get errorCode():String
        {
            return (this._errorCode);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// VoucherRedeemErrorMessageParser = "_-0T8" (String#4162, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


