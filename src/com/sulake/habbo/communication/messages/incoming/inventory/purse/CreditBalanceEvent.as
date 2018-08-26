
package com.sulake.habbo.communication.messages.incoming.inventory.purse
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.purse.CreditBalanceParser;

    public class CreditBalanceEvent extends MessageEvent implements IMessageEvent 
    {

        public function CreditBalanceEvent(_arg_1:Function)
        {
            super(_arg_1, CreditBalanceParser);
        }
        public function getParser():CreditBalanceParser
        {
            return ((this._parser as CreditBalanceParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.purse

// CreditBalanceParser = "_-2Xi" (String#6717, DoABC#2)
// CreditBalanceEvent = "_-lg" (String#24097, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


