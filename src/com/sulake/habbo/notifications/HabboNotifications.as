
package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.core.runtime.IContext;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementBonusMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerFinishedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusCannotEnterMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetReceivedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
    import com.sulake.habbo.communication.messages.parser.notifications.MOTDNotificationParser;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseOKMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerFinishedMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.communication.messages.parser.moderation.ModMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusCannotEnterMessageParser;
    import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageParser;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetRespectFailedParser;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.parser.notifications.ClubGiftNotificationParser;
    import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftSelectedParser;

    public class HabboNotifications extends Component implements IHabboNotifications, IUpdateReceiver, IGetImageListener 
    {

        private static const _SafeStr_12121:String = "pixelbalance";
        private static const _SafeStr_12122:String = "badges";
        private static const _SafeStr_12123:String = "selectbadge";
        private static const _SafeStr_12124:String = "inventory";
        private static const _SafeStr_12125:String = "selectfurni";
        private static const UILINK_CREDITS:String = "credits";
        private static const _SafeStr_12126:String = "friendlist";
        private static const _SafeStr_12127:String = "pet_inventory";
        private static const _SafeStr_12128:String = "go_to_room";

        private var _communication:IHabboCommunicationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _inventory:IHabboInventory;
        private var _friendList:IHabboFriendList;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _roomEngine:IRoomEngine;
        private var _config:IHabboConfigurationManager;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_6296:IHabboToolbar;
        private var _assetLibrary:IAssetLibrary;
        private var _SafeStr_12129:Array;
        private var _SafeStr_12130:Map;
        private var _SafeStr_12131:HabboNotificationViewManager;
        private var _SafeStr_12132:HabboAlertDialogManager;
        private var _SafeStr_12133:ParkBusDialogManager;
        private var _SafeStr_12134:Boolean;
        private var _SafeStr_12135:ClubGiftNotification;
        private var _SafeStr_12136:ClubEndingNotification;
        private var _SafeStr_12137:ClubPromoNotification;
        private var _SafeStr_12138:Dictionary;
        private var _disabled:Boolean;

        public function HabboNotifications(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            var _local_7:int;
            var _local_8:Map;
            var _local_9:BitmapDataAsset;
            var _local_10:BitmapData;
            super(_arg_1, _arg_2, _arg_3);
            this._assetLibrary = _arg_3;
            this._SafeStr_12129 = new Array();
            this._SafeStr_12130 = new Map();
            this._disabled = false;
            this._SafeStr_12138 = new Dictionary();
            var _local_4:IAsset = this._assetLibrary.getAssetByName("habbo_notifications_config_xml");
            var _local_5:XmlAsset = XmlAsset(_local_4);
            if (_local_5 != null){
                XMLVariableParser.parseVariableList(XML(_local_5.content).children(), this._SafeStr_12130);
            };
            var _local_6:Map = this._SafeStr_12130["styles"];
            if (_local_6 != null){
                _local_7 = 0;
                while (_local_7 < _local_6.length) {
                    _local_8 = _local_6.getWithIndex(_local_7);
                    if (_local_8["icon"] != null){
                        _local_9 = (this._assetLibrary.getAssetByName(_local_8["icon"]) as BitmapDataAsset);
                        _local_10 = (_local_9.content as BitmapData);
                        _local_8["icon"] = _local_10;
                    };
                    _local_7++;
                };
            };
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.HabboUserDefinedRoomEvents);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
        }
        override public function dispose():void
        {
            if (this._SafeStr_12131 != null){
                this._SafeStr_12131.dispose();
                this._SafeStr_12131 = null;
            };
            if (this._SafeStr_12132 != null){
                this._SafeStr_12132.dispose();
                this._SafeStr_12132 = null;
            };
            if (this._SafeStr_12133 != null){
                this._SafeStr_12133.dispose();
                this._SafeStr_12133 = null;
            };
            if (this._SafeStr_12135 != null){
                this._SafeStr_12135.dispose();
                this._SafeStr_12135 = null;
            };
            if (this._SafeStr_12136){
                this._SafeStr_12136.dispose();
                this._SafeStr_12136 = null;
            };
            if (this._SafeStr_12137){
                this._SafeStr_12137.dispose();
                this._SafeStr_12137 = null;
            };
            if (this._avatarRenderManager){
                this._avatarRenderManager.release(new IIDAvatarRenderManager());
                this._avatarRenderManager = null;
            };
            if (this._catalog){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._config){
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this._friendList){
                this._friendList.release(new IIDHabboFriendList());
                this._friendList = null;
            };
            if (this._inventory){
                this._inventory.release(new IIDHabboInventory());
                this._inventory = null;
            };
            if (this._localization){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._roomEngine){
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this._sessionDataManager){
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            super.dispose();
        }
        private function addItem(_arg_1:String, _arg_2:String, _arg_3:BitmapData, _arg_4:String=null):int
        {
            if (this._disabled){
                return (0);
            };
            var _local_5:Map = this._SafeStr_12130["styles"];
            if (_local_5 == null){
                return (0);
            };
            var _local_6:Map = _local_5[_arg_2];
            if (_local_6 == null){
                return (0);
            };
            var _local_7:HabboNotificationItemStyle = new HabboNotificationItemStyle(_local_6, _arg_3, true, _arg_4);
            var _local_8:HabboNotificationItem = new HabboNotificationItem(_arg_1, _local_7, this);
            this._SafeStr_12129.push(_local_8);
            return (this._SafeStr_12129.length);
        }
        private function getNextItemFromQueue():HabboNotificationItem
        {
            var _local_1:Array = this._SafeStr_12129.splice(0, 1);
            return ((_local_1[0] as HabboNotificationItem));
        }
        private function HabboUserDefinedRoomEvents(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(_arg_2);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(_arg_2);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._localization = (_arg_2 as IHabboLocalizationManager);
            this._SafeStr_12132 = new HabboAlertDialogManager(this._windowManager, this._localization);
            if (this._communication){
                this._communication.HabboCommunicationManager(new AuthenticationOKMessageEvent(this.onAuthenticationOk));
                this._communication.HabboCommunicationManager(new MOTDNotificationEvent(this.onMOTD));
            };
        }
        private function onInventoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._inventory = (_arg_2 as IHabboInventory);
        }
        private function onFriendListReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._friendList = (_arg_2 as IHabboFriendList);
        }
        private function onAvatarRenderManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._avatarRenderManager = (_arg_2 as IAvatarRenderManager);
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._roomEngine = (_arg_2 as IRoomEngine);
        }
        private function onConfigurationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._config = (_arg_2 as IHabboConfigurationManager);
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._catalog = (_arg_2 as IHabboCatalog);
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._SafeStr_6296 = (_arg_2 as IHabboToolbar);
        }
        function onAchievementBonus(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboAchievementBonusMessageEvent = (_arg_1 as HabboAchievementBonusMessageEvent);
            new AchievementNotificationBonus(_local_2.bonusPoints, _local_2.realName, assets, this._windowManager, this._localization);
        }
        function onAuthenticationOk(_arg_1:IMessageEvent):void
        {
            this._SafeStr_12131 = new HabboNotificationViewManager(this._assetLibrary, this._windowManager, this._config, this._SafeStr_6296, this._SafeStr_12130["styles"], this._SafeStr_12130["view"]);
            this._communication.HabboCommunicationManager(new HabboBroadcastMessageEvent(this.onBroadcastMessageEvent));
            this._communication.HabboCommunicationManager(new HabboAchievementBonusMessageEvent(this.onAchievementBonus));
            this._communication.HabboCommunicationManager(new RespectNotificationMessageEvent(this.onRespectNotification));
            this._communication.HabboCommunicationManager(new PurchaseOKMessageEvent(this.onPurchaseOK));
            this._communication.HabboCommunicationManager(new RecyclerFinishedMessageEvent(this.onRecyclerFinished));
            this._communication.HabboCommunicationManager(new ScrSendUserInfoEvent(this.onSubscriptionInfo));
            this._communication.HabboCommunicationManager(new InfoFeedEnableMessageEvent(this.onInfoFeedEnable));
            this._communication.HabboCommunicationManager(new ModMessageEvent(this.onModMessageEvent));
            this._communication.HabboCommunicationManager(new UserBannedMessageEvent(this.onUserBannedMessageEvent));
            this._communication.HabboCommunicationManager(new InfoHotelClosingMessageEvent(this.onHotelClosing));
            this._communication.HabboCommunicationManager(new InfoHotelClosedMessageEvent(this.onHotelClosed));
            this._communication.HabboCommunicationManager(new LoginFailedHotelClosedMessageEvent(this.onLoginFailedHotelClosed));
            this._communication.HabboCommunicationManager(new ParkBusCannotEnterMessageEvent(this.onParkBusMessageEvent));
            this._communication.HabboCommunicationManager(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._communication.HabboCommunicationManager(new PetLevelNotificationEvent(this.onPetLevelNotification));
            this._communication.HabboCommunicationManager(new PetReceivedMessageEvent(this.onPetReceived));
            this._communication.HabboCommunicationManager(new PetRespectFailedEvent(this.onPetRespectFailed));
            this._communication.HabboCommunicationManager(new ClubGiftNotificationEvent(this.onClubGiftNotification));
            this._communication.HabboCommunicationManager(new ClubGiftSelectedEvent(this.onClubGiftSelected));
            this._communication.HabboCommunicationManager(new RoomMessageNotificationMessageEvent(this.onRoomMessagesNotification));
            IContext(this._SafeStr_12131, 1);
            IContext(this, 2);
            this._sessionDataManager.events.addEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this.InfostandWidget);
            this._communication.HabboCommunicationManager(null).send(new GetMOTDMessageComposer());
        }
        function onMOTD(_arg_1:IMessageEvent):void
        {
            var _local_2:MOTDNotificationEvent = (_arg_1 as MOTDNotificationEvent);
            var _local_3:MOTDNotificationParser = (_local_2.getParser() as MOTDNotificationParser);
            if (((_local_3.messages) && ((_local_3.messages.length > 0)))){
                new MOTDNotification(_local_3.messages, this._assetLibrary, this._windowManager);
            };
        }
        function onRespectNotification(_arg_1:IMessageEvent):void
        {
            var _local_3:ILocalization;
            var _local_4:ILocalization;
            var _local_2:RespectNotificationMessageEvent = (_arg_1 as RespectNotificationMessageEvent);
            if (this._sessionDataManager.userId == _local_2.userId){
                this._localization.registerParameter("notifications.text.respect.2", "count", String(_local_2.respectTotal));
                _local_3 = this._localization.getLocalization("notifications.text.respect.1");
                _local_4 = this._localization.getLocalization("notifications.text.respect.2");
                if (_local_3){
                    this.addItem(_local_3.value, NotificationType._SafeStr_12059, null);
                };
                if (_local_4){
                    this.addItem(_local_4.value, NotificationType._SafeStr_12059, null);
                };
            };
        }
        public function addSongPlayingNotification(_arg_1:String, _arg_2:String):void
        {
            this._localization.registerParameter("soundmachine.notification.playing", "songname", _arg_1);
            this._localization.registerParameter("soundmachine.notification.playing", "songauthor", _arg_2);
            var _local_3:ILocalization = this._localization.getLocalization("soundmachine.notification.playing");
            if (_local_3){
                this.addItem(_local_3.value, NotificationType._SafeStr_12060, null);
            };
        }
        public function showGenericNotification(_arg_1:String):void
        {
            this.addItem(_arg_1, NotificationType._SafeStr_12057, null);
        }
        private function onRoomMessagesNotification(_arg_1:RoomMessageNotificationMessageEvent):void
        {
            var _local_3:ILocalization;
            var _local_2:RoomMessageNotificationMessageParser = _arg_1.getParser();
            var _local_4:String = NotificationType._SafeStr_12064;
            this._localization.registerParameter("notifications.text.room.messages.posted", "room_name", _local_2.roomName);
            this._localization.registerParameter("notifications.text.room.messages.posted", "messages_count", _local_2.messageCount.toString());
            _local_3 = this._localization.getLocalization("notifications.text.room.messages.posted");
            var _local_5:BitmapDataAsset = (assets.getAssetByName("if_icon_temp_png") as BitmapDataAsset);
            var _local_6:BitmapData = (_local_5.content as BitmapData);
            if (_local_3){
                this.addItem(_local_3.value, _local_4, _local_6.clone());
            };
        }
        private function onPurchaseOK(_arg_1:IMessageEvent):void
        {
            var _local_6:CatalogPageMessageProductData;
            var _local_7:IFurnitureData;
            var _local_8:ILocalization;
            var _local_9:IProductData;
            var _local_2:PurchaseOKMessageEvent = (_arg_1 as PurchaseOKMessageEvent);
            var _local_3:PurchaseOKMessageParser = _local_2.getParser();
            var _local_4:CatalogPageMessageOfferData = _local_3.offer;
            var _local_5:BitmapData;
            if (_local_4 == null){
                return;
            };
            for each (_local_6 in _local_4.products) {
                if (_local_6){
                    if (_local_6.productType == CatalogPageMessageProductData._SafeStr_5017){
                        _local_7 = this._sessionDataManager.SessionDataManager(_local_6.furniClassId);
                    }
                    else {
                        if (_local_6.productType == CatalogPageMessageProductData._SafeStr_5019){
                            _local_7 = this._sessionDataManager.SessionDataManager(_local_6.furniClassId);
                        };
                    };
                    _local_5 = this.getProductImage(_local_6.productType, _local_6.furniClassId, _local_6.extraParam);
                    if (((_local_7) && (!((_local_7.title == ""))))){
                        this._localization.registerParameter("notifications.text.purchase.ok", "productName", _local_7.title);
                    }
                    else {
                        _local_9 = this._sessionDataManager.getProductData(_local_4.localizationId);
                        if (_local_9){
                            this._localization.registerParameter("notifications.text.purchase.ok", "productName", _local_9.name);
                        };
                    };
                    _local_8 = this._localization.getLocalization("notifications.text.purchase.ok");
                    if (_local_8){
                        this.addItem(_local_8.value, NotificationType._SafeStr_12063, _local_5);
                    };
                };
            };
            Logger.log("[HabboNotifications] purchase ok");
        }
        private function getProductImage(_arg_1:String, _arg_2:int, _arg_3:String):BitmapData
        {
            var _local_4:BitmapDataAsset;
            var _local_5:ImageResult;
            var _local_6:BitmapData;
            var _local_7:int;
            switch (_arg_1){
                case CatalogPageMessageProductData._SafeStr_5017:
                    _local_5 = this._roomEngine.getFurnitureIcon(_arg_2, this);
                    break;
                case CatalogPageMessageProductData._SafeStr_5019:
                    _local_7 = this.tempCategoryMapping("I", _arg_2);
                    if (_local_7 == 1){
                        _local_5 = this._roomEngine.getWallItemIcon(_arg_2, this, _arg_3);
                    }
                    else {
                        switch (_local_7){
                            case FurniCategory._SafeStr_7051:
                                _local_4 = ((this._inventory as Component).assets.getAssetByName("icon_wallpaper_png") as BitmapDataAsset);
                                if (_local_4 != null){
                                    _local_6 = (_local_4.content as BitmapData).clone();
                                };
                                break;
                            case FurniCategory._SafeStr_7053:
                                _local_4 = ((this._inventory as Component).assets.getAssetByName("icon_landscape_png") as BitmapDataAsset);
                                if (_local_4 != null){
                                    _local_6 = (_local_4.content as BitmapData).clone();
                                };
                                break;
                            case FurniCategory._SafeStr_7052:
                                _local_4 = ((this._inventory as Component).assets.getAssetByName("icon_floor_png") as BitmapDataAsset);
                                if (_local_4 != null){
                                    _local_6 = (_local_4.content as BitmapData).clone();
                                };
                                break;
                        };
                        _local_5 = null;
                    };
                    break;
                case CatalogPageMessageProductData._SafeStr_5021:
                    _local_4 = ((this._inventory as Component).assets.getAssetByName((("fx_icon_" + _arg_2) + "_png")) as BitmapDataAsset);
                    if (_local_4 != null){
                        _local_6 = (_local_4.content as BitmapData).clone();
                    };
                    break;
                default:
                    Logger.log("[HabboNotifications] Can not yet handle this type of product: ");
            };
            if (_local_5 != null){
                _local_6 = _local_5.data;
            };
            return (_local_6);
        }
        private function onRecyclerFinished(_arg_1:IMessageEvent):void
        {
            var _local_2:RecyclerFinishedMessageParser = (_arg_1 as RecyclerFinishedMessageEvent).getParser();
            if ((((_local_2 == null)) || (!((_local_2.recyclerFinishedStatus == RecyclerFinishedMessageEvent._SafeStr_8287))))){
                return;
            };
            var _local_3:ILocalization = this._localization.getLocalization("notifications.text.recycle.ok");
            if (_local_3){
                this.addItem(_local_3.value, NotificationType._SafeStr_12058, null);
            };
            Logger.log("[HabboNotifications] recycle ok");
        }
        private function onSubscriptionInfo(_arg_1:IMessageEvent):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:String;
            var _local_6:String;
            var _local_7:ILocalization;
            Logger.log("[HabboNotifications] subscription update");
            var _local_2:ScrSendUserInfoMessageParser = (_arg_1 as ScrSendUserInfoEvent).getParser();
            if (_local_2 == null){
                return;
            };
            if (_local_2.responseType == ScrSendUserInfoMessageParser.RESPONSE_TYPE_PURCHASE){
                _local_3 = Math.max(0, _local_2.daysToPeriodEnd);
                _local_4 = Math.max(0, _local_2.periodsSubscribedAhead);
                if (_local_2.isVIP){
                    _local_5 = "notifications.text.vipdays";
                    _local_6 = NotificationType._SafeStr_3939;
                }
                else {
                    _local_5 = "notifications.text.clubdays";
                    _local_6 = NotificationType.RWBIUE_HABBO_CLUB;
                };
                if (_local_4 > 0){
                    _local_5 = (_local_5 + ".long");
                };
                this._localization.registerParameter(_local_5, "days", String(_local_3));
                this._localization.registerParameter(_local_5, "months", String(_local_4));
                _local_7 = this._localization.getLocalization(_local_5);
                if (_local_7){
                    this.addItem(_local_7.value, _local_6, null);
                };
            }
            else {
                if (_local_2.isVIP){
                    if (!this._config.getBoolean("club.membership.extend.vip.promotion.enabled", false)){
                        this.checkClubEndingNotification(_local_2);
                    };
                }
                else {
                    if (!this._config.getBoolean("club.membership.extend.basic.promotion.enabled", false)){
                        this.checkClubEndingNotification(_local_2);
                    };
                };
                if (_local_2.isShowBasicPromo){
                    if (this._SafeStr_12137){
                        this._SafeStr_12137.dispose();
                    };
                    this._SafeStr_12137 = new ClubPromoNotification(_local_2.basicNormalPrice, _local_2.basicPromoPrice, assets, this._windowManager, this._catalog, this._localization);
                };
            };
        }
        private function checkClubEndingNotification(_arg_1:ScrSendUserInfoMessageParser):void
        {
            var _local_2:int = parseInt(this._config.getKey("subscription.reminder.when.days.left", "5"));
            if ((((((((_local_2 > 0)) && ((_arg_1.daysToPeriodEnd > 0)))) && ((_arg_1.daysToPeriodEnd <= _local_2)))) && ((_arg_1.periodsSubscribedAhead == 0)))){
                if (this._SafeStr_12136){
                    this._SafeStr_12136.dispose();
                };
                this._SafeStr_12136 = new ClubEndingNotification(_arg_1.daysToPeriodEnd, _arg_1.isVIP, assets, this._windowManager, this._catalog, this._localization);
            };
        }
        private function onInfoFeedEnable(_arg_1:IMessageEvent):void
        {
            var _local_2:InfoFeedEnableMessageEvent = (_arg_1 as InfoFeedEnableMessageEvent);
            if (_local_2 != null){
                this._disabled = !(_local_2.enabled);
            };
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:HabboNotificationItem;
            if (((this._SafeStr_12131.HabboNotificationViewManager()) && ((this._SafeStr_12129.length > 0)))){
                _local_2 = this.getNextItemFromQueue();
                if (!this._SafeStr_12131.showItem(_local_2)){
                    _local_2.dispose();
                };
            };
        }
        public function onExecuteLink(_arg_1:String):void
        {
            switch (_arg_1){
                case _SafeStr_12121:
                    return;
                case _SafeStr_12122:
                    if (this._inventory != null){
                        this._inventory.HabboInventory(InventoryCategory._SafeStr_7061);
                    };
                    return;
                case _SafeStr_12123:
                    return;
                case _SafeStr_12124:
                    if (((!((this._inventory == null))) && (this._inventory.hasRoomSession))){
                        this._inventory.HabboInventory(InventoryCategory._SafeStr_5995);
                    };
                    return;
                case _SafeStr_12127:
                    if (((!((this._inventory == null))) && (this._inventory.hasRoomSession))){
                        this._inventory.HabboInventory(InventoryCategory._SafeStr_5996);
                    };
                    return;
                case _SafeStr_12125:
                    return;
                case UILINK_CREDITS:
                    return;
                case _SafeStr_12126:
                    if (this._friendList != null){
                        this._friendList.openFriendList();
                    };
                    return;
                case _SafeStr_12128:
                    return;
            };
        }
        private function InfostandWidget(_arg_1:BadgeImageReadyEvent):void
        {
            if (((!((_arg_1 == null))) && (!((this._SafeStr_12131 == null))))){
                this._SafeStr_12131.replaceIcon(_arg_1);
            };
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
        }
        private function tempCategoryMapping(_arg_1:String, _arg_2:int):int
        {
            if (_arg_1 == "S"){
                return (1);
            };
            if (_arg_1 == "I"){
                if (_arg_2 == 3001){
                    return (FurniCategory._SafeStr_7051);
                };
                if (_arg_2 == 3002){
                    return (FurniCategory._SafeStr_7052);
                };
                if (_arg_2 == 4057){
                    return (FurniCategory._SafeStr_7053);
                };
                return (1);
            };
            return (1);
        }
        private function onModMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:ModMessageParser = (_arg_1 as ModMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._SafeStr_12132 == null)))){
                return;
            };
            this._SafeStr_12132.handleModMessage(_local_2.message, _local_2.url);
        }
        private function onUserBannedMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:UserBannedMessageParser = (_arg_1 as UserBannedMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._SafeStr_12132 == null)))){
                return;
            };
            this._SafeStr_12132.handleUserBannedMessage(_local_2.message);
        }
        private function onHotelClosing(_arg_1:IMessageEvent):void
        {
            var _local_2:InfoHotelClosingMessageParser = (_arg_1 as InfoHotelClosingMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._SafeStr_12132 == null)))){
                return;
            };
            this._SafeStr_12132.handleHotelClosingMessage(_local_2.minutesUntilClosing);
        }
        private function onHotelClosed(_arg_1:IMessageEvent):void
        {
            var _local_2:InfoHotelClosedMessageParser = (_arg_1 as InfoHotelClosedMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._SafeStr_12132 == null)))){
                return;
            };
            this._SafeStr_12132.handleHotelClosedMessage(_local_2.openHour, _local_2.openMinute, _local_2.userThrownOutAtClose);
        }
        private function onLoginFailedHotelClosed(_arg_1:IMessageEvent):void
        {
            var _local_2:LoginFailedHotelClosedMessageParser = (_arg_1 as LoginFailedHotelClosedMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._SafeStr_12132 == null)))){
                return;
            };
            this._SafeStr_12132.handleLoginFailedHotelClosedMessage(_local_2.openHour, _local_2.openMinute);
        }
        private function onParkBusMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:ParkBusCannotEnterMessageParser = (_arg_1 as ParkBusCannotEnterMessageEvent).getParser();
            if (this._SafeStr_12133 == null){
                this._SafeStr_12133 = new ParkBusDialogManager(this._windowManager, assets, this._localization);
            };
            if (((!((_local_2 == null))) || (!((this._SafeStr_12133 == null))))){
                this._SafeStr_12133.handleParkBusCannotEnter(_local_2.reason);
            };
        }
        private function onPetLevelNotification(_arg_1:PetLevelNotificationEvent):void
        {
            var _local_4:BitmapData;
            if (_arg_1 == null){
                return;
            };
            var _local_2:PetLevelNotificationParser = _arg_1.getParser();
            this._localization.registerParameter("notifications.text.petlevel", "pet_name", _local_2.petName);
            this._localization.registerParameter("notifications.text.petlevel", "level", _local_2.level.toString());
            var _local_3:ILocalization = this._localization.getLocalization("notifications.text.petlevel");
            if (_local_3){
                _local_4 = this.RoomEngine(_local_2.petType, _local_2.breed, _local_2.color);
                this.addItem(_local_3.value, NotificationType._SafeStr_12061, _local_4);
            };
        }
        private function onPetReceived(_arg_1:PetReceivedMessageEvent):void
        {
            var _local_3:ILocalization;
            var _local_4:PetData;
            var _local_5:BitmapData;
            if (_arg_1 == null){
                return;
            };
            var _local_2:PetReceivedMessageParser = _arg_1.getParser();
            if (_local_2.boughtAsGift){
                _local_3 = this._localization.getLocalization("notifications.text.petbought");
            }
            else {
                _local_3 = this._localization.getLocalization("notifications.text.petreceived");
            };
            if (_local_3){
                _local_4 = _local_2.pet;
                _local_5 = this.RoomEngine(_local_4.type, _local_4.breed, _local_4.color);
                this.addItem(_local_3.value, NotificationType._SafeStr_12061, _local_5);
            };
        }
        private function RoomEngine(_arg_1:int, _arg_2:int, _arg_3:String):BitmapData
        {
            var _local_5:uint;
            var _local_6:IAvatarImage;
            var _local_7:uint;
            var _local_8:ImageResult;
            var _local_4:BitmapData;
            if ((((_arg_1 < 0)) || ((_arg_2 < 0)))){
                return (_local_4);
            };
            if (_arg_1 < 8){
                _local_5 = parseInt(_arg_3, 16);
                _local_6 = this._avatarRenderManager.createPetImage(_arg_1, _arg_2, _local_5, AvatarScaleType._SafeStr_4336);
                if (_local_6 != null){
                    _local_6.setDirection(AvatarSetType._SafeStr_4457, 3);
                    _local_4 = _local_6.getCroppedImage(AvatarSetType._SafeStr_4458);
                    _local_6.dispose();
                };
            }
            else {
                _local_7 = 0;
                _local_8 = this._roomEngine.RoomEngine(_arg_1, _arg_2, new Vector3d(135), 32, null, _local_7);
                if (_local_8 != null){
                    _local_4 = _local_8.data;
                };
            };
            return (_local_4);
        }
        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            var _local_2:String;
            if (!this._SafeStr_12134){
                _local_2 = this._localization.getKey("mod.chatdisclaimer", "NA");
                this.addItem(_local_2, NotificationType._SafeStr_12057, null);
                this._SafeStr_12134 = true;
                Logger.log(("DISPLAYED MOD INFO: " + _local_2));
            };
        }
        private function onBroadcastMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboBroadcastMessageParser = (_arg_1 as HabboBroadcastMessageEvent).getParser();
            var _local_3:String = _local_2.messageText;
            var _local_4:RegExp = /\\r/g;
            _local_3 = _local_3.replace(_local_4, "\r");
            this._windowManager.alert("${notifications.broadcast.title}", _local_3, 0, this.QuestsList);
        }
        private function onPetRespectFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:PetRespectFailedParser = (_arg_1 as PetRespectFailedEvent).getParser();
            this._localization.registerParameter("room.error.pets.respectfailed", "required_age", ("" + _local_2.requiredDays));
            this._localization.registerParameter("room.error.pets.respectfailed", "avatar_age", ("" + _local_2.avatarAgeInDays));
            this._windowManager.alert("${error.title}", "${room.error.pets.respectfailed}", 0, this.QuestsList);
        }
        public function QuestsList(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if ((((_arg_2.type == WindowEvent.WE_OK)) || ((_arg_2.type == WindowEvent.WE_CANCEL)))){
                _arg_1.dispose();
            };
        }
        private function onClubGiftNotification(_arg_1:ClubGiftNotificationEvent):void
        {
            if (!_arg_1){
                return;
            };
            var _local_2:ClubGiftNotificationParser = _arg_1.getParser();
            if (!_local_2){
                return;
            };
            if (_local_2.numGifts < 1){
                return;
            };
            if (((this._SafeStr_12135) && (this._SafeStr_12135.visible))){
                return;
            };
            this._SafeStr_12135 = new ClubGiftNotification(_local_2.numGifts, assets, this._windowManager, this._catalog, this._SafeStr_6296);
        }
        private function onClubGiftSelected(_arg_1:ClubGiftSelectedEvent):void
        {
            if (((!(_arg_1)) || (!(this._localization)))){
                return;
            };
            var _local_2:ClubGiftSelectedParser = _arg_1.getParser();
            if (!_local_2){
                return;
            };
            var _local_3:Array = _local_2.products;
            if (((!(_local_3)) || ((_local_3.length == 0)))){
                return;
            };
            var _local_4:CatalogPageMessageProductData = (_local_3[0] as CatalogPageMessageProductData);
            if (!_local_4){
                return;
            };
            var _local_5:String = this._localization.getKey("notifications.text.club_gift.received");
            var _local_6:BitmapData = this.getProductImage(_local_4.productType, _local_4.furniClassId, _local_4.extraParam);
            this.addItem(_local_5, NotificationType._SafeStr_12057, _local_6);
        }

    }
}//package com.sulake.habbo.notifications

