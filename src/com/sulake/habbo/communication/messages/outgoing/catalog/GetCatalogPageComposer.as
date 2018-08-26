
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetCatalogPageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function GetCatalogPageComposer(_arg_1:int, _arg_2:int)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
            this._data.push(_arg_2);
        }
        public function dispose():void
        {
            this._data = null;
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.catalog

// GetCatalogPageComposer = "_-2oJ" (String#21015, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


