
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RedeemVoucherMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function RedeemVoucherMessageComposer(_arg_1:String)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }
        public function dispose():void
        {
            this._data = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.catalog

// RedeemVoucherMessageComposer = "_-0bE" (String#15486, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


