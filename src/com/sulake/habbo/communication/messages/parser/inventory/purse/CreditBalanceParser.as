
package com.sulake.habbo.communication.messages.parser.inventory.purse
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CreditBalanceParser implements IMessageParser 
    {

        private var _balance:int;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._balance = int(_arg_1.readString());
            return (true);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function get balance():int
        {
            return (this._balance);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.purse

// CreditBalanceParser = "_-2Xi" (String#6717, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _balance = "_-8R" (String#927, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


