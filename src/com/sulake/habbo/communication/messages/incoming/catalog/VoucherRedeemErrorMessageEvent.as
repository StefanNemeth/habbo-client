
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemErrorMessageParser;

    public class VoucherRedeemErrorMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoucherRedeemErrorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, VoucherRedeemErrorMessageParser);
        }
        public function get errorCode():String
        {
            return ((_parser as VoucherRedeemErrorMessageParser).errorCode);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// VoucherRedeemErrorMessageEvent = "_-2Yt" (String#20390, DoABC#2)
// VoucherRedeemErrorMessageParser = "_-0T8" (String#4162, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


