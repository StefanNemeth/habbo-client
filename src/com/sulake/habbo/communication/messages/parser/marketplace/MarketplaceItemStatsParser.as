
package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceItemStatsParser implements IMessageParser 
    {

        private var _averagePrice:int;
        private var _offerCount:int;
        private var _historyLength:int;
        private var _dayOffsets:Array;
        private var _averagePrices:Array;
        private var _soldAmounts:Array;
        private var _furniTypeId:int;
        private var _furniCategoryId:int;

        public function get averagePrice():int
        {
            return (this._averagePrice);
        }
        public function get offerCount():int
        {
            return (this._offerCount);
        }
        public function get historyLength():int
        {
            return (this._historyLength);
        }
        public function get dayOffsets():Array
        {
            return (this._dayOffsets);
        }
        public function get averagePrices():Array
        {
            return (this._averagePrices);
        }
        public function get soldAmounts():Array
        {
            return (this._soldAmounts);
        }
        public function get furniTypeId():int
        {
            return (this._furniTypeId);
        }
        public function get furniCategoryId():int
        {
            return (this._furniCategoryId);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._averagePrice = _arg_1.readInteger();
            this._offerCount = _arg_1.readInteger();
            this._historyLength = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            this._dayOffsets = [];
            this._averagePrices = [];
            this._soldAmounts = [];
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._dayOffsets.push(_arg_1.readInteger());
                this._averagePrices.push(_arg_1.readInteger());
                this._soldAmounts.push(_arg_1.readInteger());
                _local_3++;
            };
            this._furniCategoryId = _arg_1.readInteger();
            this._furniTypeId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.marketplace

// MarketplaceItemStatsParser = "_-Fz" (String#22851, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _averagePrice = "_-53" (String#925, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _offerCount = "_-3L5" (String#7724, DoABC#2)
// _historyLength = "_-21M" (String#6073, DoABC#2)
// _averagePrices = "_-1ij" (String#5728, DoABC#2)
// _soldAmounts = "_-1th" (String#5914, DoABC#2)
// _furniTypeId = "_-3IR" (String#7679, DoABC#2)
// _furniCategoryId = "_-2GJ" (String#6372, DoABC#2)
// historyLength = "_-1dq" (String#18052, DoABC#2)
// dayOffsets = "_-1hM" (String#18187, DoABC#2)
// averagePrices = "_-2fx" (String#20689, DoABC#2)
// soldAmounts = "_-z4" (String#24653, DoABC#2)
// furniTypeId = "_-2n-" (String#20961, DoABC#2)
// furniCategoryId = "_-0bd" (String#15499, DoABC#2)


