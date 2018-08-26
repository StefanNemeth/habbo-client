
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PurchaseErrorMessageParser implements IMessageParser 
    {

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PurchaseErrorMessageParser = "_-10X" (String#4882, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


