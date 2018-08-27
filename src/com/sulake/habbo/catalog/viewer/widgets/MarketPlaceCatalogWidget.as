
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import flash.events.TimerEvent;
    import com.sulake.habbo.catalog.marketplace.MarketplaceChart;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.ImageResult;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Matrix;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class MarketPlaceCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IMarketPlaceVisualization 
    {

        private const _SafeStr_10508:int = 1;
        private const _SafeStr_10509:int = 2;
        private const _SafeStr_10510:int = 40;
        private const _SafeStr_10511:int = 10;

        private var _SafeStr_10512:Array;
        private var _SafeStr_10513:MarketPlaceOfferData;
        private var _itemList:IItemListWindow;
        private var _SafeStr_10514:IWindowContainer;
        private var _SafeStr_10515:Timer;
        private var _offers:Map;
        private var _SafeStr_10516:int;

        public function MarketPlaceCatalogWidget(_arg_1:IWindowContainer)
        {
            this._SafeStr_10512 = [];
            super(_arg_1);
        }
        override public function dispose():void
        {
            super.dispose();
            this._SafeStr_10513 = null;
            this._offers = null;
            this._itemList = null;
            if (this._SafeStr_10514){
                this._SafeStr_10514.dispose();
                this._SafeStr_10514 = null;
            };
            if (this._SafeStr_10515){
                this._SafeStr_10515.removeEventListener(TimerEvent.TIMER, this.onPopulationTimer);
                this._SafeStr_10515 = null;
            };
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            if (this.marketPlace == null){
                return (false);
            };
            this.marketPlace.registerVisualization(this);
            this.displayMainView();
            return (true);
        }
        public function listUpdatedNotify():void
        {
            this.hideDetails();
            this.updateList();
        }
        public function updateStats():void
        {
            var _local_6:MarketplaceChart;
            var _local_9:BitmapData;
            var _local_10:String;
            if (((((!(this.marketPlace)) || (!(this.marketPlace.localization)))) || (!(_window)))){
                return;
            };
            var _local_1:MarketplaceItemStats = this.marketPlace.itemStats;
            if (!_local_1){
                return;
            };
            var _local_2:IWindowContainer = (_window.findChildByName("details_container") as IWindowContainer);
            if (((!(_local_2)) || (!(_local_2.visible)))){
                return;
            };
            var _local_3:ITextWindow = (_local_2.findChildByName("offer_count") as ITextWindow);
            if (_local_3){
                this.marketPlace.localization.registerParameter("catalog.marketplace.offer_details.offer_count", "count", _local_1.offerCount.toString());
                _local_3.visible = true;
            };
            var _local_4:ISelectorWindow = (_local_2.findChildByName("chart_selector") as ISelectorWindow);
            if (!_local_4){
                return;
            };
            var _local_5:ISelectableWindow = _local_4.getSelected();
            if (!_local_5){
                return;
            };
            switch (_local_5.name){
                case "price_development":
                    _local_6 = new MarketplaceChart(_local_1.dayOffsets, _local_1.averagePrices);
                    break;
                case "trade_volume":
                    _local_6 = new MarketplaceChart(_local_1.dayOffsets, _local_1.soldAmounts);
                    break;
                default:
                    return;
            };
            if (!_local_6){
                return;
            };
            var _local_7:IBitmapWrapperWindow = (_local_2.findChildByName("chart_bitmap") as IBitmapWrapperWindow);
            if (_local_7){
                _local_7.bitmap = null;
                _local_7.bitmap = new BitmapData(_local_7.width, _local_7.height);
                _local_9 = _local_6.draw(_local_7.width, _local_7.height);
                _local_7.bitmap.draw(_local_9);
                _local_9.dispose();
            };
            var _local_8:ITextWindow = (_local_2.findChildByName("chart_title") as ITextWindow);
            if (_local_8){
                if (_local_6.available){
                    _local_10 = ("catalog.marketplace.offer_details.chart_title." + _local_5.name);
                    this.marketPlace.localization.registerParameter(_local_10, "days", _local_1.historyLength.toString());
                }
                else {
                    _local_10 = "catalog.marketplace.offer_details.chart_title.not_available";
                };
                _local_8.text = this.marketPlace.localization.getKey(_local_10);
            };
        }
        private function get marketPlace():IMarketPlace
        {
            if (((((page) && (page.viewer))) && (page.viewer.catalog))){
                return (page.viewer.catalog.getMarketPlace());
            };
            return (null);
        }
        public function displayMainView():void
        {
            var _local_1:XML = this.getAssetXML("marketPlaceWidget");
            if (_local_1 == null){
                return;
            };
            window.removeChildAt(0);
            if (((((((!(window)) || (!(page)))) || (!(page.viewer)))) || (!(page.viewer.catalog)))){
                return;
            };
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_1));
            window.procedure = this.onWidgetEvent;
            this._itemList = (window.findChildByName("offer_list") as IItemListWindow);
            this.selectSearchCategory("search_advanced");
        }
        private function selectSearchCategory(_arg_1:String):void
        {
            var _local_5:String;
            var _local_2:ISelectorWindow = (_window.findChildByName("search_selector") as ISelectorWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:ISelectableWindow = _local_2.getSelectableByName(_arg_1);
            if (_local_3 == null){
                return;
            };
            _local_2.setSelected(_local_3);
            var _local_4:IWindowContainer = (_window.findChildByName("search_container") as IWindowContainer);
            if (_local_4 == null){
                return;
            };
            while (_local_4.numChildren > 0) {
                _local_4.removeChildAt(0);
            };
            switch (_arg_1){
                case "search_by_value":
                    _local_5 = "marketplace_search_simple";
                    this._SafeStr_10512 = [1, 2];
                    break;
                case "search_by_activity":
                    _local_5 = "marketplace_search_simple";
                    this._SafeStr_10512 = [3, 4, 5, 6];
                    break;
                case "search_advanced":
                    _local_5 = "marketplace_search_advanced";
                    this._SafeStr_10512 = [1, 2, 3, 4, 5, 6];
                    break;
                default:
                    return;
            };
            var _local_6:IWindowContainer = (this.createWindow(_local_5) as IWindowContainer);
            _local_4.addChild(_local_6);
            _local_4.rectangle = _local_6.rectangle;
            this.resizeOfferList();
            var _local_7:IDropMenuWindow = (_window.findChildByName("sort_dropmenu") as IDropMenuWindow);
            if (_local_7 != null){
                _local_7.populate(this.getSortKeys(this._SafeStr_10512));
                _local_7.selection = 0;
            };
        }
        private function getSortKeys(_arg_1:Array):Array
        {
            var _local_3:int;
            var _local_2:Array = [];
            for each (_local_3 in _arg_1) {
                _local_2.push(((("$" + "{catalog.marketplace.sort.") + _local_3) + "}"));
            };
            return (_local_2);
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if (((((((((!(page)) || (!(page.viewer)))) || (!(page.viewer.catalog)))) || (!(page.viewer.catalog.assets)))) || (!(page.viewer.catalog.windowManager)))){
                return (null);
            };
            var _local_2:XmlAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((!(_local_2)) || (!(_local_2.content)))){
                return (null);
            };
            var _local_3:XML = (_local_2.content as XML);
            if (!_local_3){
                return (null);
            };
            return (page.viewer.catalog.windowManager.buildFromXML(_local_3));
        }
        private function resizeOfferList():void
        {
            if (!_window){
                return;
            };
            var _local_1:IItemListWindow = (_window.findChildByName("main_item_list") as IItemListWindow);
            var _local_2:IWindowContainer = (_window.findChildByName("offer_list_container") as IWindowContainer);
            _local_2.height = (_local_1.height - _local_2.y);
        }
        private function updateStatusDisplay(_arg_1:int, _arg_2:int=-1, _arg_3:int=-1):void
        {
            var _local_6:String;
            var _local_4:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_local_4){
                return;
            };
            if (((((((!(window)) || (!(page)))) || (!(page.viewer)))) || (!(page.viewer.catalog)))){
                return;
            };
            var _local_5:ITextWindow = (window.findChildByName("status_text") as ITextWindow);
            if (_local_5 == null){
                return;
            };
            if (_arg_1 == this._SafeStr_10508){
                _local_6 = _local_4.getKey("catalog.marketplace.searching");
            }
            else {
                if (this._SafeStr_10509){
                    if (_arg_3 > 0){
                        _local_6 = _local_4.getKey("catalog.marketplace.items_found");
                        _local_6 = _local_6.replace("%count%", _arg_3);
                        if ((((_arg_2 > 0)) && ((_arg_2 < _arg_3)))){
                            _local_6 = (_local_6 + ((". " + _local_4.getKey("catalog.marketplace.items_shown")) + "."));
                            _local_6 = _local_6.replace("%count%", _arg_2);
                        };
                    }
                    else {
                        _local_6 = _local_4.getKey("catalog.marketplace.no_items");
                    };
                };
            };
            _local_5.text = _local_6;
        }
        private function updateList():void
        {
            var _local_4:XML;
            var _local_5:IHabboWindowManager;
            if (((!(this.marketPlace)) || (!(window)))){
                return;
            };
            var _local_1:Map = this.marketPlace.latestOffers();
            if (!_local_1){
                return;
            };
            var _local_2:int = this.marketPlace.totalItemsFound();
            this._offers = _local_1;
            if (!this._itemList){
                return;
            };
            this._itemList.destroyListItems();
            if (!this._SafeStr_10514){
                _local_4 = this.getAssetXML("marketplace_offers_item");
                if (!_local_4){
                    return;
                };
                _local_5 = this.marketPlace.windowManager;
                if (_local_5 == null){
                    return;
                };
                this._SafeStr_10514 = (_local_5.buildFromXML(_local_4) as IWindowContainer);
            };
            if (!this._SafeStr_10514){
                return;
            };
            var _local_3:Array = _local_1.getKeys();
            if (_local_3 == null){
                return;
            };
            this.updateStatusDisplay(this._SafeStr_10509, _local_3.length, _local_2);
            if (!this._SafeStr_10515){
                this._SafeStr_10515 = new Timer(25);
                this._SafeStr_10515.addEventListener(TimerEvent.TIMER, this.onPopulationTimer);
            };
            this._SafeStr_10516 = 0;
            this.populateList();
            this._SafeStr_10515.start();
        }
        private function onPopulationTimer(_arg_1:TimerEvent):void
        {
            if (!this._SafeStr_10515){
                return;
            };
            if (this.populateList()){
                this._SafeStr_10515.stop();
            };
        }
        private function populateList():Boolean
        {
            if (!this._offers){
                return (true);
            };
            var _local_1:int;
            while (_local_1 < 5) {
                if (this._SafeStr_10516 >= this._offers.length){
                    return (true);
                };
                this.addListItem(this._offers.getWithIndex(this._SafeStr_10516));
                this._SafeStr_10516++;
                _local_1++;
            };
            return (false);
        }
        private function addListItem(_arg_1:MarketPlaceOfferData):void
        {
            var _local_7:String;
            var _local_8:String;
            var _local_9:ImageResult;
            var _local_10:IBitmapWrapperWindow;
            var _local_11:Point;
            if (((((((!(_arg_1)) || (!(this._itemList)))) || (!(this._SafeStr_10514)))) || (!(this.marketPlace.localization)))){
                return;
            };
            var _local_2:IWindowContainer = (this._SafeStr_10514.clone() as IWindowContainer);
            if (((!(_local_2)) || (_local_2.disposed))){
                return;
            };
            var _local_3:ITextWindow = (_local_2.findChildByName("item_name") as ITextWindow);
            if (_local_3 != null){
                _local_3.text = ((("$" + "{") + this.marketPlace.getNameLocalizationKey(_arg_1)) + "}");
            };
            var _local_4:ITextWindow = (_local_2.findChildByName("item_desc") as ITextWindow);
            if (_local_4 != null){
                _local_4.text = ((("$" + "{") + this.marketPlace.getDescriptionLocalizationKey(_arg_1)) + "}");
            };
            var _local_5:ITextWindow = (_local_2.findChildByName("item_price") as ITextWindow);
            if (_local_5 != null){
                _local_7 = this.marketPlace.localization.getKey("catalog.marketplace.offer.price_public_item");
                _local_7 = _local_7.replace("%price%", _arg_1.price);
                _local_7 = _local_7.replace("%average%", (((_arg_1.averagePrice)!=0) ? _arg_1.averagePrice.toString() : " - "));
                _local_5.text = _local_7;
            };
            var _local_6:ITextWindow = (_local_2.findChildByName("offer_count") as ITextWindow);
            if (_local_6){
                _local_8 = this.marketPlace.localization.getKey("catalog.marketplace.offer_count");
                _local_8 = _local_8.replace("%count%", _arg_1.offerCount);
                _local_6.text = _local_8;
            };
            if (_arg_1.image == null){
                _local_9 = this.getFurniImageResult(_arg_1.furniId, _arg_1.furniType, _arg_1.stuffData);
                if (((!((_local_9 == null))) && (!((_local_9.data == null))))){
                    _arg_1.image = (_local_9.data as BitmapData);
                    _arg_1.imageCallback = _local_9.id;
                    _local_2.id = _local_9.id;
                };
            };
            if (_arg_1.image != null){
                _local_10 = (_local_2.findChildByName("item_image") as IBitmapWrapperWindow);
                if (_local_10 != null){
                    _local_11 = new Point(((_local_10.width - _arg_1.image.width) / 2), ((_local_10.height - _arg_1.image.height) / 2));
                    if (_local_10.bitmap == null){
                        _local_10.bitmap = new BitmapData(_local_10.width, _local_10.height, true, 0);
                    };
                    _local_10.bitmap.copyPixels(_arg_1.image, _arg_1.image.rect, _local_11);
                };
            };
            this._itemList.addListItem(_local_2);
            _local_2.procedure = this.onOfferListEvent;
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_4:IWindowContainer;
            var _local_5:MarketPlaceOfferData;
            var _local_6:IBitmapWrapperWindow;
            var _local_7:Point;
            if (((((((((disposed) || (!(this.marketPlace)))) || (!(_arg_2)))) || (!(this._itemList)))) || (!(this._offers)))){
                return;
            };
            var _local_3:Array = [];
            if (this._itemList.groupListItemsWithID(_arg_1, _local_3)){
                for each (_local_4 in _local_3) {
                    if (_local_4){
                        _local_6 = (_local_4.findChildByName("item_image") as IBitmapWrapperWindow);
                        if (_local_6 != null){
                            _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
                            _local_7 = new Point(((_local_6.width - _arg_2.width) / 2), ((_local_6.height - _arg_2.height) / 2));
                            _local_6.bitmap.copyPixels(_arg_2, _arg_2.rect, _local_7, null, null, true);
                        };
                        _local_4.id = 0;
                    };
                };
            };
            for each (_local_5 in this._offers) {
                if (_local_5.imageCallback == _arg_1){
                    _local_5.imageCallback = 0;
                    _local_5.image = _arg_2;
                };
            };
        }
        private function getFurniImageResult(_arg_1:int, _arg_2:int, _arg_3:String=null):ImageResult
        {
            if (((((!(page)) || (!(page.viewer)))) || (!(page.viewer.roomEngine)))){
                return (null);
            };
            if (_arg_2 == 1){
                return (page.viewer.roomEngine.getFurnitureIcon(_arg_1, this));
            };
            if (_arg_2 == 2){
                return (page.viewer.roomEngine.getWallItemIcon(_arg_1, this, _arg_3));
            };
            return (null);
        }
        private function onOfferListEvent(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_3:int;
            var _local_4:Map;
            var _local_5:MarketPlaceOfferData;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                if (((((!(window)) || (!(this.marketPlace)))) || (!(_arg_2)))){
                    return;
                };
                if (this._itemList == null){
                    return;
                };
                _local_3 = this._itemList.getListItemIndex(_arg_1.window.parent);
                _local_4 = this.marketPlace.latestOffers();
                _local_5 = (_local_4.getWithIndex(_local_3) as MarketPlaceOfferData);
                if (!_local_5){
                    return;
                };
                switch (_arg_2.name){
                    case "buy_button":
                        this.marketPlace.buyOffer(_local_5.offerId);
                        return;
                    case "more_button":
                        this.showDetails(_local_5);
                        return;
                };
            };
        }
        private function showDetails(_arg_1:MarketPlaceOfferData):void
        {
            var _local_9:ImageResult;
            var _local_10:IBitmapWrapperWindow;
            if (((((!(_arg_1)) || (!(_window)))) || (!(this.marketPlace)))){
                return;
            };
            this._SafeStr_10513 = _arg_1;
            var _local_2:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_local_2){
                return;
            };
            var _local_3:IWindow = _window.findChildByName("main_item_list");
            if (_local_3){
                _local_3.visible = false;
            };
            var _local_4:IWindowContainer = (_window.findChildByName("details_container") as IWindowContainer);
            if (_local_4){
                _local_4.visible = true;
            }
            else {
                _local_4 = (this.createWindow("marketplace_offer_details") as IWindowContainer);
                _window.addChild(_local_4);
                _local_4.procedure = this.detailsEventHandler;
            };
            var _local_5:ITextWindow = (_local_4.findChildByName("item_name") as ITextWindow);
            if (_local_5){
                _local_5.text = ((("$" + "{") + this.marketPlace.getNameLocalizationKey(_arg_1)) + "}");
            };
            _local_5 = (_local_4.findChildByName("item_description") as ITextWindow);
            if (_local_5){
                _local_5.text = ((("$" + "{") + this.marketPlace.getDescriptionLocalizationKey(_arg_1)) + "}");
            };
            _local_5 = (_local_4.findChildByName("item_count") as ITextWindow);
            if (_local_5){
                _local_5.visible = false;
            };
            _local_2.registerParameter("catalog.marketplace.offer_details.price", "price", _arg_1.price.toString());
            _local_2.registerParameter("catalog.marketplace.offer_details.average_price", "days", this.marketPlace.averagePricePeriod.toString());
            var _local_6:String = (((_arg_1.averagePrice == 0)) ? " - " : _arg_1.averagePrice.toString());
            _local_2.registerParameter("catalog.marketplace.offer_details.average_price", "average", _local_6);
            if (_arg_1.image == null){
                _local_9 = this.getFurniImageResult(_arg_1.furniId, _arg_1.furniType, _arg_1.stuffData);
                if (((!((_local_9 == null))) && (!((_local_9.data == null))))){
                    _arg_1.image = (_local_9.data as BitmapData);
                    _arg_1.imageCallback = _local_9.id;
                };
            };
            if (_arg_1.image != null){
                _local_10 = (_local_4.findChildByName("item_image") as IBitmapWrapperWindow);
                if (_local_10 != null){
                    _local_10.bitmap = null;
                    _local_10.bitmap = new BitmapData(_local_10.width, _local_10.height, true, 0);
                    _local_10.bitmap.draw(_arg_1.image, new Matrix(1, 0, 0, 1, ((_local_10.width - _arg_1.image.width) / 2), ((_local_10.height - _arg_1.image.height) / 2)));
                };
            };
            var _local_7:ISelectorWindow = (_local_4.findChildByName("chart_selector") as ISelectorWindow);
            if (_local_7){
                _local_7.setSelected(_local_7.getSelectableAt(0));
            };
            var _local_8:IBitmapWrapperWindow = (_local_4.findChildByName("chart_bitmap") as IBitmapWrapperWindow);
            if (_local_8){
                _local_8.bitmap = null;
            };
            this.marketPlace.requestItemStats(_arg_1.furniType, _arg_1.furniId);
        }
        private function hideDetails():void
        {
            if (!_window){
                return;
            };
            this._SafeStr_10513 = null;
            var _local_1:IWindow = _window.findChildByName("details_container");
            if (_local_1){
                _local_1.visible = false;
            };
            _local_1 = _window.findChildByName("main_item_list");
            if (_local_1){
                _local_1.visible = true;
            };
        }
        private function doSearch():void
        {
            var _local_5:ITextFieldWindow;
            this.updateStatusDisplay(this._SafeStr_10508);
            var _local_1:int = -1;
            var _local_2:int = -1;
            var _local_3:String = "";
            var _local_4:int = 1;
            _local_5 = (_window.findChildByName("min_price_input") as ITextFieldWindow);
            if (_local_5){
                if (_local_5.text == ""){
                    _local_1 = -1;
                }
                else {
                    _local_1 = parseInt(_local_5.text);
                };
            };
            _local_5 = (_window.findChildByName("max_price_input") as ITextFieldWindow);
            if (_local_5){
                if (_local_5.text == ""){
                    _local_2 = -1;
                }
                else {
                    _local_2 = parseInt(_local_5.text);
                };
            };
            _local_5 = (_window.findChildByName("search_input") as ITextFieldWindow);
            if (_local_5){
                _local_3 = _local_5.text;
            };
            var _local_6:IDropMenuWindow = (_window.findChildByName("sort_dropmenu") as IDropMenuWindow);
            if (((((_local_6) && ((_local_6.selection >= 0)))) && ((_local_6.selection < this._SafeStr_10512.length)))){
                _local_4 = this._SafeStr_10512[_local_6.selection];
            };
            this.marketPlace.requestOffers(_local_1, _local_2, _local_3, _local_4);
        }
        private function onWidgetEvent(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_5:ISelectorWindow;
            var _local_6:ISelectableWindow;
            var _local_7:ITextFieldWindow;
            var _local_8:int;
            if (((((!(_arg_1)) || (!(_arg_2)))) || (!(this.marketPlace)))){
                return;
            };
            var _local_3:ICoreLocalizationManager = this.marketPlace.localization;
            var _local_4:ITextWindow = (window.findChildByName("search_input") as ITextWindow);
            if (_arg_1.type == WindowEvent.WE_SELECTED){
                switch (_arg_2.name){
                    case "sort_dropmenu":
                        _local_5 = (_window.findChildByName("search_selector") as ISelectorWindow);
                        if (!_local_5){
                            return;
                        };
                        _local_6 = _local_5.getSelected();
                        if (!_local_6){
                            return;
                        };
                        if ((((_local_6.name == "search_by_value")) || ((_local_6.name == "search_by_activity")))){
                            this.doSearch();
                        };
                        break;
                    case "search_by_value":
                    case "search_by_activity":
                    case "search_advanced":
                        this.selectSearchCategory(_arg_2.name);
                        break;
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                    switch (_arg_2.name){
                        case "search_input":
                            if (((((_local_3) && (_local_4))) && ((_local_4.text == _local_3.getKey("catalog.marketplace.search_name"))))){
                                _local_4.text = "";
                            };
                            break;
                        case "search_button":
                            if (((((_local_3) && (_local_4))) && ((_local_4.text == _local_3.getKey("catalog.marketplace.search_name"))))){
                                return;
                            };
                            this.doSearch();
                            break;
                    };
                }
                else {
                    if (_arg_1.type == WindowEvent.WE_CHANGE){
                        _local_7 = (_arg_2 as ITextFieldWindow);
                        if (!_local_7){
                            return;
                        };
                        switch (_local_7.name){
                            case "min_price_input":
                            case "max_price_input":
                                _local_8 = this._SafeStr_10511;
                                break;
                            case "search_input":
                                _local_8 = this._SafeStr_10510;
                                break;
                            default:
                                return;
                        };
                        if (_local_7.text.length > _local_8){
                            _local_7.text = _local_7.text.substr(0, _local_8);
                        };
                        _local_7.scrollH = 0;
                    };
                };
            };
        }
        private function detailsEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1)) || (!(_arg_2)))){
                return;
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "back_button":
                        this.hideDetails();
                        return;
                    case "buy_button":
                        this.marketPlace.buyOffer(this._SafeStr_10513.offerId);
                        return;
                };
                return;
            };
            if (_arg_1.type == WindowEvent.WE_SELECTED){
                switch (_arg_2.name){
                    case "price_development":
                    case "trade_volume":
                        this.updateStats();
                        return;
                };
            };
        }
        private function getAssetXML(_arg_1:String):XML
        {
            if (((((((!(page)) || (!(page.viewer)))) || (!(page.viewer.catalog)))) || (!(page.viewer.catalog.assets)))){
                return (null);
            };
            var _local_2:XmlAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_2 == null){
                return (null);
            };
            return ((_local_2.content as XML));
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// requestItemStats = "_-31B" (String#7332, DoABC#2)
// buyOffer = "_-0dj" (String#4387, DoABC#2)
// latestOffers = "_-EU" (String#7960, DoABC#2)
// itemStats = "_-2mo" (String#7016, DoABC#2)
// getNameLocalizationKey = "_-0SQ" (String#4147, DoABC#2)
// getDescriptionLocalizationKey = "_-sT" (String#8746, DoABC#2)
// listUpdatedNotify = "_-0rN" (String#4671, DoABC#2)
// updateStats = "_-0mx" (String#4566, DoABC#2)
// imageCallback = "_-3-K" (String#7292, DoABC#2)
// displayMainView = "_-1jQ" (String#1749, DoABC#2)
// _SafeStr_10508 = "_-2Z" (String#6745, DoABC#2)
// _SafeStr_10509 = "_-Zp" (String#8415, DoABC#2)
// _SafeStr_10510 = "_-2aU" (String#20463, DoABC#2)
// _SafeStr_10511 = "_-1j-" (String#18245, DoABC#2)
// _SafeStr_10512 = "_-2TH" (String#20175, DoABC#2)
// _SafeStr_10513 = "_-1xG" (String#18858, DoABC#2)
// _SafeStr_10514 = "_-2WJ" (String#20297, DoABC#2)
// _SafeStr_10515 = "_-2eM" (String#20617, DoABC#2)
// _SafeStr_10516 = "_-1cx" (String#18010, DoABC#2)
// onPopulationTimer = "_-0TS" (String#15189, DoABC#2)
// marketPlace = "_-1D5" (String#5127, DoABC#2)
// hideDetails = "_-2DJ" (String#19539, DoABC#2)
// onWidgetEvent = "_-0Gj" (String#3887, DoABC#2)
// selectSearchCategory = "_-10w" (String#16496, DoABC#2)
// resizeOfferList = "_-Rv" (String#23321, DoABC#2)
// getSortKeys = "_-000" (String#14052, DoABC#2)
// updateStatusDisplay = "_-33x" (String#7387, DoABC#2)
// populateList = "_-09Y" (String#14428, DoABC#2)
// onOfferListEvent = "_-0gg" (String#15697, DoABC#2)
// detailsEventHandler = "_-2we" (String#21332, DoABC#2)
// doSearch = "_-1NB" (String#17405, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IMarketPlace = "_-1xE" (String#5977, DoABC#2)
// MarketplaceItemStats = "_-2Fw" (String#19640, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// IMarketPlaceVisualization = "_-2vn" (String#7194, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// MarketPlaceOfferData = "_-2vY" (String#7188, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// MarketPlaceCatalogWidget = "_-kk" (String#8620, DoABC#2)
// MarketplaceChart = "_-34I" (String#21670, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// showDetails = "_-3H6" (String#7649, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// getFurniImageResult = "_-2ST" (String#889, DoABC#2)
// destroyListItems = "_-0xF" (String#4796, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// registerVisualization = "_-2z1" (String#7263, DoABC#2)
// requestOffers = "_-1ST" (String#5406, DoABC#2)
// getAssetXML = "_-1XT" (String#364, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// getSelectableByName = "_-0EO" (String#3836, DoABC#2)
// furniType = "_-26P" (String#6173, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)
// historyLength = "_-1dq" (String#18052, DoABC#2)
// dayOffsets = "_-1hM" (String#18187, DoABC#2)
// averagePrices = "_-2fx" (String#20689, DoABC#2)
// soldAmounts = "_-z4" (String#24653, DoABC#2)
// averagePricePeriod = "_-0lE" (String#4528, DoABC#2)
// totalItemsFound = "_-hr" (String#8552, DoABC#2)
// getSelectableAt = "_-2Vc" (String#6675, DoABC#2)
// groupListItemsWithID = "_-CS" (String#7927, DoABC#2)


