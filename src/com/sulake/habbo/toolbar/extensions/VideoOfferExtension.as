
package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.toolbar.HabboToolbar;
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
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.toolbar.ExtensionFixedSlotsEnum;

    public class VideoOfferExtension 
    {

        private static const _SafeStr_6262:String = "video_offer";
        private static const _SafeStr_6288:String = "supersaverAdsOnCampaignsReady";
        private static const _SafeStr_6289:String = "supersaverAdsOnCampaignCompleted";
        private static const _SafeStr_6290:String = "supersaverAdsOnCampaignOpen";
        private static const _SafeStr_6291:String = "supersaverAdsOnCampaignClose";
        private static const _SafeStr_6292:String = "supersaverAdsLoadCampaigns";
        private static const _SafeStr_6293:String = "supersaverAdsCamapaignEngage";
        private static const _SafeStr_6263:uint = 0xFFFFFF;
        private static const _SafeStr_6264:uint = 12247545;
        private static const _SafeStr_6294:uint = 0x666666;
        private static const _SafeStr_6295:uint = 0xCCCCCC;

        private var _SafeStr_6296:HabboToolbar;
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
        private var _SafeStr_6271:IRegionWindow;
        private var _SafeStr_6297:IIconWindow;
        private var _volume:Number = -1;
        private var _SafeStr_6298:Boolean = false;
        private var _SafeStr_6299:int = 0;
        private var _SafeStr_6300:int = 0;

        public function VideoOfferExtension(_arg_1:HabboToolbar, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IEventDispatcher, _arg_5:IHabboConfigurationManager, _arg_6:ICoreLocalizationManager, _arg_7:IHabboInventory, _arg_8:IHabboCatalog, _arg_9:IConnection)
        {
            this._windowManager = _arg_2;
            this._assets = _arg_3;
            this._events = _arg_4;
            this._config = _arg_5;
            this._localization = _arg_6;
            this._inventory = _arg_7;
            this._catalog = _arg_8;
            this._connection = _arg_9;
            this._SafeStr_6296 = _arg_1;
            this._extensionView = _arg_1.extensionView;
            if (this._inventory){
                this._inventory.events.addEventListener(HabboInventoryHabboClubEvent.HIHCE_HABBO_CLUB_CHANGED, this.onClubChanged);
            };
        }
        private function onClubChanged(_arg_1:HabboInventoryHabboClubEvent):void
        {
            if (((((this._inventory.clubIsExpiring) && (!(this._view)))) && (this.isClubExtensionEnabled()))){
                this._extensionView.detachExtension(_SafeStr_6262);
                this.destroyWindow();
                return;
            };
            if (((((ExternalInterface.available) && (!(this._SafeStr_6298)))) && (!(this._view)))){
                ExternalInterface.addCallback(_SafeStr_6288, this.onCampaignsReady);
                ExternalInterface.addCallback(_SafeStr_6289, this.onCampaignComplete);
                ExternalInterface.addCallback(_SafeStr_6290, this.onCampaignOpen);
                ExternalInterface.addCallback(_SafeStr_6291, this.onCampaignClose);
                ExternalInterface.call(_SafeStr_6292);
            };
        }
        private function isClubExtensionEnabled():Boolean
        {
            if ((((((this._inventory.clubLevel == HabboClubLevelEnum._SafeStr_3939)) && (this._config.getBoolean("club.membership.extend.vip.promotion.enabled", false)))) || ((((this._inventory.clubLevel == HabboClubLevelEnum._SafeStr_3943)) && (this._config.getBoolean("club.membership.extend.basic.promotion.enabled", false)))))){
                return (true);
            };
            return (false);
        }
        private function onCampaignsReady(_arg_1:String):void
        {
            this._SafeStr_6299 = parseInt(_arg_1);
            if (isNaN(this._SafeStr_6299)){
                this._SafeStr_6299 = 0;
            };
            if ((((((this._SafeStr_6299 <= 0)) || (this._SafeStr_6298))) || (((this._inventory.clubIsExpiring) && (this.isClubExtensionEnabled()))))){
                if (this._view){
                    this.destroyWindow();
                };
                return;
            };
            if (!this._view){
                this._view = this.createWindow(this._assets, this._windowManager);
            };
        }
        private function onCampaignOpen():void
        {
        }
        private function onCampaignClose():void
        {
            this.turnVolumeUp();
            if (this._connection){
                this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.close"));
            };
        }
        private function onCampaignComplete():void
        {
            this.turnVolumeUp();
            if (this._connection){
                this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.complete"));
            };
        }
        private function createWindow(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager):IWindowContainer
        {
            var _local_5:String;
            var _local_6:ITextWindow;
            var _local_7:ITextWindow;
            var _local_8:BitmapDataAsset;
            var _local_9:BitmapData;
            var _local_10:IBitmapWrapperWindow;
            var _local_3:IWindowContainer;
            var _local_4:XmlAsset = (_arg_1.getAssetByName("video_offer_promotion_xml") as XmlAsset);
            if (_local_4){
                _local_3 = (_arg_2.buildFromXML((_local_4.content as XML), 1) as IWindowContainer);
                if (_local_3){
                    _local_5 = this._localization.getKey("supersaverads.video.promo.offer", "Watch a video and earn a credit!");
                    _local_6 = (_local_3.findChildByName("promo_text") as ITextWindow);
                    _local_7 = (_local_3.findChildByName("promo_text_shadow") as ITextWindow);
                    if (_local_6){
                        _local_6.text = _local_5;
                    };
                    if (_local_7){
                        _local_7.text = _local_5;
                    };
                    _local_8 = (this._assets.getAssetByName("offer_icon_png") as BitmapDataAsset);
                    if (_local_8 != null){
                        _local_9 = (_local_8.content as BitmapData);
                        _local_10 = (_local_3.findChildByName("promo_icon") as IBitmapWrapperWindow);
                        if (((!((_local_9 == null))) && (!((_local_10 == null))))){
                            _local_10.bitmap = new BitmapData(_local_10.width, _local_10.height, true, 0);
                            _local_10.bitmap.copyPixels(_local_9, _local_9.rect, new Point(0, 0));
                        };
                    };
                    this._SafeStr_6271 = (_local_3.findChildByName("text_region") as IRegionWindow);
                    if (this._SafeStr_6271){
                        this._SafeStr_6271.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTextRegionClicked);
                        this._SafeStr_6271.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onTextRegionMouseOver);
                        this._SafeStr_6271.addEventListener(WindowMouseEvent.WME_OUT, this.onTextRegionMouseOut);
                    };
                    this._SafeStr_6297 = (_local_3.findChildByName("promo_close_icon") as IIconWindow);
                    if (this._SafeStr_6297){
                        this._SafeStr_6297.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCloseClicked);
                        this._SafeStr_6297.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onCloseMouseOver);
                        this._SafeStr_6297.addEventListener(WindowMouseEvent.WME_OUT, this.onCloseMouseOut);
                    };
                    this._extensionView.attachExtension(_SafeStr_6262, _local_3, ExtensionFixedSlotsEnum._SafeStr_6282);
                };
            };
            return (_local_3);
        }
        private function destroyWindow():void
        {
            if (this._view){
                if (this._SafeStr_6271){
                    this._SafeStr_6271.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTextRegionClicked);
                    this._SafeStr_6271.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onTextRegionMouseOver);
                    this._SafeStr_6271.removeEventListener(WindowMouseEvent.WME_OUT, this.onTextRegionMouseOut);
                    this._SafeStr_6271 = null;
                };
                if (this._SafeStr_6297){
                    this._SafeStr_6297.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCloseClicked);
                    this._SafeStr_6297.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onCloseMouseOver);
                    this._SafeStr_6297.removeEventListener(WindowMouseEvent.WME_OUT, this.onCloseMouseOut);
                    this._SafeStr_6297 = null;
                };
                this._view.dispose();
                this._view = null;
            };
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._extensionView){
                    this._extensionView.detachExtension(_SafeStr_6262);
                    this._extensionView = null;
                };
                this.destroyWindow();
                if (ExternalInterface.available){
                    ExternalInterface.addCallback(_SafeStr_6288, null);
                    ExternalInterface.addCallback(_SafeStr_6289, null);
                    ExternalInterface.addCallback(_SafeStr_6290, null);
                    ExternalInterface.addCallback(_SafeStr_6291, null);
                };
                if (this._inventory){
                    this._inventory.events.removeEventListener(HabboInventoryHabboClubEvent.HIHCE_HABBO_CLUB_CHANGED, this.onClubChanged);
                    this._inventory = null;
                };
                this._SafeStr_6296 = null;
                this._inventory = null;
                this._catalog = null;
                this._localization = null;
                this._config = null;
                this._assets = null;
                this._events = null;
                this._disposed = true;
            };
        }
        private function onCloseClicked(_arg_1:WindowMouseEvent):void
        {
            this._SafeStr_6298 = true;
            this.destroyWindow();
            if (this._connection){
                this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.close_clicked"));
            };
        }
        private function onCloseMouseOver(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_6297){
                this._SafeStr_6297.color = _SafeStr_6295;
            };
        }
        private function onCloseMouseOut(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_6297){
                this._SafeStr_6297.color = _SafeStr_6294;
            };
        }
        private function onTextRegionClicked(_arg_1:WindowMouseEvent):void
        {
            if (ExternalInterface.available){
                this._SafeStr_6300 = (this._SafeStr_6300 + 1);
                ExternalInterface.call(_SafeStr_6293);
                this.turnVolumeDown();
                if (this._connection){
                    this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.launched"));
                };
            };
            if (this._SafeStr_6299 == this._SafeStr_6300){
                this.destroyWindow();
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
        private function turnVolumeDown():void
        {
            if (this._SafeStr_6296.soundManager){
                this._volume = this._SafeStr_6296.soundManager.volume;
                this._SafeStr_6296.soundManager.volume = 0;
            };
        }
        private function turnVolumeUp():void
        {
            if (((this._SafeStr_6296.soundManager) && (!((this._volume == -1))))){
                this._SafeStr_6296.soundManager.volume = this._volume;
            };
        }

    }
}//package com.sulake.habbo.toolbar.extensions

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IExtensionView = "_-1z2" (String#6016, DoABC#2)
// VideoOfferExtension = "_-2EP" (String#6331, DoABC#2)
// ExtensionFixedSlotsEnum = "_-0tc" (String#16185, DoABC#2)
// HabboInventoryHabboClubEvent = "_-0Pe" (String#15048, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// clubIsExpiring = "_-0Gw" (String#3893, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// HIHCE_HABBO_CLUB_CHANGED = "_-36p" (String#21757, DoABC#2)
// onClubChanged = "_-0NQ" (String#1461, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// _SafeStr_6262 = "_-FZ" (String#7985, DoABC#2)
// _SafeStr_6263 = "_-W7" (String#2122, DoABC#2)
// _SafeStr_6264 = "_-xC" (String#2222, DoABC#2)
// _SafeStr_6271 = "_-2N5" (String#6502, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// onTextRegionClicked = "_-0MF" (String#4006, DoABC#2)
// onTextRegionMouseOver = "_-0iI" (String#4469, DoABC#2)
// onTextRegionMouseOut = "_-mG" (String#8648, DoABC#2)
// destroyWindow = "_-1pr" (String#5854, DoABC#2)
// detachExtension = "_-gb" (String#8524, DoABC#2)
// attachExtension = "_-01F" (String#3587, DoABC#2)
// _SafeStr_6282 = "_-3GU" (String#22141, DoABC#2)
// _SafeStr_6288 = "_-1Mu" (String#17396, DoABC#2)
// _SafeStr_6289 = "_-2xw" (String#21389, DoABC#2)
// _SafeStr_6290 = "_-1kq" (String#18324, DoABC#2)
// _SafeStr_6291 = "_-2P-" (String#20001, DoABC#2)
// _SafeStr_6292 = "_-3EJ" (String#22049, DoABC#2)
// _SafeStr_6293 = "_-10Z" (String#16485, DoABC#2)
// _SafeStr_6294 = "_-0r9" (String#16092, DoABC#2)
// _SafeStr_6295 = "_-Cc" (String#22709, DoABC#2)
// _SafeStr_6296 = "_-1UJ" (String#5438, DoABC#2)
// _SafeStr_6297 = "_-22b" (String#19115, DoABC#2)
// _SafeStr_6298 = "_-Vt" (String#23488, DoABC#2)
// _SafeStr_6299 = "_-0zy" (String#16425, DoABC#2)
// _SafeStr_6300 = "_-2Kd" (String#19829, DoABC#2)
// isClubExtensionEnabled = "_-0rq" (String#16115, DoABC#2)
// onCampaignsReady = "_-12b" (String#16563, DoABC#2)
// onCampaignComplete = "_-24B" (String#19184, DoABC#2)
// onCampaignOpen = "_-0r5" (String#16089, DoABC#2)
// onCampaignClose = "_-V-" (String#23447, DoABC#2)
// turnVolumeUp = "_-A4" (String#22621, DoABC#2)
// onCloseClicked = "_-1Aj" (String#16890, DoABC#2)
// onCloseMouseOver = "_-1v8" (String#18762, DoABC#2)
// onCloseMouseOut = "_-3Hn" (String#22193, DoABC#2)
// turnVolumeDown = "_-2j4" (String#20809, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)


