
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemOkMessageParser;

    public class VoucherRedeemOkMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoucherRedeemOkMessageEvent(_arg_1:Function)
        {
            super(_arg_1, VoucherRedeemOkMessageParser);
        }
        public function get productName():String
        {
            return ((_parser as VoucherRedeemOkMessageParser).productName);
        }
        public function get productDescription():String
        {
            return ((_parser as VoucherRedeemOkMessageParser).productDescription);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// VoucherRedeemOkMessageEvent = "_-2Af" (String#19432, DoABC#2)
// VoucherRedeemOkMessageParser = "_-3A8" (String#7515, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


