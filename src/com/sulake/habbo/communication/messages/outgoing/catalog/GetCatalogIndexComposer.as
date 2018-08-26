
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetCatalogIndexComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function GetCatalogIndexComposer()
        {
            this._data = [];
            super();
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

// GetCatalogIndexComposer = "_-cD" (String#23723, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


