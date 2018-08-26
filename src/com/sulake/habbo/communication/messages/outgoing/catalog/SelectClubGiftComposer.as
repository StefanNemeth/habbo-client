
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SelectClubGiftComposer implements IMessageComposer 
    {

        private var _productCode:String;

        public function SelectClubGiftComposer(_arg_1:String)
        {
            this._productCode = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._productCode]);
        }
        public function dispose():void
        {
            this._productCode = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.catalog

// SelectClubGiftComposer = "_-0BI" (String#14497, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)


