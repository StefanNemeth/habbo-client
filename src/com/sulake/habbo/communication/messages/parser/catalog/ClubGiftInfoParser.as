
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftInfoParser implements IMessageParser 
    {

        private var _daysUntilNextGift:int;
        private var _giftsAvailable:int;
        private var _offers:Array;
        private var _giftData:Map;

        public function flush():Boolean
        {
            this._offers = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:ClubGiftData;
            this._daysUntilNextGift = _arg_1.readInteger();
            this._giftsAvailable = _arg_1.readInteger();
            this._offers = new Array();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2) {
                this._offers.push(new CatalogPageMessageOfferData(_arg_1));
                _local_3++;
            };
            this._giftData = new Map();
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2) {
                _local_4 = new ClubGiftData(_arg_1);
                this._giftData.add(_local_4.offerId, _local_4);
                _local_3++;
            };
            return (true);
        }
        public function get daysUntilNextGift():int
        {
            return (this._daysUntilNextGift);
        }
        public function get giftsAvailable():int
        {
            return (this._giftsAvailable);
        }
        public function get offers():Array
        {
            return (this._offers);
        }
        public function get giftData():Map
        {
            return (this._giftData);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// giftData = "_-2mv" (String#20957, DoABC#2)
// CatalogPageMessageOfferData = "_-1vw" (String#5957, DoABC#2)
// ClubGiftInfoParser = "_-1gX" (String#5674, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ClubGiftData = "_-2Io" (String#6416, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _daysUntilNextGift = "_-09n" (String#3755, DoABC#2)
// _giftsAvailable = "_-01z" (String#3603, DoABC#2)
// _giftData = "_-0kP" (String#4509, DoABC#2)
// daysUntilNextGift = "_-12R" (String#16556, DoABC#2)
// giftsAvailable = "_-GA" (String#22860, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


