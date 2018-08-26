
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.habbo.catalog.viewer.ProductGridItem;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    public class ItemGroupCatalogWidget extends ItemGridCatalogWidget implements ICatalogWidget, IItemGrid, IDragAndDropDoneReceiver 
    {

        private var _groupNames:Array;
        private var _groups:Array;
        private var _SafeStr_10540:int = 0;
        private var _SafeStr_10541:int = 0;

        public function ItemGroupCatalogWidget(_arg_1:IWindowContainer, _arg_2:ISessionDataManager)
        {
            this._groupNames = new Array();
            this._groups = new Array();
            super(_arg_1, _arg_2);
        }
        override public function dispose():void
        {
            super.dispose();
        }
        override public function init():Boolean
        {
            Logger.log("Init Item Group Catalog Widget (Plasto)");
            this.createOfferGroups();
            _SafeStr_7794 = false;
            if (!super.init()){
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX, this.onColourIndex);
            return (true);
        }
        public function onWidgetsInitialized(_arg_1:CatalogWidgetsInitializedEvent):void
        {
            var _local_2:Offer = this._groups[this._SafeStr_10540][this._SafeStr_10541];
            this.select((_local_2.productContainer as IGridItem));
        }
        override public function select(_arg_1:IGridItem):void
        {
            var _local_5:Offer;
            var _local_6:IFurnitureData;
            var _local_7:int;
            if (_arg_1 == null){
                return;
            };
            super.select(_arg_1);
            this._SafeStr_10540 = _SafeStr_10421.getGridItemIndex(_arg_1.view);
            var _local_2:String = this._groupNames[this._SafeStr_10540];
            var _local_3:Array = (this._groups[this._SafeStr_10540] as Array);
            var _local_4:Array = new Array();
            for each (_local_5 in _local_3) {
                _local_6 = _local_5.productContainer.firstProduct.furnitureData;
                _local_7 = _local_6.colours[(_local_6.colours.length - 1)];
                _local_4.push(_local_7);
            };
            Logger.log(((("Show the colors for current selection..." + _local_2) + " ") + _local_4.length));
            events.dispatchEvent(new CatalogWidgetColoursEvent(_local_4, "ctlg_clr_40x32_1", "ctlg_clr_40x32_2", "ctlg_clr_40x32_3", this._SafeStr_10541));
        }
        override public function startDragAndDrop(_arg_1:IGridItem):Boolean
        {
            var _local_2:Array = (this._groups[this._SafeStr_10540] as Array);
            var _local_3:Offer = (_local_2[this._SafeStr_10541] as Offer);
            if (_local_3 != null){
                if (_session.hasUserRight(null, _local_3.clubLevel)){
                    (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this, _local_3);
                };
            };
            return (true);
        }
        override protected function populateItemGrid():void
        {
            var _local_1:Array;
            var _local_2:Offer;
            for each (_local_1 in this._groups) {
                if (this._SafeStr_10541 < _local_1.length){
                    _local_2 = (_local_1[this._SafeStr_10541] as Offer);
                    createGridItem(_local_2);
                    loadGraphics(_local_2);
                    _local_2.productContainer.grid = this;
                };
            };
        }
        private function onColourIndex(_arg_1:CatalogWidgetColourIndexEvent):void
        {
            this._SafeStr_10541 = _arg_1.index;
            var _local_2:Array = (this._groups[this._SafeStr_10540] as Array);
            var _local_3:Offer = (_local_2[this._SafeStr_10541] as Offer);
            if (_local_3 != null){
                events.dispatchEvent(new SelectProductEvent(_local_3));
            };
            this.updateGridWithSelectedColour();
        }
        private function updateGridWithSelectedColour():void
        {
            if (_SafeStr_8482){
                _SafeStr_8482.deActivate();
                _SafeStr_8482 = null;
            };
            _SafeStr_10421.destroyGridItems();
            this.populateItemGrid();
            var _local_1:Array = (this._groups[this._SafeStr_10540] as Array);
            var _local_2:Offer = (_local_1[this._SafeStr_10541] as Offer);
            _SafeStr_8482 = (_local_2.productContainer as ProductGridItem);
            _SafeStr_8482.activate();
        }
        private function createOfferGroups():void
        {
            var _local_1:Offer;
            var _local_2:Array;
            var _local_3:IProduct;
            var _local_4:int;
            var _local_5:String;
            var _local_6:int;
            for each (_local_1 in page.offers) {
                if ((((_local_1.pricingModel == Offer._SafeStr_4886)) || ((_local_1.pricingModel == Offer._SafeStr_4887)))){
                    _local_3 = _local_1.productContainer.firstProduct;
                    if (_local_3 != null){
                        _local_4 = _local_3.productClassId;
                        if ((((_local_3.productType == ProductTypeEnum._SafeStr_5019)) || ((_local_3.productType == ProductTypeEnum._SafeStr_5017)))){
                            if (_local_3.furnitureData != null){
                                _local_5 = _local_3.furnitureData.name;
                                if (this._groupNames.indexOf(_local_5) == -1){
                                    this._groupNames.push(_local_5);
                                    this._groups.push(new Array());
                                };
                                _local_6 = this._groupNames.indexOf(_local_5);
                                (this._groups[_local_6] as Array).push(_local_1);
                            };
                        };
                    };
                };
            };
            for each (_local_2 in this._groups) {
                _local_2.sort(this.sortByColor);
            };
        }
        private function debug(_arg_1:Array):void
        {
            var _local_3:Offer;
            var _local_4:IFurnitureData;
            var _local_5:uint;
            var _local_6:Number;
            var _local_2:Array = [];
            for each (_local_3 in _arg_1) {
                _local_4 = _local_3.productContainer.firstProduct.furnitureData;
                _local_5 = _local_4.colours[(_local_4.colours.length - 1)];
                _local_6 = this.getIntensity(_local_5);
                _local_2.push(_local_6);
                Logger.log(((_local_6 + " ") + _local_5));
            };
            Logger.log(_local_2);
        }
        private function sortByColor(_arg_1:Offer, _arg_2:Offer):int
        {
            var _local_3:IFurnitureData = _arg_1.productContainer.firstProduct.furnitureData;
            var _local_4:IFurnitureData = _arg_2.productContainer.firstProduct.furnitureData;
            var _local_5:uint = _local_3.colours[(_local_3.colours.length - 1)];
            var _local_6:uint = _local_4.colours[(_local_4.colours.length - 1)];
            var _local_7:Number = this.getIntensity(_local_5);
            var _local_8:Number = this.getIntensity(_local_6);
            if ((((_local_7 == 0xFF)) || ((_local_7 == 0)))){
                return (-1);
            };
            if ((((_local_8 == 0xFF)) || ((_local_8 == 0)))){
                return (1);
            };
            var _local_9:Number = this.rgb2hsv(_local_5);
            var _local_10:Number = this.rgb2hsv(_local_6);
            if (_local_9 > _local_10){
                return (1);
            };
            if (_local_9 < _local_10){
                return (-1);
            };
            return (0);
        }
        private function rgb2hsv(_arg_1:uint):uint
        {
            var _local_2:uint = 0xFF;
            var _local_3:uint = 0xFF;
            var _local_4:uint = 0xFF;
            if (_arg_1 >= 0){
                _local_2 = ((_arg_1 >> 16) & 0xFF);
                _local_3 = ((_arg_1 >> 8) & 0xFF);
                _local_4 = ((_arg_1 >> 0) & 0xFF);
            };
            var _local_5:uint = Math.min(Math.min(_local_2, _local_3), _local_4);
            var _local_6:uint = Math.max(Math.max(_local_2, _local_3), _local_4);
            if (_local_5 == _local_6){
                return (0);
            };
            var _local_7:Number = (((_local_2)==_local_5) ? (_local_3 - _local_4) : (((_local_3)==_local_5) ? (_local_4 - _local_2) : (_local_2 - _local_3)));
            var _local_8:Number = (((_local_2)==_local_6) ? 3 : (((_local_3)==_local_5) ? 5 : 1));
            return ((Math.floor(((_local_8 - (_local_7 / (_local_6 - _local_5))) * 60)) % 360));
        }
        private function getIntensity(_arg_1:uint):Number
        {
            var _local_2:uint = 0xFF;
            var _local_3:uint = 0xFF;
            var _local_4:uint = 0xFF;
            if (_arg_1 >= 0){
                _local_2 = ((_arg_1 >> 16) & 0xFF);
                _local_3 = ((_arg_1 >> 8) & 0xFF);
                _local_4 = ((_arg_1 >> 0) & 0xFF);
            };
            return ((((_local_2 + _local_3) + _local_4) / 3));
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onColourIndex = "_-WH" (String#934, DoABC#2)
// onWidgetsInitialized = "_-2Ty" (String#890, DoABC#2)
// _SafeStr_10421 = "_-2Kz" (String#19845, DoABC#2)
// requestSelectedItemToMover = "_-Xj" (String#23551, DoABC#2)
// createGridItem = "_-1sQ" (String#18649, DoABC#2)
// loadGraphics = "_-2m3" (String#20920, DoABC#2)
// _SafeStr_10540 = "_-0yG" (String#1586, DoABC#2)
// _SafeStr_10541 = "_-39I" (String#7496, DoABC#2)
// updateGridWithSelectedColour = "_-29z" (String#19405, DoABC#2)
// sortByColor = "_-1XN" (String#17791, DoABC#2)
// getIntensity = "_-0sO" (String#16139, DoABC#2)
// rgb2hsv = "_-0tZ" (String#16182, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IDragAndDropDoneReceiver = "_-Vz" (String#8320, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// ProductGridItem = "_-24U" (String#6129, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// ItemGridCatalogWidget = "_-0OU" (String#4058, DoABC#2)
// CatalogWidgetsInitializedEvent = "_-0-E" (String#14021, DoABC#2)
// ItemGroupCatalogWidget = "_-b3" (String#8442, DoABC#2)
// CatalogWidgetColourIndexEvent = "_-00G" (String#3567, DoABC#2)
// CatalogWidgetColoursEvent = "_-2Vi" (String#6678, DoABC#2)
// _session = "_-32Q" (String#627, DoABC#2)
// _SafeStr_4886 = "_-04Q" (String#14220, DoABC#2)
// _SafeStr_4887 = "_-0F0" (String#14645, DoABC#2)
// pricingModel = "_-1Lx" (String#17355, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// startDragAndDrop = "_-Di" (String#7945, DoABC#2)
// furnitureData = "_-2GE" (String#6370, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// populateItemGrid = "_-2Ws" (String#892, DoABC#2)
// colours = "_-2hm" (String#6902, DoABC#2)
// _groups = "_-3S" (String#2047, DoABC#2)
// _SafeStr_7794 = "_-aa" (String#8430, DoABC#2)
// _SafeStr_8482 = "_-2IF" (String#618, DoABC#2)


