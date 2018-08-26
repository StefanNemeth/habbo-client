
package com.sulake.habbo.ui.widget.furniture.teaser
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTeaserDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetViralFurniMessage;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetConversionPointMessage;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class TeaserFurniWidget extends RoomWidgetBase 
    {

        private const _SafeStr_5960:int = 0;
        private const _SafeStr_5961:int = 1;
        private const _SafeStr_5962:int = 2;
        private const _SafeStr_5963:int = 3;
        private const _SafeStr_5964:int = 4;
        private const _SafeStr_5965:int = 0;
        private const _SafeStr_5966:int = 1;
        private const _SafeStr_5967:int = 2;
        private const _SafeStr_5968:int = 3;
        private const _SafeStr_5969:int = 4;
        private const _SafeStr_5970:int = 5;
        private const _SafeStr_5971:String = "deco_img";
        private const _SafeStr_5972:String = "dialog_bg";
        private const _SafeStr_5973:String = "%campaign%_dialog_bg.png";
        private const _SafeStr_5974:String = "%campaign%_gift_package.png";
        private const _SafeStr_5975:String = "%campaign%_gift_content.png";
        private const _SafeStr_5976:String = "%campaign%_friend_gift_package.png";

        private var _habboConfiguration:IHabboConfigurationManager;
        private var _inventory:IHabboInventory;
        private var _window:IFrameWindow;
        private var _SafeStr_5978:int = -1;
        private var _status:int = -1;
        private var _shareId:String;
        private var _objectId:int = -1;
        private var _SafeStr_5979:Array;
        private var _SafeStr_5980:String;
        private var _campaignID:String;
        private var _itemCategory:int = 0;

        public function TeaserFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboConfigurationManager, _arg_6:IHabboInventory)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._habboConfiguration = _arg_5;
            this._inventory = _arg_6;
            this._SafeStr_5979 = new Array();
            this._SafeStr_5980 = this._habboConfiguration.getKey("image.library.url", "http://images.habbo.com/c_images/");
            this._SafeStr_5980 = (this._SafeStr_5980 + "Viral/");
        }
        override public function dispose():void
        {
            var _local_2:ImageDownloader;
            if (disposed){
                return;
            };
            this.hideInterface();
            if (((!((this._window == null))) && (!(this._window.disposed)))){
                this._window.dispose();
                this._window = null;
            };
            var _local_1:int;
            while (_local_1 < this._SafeStr_5979.length) {
                _local_2 = this._SafeStr_5979.pop();
                _local_2.dispose();
                _local_1++;
            };
            this._habboConfiguration = null;
            super.dispose();
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetTeaserDataUpdateEvent.RWTDUE_TEASER_DATA, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetTeaserDataUpdateEvent.RWTDUE_GIFT_DATA, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetTeaserDataUpdateEvent.RWTDUE_GIFT_RECEIVED, this.onObjectUpdate);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetTeaserDataUpdateEvent.RWTDUE_TEASER_DATA, this.onObjectUpdate);
        }
        private function onObjectUpdate(_arg_1:RoomWidgetTeaserDataUpdateEvent):void
        {
            var _local_2:int;
            var _local_4:String;
            var _local_5:Boolean;
            var _local_3:String = _arg_1.campaignID;
            switch (_arg_1.type){
                case RoomWidgetTeaserDataUpdateEvent.RWTDUE_TEASER_DATA:
                    _local_2 = this._SafeStr_5960;
                    this._shareId = null;
                    break;
                case RoomWidgetTeaserDataUpdateEvent.RWTDUE_GIFT_RECEIVED:
                    _local_4 = _arg_1.firstClickUserName;
                    _local_5 = _arg_1.giftWasReceived;
                    if (_local_5){
                        if (((_local_4) && (!((_local_4 == ""))))){
                            _local_2 = this._SafeStr_5963;
                            _localizations.registerParameter("widget.furni.teaser.notify.unlocked.desc", "username", _local_4);
                        }
                        else {
                            _local_2 = this._SafeStr_5962;
                        };
                    }
                    else {
                        _local_2 = this._SafeStr_5964;
                    };
                    this._shareId = null;
                    this._itemCategory = _arg_1.itemCategory;
                    break;
                case RoomWidgetTeaserDataUpdateEvent.RWTDUE_GIFT_DATA:
                    _local_2 = this._SafeStr_5961;
                    this._objectId = _arg_1.objectId;
                    this._shareId = _arg_1.data;
                    this._status = _arg_1.status;
                    this._itemCategory = _arg_1.itemCategory;
                    _localizations.registerParameter("notifications.viral_furni.fb.title", "realname", _arg_1.ownRealName);
                    _localizations.registerParameter("notifications.viral_furni.fb.desc", "realname", _arg_1.ownRealName);
                    _localizations.registerParameter("widget.furni.teaser.gift.unlocked.desc", "username", _arg_1.firstClickUserName);
                    break;
                default:
                    Logger.log(("Error, invalid viral widget update message: " + _arg_1.type));
            };
            if (((this._window) && (((!((this._SafeStr_5978 == _local_2))) || (!((_local_3 == this._campaignID))))))){
                this._window.dispose();
                this._window = null;
            };
            this._campaignID = _local_3;
            this._SafeStr_5978 = _local_2;
            this.mainWindow;
            this.showInterface();
        }
        override public function get mainWindow():IWindow
        {
            var _local_1:XmlAsset;
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:ITextWindow;
            var _local_7:IWindow;
            if (this._SafeStr_5978 == -1){
                return (null);
            };
            if (!this._window){
                switch (this._SafeStr_5978){
                    case this._SafeStr_5960:
                        _local_1 = (assets.getAssetByName("notification_teaser") as XmlAsset);
                        _local_2 = this._SafeStr_5974;
                        this.RoomSession("viral_val11", "client.show.teaser");
                        break;
                    case this._SafeStr_5961:
                        if (this._status == this._SafeStr_5965){
                            _local_1 = (assets.getAssetByName("notification_gift_locked") as XmlAsset);
                            this.RoomSession(("viral_" + this._campaignID), "client.show.locked");
                            _local_2 = this._SafeStr_5974;
                        }
                        else {
                            if (this._status == this._SafeStr_5966){
                                _local_1 = (assets.getAssetByName("notification_gift_unlocked") as XmlAsset);
                                this.RoomSession(("viral_" + this._campaignID), "client.show.unlocked");
                                _local_2 = this._SafeStr_5975;
                            }
                            else {
                                if (this._status == this._SafeStr_5967){
                                    _local_1 = (assets.getAssetByName("notification_gift_alert") as XmlAsset);
                                    this.RoomSession(("viral_" + this._campaignID), "client.show.no_fb");
                                    _local_3 = _localizations.getKey("widget.furni.teaser.gift.no_fb.title");
                                    _local_4 = _localizations.getKey("widget.furni.teaser.gift.no_fb.desc");
                                    _local_2 = this._SafeStr_5974;
                                }
                                else {
                                    if (this._status == this._SafeStr_5968){
                                        _local_1 = (assets.getAssetByName("notification_gift_alert") as XmlAsset);
                                        this.RoomSession(("viral_" + this._campaignID), "client.show.not_enough_fb_friends");
                                        _local_3 = _localizations.getKey("widget.furni.teaser.gift.no_spam.title");
                                        _local_4 = _localizations.getKey("widget.furni.teaser.gift.no_spam.desc");
                                        _local_2 = this._SafeStr_5974;
                                    }
                                    else {
                                        if (this._status == this._SafeStr_5969){
                                            _local_1 = (assets.getAssetByName("notification_gift_alert") as XmlAsset);
                                            this.RoomSession(("viral_" + this._campaignID), "client.show.not_enough_fb_friends");
                                            _local_3 = _localizations.getKey("widget.furni.teaser.gift.no_min_fb_friends.title");
                                            _local_4 = _localizations.getKey("widget.furni.teaser.gift.no_min_fb_friends.desc");
                                            _local_2 = this._SafeStr_5974;
                                        }
                                        else {
                                            if (this._status == this._SafeStr_5970){
                                                _local_1 = (assets.getAssetByName("notification_gift_alert") as XmlAsset);
                                                this.RoomSession(("viral_" + this._campaignID), "client.show.campaign_closed");
                                                _local_3 = _localizations.getKey("widget.furni.teaser.gift.campaign_closed.title", "widget.furni.teaser.gift.campaign_closed.title");
                                                _local_4 = _localizations.getKey("widget.furni.teaser.gift.campaign_closed.desc", "widget.furni.teaser.gift.campaign_closed.desc");
                                                _local_2 = this._SafeStr_5974;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        break;
                    case this._SafeStr_5962:
                        _local_1 = (assets.getAssetByName("notification_gift_received") as XmlAsset);
                        _local_2 = this._SafeStr_5976;
                        break;
                    case this._SafeStr_5963:
                        _local_1 = (assets.getAssetByName("notification_gift_unlocked_notify") as XmlAsset);
                        _local_2 = this._SafeStr_5974;
                        break;
                    case this._SafeStr_5964:
                        _local_1 = (assets.getAssetByName("notification_gift_alert") as XmlAsset);
                        _local_3 = _localizations.getKey("widget.furni.teaser.gift.campaign_closed.title", "widget.furni.teaser.gift.campaign_closed.title");
                        _local_4 = _localizations.getKey("widget.furni.teaser.gift.campaign_closed.desc", "widget.furni.teaser.gift.campaign_closed.desc");
                        break;
                };
                if (_local_1 == null){
                    return (null);
                };
                this._window = (windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
                this._window.header.controls.visible = false;
                this._window.center();
                this._window.visible = false;
                _local_5 = this._SafeStr_5973.replace("%campaign%", this._campaignID);
                this.TeaserFurniWidget(_local_5, this._SafeStr_5972);
                _local_2 = _local_2.replace("%campaign%", this._campaignID);
                this.TeaserFurniWidget(_local_2, this._SafeStr_5971);
                if (_local_3){
                    _local_6 = (this._window.findChildByName("alert_title") as ITextWindow);
                    _local_6.text = _local_3;
                };
                if (_local_4){
                    _local_6 = (this._window.findChildByName("alert_desc") as ITextWindow);
                    _local_6.text = _local_4;
                };
                _local_7 = this._window.findChildByName("teaser_ok_btn");
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.TeaserFurniWidget);
                };
                _local_7 = this._window.findChildByName("no_fb_btn");
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.TeaserFurniWidget);
                };
                _local_7 = this._window.findChildByName("received_ok_btn");
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.TeaserFurniWidget);
                };
                _local_7 = this._window.findChildByName("skip_btn");
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.TeaserFurniWidget);
                };
                _local_7 = this._window.findChildByName("post_btn");
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.TeaserFurniWidget);
                };
                _local_7 = this._window.findChildByName("open_btn");
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.TeaserFurniWidget);
                };
            };
            return (this._window);
        }
        private function showInterface():void
        {
            if (this._window == null){
                return;
            };
            this._window.visible = true;
        }
        private function hideInterface():void
        {
            if (this._window){
                this._window.visible = false;
            };
        }
        private function TeaserFurniWidget(_arg_1:WindowEvent):void
        {
            this.hideInterface();
        }
        private function TeaserFurniWidget(_arg_1:WindowEvent):void
        {
            var _local_2:RoomWidgetViralFurniMessage;
            if (messageListener != null){
                _local_2 = new RoomWidgetViralFurniMessage(RoomWidgetViralFurniMessage.RWVFM_VIRAL_FOUND);
                messageListener.processWidgetMessage(_local_2);
            };
            this.hideInterface();
        }
        private function TeaserFurniWidget(_arg_1:WindowEvent):void
        {
            this.hideInterface();
        }
        private function TeaserFurniWidget(_arg_1:WindowEvent):void
        {
            this.RoomSession(("viral_" + this._campaignID), "client.skip_post");
            this.hideInterface();
        }
        private function TeaserFurniWidget(_arg_1:WindowEvent):void
        {
            var _local_2:String = _localizations.getKey("notifications.viral_furni.fb.title");
            var _local_3:String = _localizations.getKey("notifications.viral_furni.fb.desc");
            this.RoomSession(("viral_" + this._campaignID), "client.start_post", this._shareId);
            var _local_4:String = this._habboConfiguration.getKey("viral.furni.post_type", "feed");
            HabboWebTools.facebookViralGiftPost(this._campaignID, _local_2, _local_3, this._shareId, _local_4);
            this.hideInterface();
        }
        private function TeaserFurniWidget(_arg_1:WindowEvent):void
        {
            var _local_2:RoomWidgetViralFurniMessage;
            if (messageListener != null){
                _local_2 = new RoomWidgetViralFurniMessage(RoomWidgetViralFurniMessage.RWVFM_OPEN_PRESENT);
                _local_2.objectId = this._objectId;
                messageListener.processWidgetMessage(_local_2);
            };
            this.hideInterface();
            if (this._inventory){
                if (this._itemCategory != 0){
                    this._inventory.HabboInventory((((this._itemCategory == 1)) ? InventoryCategory._SafeStr_5995 : InventoryCategory._SafeStr_5996));
                };
            };
            this.RoomSession(("viral_" + this._campaignID), "client.open_gift");
        }
        private function RoomSession(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:int=0):void
        {
            var _local_5:RoomWidgetConversionPointMessage;
            if (messageListener != null){
                _local_5 = new RoomWidgetConversionPointMessage(RoomWidgetConversionPointMessage.RWCPM_CONVERSION_POINT, "ViralGift", _arg_1, _arg_2, _arg_3, _arg_4);
                messageListener.processWidgetMessage(_local_5);
            };
        }
        private function TeaserFurniWidget(_arg_1:String, _arg_2:String):void
        {
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (!_local_3){
                return;
            };
            var _local_4:IAsset = _assets.getAssetByName(_arg_1);
            if (!_local_4){
                this._SafeStr_5979.push(new ImageDownloader(this, _assets, this._campaignID, this._SafeStr_5980, _arg_1, _arg_2));
                return;
            };
            var _local_5:BitmapData = (_local_4.content as BitmapData).clone();
            switch (_arg_2){
                case this._SafeStr_5972:
                case this._SafeStr_5971:
                    _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                    _local_3.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, (_local_3.height - _local_5.height)), null, null, true);
                    return;
            };
        }
        function TeaserFurniWidget(_arg_1:ImageDownloader):void
        {
            if (disposed){
                return;
            };
            if (((!(this._window)) || (!((this._campaignID == _arg_1.campaignID))))){
                return;
            };
            var _local_2:IAsset = _assets.getAssetByName(_arg_1.imageName);
            if (!_local_2){
                return;
            };
            this.TeaserFurniWidget(_arg_1.imageName, _arg_1.viewElementID);
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.teaser

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// TeaserFurniWidget = "_-1kW" (String#5761, DoABC#2)
// RoomWidgetTeaserDataUpdateEvent = "_-Cu" (String#7931, DoABC#2)
// ImageDownloader = "_-2EI" (String#6327, DoABC#2)
// RoomWidgetViralFurniMessage = "_-2jy" (String#6954, DoABC#2)
// RWVFM_VIRAL_FOUND = "_-22P" (String#19106, DoABC#2)
// RWVFM_OPEN_PRESENT = "_-Bb" (String#22674, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWCPM_CONVERSION_POINT = "_-0hK" (String#15721, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// facebookViralGiftPost = "_-0s0" (String#16123, DoABC#2)
// _campaignID = "_-eQ" (String#639, DoABC#2)
// _itemCategory = "_-0MW" (String#814, DoABC#2)
// firstClickUserName = "_-0jN" (String#15804, DoABC#2)
// giftWasReceived = "_-1AI" (String#16872, DoABC#2)
// itemCategory = "_-3Bq" (String#21955, DoABC#2)
// campaignID = "_-09Z" (String#14429, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// _SafeStr_5960 = "_-uY" (String#24473, DoABC#2)
// _SafeStr_5961 = "_-0o1" (String#15978, DoABC#2)
// _SafeStr_5962 = "_-q7" (String#24277, DoABC#2)
// _SafeStr_5963 = "_-06r" (String#14319, DoABC#2)
// _SafeStr_5964 = "_-2DA" (String#19531, DoABC#2)
// _SafeStr_5965 = "_-kv" (String#24067, DoABC#2)
// _SafeStr_5966 = "_-ec" (String#23828, DoABC#2)
// _SafeStr_5967 = "_-1HE" (String#17160, DoABC#2)
// _SafeStr_5968 = "_-cy" (String#23754, DoABC#2)
// _SafeStr_5969 = "_-2SR" (String#20136, DoABC#2)
// _SafeStr_5970 = "_-2VS" (String#20260, DoABC#2)
// _SafeStr_5971 = "_-1Dx" (String#17022, DoABC#2)
// _SafeStr_5972 = "_-MJ" (String#23096, DoABC#2)
// _SafeStr_5973 = "_-1Fc" (String#17099, DoABC#2)
// _SafeStr_5974 = "_-2D4" (String#19526, DoABC#2)
// _SafeStr_5975 = "_-Oe" (String#23192, DoABC#2)
// _SafeStr_5976 = "_-2Eg" (String#19592, DoABC#2)
// _habboConfiguration = "_-Mv" (String#637, DoABC#2)
// _SafeStr_5978 = "_-x" (String#24570, DoABC#2)
// _SafeStr_5979 = "_-1pX" (String#18527, DoABC#2)
// _SafeStr_5980 = "_-5y" (String#22463, DoABC#2)
// RWTDUE_TEASER_DATA = "_-0sx" (String#16159, DoABC#2)
// RWTDUE_GIFT_DATA = "_-3G0" (String#22116, DoABC#2)
// RWTDUE_GIFT_RECEIVED = "_-io" (String#23991, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)
// ownRealName = "_-ZW" (String#23616, DoABC#2)
// RoomSession = "_-0C0" (String#1425, DoABC#2)
// TeaserFurniWidget = "_-2Zm" (String#20431, DoABC#2)
// TeaserFurniWidget = "_-2dy" (String#20600, DoABC#2)
// TeaserFurniWidget = "_-04Z" (String#14225, DoABC#2)
// TeaserFurniWidget = "_-0-m" (String#14044, DoABC#2)
// TeaserFurniWidget = "_-0xZ" (String#16335, DoABC#2)
// TeaserFurniWidget = "_-2g6" (String#20697, DoABC#2)
// TeaserFurniWidget = "_-2S2" (String#20120, DoABC#2)
// HabboInventory = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_5996 = "_-Jg" (String#22993, DoABC#2)
// TeaserFurniWidget = "_-3O" (String#22354, DoABC#2)
// imageName = "_-0cN" (String#15528, DoABC#2)
// viewElementID = "_-2MU" (String#19906, DoABC#2)


