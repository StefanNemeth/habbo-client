
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogLocalizationData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageParser implements IMessageParser 
    {

        private var _pageId:int;
        private var _layoutCode:String;
        private var _localization:CatalogLocalizationData;
        private var _offers:Array;
        private var _offerId:int;

        public function get pageId():int
        {
            return (this._pageId);
        }
        public function get layoutCode():String
        {
            return (this._layoutCode);
        }
        public function get localization():CatalogLocalizationData
        {
            return (this._localization);
        }
        public function get offers():Array
        {
            return (this._offers);
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function flush():Boolean
        {
            this._pageId = -1;
            this._layoutCode = "";
            this._localization = null;
            this._offers = [];
            this._offerId = -1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._pageId = _arg_1.readInteger();
            this._layoutCode = _arg_1.readString();
            this._localization = new CatalogLocalizationData(_arg_1);
            this._offers = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._offers.push(new CatalogPageMessageOfferData(_arg_1));
                _local_3++;
            };
            this._offerId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// CatalogPageMessageOfferData = "_-1vw" (String#5957, DoABC#2)
// CatalogPageMessageParser = "_-1gI" (String#5668, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CatalogLocalizationData = "_-397" (String#7491, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _pageId = "_-251" (String#366, DoABC#2)
// _layoutCode = "_-0WC" (String#4230, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


