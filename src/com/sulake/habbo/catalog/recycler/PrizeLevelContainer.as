
package com.sulake.habbo.catalog.recycler
{
    import com.sulake.habbo.communication.messages.incoming.recycler.PrizeMessageData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.communication.messages.incoming.recycler.PrizeLevelMessageData;
    import com.sulake.habbo.catalog.IHabboCatalog;

    public class PrizeLevelContainer 
    {

        private var _prizeLevelId:int;
        private var _prizes:Array;

        public function PrizeLevelContainer(_arg_1:PrizeLevelMessageData, _arg_2:IHabboCatalog)
        {
            var _local_4:PrizeMessageData;
            var _local_5:IFurnitureData;
            var _local_6:PrizeContainer;
            super();
            this._prizeLevelId = _arg_1.prizeLevelId;
            _arg_2.localization.registerParameter(("recycler.prizes.odds." + this._prizeLevelId), "odds", ("1:" + _arg_1.probabilityDenominator));
            this._prizes = new Array();
            var _local_3:int;
            while (_local_3 < _arg_1.prizes.length) {
                _local_4 = _arg_1.prizes[_local_3];
                _local_5 = _arg_2.getFurnitureData(_local_4.productItemTypeId, _local_4.productItemType);
                _local_6 = new PrizeContainer(_local_4.productItemType, _local_4.productItemTypeId, _local_5, this._prizeLevelId);
                this._prizes.push(_local_6);
                _local_3++;
            };
        }
        public function get prizeLevelId():int
        {
            return (this._prizeLevelId);
        }
        public function get prizes():Array
        {
            return (this._prizes);
        }

    }
}//package com.sulake.habbo.catalog.recycler

// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// PrizeLevelMessageData = "_-0gy" (String#4444, DoABC#2)
// PrizeLevelContainer = "_-0wZ" (String#4783, DoABC#2)
// PrizeMessageData = "_-aq" (String#8436, DoABC#2)
// PrizeContainer = "_-2SW" (String#6620, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// _prizeLevelId = "_-14c" (String#4971, DoABC#2)
// _prizes = "_-1ct" (String#855, DoABC#2)
// prizeLevelId = "_-BF" (String#22664, DoABC#2)
// probabilityDenominator = "_-1nl" (String#18450, DoABC#2)
// productItemType = "_-0fq" (String#15665, DoABC#2)
// productItemTypeId = "_-0y9" (String#16357, DoABC#2)


