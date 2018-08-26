
package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeMessageData 
    {

        private var _productItemType:String;
        private var _productItemTypeId:int;

        public function PrizeMessageData(_arg_1:IMessageDataWrapper)
        {
            this._productItemType = _arg_1.readString();
            this._productItemTypeId = _arg_1.readInteger();
        }
        public function get productItemType():String
        {
            return (this._productItemType);
        }
        public function get productItemTypeId():int
        {
            return (this._productItemTypeId);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.recycler

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PrizeMessageData = "_-aq" (String#8436, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _productItemType = "_-0bZ" (String#4334, DoABC#2)
// _productItemTypeId = "_-0Rf" (String#4126, DoABC#2)
// productItemType = "_-0fq" (String#15665, DoABC#2)
// productItemTypeId = "_-0y9" (String#16357, DoABC#2)


