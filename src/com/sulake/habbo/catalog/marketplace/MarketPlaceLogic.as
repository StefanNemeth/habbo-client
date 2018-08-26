
package com.sulake.habbo.catalog.marketplace
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.utils.Map;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultParser;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    public class MarketPlaceLogic implements IMarketPlace 
    {

        private static const _FurniturePresentWidgetHandler:String = "poster";

        public const _SafeStr_10256:int = 1;
        public const _SafeStr_10257:int = 2;
        public const _SafeStr_10258:int = 3;

        private var _catalog:IHabboCatalog;
        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _visualization:IMarketPlaceVisualization;
        private var _SafeStr_5427:MarketplaceConfirmationDialog;
        private var _MarketPlaceLogic:Map;
        private var _SafeStr_10260:Map;
        private var _creditsWaiting:int;
        private var _averagePricePeriod:int = -1;
        private var _itemStats:MarketplaceItemStats;
        private var _SafeStr_8572:int;
        private var _SafeStr_8573:int;
        private var _totalItemsFound:int;
        private var _SafeStr_10262:int = 0;
        private var _SafeStr_10263:int = 0;
        private var _SafeStr_10264:String = "";
        private var _SafeStr_10265:int = -1;
        private var _disposed:Boolean = false;

        public function MarketPlaceLogic(_arg_1:IHabboCatalog, _arg_2:IHabboWindowManager, _arg_3:IRoomEngine)
        {
            this._catalog = _arg_1;
            this._windowManager = _arg_2;
            this._roomEngine = _arg_3;
            this.getConfiguration();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._catalog = null;
            this._windowManager = null;
            if (this._MarketPlaceLogic != null){
                this.MarketPlaceLogic(this._MarketPlaceLogic);
                this._MarketPlaceLogic = null;
            };
            if (this._SafeStr_10260 != null){
                this.MarketPlaceLogic(this._SafeStr_10260);
                this._SafeStr_10260 = null;
            };
            this._disposed = true;
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get localization():ICoreLocalizationManager
        {
            return (this._catalog.localization);
        }
        public function MarketPlaceLogic(_arg_1:IMarketPlaceVisualization=null):void
        {
            if (_arg_1 == null){
                return;
            };
            this._visualization = _arg_1;
        }
        private function getConfiguration():void
        {
            if (((!(this._catalog)) || (!(this._catalog.connection)))){
                return;
            };
            this._catalog.connection.send(new GetMarketplaceConfigurationMessageComposer());
        }
        private function showConfirmation(_arg_1:int, _arg_2:MarketPlaceOfferData):void
        {
            if (!this._SafeStr_5427){
                this._SafeStr_5427 = new MarketplaceConfirmationDialog(this, this._catalog, this._roomEngine);
            };
            this._SafeStr_5427.showConfirmation(_arg_1, _arg_2);
        }
        public function MarketPlaceLogic(_arg_1:String):void
        {
            if (this._catalog){
                this._catalog.getPublicMarketPlaceOffers(-1, -1, _arg_1, -1);
            };
        }
        public function MarketPlaceLogic(_arg_1:int):void
        {
            if (this._catalog){
                this._catalog.getPublicMarketPlaceOffers(_arg_1, -1, "", -1);
            };
        }
        public function MarketPlaceLogic(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):void
        {
            this._SafeStr_10262 = _arg_1;
            this._SafeStr_10263 = _arg_2;
            this._SafeStr_10264 = _arg_3;
            this._SafeStr_10265 = _arg_4;
            if (this._catalog){
                this._catalog.getPublicMarketPlaceOffers(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }
        public function MarketPlaceLogic():void
        {
            this.MarketPlaceLogic(this._SafeStr_10262, this._SafeStr_10263, this._SafeStr_10264, this._SafeStr_10265);
        }
        public function MarketPlaceLogic():void
        {
            if (this._catalog){
                this._catalog.getOwnMarketPlaceOffers();
            };
        }
        public function MarketPlaceLogic(_arg_1:int, _arg_2:int):void
        {
            if (this._catalog){
                this._SafeStr_8573 = _arg_2;
                this._SafeStr_8572 = _arg_1;
                this._catalog.getMarketplaceItemStats(_arg_1, _arg_2);
            };
        }
        public function MarketPlaceLogic(_arg_1:int):void
        {
            if (((((!(this._MarketPlaceLogic)) || (!(this._catalog)))) || (!(this._catalog.getPurse())))){
                return;
            };
            var _local_2:MarketPlaceOfferData = (this._MarketPlaceLogic.getValue(_arg_1) as MarketPlaceOfferData);
            if (!_local_2){
                return;
            };
            if (this._catalog.getPurse().credits < _local_2.price){
                this._catalog.showNotEnoughCreditsAlert();
                return;
            };
            this.showConfirmation(this._SafeStr_10256, _local_2);
        }
        public function MarketPlaceLogic(_arg_1:int):void
        {
            if (this._catalog){
                this._catalog.redeemExpiredMarketPlaceOffer(_arg_1);
            };
        }
        public function MarketPlaceLogic():void
        {
            var _local_2:int;
            var _local_3:MarketPlaceOfferData;
            if (this.disposed){
                return;
            };
            if (this._SafeStr_10260 == null){
                return;
            };
            var _local_1:Array = this._SafeStr_10260.getKeys();
            for each (_local_2 in _local_1) {
                _local_3 = this._SafeStr_10260.getValue(_local_2);
                if (_local_3.status == MarketPlaceOfferState._SafeStr_10272){
                    this._SafeStr_10260.remove(_local_2);
                    _local_3.dispose();
                };
            };
            if (this._catalog){
                this._catalog.redeemSoldMarketPlaceOffers();
            };
            if (this._visualization != null){
                this._visualization.listUpdatedNotify();
            };
        }
        private function MarketPlaceLogic(_arg_1:Map):void
        {
            var _local_2:MarketPlaceOfferData;
            if (_arg_1 != null){
                for each (_local_2 in _arg_1) {
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                };
                _arg_1.dispose();
            };
        }
        public function MarketPlaceLogic(_arg_1:IMessageEvent):void
        {
            var _local_4:MarketPlaceOffer;
            var _local_5:MarketPlaceOfferData;
            var _local_2:MarketPlaceOffersEvent = (_arg_1 as MarketPlaceOffersEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:MarketPlaceOffersParser = (_local_2.getParser() as MarketPlaceOffersParser);
            if (_local_3 == null){
                return;
            };
            this.MarketPlaceLogic(this._MarketPlaceLogic);
            this._MarketPlaceLogic = new Map();
            for each (_local_4 in _local_3.offers) {
                _local_5 = new MarketPlaceOfferData(_local_4.offerId, _local_4.furniId, _local_4.furniType, _local_4.stuffData, _local_4.price, _local_4.status, _local_4.averagePrice, _local_4.offerCount);
                _local_5.timeLeftMinutes = _local_4.timeLeftMinutes;
                this._MarketPlaceLogic.add(_local_4.offerId, _local_5);
            };
            this._totalItemsFound = _local_3.totalItemsFound;
            if (this._visualization != null){
                this._visualization.listUpdatedNotify();
            };
        }
        public function MarketPlaceLogic(_arg_1:IMessageEvent):void
        {
            var _local_4:MarketPlaceOffer;
            var _local_5:MarketPlaceOfferData;
            var _local_2:MarketPlaceOwnOffersEvent = (_arg_1 as MarketPlaceOwnOffersEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:MarketPlaceOwnOffersParser = (_local_2.getParser() as MarketPlaceOwnOffersParser);
            if (_local_3 == null){
                return;
            };
            this.MarketPlaceLogic(this._SafeStr_10260);
            this._SafeStr_10260 = new Map();
            this._creditsWaiting = _local_3.creditsWaiting;
            for each (_local_4 in _local_3.offers) {
                _local_5 = new MarketPlaceOfferData(_local_4.offerId, _local_4.furniId, _local_4.furniType, _local_4.stuffData, _local_4.price, _local_4.status, _local_4.averagePrice);
                _local_5.timeLeftMinutes = _local_4.timeLeftMinutes;
                this._SafeStr_10260.add(_local_4.offerId, _local_5);
            };
            if (this._visualization != null){
                this._visualization.listUpdatedNotify();
            };
        }
        public function MarketPlaceLogic(event:IMessageEvent):void
        {
            var item:MarketPlaceOfferData;
            var updateItem:MarketPlaceOfferData;
            var buyEvent:MarketplaceBuyOfferResultEvent = (event as MarketplaceBuyOfferResultEvent);
            if (event == null){
                return;
            };
            var parser:MarketplaceBuyOfferResultParser = (buyEvent.getParser() as MarketplaceBuyOfferResultParser);
            if (parser == null){
                return;
            };
            if (parser.result == 1){
                this.MarketPlaceLogic();
            }
            else {
                if (parser.result == 2){
                    item = this._MarketPlaceLogic.remove(parser.requestedOfferId);
                    if (item != null){
                        item.dispose();
                    };
                    if (this._visualization != null){
                        this._visualization.listUpdatedNotify();
                    };
                    if (this._windowManager != null){
                        this._windowManager.alert("${catalog.marketplace.not_available_title}", "${catalog.marketplace.not_available_header}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                    };
                }
                else {
                    if (parser.result == 3){
                        updateItem = (this._MarketPlaceLogic.getValue(parser.requestedOfferId) as MarketPlaceOfferData);
                        if (updateItem){
                            updateItem.offerId = parser.offerId;
                            updateItem.price = parser.newPrice;
                            updateItem.offerCount--;
                            this._MarketPlaceLogic.add(parser.offerId, updateItem);
                        };
                        this._MarketPlaceLogic.remove(parser.requestedOfferId);
                        this.showConfirmation(this._SafeStr_10257, updateItem);
                        if (this._visualization != null){
                            this._visualization.listUpdatedNotify();
                        };
                    }
                    else {
                        if (parser.result == 4){
                            if (this._windowManager != null){
                                this._windowManager.alert("${catalog.alert.notenough.title}", "${catalog.alert.notenough.credits.description}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                                {
                                    _arg_1.dispose();
                                });
                            };
                        };
                    };
                };
            };
        }
        public function MarketPlaceLogic(event:IMessageEvent):void
        {
            var item:MarketPlaceOfferData;
            var cancelEvent:MarketplaceCancelOfferResultEvent = (event as MarketplaceCancelOfferResultEvent);
            if (event == null){
                return;
            };
            var parser:MarketplaceCancelOfferResultParser = (cancelEvent.getParser() as MarketplaceCancelOfferResultParser);
            if (parser == null){
                return;
            };
            if (parser.result == 1){
                item = this._SafeStr_10260.remove(parser.offerId);
                if (item != null){
                    item.dispose();
                };
                if (this._visualization != null){
                    this._visualization.listUpdatedNotify();
                };
            }
            else {
                if (parser.result == 0){
                    if (this._windowManager != null){
                        this._windowManager.alert("${catalog.marketplace.operation_failed.topic}", "{{catalog.marketplace.cancel_failed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                    };
                };
            };
        }
        public function MarketPlaceLogic():Map
        {
            return (this._MarketPlaceLogic);
        }
        public function latestOwnOffers():Map
        {
            return (this._SafeStr_10260);
        }
        public function totalItemsFound():int
        {
            return (this._totalItemsFound);
        }
        public function set itemStats(_arg_1:MarketplaceItemStats):void
        {
            if (((!((_arg_1.furniCategoryId == this._SafeStr_8572))) || (!((_arg_1.furniTypeId == this._SafeStr_8573))))){
                return;
            };
            this._itemStats = _arg_1;
            if (this._visualization != null){
                this._visualization.updateStats();
            };
        }
        public function get itemStats():MarketplaceItemStats
        {
            return (this._itemStats);
        }
        public function get creditsWaiting():int
        {
            return (this._creditsWaiting);
        }
        public function get averagePricePeriod():int
        {
            return (this._averagePricePeriod);
        }
        public function set averagePricePeriod(_arg_1:int):void
        {
            this._averagePricePeriod = _arg_1;
        }
        private function isPosterItem(_arg_1:IMarketPlaceOfferData):Boolean
        {
            var _local_3:IFurnitureData;
            var _local_4:String;
            var _local_2:Boolean;
            if ((((_arg_1.furniType == 2)) && (!((_arg_1.stuffData == null))))){
                _local_3 = this._catalog.getFurnitureData(_arg_1.furniId, ProductTypeEnum._SafeStr_5019);
                if (_local_3){
                    _local_4 = _local_3.name;
                    if (((!((_local_4 == null))) && ((_local_4 == _FurniturePresentWidgetHandler)))){
                        _local_2 = true;
                    };
                };
            };
            return (_local_2);
        }
        public function getNameLocalizationKey(_arg_1:IMarketPlaceOfferData):String
        {
            var _local_2:String = "";
            if (_arg_1 != null){
                if (this.isPosterItem(_arg_1)){
                    _local_2 = (("poster_" + _arg_1.stuffData) + "_name");
                }
                else {
                    if (_arg_1.furniType == MarketPlaceOfferData._SafeStr_7291){
                        _local_2 = ("roomItem.name." + _arg_1.furniId);
                    }
                    else {
                        if (_arg_1.furniType == MarketPlaceOfferData._SafeStr_10277){
                            _local_2 = ("wallItem.name." + _arg_1.furniId);
                        };
                    };
                };
            };
            return (_local_2);
        }
        public function getDescriptionLocalizationKey(_arg_1:IMarketPlaceOfferData):String
        {
            var _local_2:String = "";
            if (_arg_1 != null){
                if (this.isPosterItem(_arg_1)){
                    _local_2 = (("poster_" + _arg_1.stuffData) + "_desc");
                }
                else {
                    if (_arg_1.furniType == MarketPlaceOfferData._SafeStr_7291){
                        _local_2 = ("roomItem.desc." + _arg_1.furniId);
                    }
                    else {
                        if (_arg_1.furniType == MarketPlaceOfferData._SafeStr_10277){
                            _local_2 = ("wallItem.desc." + _arg_1.furniId);
                        };
                    };
                };
            };
            return (_local_2);
        }

    }
}//package com.sulake.habbo.catalog.marketplace

// MarketPlaceLogic = "_-0LM" (String#3987, DoABC#2)
// MarketPlaceLogic = "_-3Ea" (String#7604, DoABC#2)
// MarketPlaceLogic = "_-4T" (String#7756, DoABC#2)
// MarketPlaceLogic = "_-Q9" (String#8203, DoABC#2)
// MarketPlaceLogic = "_-12y" (String#4932, DoABC#2)
// MarketPlaceLogic = "_-0gr" (String#4443, DoABC#2)
// MarketPlaceLogic = "_-vS" (String#8793, DoABC#2)
// MarketPlaceLogic = "_-31B" (String#7332, DoABC#2)
// MarketPlaceLogic = "_-0dj" (String#4387, DoABC#2)
// MarketPlaceLogic = "_-210" (String#6065, DoABC#2)
// MarketPlaceLogic = "_-1o8" (String#5820, DoABC#2)
// MarketPlaceLogic = "_-EU" (String#7960, DoABC#2)
// latestOwnOffers = "_-0sN" (String#4692, DoABC#2)
// itemStats = "_-2mo" (String#7016, DoABC#2)
// getNameLocalizationKey = "_-0SQ" (String#4147, DoABC#2)
// getDescriptionLocalizationKey = "_-sT" (String#8746, DoABC#2)
// _SafeStr_10256 = "_-0Ht" (String#14752, DoABC#2)
// _SafeStr_10257 = "_-2hn" (String#20764, DoABC#2)
// _SafeStr_10258 = "_-2fI" (String#20659, DoABC#2)
// _MarketPlaceLogic = "_-2FE" (String#19613, DoABC#2)
// _SafeStr_10260 = "_-MS" (String#23102, DoABC#2)
// _itemStats = "_-2tv" (String#21234, DoABC#2)
// _SafeStr_10262 = "_-22w" (String#19132, DoABC#2)
// _SafeStr_10263 = "_-04H" (String#14213, DoABC#2)
// _SafeStr_10264 = "_-1NM" (String#5300, DoABC#2)
// _SafeStr_10265 = "_-1zV" (String#18947, DoABC#2)
// MarketPlaceLogic = "_-qb" (String#24296, DoABC#2)
// getPublicMarketPlaceOffers = "_-1kA" (String#5754, DoABC#2)
// getOwnMarketPlaceOffers = "_-2ye" (String#7252, DoABC#2)
// getMarketplaceItemStats = "_-0Ya" (String#4274, DoABC#2)
// showNotEnoughCreditsAlert = "_-20s" (String#6062, DoABC#2)
// redeemExpiredMarketPlaceOffer = "_-29g" (String#6244, DoABC#2)
// _SafeStr_10272 = "_-1Se" (String#17607, DoABC#2)
// redeemSoldMarketPlaceOffers = "_-2lU" (String#6992, DoABC#2)
// listUpdatedNotify = "_-0rN" (String#4671, DoABC#2)
// updateStats = "_-0mx" (String#4566, DoABC#2)
// isPosterItem = "_-vT" (String#24507, DoABC#2)
// _SafeStr_10277 = "_-2s7" (String#21163, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IMarketPlace = "_-1xE" (String#5977, DoABC#2)
// MarketplaceBuyOfferResultEvent = "_-0Q7" (String#15066, DoABC#2)
// MarketplaceItemStats = "_-2Fw" (String#19640, DoABC#2)
// MarketPlaceOffersEvent = "_-sl" (String#24391, DoABC#2)
// MarketPlaceOwnOffersEvent = "_-2c-" (String#20524, DoABC#2)
// MarketplaceCancelOfferResultEvent = "_-2jK" (String#20816, DoABC#2)
// MarketPlaceLogic = "_-8V" (String#7832, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IMarketPlaceOfferData = "_-1JA" (String#5225, DoABC#2)
// IMarketPlaceVisualization = "_-2vn" (String#7194, DoABC#2)
// MarketplaceBuyOfferResultParser = "_-2Ro" (String#6602, DoABC#2)
// MarketPlaceOffersParser = "_-Z6" (String#8394, DoABC#2)
// MarketPlaceOwnOffersParser = "_-mo" (String#8656, DoABC#2)
// MarketplaceCancelOfferResultParser = "_-23v" (String#6120, DoABC#2)
// MarketPlaceOffer = "_-1BB" (String#5098, DoABC#2)
// GetMarketplaceConfigurationMessageComposer = "_-K-" (String#23005, DoABC#2)
// MarketPlaceOfferData = "_-2vY" (String#7188, DoABC#2)
// MarketplaceConfirmationDialog = "_-ln" (String#8638, DoABC#2)
// MarketPlaceOfferState = "_-2CX" (String#19506, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// _SafeStr_5427 = "_-au" (String#638, DoABC#2)
// MarketPlaceLogic = "_-1x1" (String#5973, DoABC#2)
// MarketPlaceLogic = "_-2z1" (String#7263, DoABC#2)
// MarketPlaceLogic = "_-1ST" (String#5406, DoABC#2)
// _SafeStr_7291 = "_-00x" (String#1383, DoABC#2)
// _FurniturePresentWidgetHandler = "_-2iw" (String#6930, DoABC#2)
// furniType = "_-26P" (String#6173, DoABC#2)
// timeLeftMinutes = "_-09A" (String#3743, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)
// furniTypeId = "_-2n-" (String#20961, DoABC#2)
// furniCategoryId = "_-0bd" (String#15499, DoABC#2)
// _averagePricePeriod = "_-2nH" (String#1940, DoABC#2)
// averagePricePeriod = "_-0lE" (String#4528, DoABC#2)
// newPrice = "_-0sC" (String#16131, DoABC#2)
// requestedOfferId = "_-1R0" (String#17548, DoABC#2)
// _totalItemsFound = "_-1Om" (String#5330, DoABC#2)
// totalItemsFound = "_-hr" (String#8552, DoABC#2)
// _creditsWaiting = "_-1BM" (String#5102, DoABC#2)
// creditsWaiting = "_-1Ru" (String#5396, DoABC#2)
// _SafeStr_8572 = "_-0Xo" (String#4263, DoABC#2)
// _SafeStr_8573 = "_-1Hw" (String#5205, DoABC#2)


