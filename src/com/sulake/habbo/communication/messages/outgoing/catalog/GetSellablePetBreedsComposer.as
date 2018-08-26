
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetSellablePetBreedsComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function GetSellablePetBreedsComposer(_arg_1:String)
        {
            this._data = [];
            super();
            this._data = [_arg_1];
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

// GetSellablePetBreedsComposer = "_-2Jj" (String#19799, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


