
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferState;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MarketPlaceOwnItemsCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IMarketPlaceVisualization 
    {

        private const _SafeStr_10508:int = 1;
        private const _SafeStr_10509:int = 2;

        private var _SafeStr_10575:Map;
        private var _itemList:IItemListWindow;
        private var _offers:Map;

        public function MarketPlaceOwnItemsCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
            this._SafeStr_10575 = new Map();
        }
        override public function dispose():void
        {
            super.dispose();
        }
        override public function init():Boolean
        {
            var _local_2:IWindowContainer;
            var _local_3:XML;
            if (!super.init()){
                return (false);
            };
            if (this.marketPlace == null){
                return (false);
            };
            var _local_1:IHabboWindowManager = this.marketPlace.windowManager;
            if (_local_1 == null){
                return (false);
            };
            _local_3 = this.getAssetXML("marketplace_ongoing_item");
            if (_local_3 != null){
                _local_2 = (_local_1.buildFromXML(_local_3) as IWindowContainer);
                if (_local_2){
                    this._SafeStr_10575.add(MarketPlaceOfferState._SafeStr_10283, _local_2);
                };
            };
            _local_3 = this.getAssetXML("marketplace_sold_item");
            if (_local_3 != null){
                _local_2 = (_local_1.buildFromXML(_local_3) as IWindowContainer);
                if (_local_2){
                    this._SafeStr_10575.add(MarketPlaceOfferState._SafeStr_10272, _local_2);
                };
            };
            _local_3 = this.getAssetXML("marketplace_expired_item");
            if (_local_3 != null){
                _local_2 = (_local_1.buildFromXML(_local_3) as IWindowContainer);
                if (_local_2){
                    this._SafeStr_10575.add(MarketPlaceOfferState._SafeStr_10284, _local_2);
                };
            };
            this.marketPlace.registerVisualization(this);
            this.displayMainView();
            this.marketPlace.requestOwnItems();
            this.updateStatusDisplay(this._SafeStr_10508);
            this.showRedeemInfo(false);
            return (true);
        }
        private function showRedeemInfo(_arg_1:Boolean):void
        {
            if (!window){
                return;
            };
            var _local_2:IWindowContainer = (window.findChildByName("redeem_border") as IWindowContainer);
            if (_local_2){
                _local_2.visible = _arg_1;
            };
        }
        public function listUpdatedNotify():void
        {
            if (this.marketPlace == null){
                return;
            };
            this.updateList(this.marketPlace.latestOwnOffers());
        }
        private function updateStatusDisplay(_arg_1:int, _arg_2:int=-1):void
        {
            var _local_5:String;
            if (((!(this.marketPlace)) || (!(window)))){
                return;
            };
            var _local_3:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_local_3){
                return;
            };
            var _local_4:ITextWindow = (window.findChildByName("status_text") as ITextWindow);
            if (_local_4 == null){
                return;
            };
            if (_arg_1 == this._SafeStr_10508){
                _local_5 = _local_3.getKey("catalog.marketplace.searching");
            }
            else {
                if (this._SafeStr_10509){
                    if (_arg_2 > 0){
                        _local_5 = _local_3.getKey("catalog.marketplace.items_found");
                        _local_5 = _local_5.replace("%count%", _arg_2);
                    }
                    else {
                        _local_5 = _local_3.getKey("catalog.marketplace.no_items");
                    };
                };
            };
            _local_4.text = _local_5;
        }
        private function get marketPlace():IMarketPlace
        {
            if (((((!(page)) || (!(page.viewer)))) || (!(page.viewer.catalog)))){
                return (null);
            };
            return (page.viewer.catalog.getMarketPlace());
        }
        private function updateList(_arg_1:Map):void
        {
            var _local_4:IWindowContainer;
            var _local_10:int;
            var _local_11:MarketPlaceOfferData;
            var _local_12:IWindowContainer;
            var _local_13:ITextWindow;
            var _local_14:ITextWindow;
            var _local_15:ITextWindow;
            var _local_16:String;
            var _local_17:ITextWindow;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:String;
            var _local_22:String;
            var _local_23:ITextWindow;
            var _local_24:ITextWindow;
            var _local_25:ImageResult;
            var _local_26:IBitmapWrapperWindow;
            var _local_27:Point;
            if (((((!(_arg_1)) || (!(this.marketPlace)))) || (!(window)))){
                return;
            };
            this._offers = _arg_1;
            var _local_2:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_local_2){
                return;
            };
            var _local_3:IItemListWindow = (window.findChildByName("item_list") as IItemListWindow);
            if (!_local_3){
                return;
            };
            _local_3.destroyListItems();
            var _local_5:int;
            var _local_6:Array = _arg_1.getKeys();
            if (!_local_6){
                return;
            };
            this.updateStatusDisplay(this._SafeStr_10509, _local_6.length);
            var _local_7:int;
            while (_local_7 < _local_6.length) {
                _local_10 = _local_6[_local_7];
                _local_11 = (_arg_1.getValue(_local_10) as MarketPlaceOfferData);
                if (_local_11.status == MarketPlaceOfferState._SafeStr_10272){
                    _local_5++;
                };
                _local_4 = this._SafeStr_10575.getValue(_local_11.status);
                if (_local_4){
                    _local_12 = (_local_4.clone() as IWindowContainer);
                    if (!((!(_local_12)) || (_local_12.disposed))){
                        _local_13 = (_local_12.findChildByName("item_name") as ITextWindow);
                        if (_local_13 != null){
                            _local_13.text = (((this.marketPlace)!=null) ? ((("$" + "{") + this.marketPlace.getNameLocalizationKey(_local_11)) + "}") : "");
                        };
                        _local_14 = (_local_12.findChildByName("item_desc") as ITextWindow);
                        if (_local_14 != null){
                            _local_14.text = (((this.marketPlace)!=null) ? ((("$" + "{") + this.marketPlace.getDescriptionLocalizationKey(_local_11)) + "}") : "");
                        };
                        _local_15 = (_local_12.findChildByName("item_price") as ITextWindow);
                        if (_local_15 != null){
                            _local_16 = _local_2.getKey("catalog.marketplace.offer.price_own_item");
                            _local_16 = _local_16.replace("%price%", _local_11.price);
                            _local_15.text = _local_16;
                        };
                        if (_local_11.status == MarketPlaceOfferState._SafeStr_10283){
                            _local_17 = (_local_12.findChildByName("item_time") as ITextWindow);
                            if (_local_17 != null){
                                _local_18 = Math.max(1, _local_11.timeLeftMinutes);
                                _local_19 = Math.floor((_local_18 / 60));
                                _local_20 = (_local_18 - (_local_19 * 60));
                                _local_21 = ((_local_20 + " ") + _local_2.getKey("catalog.marketplace.offer.minutes"));
                                if (_local_19 > 0){
                                    _local_21 = ((((_local_19 + " ") + _local_2.getKey("catalog.marketplace.offer.hours")) + " ") + _local_21);
                                };
                                _local_22 = _local_2.getKey("catalog.marketplace.offer.time_left");
                                _local_22 = _local_22.replace("%time%", _local_21);
                                _local_17.text = _local_22;
                            };
                        };
                        if (_local_11.status == MarketPlaceOfferState._SafeStr_10272){
                            _local_23 = (_local_12.findChildByName("item_sold") as ITextWindow);
                            if (_local_23 != null){
                                _local_23.text = _local_2.getKey("catalog.marketplace.offer.sold");
                            };
                        };
                        if (_local_11.status == MarketPlaceOfferState._SafeStr_10284){
                            _local_24 = (_local_12.findChildByName("item_expired") as ITextWindow);
                            if (_local_24 != null){
                                _local_24.text = _local_2.getKey("catalog.marketplace.offer.expired");
                            };
                        };
                        if (_local_11.image == null){
                            _local_25 = this.getFurniImageResult(_local_11.furniId, _local_11.furniType, _local_11.stuffData);
                            if (((!((_local_25 == null))) && (!((_local_25.data == null))))){
                                _local_11.image = (_local_25.data as BitmapData);
                                _local_11.imageCallback = _local_25.id;
                                _local_12.id = _local_25.id;
                            };
                        };
                        if (_local_11.image != null){
                            _local_26 = (_local_12.findChildByName("item_image") as IBitmapWrapperWindow);
                            if (_local_26 != null){
                                _local_27 = new Point(((_local_26.width - _local_11.image.width) / 2), ((_local_26.height - _local_11.image.height) / 2));
                                if (_local_26.bitmap == null){
                                    _local_26.bitmap = new BitmapData(_local_26.width, _local_26.height, true, 0);
                                };
                                _local_26.bitmap.copyPixels(_local_11.image, _local_11.image.rect, _local_27);
                            };
                        };
                        _local_3.addListItem(_local_12);
                        _local_12.procedure = this.onGridEvent;
                    };
                };
                _local_7++;
            };
            this.showRedeemInfo(true);
            var _local_8:IButtonWindow = (window.findChildByName("redeem_sold") as IButtonWindow);
            var _local_9:ITextWindow = (window.findChildByName("redeem_info") as ITextWindow);
            if (((_local_8) && (_local_9))){
                if (_local_5 > 0){
                    _local_8.enable();
                    _local_2.registerParameter("catalog.marketplace.redeem.get_credits", "count", _local_5.toString());
                    _local_2.registerParameter("catalog.marketplace.redeem.get_credits", "credits", this.marketPlace.creditsWaiting.toString());
                    _local_9.text = ("$" + "{catalog.marketplace.redeem.get_credits}");
                }
                else {
                    _local_8.disable();
                    _local_9.text = ("$" + "{catalog.marketplace.redeem.no_sold_items}");
                };
            };
        }
        public function displayMainView():void
        {
            var _local_1:XML = this.getAssetXML("marketPlaceOwnItemsWidget");
            if (((!(_local_1)) || (!(window)))){
                return;
            };
            window.removeChildAt(0);
            if (((((((!(page)) || (!(page.viewer)))) || (!(page.viewer.catalog)))) || (!(page.viewer.catalog.windowManager)))){
                return;
            };
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_1));
            window.procedure = this.onWidgetEvent;
            this._itemList = (window.findChildByName("item_list") as IItemListWindow);
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
        private function onGridEvent(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_3:IItemListWindow;
            var _local_4:int;
            var _local_5:Map;
            var _local_6:MarketPlaceOfferData;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                if (((((!(this.marketPlace)) || (!(_arg_2)))) || (!(window)))){
                    return;
                };
                if (_arg_2.name == "pick_button"){
                    _local_3 = (window.findChildByName("item_list") as IItemListWindow);
                    if (_local_3 == null){
                        return;
                    };
                    _local_4 = _local_3.getListItemIndex(_arg_1.window.parent);
                    _local_5 = this.marketPlace.latestOwnOffers();
                    if (!_local_5){
                        return;
                    };
                    _local_6 = (_local_5.getWithIndex(_local_4) as MarketPlaceOfferData);
                    if (_local_6){
                        this.marketPlace.redeemExpiredOffer(_local_6.offerId);
                    };
                };
            };
        }
        private function onWidgetEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_2 == null){
                _arg_2 = (_arg_1.target as IWindow);
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "redeem_sold":
                        if (this.marketPlace){
                            this.marketPlace.redeemSoldOffers();
                        };
                        return;
                };
            };
        }
        public function updateStats():void
        {
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// requestOwnItems = "_-vS" (String#8793, DoABC#2)
// redeemExpiredOffer = "_-210" (String#6065, DoABC#2)
// redeemSoldOffers = "_-1o8" (String#5820, DoABC#2)
// latestOwnOffers = "_-0sN" (String#4692, DoABC#2)
// getNameLocalizationKey = "_-0SQ" (String#4147, DoABC#2)
// getDescriptionLocalizationKey = "_-sT" (String#8746, DoABC#2)
// _SafeStr_10272 = "_-1Se" (String#17607, DoABC#2)
// listUpdatedNotify = "_-0rN" (String#4671, DoABC#2)
// updateStats = "_-0mx" (String#4566, DoABC#2)
// imageCallback = "_-3-K" (String#7292, DoABC#2)
// displayMainView = "_-1jQ" (String#1749, DoABC#2)
// _SafeStr_10283 = "_-2uK" (String#21252, DoABC#2)
// _SafeStr_10284 = "_-24h" (String#19210, DoABC#2)
// _SafeStr_10508 = "_-2Z" (String#6745, DoABC#2)
// _SafeStr_10509 = "_-Zp" (String#8415, DoABC#2)
// marketPlace = "_-1D5" (String#5127, DoABC#2)
// onWidgetEvent = "_-0Gj" (String#3887, DoABC#2)
// updateStatusDisplay = "_-33x" (String#7387, DoABC#2)
// _SafeStr_10575 = "_-0o4" (String#15979, DoABC#2)
// showRedeemInfo = "_-2W5" (String#20285, DoABC#2)
// onGridEvent = "_-2A" (String#19406, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IMarketPlace = "_-1xE" (String#5977, DoABC#2)
// IMarketPlaceVisualization = "_-2vn" (String#7194, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// MarketPlaceOfferData = "_-2vY" (String#7188, DoABC#2)
// MarketPlaceOfferState = "_-2CX" (String#19506, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// MarketPlaceOwnItemsCatalogWidget = "_-2Di" (String#6316, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// getFurniImageResult = "_-2ST" (String#889, DoABC#2)
// destroyListItems = "_-0xF" (String#4796, DoABC#2)
// registerVisualization = "_-2z1" (String#7263, DoABC#2)
// getAssetXML = "_-1XT" (String#364, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// furniType = "_-26P" (String#6173, DoABC#2)
// timeLeftMinutes = "_-09A" (String#3743, DoABC#2)
// creditsWaiting = "_-1Ru" (String#5396, DoABC#2)
// groupListItemsWithID = "_-CS" (String#7927, DoABC#2)


