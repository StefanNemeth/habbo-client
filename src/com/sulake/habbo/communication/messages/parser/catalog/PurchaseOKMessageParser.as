
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PurchaseOKMessageParser implements IMessageParser 
    {

        private var _offer:CatalogPageMessageOfferData;

        public function get offer():CatalogPageMessageOfferData
        {
            return (this._offer);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._offer = new CatalogPageMessageOfferData(_arg_1);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// CatalogPageMessageOfferData = "_-1vw" (String#5957, DoABC#2)
// PurchaseOKMessageParser = "_-2DV" (String#6312, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


