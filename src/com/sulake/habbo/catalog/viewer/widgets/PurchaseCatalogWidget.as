
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.tracking.HabboTracking;

    public class PurchaseCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _SafeStr_10470:XML;
        private var _SafeStr_10471:XML;
        private var _SafeStr_10472:XML;
        private var _SafeStr_10473:XML;
        private var _SafeStr_10474:XML;
        private var _SafeStr_10475:XML;
        private var _SafeStr_10476:IWindowContainer;
        private var _SafeStr_10477:IButtonWindow;
        private var _SafeStr_10478:IButtonWindow;
        private var _SafeStr_10479:IButtonWindow;
        private var _SafeStr_10480:ITextWindow;
        private var _SafeStr_10481:ITextWindow;
        private var _SafeStr_10482:ITextWindow;
        private var _SafeStr_10483:ITextWindow;
        private var _offer:Offer;
        private var _SafeStr_10484:String = "";
        private var _SafeStr_10485:Function;
        private var _session:ISessionDataManager;

        public function PurchaseCatalogWidget(_arg_1:IWindowContainer, _arg_2:ISessionDataManager)
        {
            super(_arg_1);
            this._session = _arg_2;
        }
        override public function dispose():void
        {
            events.removeEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.removeEventListener(WidgetEvent.CWE_SET_EXTRA_PARM, this.onSetParameter);
            events.removeEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE, this.onPurchaseOverride);
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsStub") as XmlAsset);
            if (_local_1 != null){
                this._SafeStr_10470 = (_local_1.content as XML);
            };
            var _local_2:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetPixelsStub") as XmlAsset);
            if (_local_2 != null){
                this._SafeStr_10471 = (_local_2.content as XML);
            };
            var _local_3:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsPixelsStub") as XmlAsset);
            if (_local_3 != null){
                this._SafeStr_10472 = (_local_3.content as XML);
            };
            var _local_4:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsOrCreditsAndPixelsStub") as XmlAsset);
            var _local_5:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyClubStub") as XmlAsset);
            if (_local_5 != null){
                this._SafeStr_10473 = (_local_5.content as XML);
            };
            var _local_6:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset);
            if (_local_6 != null){
                this._SafeStr_10474 = (_local_6.content as XML);
            };
            var _local_7:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset);
            if (_local_7 != null){
                this._SafeStr_10475 = (_local_7.content as XML);
            };
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.addEventListener(WidgetEvent.CWE_SET_EXTRA_PARM, this.onSetParameter);
            events.addEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE, this.onPurchaseOverride);
            events.addEventListener(WidgetEvent.CWE_INIT_PURCHASE, this.initPurchase);
            return (true);
        }
        private function onPurchaseOverride(_arg_1:CatalogWidgetPurchaseOverrideEvent):void
        {
            this._SafeStr_10485 = _arg_1.callback;
        }
        private function attachStub(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IWindowContainer;
            if (this._session.hasUserRight(null, _arg_2)){
                switch (_arg_1){
                    case Offer._SafeStr_4890:
                        _local_3 = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10470) as IWindowContainer);
                        break;
                    case Offer._SafeStr_4891:
                        _local_3 = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10471) as IWindowContainer);
                        break;
                    case Offer._SafeStr_4892:
                        _local_3 = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10472) as IWindowContainer);
                        break;
                    default:
                        Logger.log(("Unknown price-type, can't attach..." + this._offer.priceType));
                };
            }
            else {
                switch (_arg_2){
                    case HabboClubLevelEnum._SafeStr_3943:
                        _local_3 = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10473) as IWindowContainer);
                        break;
                    case HabboClubLevelEnum._SafeStr_3939:
                        if (!this._session.hasUserRight(null, HabboClubLevelEnum._SafeStr_3943)){
                            _local_3 = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10474) as IWindowContainer);
                        }
                        else {
                            _local_3 = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10475) as IWindowContainer);
                        };
                        break;
                };
            };
            if (_local_3 != null){
                if (this._SafeStr_10476 != null){
                    _window.removeChild(this._SafeStr_10476);
                    this._SafeStr_10476.dispose();
                };
                this._SafeStr_10476 = _local_3;
                _window.addChild(_local_3);
                this._SafeStr_10476.x = 0;
                this._SafeStr_10476.y = 0;
            };
            this._SafeStr_10480 = (_window.findChildByName("ctlg_price_credits") as ITextWindow);
            this._SafeStr_10481 = (_window.findChildByName("ctlg_price_pixels") as ITextWindow);
            this._SafeStr_10482 = (_window.findChildByName("ctlg_price_credits_pixels") as ITextWindow);
            this._SafeStr_10483 = (_window.findChildByName("ctlg_special_txt") as ITextWindow);
            this._SafeStr_10477 = (window.findChildByName("ctlg_buy_button") as IButtonWindow);
            this._SafeStr_10479 = (window.findChildByName("ctlg_buy_club_button") as IButtonWindow);
            if (this._SafeStr_10477 != null){
                if (this._SafeStr_10485 != null){
                    this._SafeStr_10477.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this._SafeStr_10485);
                }
                else {
                    this._SafeStr_10477.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this._SafeStr_10485);
                    this._SafeStr_10477.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPurchase);
                };
                this._SafeStr_10477.disable();
            };
            if (this._SafeStr_10479 != null){
                this._SafeStr_10479.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBuyClub);
            };
        }
        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            var _local_4:String;
            var _local_2:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            this._offer = _arg_1.offer;
            this.attachStub(this._offer.priceType, this._offer.clubLevel);
            if (this._SafeStr_10480 != null){
                _local_2.registerParameter("catalog.purchase.price.credits", "credits", String(this._offer.priceInCredits));
                this._SafeStr_10480.caption = "${catalog.purchase.price.credits}";
            };
            var _local_3:String = (((this._offer.activityPointType == ActivityPointTypeEnum.PIXEL)) ? "pixels" : "activitypoints");
            if (this._SafeStr_10481 != null){
                _local_4 = ("catalog.purchase.price.activitypoints." + this._offer.activityPointType);
                _local_2.registerParameter(_local_4, _local_3, this._offer.priceInActivityPoints.toString());
                this._SafeStr_10481.caption = _local_2.getKey(_local_4);
            };
            if (this._SafeStr_10482 != null){
                _local_4 = ("catalog.purchase.price.credits_and_activitypoints." + this._offer.activityPointType);
                _local_2.registerParameter(_local_4, "credits", String(this._offer.priceInCredits));
                _local_2.registerParameter(_local_4, _local_3, String(this._offer.priceInActivityPoints));
                this._SafeStr_10482.caption = _local_2.getKey(_local_4);
            };
            var _local_5:IWindow = _window.findChildByName("activity_points_bg");
            if (_local_5 != null){
                _local_5.color = (((this._offer.activityPointType == 0)) ? 6737151 : 0xCCCCCC);
            };
            if (this._SafeStr_10477 != null){
                this._SafeStr_10477.enable();
            };
        }
        private function onSetParameter(_arg_1:SetExtraPurchaseParameterEvent):void
        {
            this._SafeStr_10484 = _arg_1.parameter;
        }
        private function onPurchase(_arg_1:WindowMouseEvent):void
        {
            if (this._offer != null){
                (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this._offer, page.pageId, this._SafeStr_10484);
            };
        }
        private function initPurchase(_arg_1:CatalogWidgetInitPurchaseEvent):void
        {
            if (this._offer != null){
                (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this._offer, page.pageId, this._SafeStr_10484, _arg_1.enableBuyAsGift);
            };
        }
        private function onBuyClub(_arg_1:WindowMouseEvent):void
        {
            (page.viewer.catalog as HabboCatalog).openCatalogPage(CatalogPageName._SafeStr_5382, true);
            HabboTracking.getInstance().trackEventLog("Catalog", "click", "BUY_CLUB");
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// CWE_SET_EXTRA_PARM = "_-0-B" (String#14018, DoABC#2)
// enableBuyAsGift = "_-2q4" (String#21084, DoABC#2)
// onSelectProduct = "_-qr" (String#463, DoABC#2)
// onPurchase = "_-ku" (String#2174, DoABC#2)
// _SafeStr_10470 = "_-2Ld" (String#19870, DoABC#2)
// _SafeStr_10471 = "_-Ks" (String#23038, DoABC#2)
// _SafeStr_10472 = "_-02Q" (String#14139, DoABC#2)
// _SafeStr_10473 = "_-qt" (String#24309, DoABC#2)
// _SafeStr_10474 = "_-Gk" (String#22879, DoABC#2)
// _SafeStr_10475 = "_-FV" (String#22831, DoABC#2)
// _SafeStr_10476 = "_-0rd" (String#16108, DoABC#2)
// _SafeStr_10477 = "_-1nf" (String#18448, DoABC#2)
// _SafeStr_10478 = "_-2Wf" (String#20310, DoABC#2)
// _SafeStr_10479 = "_-1fl" (String#18126, DoABC#2)
// _SafeStr_10480 = "_-0iY" (String#15774, DoABC#2)
// _SafeStr_10481 = "_-2iO" (String#20783, DoABC#2)
// _SafeStr_10482 = "_-qe" (String#24299, DoABC#2)
// _SafeStr_10483 = "_-CF" (String#22699, DoABC#2)
// _SafeStr_10484 = "_-1D0" (String#16983, DoABC#2)
// _SafeStr_10485 = "_-e6" (String#23807, DoABC#2)
// onSetParameter = "_-10O" (String#16478, DoABC#2)
// onPurchaseOverride = "_-2r6" (String#21123, DoABC#2)
// initPurchase = "_-1yx" (String#18924, DoABC#2)
// attachStub = "_-0AD" (String#14456, DoABC#2)
// onBuyClub = "_-1Nx" (String#17433, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// ActivityPointTypeEnum = "_-11n" (String#16529, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// PurchaseCatalogWidget = "_-2be" (String#6786, DoABC#2)
// CatalogWidgetPurchaseOverrideEvent = "_-0IB" (String#3920, DoABC#2)
// SetExtraPurchaseParameterEvent = "_-2sO" (String#7128, DoABC#2)
// CatalogWidgetInitPurchaseEvent = "_-2yJ" (String#7244, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// _session = "_-32Q" (String#627, DoABC#2)
// _SafeStr_4890 = "_-29q" (String#19397, DoABC#2)
// _SafeStr_4891 = "_-2mH" (String#20930, DoABC#2)
// _SafeStr_4892 = "_-1hh" (String#18198, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// priceType = "_-2ty" (String#7160, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// showPurchaseConfirmation = "_-2zh" (String#21447, DoABC#2)


