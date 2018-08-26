
package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceMakeOfferResultParser implements IMessageParser 
    {

        private var _result:int;

        public function get result():int
        {
            return (this._result);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._result = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.marketplace

// MarketplaceMakeOfferResultParser = "_-G-" (String#22853, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


