
package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferData;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;

    public class ClubBuyController 
    {

        private var _visualization:ClubBuyCatalogWidget;
        private var _catalog:HabboCatalog;
        private var _offers:Array;
        private var _SafeStr_5427:ClubBuyConfirmationDialog;
        private var _disposed:Boolean = false;

        public function ClubBuyController(_arg_1:HabboCatalog)
        {
            this._catalog = _arg_1;
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            if (this._visualization != null){
                this._visualization.dispose();
                this._visualization = null;
            };
            this.reset();
            this.closeConfirmation();
            this._catalog = null;
            this._disposed = true;
        }
        public function reset():void
        {
            var _local_1:ClubBuyOfferData;
            for each (_local_1 in this._offers) {
                _local_1.dispose();
            };
            this._offers = [];
        }
        public function onOffers(_arg_1:HabboClubOffersMessageEvent):void
        {
            var _local_4:ClubBuyOfferData;
            var _local_5:ClubOfferData;
            var _local_6:ClubBuyOfferData;
            var _local_7:ClubBuyOfferData;
            if (this._disposed){
                return;
            };
            var _local_2:HabboClubOffersMessageParser = _arg_1.getParser();
            this.reset();
            var _local_3:int;
            for each (_local_5 in _local_2.offers) {
                _local_6 = new ClubBuyOfferData(_local_5.offerId, _local_5.productCode, _local_5.price, _local_5.upgrade, _local_5.vip, _local_5.periods, _local_5.daysLeftAfterPurchase, _local_5.year, _local_5.month, _local_5.day);
                this._offers.push(_local_6);
                if (_local_5.vip){
                    _local_3++;
                    _local_4 = _local_6;
                };
            };
            if (_local_3 == 1){
                _local_4.upgradeHcPeriodToVip = true;
            };
            this._offers.sort(this.orderByPrecedence);
            if (this._visualization != null){
                this._visualization.reset();
                this._visualization.initClubType(this.getClubType());
                for each (_local_7 in this._offers) {
                    this._visualization.showOffer(_local_7);
                };
            };
        }
        public function unRegisterVisualization(_arg_1:ClubBuyCatalogWidget):void
        {
            if (this._visualization == _arg_1){
                this._visualization = null;
            };
        }
        public function registerVisualization(_arg_1:ClubBuyCatalogWidget):void
        {
            var _local_2:ClubBuyOfferData;
            this._visualization = _arg_1;
            if (this._visualization != null){
                if (((!((this._offers == null))) && ((this._offers.length > 0)))){
                    this._visualization.reset();
                    this._visualization.initClubType(this.getClubType());
                    for each (_local_2 in this._offers) {
                        this._visualization.showOffer(_local_2);
                    };
                };
            };
        }
        public function requestOffers():void
        {
            this._catalog.getHabboClubOffers();
        }
        public function showConfirmation(_arg_1:ClubBuyOfferData, _arg_2:int):void
        {
            this.closeConfirmation();
            this._SafeStr_5427 = new ClubBuyConfirmationDialog(this, _arg_1, _arg_2);
        }
        public function confirmSelection(_arg_1:ClubBuyOfferData, _arg_2:int):void
        {
            if (((!(this._catalog)) || (!(this._catalog.connection)))){
                return;
            };
            this._catalog.purchaseProduct(_arg_2, _arg_1.offerId);
            this.closeConfirmation();
        }
        public function closeConfirmation():void
        {
            if (this._SafeStr_5427){
                this._SafeStr_5427.dispose();
                this._SafeStr_5427 = null;
            };
        }
        public function getClubType():int
        {
            var _local_1:int = HabboClubLevelEnum._SafeStr_3942;
            if (this._catalog.getPurse().hasClubLeft){
                _local_1 = ((this._catalog.getPurse().isVIP) ? HabboClubLevelEnum._SafeStr_3939 : HabboClubLevelEnum._SafeStr_3943);
            };
            return (_local_1);
        }
        public function get hasClub():Boolean
        {
            if (((!(this._catalog)) || (!(this._catalog.getPurse())))){
                return (false);
            };
            return ((this._catalog.getPurse().clubDays > 0));
        }
        public function get windowManager():IHabboWindowManager
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.windowManager);
        }
        public function get localization():ICoreLocalizationManager
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.localization);
        }
        public function get assets():IAssetLibrary
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.assets);
        }
        public function get roomEngine():IRoomEngine
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.roomEngine);
        }
        public function getProductData(_arg_1:String):IProductData
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.getProductData(_arg_1));
        }
        public function getPurse():IPurse
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.getPurse());
        }
        private function orderByPrecedence(_arg_1:ClubBuyOfferData, _arg_2:ClubBuyOfferData):Number
        {
            var _local_3:Number = _arg_1.periods;
            var _local_4:Number = _arg_2.periods;
            if (_local_3 < _local_4){
                return (-1);
            };
            if (_local_3 > _local_4){
                return (1);
            };
            return (0);
        }

    }
}//package com.sulake.habbo.catalog.club

// IProductData = "_-0jc" (String#4494, DoABC#2)
// IPurse = "_-0GN" (String#3880, DoABC#2)
// ClubBuyController = "_-2RB" (String#6584, DoABC#2)
// HabboClubOffersMessageEvent = "_-347" (String#21664, DoABC#2)
// ClubBuyOfferData = "_-2XP" (String#6709, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// ClubBuyConfirmationDialog = "_-Hn" (String#8033, DoABC#2)
// ClubOfferData = "_-0TZ" (String#4170, DoABC#2)
// HabboClubOffersMessageParser = "_-254" (String#6142, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _SafeStr_5427 = "_-au" (String#638, DoABC#2)
// closeConfirmation = "_-2PG" (String#6548, DoABC#2)
// onOffers = "_-1x1" (String#5973, DoABC#2)
// upgrade = "_-2mZ" (String#20944, DoABC#2)
// periods = "_-0cr" (String#15546, DoABC#2)
// daysLeftAfterPurchase = "_-2JK" (String#19782, DoABC#2)
// upgradeHcPeriodToVip = "_-1Gg" (String#17139, DoABC#2)
// orderByPrecedence = "_-Ex" (String#7971, DoABC#2)
// initClubType = "_-EO" (String#22787, DoABC#2)
// getClubType = "_-1u" (String#18715, DoABC#2)
// showOffer = "_-2nW" (String#20980, DoABC#2)
// unRegisterVisualization = "_-3BS" (String#21941, DoABC#2)
// registerVisualization = "_-2z1" (String#7263, DoABC#2)
// requestOffers = "_-1ST" (String#5406, DoABC#2)
// getHabboClubOffers = "_-16e" (String#5009, DoABC#2)
// confirmSelection = "_-fK" (String#23861, DoABC#2)
// purchaseProduct = "_-na" (String#24175, DoABC#2)
// hasClubLeft = "_-1Sl" (String#5409, DoABC#2)


