
package com.sulake.habbo.catalog.recycler
{
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.IRoomEngine;

    public class PrizeContainer extends PrizeGridItem 
    {

        private var _productItemType:String;
        private var _productItemTypeId:int;
        private var _oddsLevelId:int;
        private var _furnitureData:IFurnitureData;
        private var _gridItem:PrizeGridItem;

        public function PrizeContainer(_arg_1:String, _arg_2:int, _arg_3:IFurnitureData, _arg_4:int)
        {
            this._productItemType = _arg_1;
            this._productItemTypeId = _arg_2;
            this._furnitureData = _arg_3;
            this._oddsLevelId = _arg_4;
        }
        public function setIcon(_arg_1:IRoomEngine):void
        {
            if ((((_arg_1 == null)) || ((this._furnitureData == null)))){
                return;
            };
            initProductIcon(_arg_1, this._furnitureData.type, this._productItemTypeId);
        }
        public function get productItemType():String
        {
            return (this._productItemType);
        }
        public function get productItemTypeId():int
        {
            return (this._productItemTypeId);
        }
        public function get gridItem():PrizeGridItem
        {
            return (this._gridItem);
        }
        public function get oddsLevelId():int
        {
            return (this._oddsLevelId);
        }
        public function get title():String
        {
            if (this._furnitureData == null){
                return ("");
            };
            return (this._furnitureData.title);
        }

    }
}//package com.sulake.habbo.catalog.recycler

// _oddsLevelId = "_-19a" (String#16840, DoABC#2)
// _gridItem = "_-2kp" (String#20878, DoABC#2)
// setIcon = "_-0dP" (String#4379, DoABC#2)
// oddsLevelId = "_-0c7" (String#15519, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// PrizeGridItem = "_-0tB" (String#4710, DoABC#2)
// PrizeContainer = "_-2SW" (String#6620, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// _productItemType = "_-0bZ" (String#4334, DoABC#2)
// _productItemTypeId = "_-0Rf" (String#4126, DoABC#2)
// productItemType = "_-0fq" (String#15665, DoABC#2)
// productItemTypeId = "_-0y9" (String#16357, DoABC#2)


