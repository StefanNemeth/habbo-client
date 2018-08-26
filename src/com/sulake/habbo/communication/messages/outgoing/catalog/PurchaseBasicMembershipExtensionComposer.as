
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PurchaseBasicMembershipExtensionComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function PurchaseBasicMembershipExtensionComposer(_arg_1:int)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.catalog

// PurchaseBasicMembershipExtensionComposer = "_-3Hc" (String#22184, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


