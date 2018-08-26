
package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.toolbar.IExtensionView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboBasicMembershipExtendOfferComposer;
    import com.sulake.habbo.toolbar.ExtensionFixedSlotsEnum;
    import com.sulake.core.window.components.ITextWindow;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.window.components.IIconWindow;

    public class ClubDiscountPromoExtension 
    {

        private static const _SafeStr_6262:String = "club_promo";
        private static const _SafeStr_5377:int = 13;
        private static const _SafeStr_5378:int = 14;
        private static const _SafeStr_6263:uint = 0xFFFFFF;
        private static const _SafeStr_6264:uint = 12247545;

        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _events:IEventDispatcher;
        private var _config:IHabboConfigurationManager;
        private var _localization:ICoreLocalizationManager;
        private var _inventory:IHabboInventory;
        private var _catalog:IHabboCatalog;
        private var _connection:IConnection;
        private var _extensionView:IExtensionView;
        private var _view:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_6265:IBitmapWrapperWindow;
        private var _SafeStr_6266:Timer;
        private var _SafeStr_6267:int = 0;
        private var _SafeStr_6268:int;
        private var _SafeStr_6269:Timer;
        private var _SafeStr_6270:BitmapData;
        private var _SafeStr_6271:IRegionWindow;

        public function ClubDiscountPromoExtension(_arg_1:HabboToolbar, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IEventDispatcher, _arg_5:IHabboConfigurationManager, _arg_6:ICoreLocalizationManager, _arg_7:IHabboInventory, _arg_8:IHabboCatalog, _arg_9:IConnection)
        {
            this._windowManager = _arg_2;
            this._assets = _arg_3;
            this._events = _arg_4;
            this._config = _arg_5;
            this._localization = _arg_6;
            this._inventory = _arg_7;
            this._catalog = _arg_8;
            this._connection = _arg_9;
            this._extensionView = _arg_1.extensionView;
            if (this._inventory){
                this._inventory.events.addEventListener(HabboInventoryHabboClubEvent.HIHCE_HABBO_CLUB_CHANGED, this.onClubChanged);
            };
        }
        private function createWindow(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager):IWindowContainer
        {
            var _local_5:IAsset;
            var _local_3:IWindowContainer;
            var _local_4:XmlAsset = (_arg_1.getAssetByName("club_discount_promotion_xml") as XmlAsset);
            if (_local_4){
                _local_3 = (_arg_2.buildFromXML((_local_4.content as XML), 1) as IWindowContainer);
                if (_local_3){
                    this._SafeStr_6265 = (_local_3.findChildByName("flashing_animation") as IBitmapWrapperWindow);
                    if (this._SafeStr_6265){
                        _local_5 = (this._assets.getAssetByName("extend_hilite_png") as IAsset);
                        if (_local_5){
                            this._SafeStr_6270 = (_local_5.content as BitmapData);
                            if (this._SafeStr_6270){
                                this._SafeStr_6265.bitmap = this._SafeStr_6270.clone();
                            };
                        };
                        this._SafeStr_6265.visible = false;
                    };
                    this._SafeStr_6271 = (_local_3.findChildByName("text_region") as IRegionWindow);
                    if (this._SafeStr_6271){
                        this._SafeStr_6271.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTextRegionClicked);
                        this._SafeStr_6271.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onTextRegionMouseOver);
                        this._SafeStr_6271.addEventListener(WindowMouseEvent.WME_OUT, this.onTextRegionMouseOut);
                    };
                    this.assignState();
                };
            };
            return (_local_3);
        }
        private function destroyWindow():void
        {
            if (this._view){
                this._view.dispose();
                this._view = null;
                this._SafeStr_6265 = null;
            };
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._extensionView){
                    this._extensionView.ExtensionView(_SafeStr_6262);
                    this._extensionView = null;
                };
                this.animate(false);
                this.clearAnimation();
                this.destroyWindow();
                if (this._inventory){
                    this._inventory.events.removeEventListener(HabboInventoryHabboClubEvent.HIHCE_HABBO_CLUB_CHANGED, this.onClubChanged);
                    this._inventory = null;
                };
                this._catalog = null;
                this._localization = null;
                this._config = null;
                this._assets = null;
                this._events = null;
                this._disposed = true;
            };
        }
        private function onTextRegionClicked(_arg_1:WindowMouseEvent):void
        {
            if (this._connection){
                if (this._inventory.clubLevel == HabboClubLevelEnum._SafeStr_3939){
                    this._connection.send(new EventLogMessageComposer("DiscountPromo", "discount", "client.club.extend.discount.clicked"));
                    this._connection.send(new GetHabboClubExtendOfferMessageComposer());
                };
                if (this._inventory.clubLevel == HabboClubLevelEnum._SafeStr_3943){
                    this._connection.send(new EventLogMessageComposer("DiscountPromo", "discount", "client.club.extend.basic.discount.clicked"));
                    this._connection.send(new GetHabboBasicMembershipExtendOfferComposer());
                };
            };
        }
        private function assignState():void
        {
            switch (this._inventory.clubLevel){
                case HabboClubLevelEnum._SafeStr_3942:
                    this.CurrencyIndicatorBase(this._localization.getKey("discount.bar.no.club.promo"));
                    this.ClubGiftNotification(_SafeStr_5378);
                    break;
                case HabboClubLevelEnum._SafeStr_3943:
                    this.CurrencyIndicatorBase(this._localization.getKey("discount.bar.hc.expiring", "Save 5 cr by extending your HC subscription now!"));
                    this.ClubGiftNotification(_SafeStr_5377);
                    break;
                case HabboClubLevelEnum._SafeStr_3939:
                    this.CurrencyIndicatorBase(this._localization.getKey("discount.bar.vip.expiring", "Save 5 cr by extending your VIP subscription now!"));
                    this.ClubGiftNotification(_SafeStr_5378);
                    break;
            };
            this.animate(true);
        }
        private function onClubChanged(_arg_1:HabboInventoryHabboClubEvent):void
        {
            if (((((this._inventory.clubIsExpiring) && (!(this._view)))) && (this.isExtensionEnabled()))){
                this._view = this.createWindow(this._assets, this._windowManager);
                this.assignState();
                this._extensionView.ExtensionView(_SafeStr_6262, this._view, ExtensionFixedSlotsEnum._SafeStr_6282);
            }
            else {
                this._extensionView.ExtensionView(_SafeStr_6262);
                this.destroyWindow();
            };
        }
        private function isExtensionEnabled():Boolean
        {
            if ((((this._inventory.clubLevel == HabboClubLevelEnum._SafeStr_3939)) && (this._config.getBoolean("club.membership.extend.vip.promotion.enabled", false)))){
                return (true);
            };
            if ((((this._inventory.clubLevel == HabboClubLevelEnum._SafeStr_3943)) && (this._config.getBoolean("club.membership.extend.basic.promotion.enabled", false)))){
                return (true);
            };
            return (false);
        }
        private function CurrencyIndicatorBase(_arg_1:String):void
        {
            var _local_2:ITextWindow;
            var _local_3:ITextWindow;
            if (this._view){
                _local_2 = (this._view.findChildByName("promo_text") as ITextWindow);
                _local_3 = (this._view.findChildByName("promo_text_shadow") as ITextWindow);
                if (_local_2){
                    _local_2.text = _arg_1;
                };
                if (_local_3){
                    _local_3.text = _arg_1;
                };
            };
        }
        private function animate(_arg_1:Boolean):void
        {
            if (_arg_1){
                Logger.log("Animate window");
                if (this._SafeStr_6269){
                    this._SafeStr_6269.stop();
                };
                this._SafeStr_6269 = new Timer(15000);
                this._SafeStr_6269.addEventListener(TimerEvent.TIMER, this.onTriggerTimer);
                this._SafeStr_6269.start();
            }
            else {
                if (this._SafeStr_6269){
                    this._SafeStr_6269.stop();
                    this._SafeStr_6269 = null;
                };
                this.clearAnimation();
            };
        }
        private function clearAnimation():void
        {
            if (this._SafeStr_6265){
                this._SafeStr_6265.visible = false;
                this._SafeStr_6265.bitmap = null;
                this._view.invalidate();
                if (this._SafeStr_6266){
                    this._SafeStr_6266.stop();
                    this._SafeStr_6266 = null;
                };
            };
        }
        private function onTriggerTimer(_arg_1:TimerEvent):void
        {
            if (this._SafeStr_6265){
                if (this._SafeStr_6265.context){
                    this._SafeStr_6265.visible = true;
                    this.resetAnimationVariables();
                    this.startAnimationTimer();
                };
            };
        }
        private function resetAnimationVariables():void
        {
            this._SafeStr_6265.x = 3;
            this._SafeStr_6265.y = 3;
            this._SafeStr_6265.bitmap = this._SafeStr_6270.clone();
            this._SafeStr_6265.height = (this._view.height - 6);
            this._SafeStr_6265.width = this._SafeStr_6265.bitmap.width;
            this._SafeStr_6265.invalidate();
            this._SafeStr_6268 = ((this._view.width - 7) - this._SafeStr_6265.bitmap.width);
            this._SafeStr_6267 = 0;
        }
        private function startAnimationTimer():void
        {
            this._SafeStr_6266 = new Timer(25, 26);
            this._SafeStr_6266.addEventListener(TimerEvent.TIMER, this.CurrencyIndicatorBase);
            this._SafeStr_6266.addEventListener(TimerEvent.TIMER_COMPLETE, this.CurrencyIndicatorBase);
            this._SafeStr_6266.start();
        }
        private function CurrencyIndicatorBase(_arg_1:TimerEvent):void
        {
            var _local_2:int;
            var _local_3:BitmapData;
            this._SafeStr_6265.x = (3 + ((this._SafeStr_6267 / 20) * this._SafeStr_6268));
            if (this._SafeStr_6265.x > this._SafeStr_6268){
                _local_2 = ((this._view.width - 4) - this._SafeStr_6265.x);
                _local_3 = new BitmapData(_local_2, this._SafeStr_6270.height);
                _local_3.copyPixels(this._SafeStr_6270, new Rectangle(0, 0, _local_2, this._SafeStr_6270.height), new Point(0, 0));
                this._SafeStr_6265.bitmap = _local_3;
                this._SafeStr_6265.width = _local_2;
            };
            this._SafeStr_6265.invalidate();
            this._SafeStr_6267++;
        }
        private function CurrencyIndicatorBase(_arg_1:TimerEvent):void
        {
            this.clearAnimation();
        }
        private function ClubGiftNotification(_arg_1:int):void
        {
            var _local_2:IIconWindow;
            if (this._view){
                _local_2 = (this._view.findChildByName("club_icon") as IIconWindow);
                if (_local_2){
                    _local_2.style = _arg_1;
                    _local_2.invalidate();
                };
            };
        }
        private function onTextRegionMouseOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow;
            if (this._view){
                _local_2 = (this._view.findChildByName("promo_text") as ITextWindow);
                _local_2.textColor = _SafeStr_6264;
            };
        }
        private function onTextRegionMouseOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow;
            if (this._view){
                _local_2 = (this._view.findChildByName("promo_text") as ITextWindow);
                _local_2.textColor = _SafeStr_6263;
            };
        }

    }
}//package com.sulake.habbo.toolbar.extensions

