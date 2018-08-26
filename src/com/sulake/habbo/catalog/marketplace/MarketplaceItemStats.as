
package com.sulake.habbo.catalog.marketplace
{
    public class MarketplaceItemStats 
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
        public function set averagePrice(_arg_1:int):void
        {
            this._averagePrice = _arg_1;
        }
        public function set offerCount(_arg_1:int):void
        {
            this._offerCount = _arg_1;
        }
        public function set historyLength(_arg_1:int):void
        {
            this._historyLength = _arg_1;
        }
        public function set dayOffsets(_arg_1:Array):void
        {
            this._dayOffsets = _arg_1.slice();
        }
        public function set averagePrices(_arg_1:Array):void
        {
            this._averagePrices = _arg_1.slice();
        }
        public function set soldAmounts(_arg_1:Array):void
        {
            this._soldAmounts = _arg_1.slice();
        }
        public function set furniTypeId(_arg_1:int):void
        {
            this._furniTypeId = _arg_1;
        }
        public function set furniCategoryId(_arg_1:int):void
        {
            this._furniCategoryId = _arg_1;
        }

    }
}//package com.sulake.habbo.catalog.marketplace

// MarketplaceItemStats = "_-2Fw" (String#19640, DoABC#2)
// _averagePrice = "_-53" (String#925, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)
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


