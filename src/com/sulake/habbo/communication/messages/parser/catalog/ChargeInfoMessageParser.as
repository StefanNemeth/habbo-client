
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChargeInfoMessageParser implements IMessageParser 
    {

        private var _chargeInfo:ChargeInfo;

        public function flush():Boolean
        {
            this._chargeInfo = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._chargeInfo = new ChargeInfo(_arg_1);
            return (true);
        }
        public function get chargeInfo():ChargeInfo
        {
            return (this._chargeInfo);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// chargeInfo = "_-2xn" (String#21387, DoABC#2)
// ChargeInfo = "_-1bU" (String#5587, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ChargeInfoMessageParser = "_-2wl" (String#7219, DoABC#2)
// _chargeInfo = "_-0NE" (String#4023, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