// GetHabboClubExtendOfferMessageComposer = "_-1U7" (String#17671, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IExtensionView = "_-1z2" (String#6016, DoABC#2)
// ClubDiscountPromoExtension = "_-38a" (String#7484, DoABC#2)
// ExtensionFixedSlotsEnum = "_-0tc" (String#16185, DoABC#2)
// HabboInventoryHabboClubEvent = "_-0Pe" (String#15048, DoABC#2)
// GetHabboBasicMembershipExtendOfferComposer = "_-0yV" (String#16373, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// clubIsExpiring = "_-0Gw" (String#3893, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// _SafeStr_5377 = "_-0wg" (String#1581, DoABC#2)
// _SafeStr_5378 = "_-374" (String#2003, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// HIHCE_HABBO_CLUB_CHANGED = "_-36p" (String#21757, DoABC#2)
// onClubChanged = "_-0NQ" (String#1461, DoABC#2)
// ClubGiftNotification = "_-1YR" (String#1707, DoABC#2)
// clearAnimation = "_-16P" (String#5001, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// _SafeStr_6262 = "_-FZ" (String#7985, DoABC#2)
// _SafeStr_6263 = "_-W7" (String#2122, DoABC#2)
// _SafeStr_6264 = "_-xC" (String#2222, DoABC#2)
// _SafeStr_6265 = "_-0ah" (String#15462, DoABC#2)
// _SafeStr_6266 = "_-0bu" (String#4344, DoABC#2)
// _SafeStr_6267 = "_-3H9" (String#22169, DoABC#2)
// _SafeStr_6268 = "_-qg" (String#24301, DoABC#2)
// _SafeStr_6269 = "_-34V" (String#21677, DoABC#2)
// _SafeStr_6270 = "_-Lv" (String#23078, DoABC#2)
// _SafeStr_6271 = "_-2N5" (String#6502, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// onTextRegionClicked = "_-0MF" (String#4006, DoABC#2)
// onTextRegionMouseOver = "_-0iI" (String#4469, DoABC#2)
// onTextRegionMouseOut = "_-mG" (String#8648, DoABC#2)
// assignState = "_-2wt" (String#21342, DoABC#2)
// destroyWindow = "_-1pr" (String#5854, DoABC#2)
// ExtensionView = "_-gb" (String#8524, DoABC#2)
// animate = "_-2u9" (String#21245, DoABC#2)
// isExtensionEnabled = "_-0nb" (String#15960, DoABC#2)
// ExtensionView = "_-01F" (String#3587, DoABC#2)
// _SafeStr_6282 = "_-3GU" (String#22141, DoABC#2)
// onTriggerTimer = "_-1cR" (String#17988, DoABC#2)
// resetAnimationVariables = "_-1aI" (String#17907, DoABC#2)
// startAnimationTimer = "_-1VP" (String#17715, DoABC#2)
// CurrencyIndicatorBase = "_-1j1" (String#5735, DoABC#2)
// CurrencyIndicatorBase = "_-2Lp" (String#6480, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)


