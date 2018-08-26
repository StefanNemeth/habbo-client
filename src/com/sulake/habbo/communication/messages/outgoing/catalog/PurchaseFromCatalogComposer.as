
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PurchaseFromCatalogComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function PurchaseFromCatalogComposer(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
            this._data.push(_arg_2);
            this._data.push(_arg_3);
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

// PurchaseFromCatalogComposer = "_-1Vz" (String#17741, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


