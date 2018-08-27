
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.habbo.catalog.recycler.PrizeViewer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import flash.events.TimerEvent;
    import com.sulake.habbo.catalog.recycler.PrizeContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.catalog.recycler.PrizeLevelContainer;
    import com.sulake.habbo.catalog.recycler.IRecycler;

    public class RecyclerPrizesCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid 
    {

        private var _prizes:Array;
        private var _viewer:PrizeViewer;
        private var _itemList:IItemListWindow;
        private var _SafeStr_10422:XML;
        private var _SafeStr_10496:XML;
        private var _SafeStr_8482:IGridItem;

        public function RecyclerPrizesCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            super.dispose();
            if (this._viewer != null){
                this._viewer.dispose();
                this._viewer = null;
            };
            this._prizes = null;
            this._itemList = null;
            this._SafeStr_10422 = null;
            this._SafeStr_10496 = null;
            this._SafeStr_8482 = null;
        }
        override public function init():Boolean
        {
            var _local_1:XmlAsset;
            if (!super.init()){
                return (false);
            };
            this._viewer = new PrizeViewer();
            this._prizes = this.recycler.getPrizeTable();
            if (this._prizes == null){
                return (false);
            };
            this._itemList = (_window.findChildByName("itemList") as IItemListWindow);
            _local_1 = (page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset);
            this._SafeStr_10422 = (_local_1.content as XML);
            _local_1 = (page.viewer.catalog.assets.getAssetByName("recyclerPrizesWidgetLevelItem") as XmlAsset);
            this._SafeStr_10496 = (_local_1.content as XML);
            this.populateItemGrid();
            if ((((this._prizes.length > 0)) && ((this._prizes[0].prizes.length > 0)))){
                this.select((this._prizes[0].prizes[0] as IGridItem));
            };
            return (true);
        }
        private function populateItemGrid(_arg_1:TimerEvent=null):void
        {
            var _local_2:int;
            while (_local_2 < this._prizes.length) {
                this.createLevelItem(this._prizes[_local_2]);
                _local_2++;
            };
        }
        private function createLevelItem(_arg_1:PrizeLevelContainer):void
        {
            var _local_6:PrizeContainer;
            var _local_2:IWindowContainer = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10496) as IWindowContainer);
            this._itemList.addListItem(_local_2);
            var _local_3:ITextWindow = (_local_2.findChildByName("headerText") as ITextWindow);
            if (_local_3 != null){
                _local_3.text = page.viewer.catalog.localization.getKey(("recycler.prizes.category." + _arg_1.prizeLevelId));
            };
            var _local_4:IItemGridWindow = (_local_2.findChildByName("itemGrid") as IItemGridWindow);
            var _local_5:int;
            while (_local_5 < _arg_1.prizes.length) {
                _local_6 = _arg_1.prizes[_local_5];
                this.createPrizeItem(_local_6, _local_4);
                _local_5++;
            };
        }
        private function createPrizeItem(_arg_1:PrizeContainer, _arg_2:IItemGridWindow):void
        {
            if ((((((_arg_1 == null)) || ((_arg_2 == null)))) || (_arg_2.disposed))){
                return;
            };
            var _local_3:IWindowContainer = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10422) as IWindowContainer);
            _arg_2.addGridItem(_local_3);
            _arg_2.height = _arg_2.scrollableRegion.height;
            _arg_1.view = _local_3;
            _arg_1.grid = this;
            _arg_1.setIcon(page.viewer.roomEngine);
        }
        public function select(_arg_1:IGridItem):void
        {
            if (_arg_1 == null){
                return;
            };
            if (this._SafeStr_8482 != null){
                this._SafeStr_8482.deActivate();
            };
            this._SafeStr_8482 = _arg_1;
            _arg_1.activate();
            var _local_2:PrizeContainer = (_arg_1 as PrizeContainer);
            var _local_3:IWindowContainer = (window.findChildByName("productView") as IWindowContainer);
            var _local_4:String = page.viewer.catalog.localization.getKey(("recycler.prizes.odds." + _local_2.oddsLevelId));
            this._viewer.viewProduct(page.viewer.roomEngine, _local_3, _local_2.productItemType, _local_2.productItemTypeId, _local_2.title, _local_4);
        }
        public function startDragAndDrop(_arg_1:IGridItem):Boolean
        {
            return (false);
        }
        private function get recycler():IRecycler
        {
            return (page.viewer.catalog.getRecycler());
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// getPrizeTable = "_-17e" (String#5030, DoABC#2)
// setIcon = "_-0dP" (String#4379, DoABC#2)
// oddsLevelId = "_-0c7" (String#15519, DoABC#2)
// viewProduct = "_-26X" (String#19273, DoABC#2)
// _SafeStr_10422 = "_-2c4" (String#1909, DoABC#2)
// _SafeStr_10496 = "_-2rf" (String#21143, DoABC#2)
// createLevelItem = "_-2rt" (String#21151, DoABC#2)
// createPrizeItem = "_-CP" (String#22703, DoABC#2)
// IRecycler = "_-0fo" (String#4421, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// PrizeLevelContainer = "_-0wZ" (String#4783, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// PrizeContainer = "_-2SW" (String#6620, DoABC#2)
// RecyclerPrizesCatalogWidget = "_-MH" (String#8127, DoABC#2)
// PrizeViewer = "_-2TM" (String#6630, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// startDragAndDrop = "_-Di" (String#7945, DoABC#2)
// populateItemGrid = "_-2Ws" (String#892, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// _prizes = "_-1ct" (String#855, DoABC#2)
// prizeLevelId = "_-BF" (String#22664, DoABC#2)
// productItemType = "_-0fq" (String#15665, DoABC#2)
// productItemTypeId = "_-0y9" (String#16357, DoABC#2)
// _SafeStr_8482 = "_-2IF" (String#618, DoABC#2)


