
package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class AddItemToTradeComposer implements IMessageComposer 
    {

        private var _itemID:int;

        public function AddItemToTradeComposer(_arg_1:int)
        {
            this._itemID = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._itemID]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.inventory.trading

// AddItemToTradeComposer = "_-1mn" (String#18412, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _itemID = "_-zI" (String#2231, DoABC#2)


