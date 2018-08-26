
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PurchaseNotAllowedMessageParser implements IMessageParser 
    {

        private var _errorCode:int = 0;

        public function get errorCode():int
        {
            return (this._errorCode);
        }
        public function flush():Boolean
        {
            this._errorCode = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._errorCode = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// PurchaseNotAllowedMessageParser = "_-1D6" (String#5128, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


