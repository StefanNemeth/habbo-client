
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PurchaseFromCatalogAsGiftComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function PurchaseFromCatalogAsGiftComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:int, _arg_8:int)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
            this._data.push(_arg_2);
            this._data.push(_arg_3);
            this._data.push(_arg_4);
            this._data.push(_arg_5);
            this._data.push(_arg_6);
            this._data.push(_arg_7);
            this._data.push(_arg_8);
        }
        public function dispose():void
        {
            this._data = [];
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.catalog

// PurchaseFromCatalogAsGiftComposer = "_-zC" (String#24659, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


