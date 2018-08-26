
package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenTradingComposer implements IMessageComposer 
    {

        private var _SafeStr_5260:int;

        public function OpenTradingComposer(_arg_1:int)
        {
            this._SafeStr_5260 = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_5260]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.inventory.trading

// OpenTradingComposer = "_-26G" (String#19263, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_5260 = "_-3Hm" (String#7661, DoABC#2)


