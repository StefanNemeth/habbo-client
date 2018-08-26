
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.club.ClubBuyController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.club.ClubBuyItem;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.catalog.viewer.ICatalogViewer;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.catalog.viewer.CatalogPage;
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.assets.XmlAsset;

    public class ClubBuyCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _controller:ClubBuyController;
        private var _offers:Array;

        public function ClubBuyCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            if (this._controller != null){
                this._controller.unRegisterVisualization(this);
            };
            this._controller = null;
            this.reset();
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            this._offers = [];
            this.displayMainView();
            this._controller = (page.viewer.catalog as HabboCatalog).getClubBuyController();
            this._controller.MarketPlaceLogic(this);
            this._controller.MarketPlaceLogic();
            return (true);
        }
        private function displayMainView():void
        {
            var _local_1:XML = this.getAssetXML("clubBuyWidget");
            if (((!(_local_1)) || (!(window)))){
                return;
            };
            window.removeChildAt(0);
            if (((((((!(page)) || (!(page.viewer)))) || (!(page.viewer.catalog)))) || (!(page.viewer.catalog.windowManager)))){
                return;
            };
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_1));
        }
        public function reset():void
        {
            var _local_1:ClubBuyItem;
            for each (_local_1 in this._offers) {
                _local_1.dispose();
            };
            this._offers = [];
        }
        public function initClubType(clubType:int):void
        {
            var catalog:HabboCatalog;
            var localization:ICoreLocalizationManager;
            var purse:IPurse;
            var clubDays:int;
            var clubPeriods:int;
            var clubDaysTotal:int;
            if (disposed){
                return;
            };
            var viewer:ICatalogViewer = page.viewer;
            if (viewer){
                catalog = (viewer.catalog as HabboCatalog);
                if (catalog){
                    localization = catalog.localization;
                    purse = catalog.getPurse();
                    if (((purse) && (localization))){
                        clubDays = purse.clubDays;
                        clubPeriods = purse.clubPeriods;
                        clubDaysTotal = ((clubPeriods * 31) + clubDays);
                        localization.registerParameter("catalog.club.buy.remaining.hc", "days", String(clubDaysTotal));
                        localization.registerParameter("catalog.club.buy.remaining.vip", "days", String(clubDaysTotal));
                    };
                };
            };
            try {
                if (_window){
                    switch (clubType){
                        case HabboClubLevelEnum._SafeStr_3942:
                            _window.findChildByName("club_header").caption = "${catalog.club.buy.header.none}";
                            _window.findChildByName("club_info").caption = "${catalog.club.buy.info.none}";
                            _window.findChildByName("club_remaining").visible = false;
                            _window.findChildByName("club_remaining_bg").visible = false;
                            break;
                        case HabboClubLevelEnum._SafeStr_3943:
                            _window.findChildByName("club_header").caption = "${catalog.club.buy.header.hc}";
                            _window.findChildByName("club_info").caption = "${catalog.club.buy.info.hc}";
                            _window.findChildByName("club_remaining").caption = "${catalog.club.buy.remaining.hc}";
                            break;
                        case HabboClubLevelEnum._SafeStr_3939:
                            _window.findChildByName("club_header").caption = "${catalog.club.buy.header.vip}";
                            _window.findChildByName("club_info").caption = "${catalog.club.buy.info.vip}";
                            _window.findChildByName("club_remaining").caption = "${catalog.club.buy.remaining.vip}";
                            this.showClubInfo();
                            break;
                    };
                };
            }
            catch(e:Error) {
                ErrorReportStorage.addDebugData("ClubBuyCatalogWidget", "initClubType - Window not properly constructed!");
            };
            this.initLinks();
        }
        private function initLinks():void
        {
            var _local_1:IWindow;
            if (_window){
                _local_1 = _window.findChildByName("club_link");
                if (_local_1){
                    _local_1.setParamFlag(WindowParam._SafeStr_7434);
                    _local_1.mouseThreshold = 0;
                    _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickLink);
                };
            };
        }
        public function PollSession(offer:ClubBuyOfferData):void
        {
            var target:IItemListWindow;
            var item:ClubBuyItem;
            if (disposed){
                return;
            };
            Logger.log(("Offer: " + [offer.offerId, offer.productCode, offer.price, offer.upgrade, offer.vip, offer.periods, offer.daysLeftAfterPurchase, offer.year, offer.month, offer.day, offer.upgradeHcPeriodToVip]));
            offer.page = page;
            try {
                item = new ClubBuyItem(offer, (page as CatalogPage));
            }
            catch(e:Error) {
                ErrorReportStorage.addDebugData("ClubBuyCatalogWidget", (((("showOffer - new ClubBuyItem(" + String(offer)) + ", ") + String((page as CatalogPage))) + ") crashed!"));
                return;
            };
            if (offer.vip){
                target = (_window.findChildByName("item_list_vip") as IItemListWindow);
            }
            else {
                target = (_window.findChildByName("item_list_hc") as IItemListWindow);
            };
            if (target != null){
                target.addListItem(item.window);
            };
            this._offers.push(item);
        }
        private function onClickLink(_arg_1:WindowMouseEvent):void
        {
            var _local_3:IHabboConfigurationManager;
            var _local_4:String;
            var _local_2:String = IWindow(_arg_1.target).name;
            _local_3 = (page.viewer.catalog as HabboCatalog).configuration;
            switch (_local_2){
                case "club_link":
                    _local_4 = _local_3.getKey("link.format.club", "credits/habboclub");
                    this.openExternalLink(_local_4);
                    return;
            };
        }
        private function openExternalLink(_arg_1:String):void
        {
            var _local_2:IHabboConfigurationManager = (page.viewer.catalog as HabboCatalog).configuration;
            if (_arg_1 != ""){
                page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                HabboWebTools.navigateToURL(_arg_1, "habboMain");
            };
        }
        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        private function showClubInfo():void
        {
            var _local_2:XML;
            var _local_3:IWindow;
            var _local_1:IItemListWindow = (_window.findChildByName("item_list_hc") as IItemListWindow);
            if (_local_1 != null){
                _local_2 = this.getAssetXML("club_buy_info_item");
                _local_3 = page.viewer.catalog.windowManager.buildFromXML(_local_2);
                _local_1.addListItem(_local_3);
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

// displayMainView = "_-1jQ" (String#1749, DoABC#2)
// onExternalLink = "_-022" (String#575, DoABC#2)
// initLinks = "_-34E" (String#7393, DoABC#2)
// onClickLink = "_-2wT" (String#7212, DoABC#2)
// openExternalLink = "_-0kn" (String#823, DoABC#2)
// showClubInfo = "_-46" (String#22382, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IPurse = "_-0GN" (String#3880, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// ClubBuyController = "_-2RB" (String#6584, DoABC#2)
// ClubBuyOfferData = "_-2XP" (String#6709, DoABC#2)
// ICatalogViewer = "_-Ve" (String#8313, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// CatalogPage = "_-0jJ" (String#4486, DoABC#2)
// ClubBuyItem = "_-zp" (String#8878, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// upgrade = "_-2mZ" (String#20944, DoABC#2)
// periods = "_-0cr" (String#15546, DoABC#2)
// daysLeftAfterPurchase = "_-2JK" (String#19782, DoABC#2)
// upgradeHcPeriodToVip = "_-1Gg" (String#17139, DoABC#2)
// initClubType = "_-EO" (String#22787, DoABC#2)
// PollSession = "_-2nW" (String#20980, DoABC#2)
// unRegisterVisualization = "_-3BS" (String#21941, DoABC#2)
// MarketPlaceLogic = "_-2z1" (String#7263, DoABC#2)
// MarketPlaceLogic = "_-1ST" (String#5406, DoABC#2)
// getAssetXML = "_-1XT" (String#364, DoABC#2)
// getClubBuyController = "_-2nZ" (String#20982, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)