// IID = "_-3KV" (String#7712, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// onFriendListReady = "_-1N-" (String#849, DoABC#2)
// onSubscriptionInfo = "_-3-R" (String#1981, DoABC#2)
// onRecyclerFinished = "_-0RM" (String#4120, DoABC#2)
// messageCount = "_-Qs" (String#23280, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// HabboUserDefinedRoomEvents = "_-1hF" (String#443, DoABC#2)
// onConfigurationManagerReady = "_-1OV" (String#604, DoABC#2)
// hasRoomSession = "_-Iw" (String#8059, DoABC#2)
// _SafeStr_12057 = "_-2lf" (String#20905, DoABC#2)
// _SafeStr_12058 = "_-1MP" (String#17376, DoABC#2)
// _SafeStr_12059 = "_-0pP" (String#16031, DoABC#2)
// _SafeStr_12060 = "_-2d1" (String#20564, DoABC#2)
// _SafeStr_12061 = "_-1wJ" (String#18812, DoABC#2)
// _SafeStr_12063 = "_-3-k" (String#21491, DoABC#2)
// _SafeStr_12064 = "_-33z" (String#21656, DoABC#2)
// replaceIcon = "_-1sg" (String#18663, DoABC#2)
// showItem = "_-1J5" (String#5224, DoABC#2)
// HabboNotificationViewManager = "_-0Qv" (String#15099, DoABC#2)
// handleModMessage = "_-1Bx" (String#16938, DoABC#2)
// handleUserBannedMessage = "_-0KQ" (String#14856, DoABC#2)
// handleHotelClosingMessage = "_-2G7" (String#19647, DoABC#2)
// handleHotelClosedMessage = "_-3Iu" (String#22235, DoABC#2)
// handleLoginFailedHotelClosedMessage = "_-1hn" (String#18203, DoABC#2)
// onExecuteLink = "_-2UN" (String#20215, DoABC#2)
// handleParkBusCannotEnter = "_-33L" (String#21635, DoABC#2)
// showGenericNotification = "_-1Mw" (String#5290, DoABC#2)
// addSongPlayingNotification = "_-fE" (String#8499, DoABC#2)
// _SafeStr_12121 = "_-0FD" (String#14653, DoABC#2)
// _SafeStr_12122 = "_-tE" (String#24415, DoABC#2)
// _SafeStr_12123 = "_-0O8" (String#14994, DoABC#2)
// _SafeStr_12124 = "_-1ZR" (String#17868, DoABC#2)
// _SafeStr_12125 = "_-0qq" (String#16080, DoABC#2)
// _SafeStr_12126 = "_-1CN" (String#16960, DoABC#2)
// _SafeStr_12127 = "_-1nB" (String#18432, DoABC#2)
// _SafeStr_12128 = "_-1GJ" (String#17127, DoABC#2)
// _SafeStr_12129 = "_-2iR" (String#20786, DoABC#2)
// _SafeStr_12130 = "_-3Gm" (String#22154, DoABC#2)
// _SafeStr_12131 = "_-36z" (String#21766, DoABC#2)
// _SafeStr_12132 = "_-0iA" (String#15756, DoABC#2)
// _SafeStr_12133 = "_-ou" (String#24232, DoABC#2)
// _SafeStr_12134 = "_-3Jb" (String#22268, DoABC#2)
// _SafeStr_12135 = "_-DS" (String#22747, DoABC#2)
// _SafeStr_12136 = "_-fy" (String#23889, DoABC#2)
// _SafeStr_12137 = "_-Lg" (String#23069, DoABC#2)
// _SafeStr_12138 = "_-0dK" (String#15561, DoABC#2)
// getNextItemFromQueue = "_-2k2" (String#20847, DoABC#2)
// onAuthenticationOk = "_-nL" (String#24164, DoABC#2)
// onMOTD = "_-2Pp" (String#20037, DoABC#2)
// onAchievementBonus = "_-zd" (String#24674, DoABC#2)
// onBroadcastMessageEvent = "_-3LF" (String#22336, DoABC#2)
// onInfoFeedEnable = "_-0mG" (String#15906, DoABC#2)
// onModMessageEvent = "_-9o" (String#22610, DoABC#2)
// onUserBannedMessageEvent = "_-1RA" (String#17553, DoABC#2)
// onHotelClosing = "_-0aY" (String#15457, DoABC#2)
// onHotelClosed = "_-2YS" (String#20375, DoABC#2)
// onLoginFailedHotelClosed = "_-1po" (String#18536, DoABC#2)
// onParkBusMessageEvent = "_-1Sp" (String#17616, DoABC#2)
// onPetLevelNotification = "_-gl" (String#23921, DoABC#2)
// onPetReceived = "_-2YT" (String#20376, DoABC#2)
// onPetRespectFailed = "_-38M" (String#7479, DoABC#2)
// onClubGiftNotification = "_-2BW" (String#19466, DoABC#2)
// onClubGiftSelected = "_-0tr" (String#16197, DoABC#2)
// onRoomMessagesNotification = "_-iY" (String#23979, DoABC#2)
// getProductImage = "_-23f" (String#19161, DoABC#2)
// tempCategoryMapping = "_-2br" (String#20517, DoABC#2)
// checkClubEndingNotification = "_-1-p" (String#16461, DoABC#2)
// QuestsList = "_-OQ" (String#23185, DoABC#2)
// CatalogPageMessageOfferData = "_-1vw" (String#5957, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// ClubEndingNotification = "_-2YI" (String#6732, DoABC#2)
// NotificationType = "_-3Fg" (String#22104, DoABC#2)
// InfoHotelClosingMessageParser = "_-1Iy" (String#5219, DoABC#2)
// InfoHotelClosedMessageEvent = "_-0it" (String#15786, DoABC#2)
// RecyclerFinishedMessageEvent = "_-Iu" (String#22964, DoABC#2)
// PurchaseOKMessageEvent = "_-38y" (String#21841, DoABC#2)
// HabboNotificationViewManager = "_-0C9" (String#3794, DoABC#2)
// ClubGiftNotificationEvent = "_-26N" (String#19269, DoABC#2)
// HabboAlertDialogManager = "_-13b" (String#4945, DoABC#2)
// RoomMessageNotificationMessageEvent = "_-0eE" (String#15596, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// MOTDNotificationEvent = "_-2qQ" (String#21099, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// ClubPromoNotification = "_-1jo" (String#5749, DoABC#2)
// ModMessageEvent = "_-2Uh" (String#20226, DoABC#2)
// PurchaseOKMessageParser = "_-2DV" (String#6312, DoABC#2)
// LoginFailedHotelClosedMessageParser = "_-1rF" (String#5879, DoABC#2)
// PetData = "_-01G" (String#1387, DoABC#2)
// ClubGiftSelectedParser = "_-03J" (String#3634, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// HabboBroadcastMessageEvent = "_-0xg" (String#16340, DoABC#2)
// HabboAchievementBonusMessageEvent = "_-2wf" (String#21333, DoABC#2)
// HabboBroadcastMessageParser = "_-05N" (String#3673, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// UserBannedMessageParser = "_-0bm" (String#4342, DoABC#2)
// PetLevelNotificationEvent = "_-3HY" (String#22182, DoABC#2)
// ParkBusCannotEnterMessageParser = "_-2iL" (String#6917, DoABC#2)
// ScrSendUserInfoEvent = "_-202" (String#6048, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// GetMOTDMessageComposer = "_-dZ" (String#23784, DoABC#2)
// PetRespectFailedParser = "_-0Ix" (String#3934, DoABC#2)
// PetLevelNotificationParser = "_-21" (String#6064, DoABC#2)
// PetReceivedMessageEvent = "_-Cf" (String#22711, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// CatalogPageMessageProductData = "_-2mz" (String#7020, DoABC#2)
// UserBannedMessageEvent = "_-uX" (String#24472, DoABC#2)
// RoomMessageNotificationMessageParser = "_-1RL" (String#5382, DoABC#2)
// RecyclerFinishedMessageParser = "_-0EN" (String#3835, DoABC#2)
// ModMessageParser = "_-2IO" (String#6409, DoABC#2)
// LoginFailedHotelClosedMessageEvent = "_-lF" (String#24079, DoABC#2)
// HabboNotificationItem = "_-0sR" (String#4694, DoABC#2)
// HabboNotificationItemStyle = "_-3DT" (String#7585, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// InfoFeedEnableMessageEvent = "_-2wz" (String#21347, DoABC#2)
// ClubGiftNotificationParser = "_-0bP" (String#4331, DoABC#2)
// ClubGiftSelectedEvent = "_-1am" (String#17925, DoABC#2)
// InfoHotelClosedMessageParser = "_-3K9" (String#7707, DoABC#2)
// ParkBusCannotEnterMessageEvent = "_-2yf" (String#21416, DoABC#2)
// ClubGiftNotification = "_-10I" (String#4877, DoABC#2)
// ScrSendUserInfoMessageParser = "_-1vA" (String#18764, DoABC#2)
// XMLVariableParser = "_-pR" (String#24252, DoABC#2)
// AchievementNotificationBonus = "_-1fj" (String#5661, DoABC#2)
// ParkBusDialogManager = "_-1Ta" (String#5425, DoABC#2)
// InfoHotelClosingMessageEvent = "_-0eA" (String#15593, DoABC#2)
// PetRespectFailedEvent = "_-1Pw" (String#17506, DoABC#2)
// PetReceivedMessageParser = "_-iL" (String#8563, DoABC#2)
// MOTDNotificationParser = "_-0ES" (String#3837, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// RespectNotificationMessageEvent = "_-0xG" (String#16323, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// MOTDNotification = "_-298" (String#6231, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IHabboNotifications = "_-0uT" (String#4734, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// boughtAsGift = "_-0XW" (String#15335, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// respectTotal = "_-3KU" (String#22304, DoABC#2)
// RWBIUE_HABBO_CLUB = "_-0ji" (String#15815, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// recyclerFinishedStatus = "_-2UK" (String#20212, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// messageText = "_-0EC" (String#14615, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// BIRE_BADGE_IMAGE_READY = "_-38f" (String#21828, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// _SafeStr_5021 = "_-h-" (String#23930, DoABC#2)
// furniClassId = "_-1lo" (String#18367, DoABC#2)
// bonusPoints = "_-0xr" (String#16347, DoABC#2)
// enabled = "_-0Kh" (String#14868, DoABC#2)
// _disabled = "_-2lG" (String#1933, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// _avatarRenderManager = "_-2uU" (String#454, DoABC#2)
// daysToPeriodEnd = "_-3L6" (String#22328, DoABC#2)
// periodsSubscribedAhead = "_-08y" (String#14405, DoABC#2)
// responseType = "_-0wX" (String#16291, DoABC#2)
// isShowBasicPromo = "_-0L2" (String#14879, DoABC#2)
// basicNormalPrice = "_-1o" (String#18461, DoABC#2)
// basicPromoPrice = "_-fv" (String#23887, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// HabboInventory = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_5996 = "_-Jg" (String#22993, DoABC#2)
// _SafeStr_6296 = "_-1UJ" (String#5438, DoABC#2)
// onRespectNotification = "_-27V" (String#6191, DoABC#2)
// petName = "_-qP" (String#24289, DoABC#2)
// numGifts = "_-2qu" (String#21119, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// _SafeStr_7051 = "_-AU" (String#22635, DoABC#2)
// _SafeStr_7052 = "_-0OP" (String#15005, DoABC#2)
// _SafeStr_7053 = "_-19z" (String#16856, DoABC#2)
// _SafeStr_7061 = "_-3KY" (String#22306, DoABC#2)
// requiredDays = "_-Ac" (String#22640, DoABC#2)
// avatarAgeInDays = "_-0Aw" (String#14486, DoABC#2)
// RoomEngine = "_-0Zc" (String#437, DoABC#2)
// createPetImage = "_-0Qk" (String#4105, DoABC#2)
// SessionDataManager = "_-08L" (String#3728, DoABC#2)
// SessionDataManager = "_-Hc" (String#8029, DoABC#2)
// InfostandWidget = "_-0fM" (String#1522, DoABC#2)
// addItem = "_-3Ev" (String#7610, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// onInventoryReady = "_-dE" (String#374, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// _SafeStr_8287 = "_-Qo" (String#23277, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// WE_CANCEL = "_-0gf" (String#15696, DoABC#2)


