
package com.sulake.habbo.catalog
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.geom.Point;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.catalog.viewer.CatalogViewer;
    import com.sulake.habbo.catalog.navigation.ICatalogNavigator;
    import com.sulake.habbo.catalog.purse.Purse;
    import com.sulake.habbo.catalog.recycler.RecyclerLogic;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.purchase.PurchaseConfirmationDialog;
    import com.sulake.habbo.catalog.purchase.ChargeConfirmationDialog;
    import com.sulake.habbo.catalog.purchase.GiftWrappingConfiguration;
    import com.sulake.habbo.catalog.club.ClubGiftController;
    import com.sulake.habbo.catalog.club.ClubBuyController;
    import com.sulake.habbo.catalog.club.ClubExtendController;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import com.sulake.habbo.catalog.purchase.PlacedObjectPurchaseData;
    import com.sulake.habbo.catalog.viewer.RoomPreviewer;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.catalog.event.CatalogEvent;
    import com.sulake.core.Core;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseVipMembershipExtensionComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseBasicMembershipExtensionComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogAsGiftComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ApproveNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.recycler.GetRecyclerStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.recycler.GetRecyclerPrizesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.recycler.RecycleItemsMessageComposer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetIsOfferGiftableComposer;
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftReceiverNotFoundEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.purse.CreditBalanceEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemOkMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ApproveNameMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerFinishedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerPrizesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.IsOfferGiftableMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.SellablePetBreedsMessageEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryItemAddedEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.core.localization.ILocalization;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.catalog.recycler.IRecycler;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetOwnOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.RedeemOfferCreditsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.CancelOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSellablePetBreedsComposer;
    import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.events.Event;
    import com.sulake.habbo.catalog.enum.HabboCatalogTrackingEvent;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogIndexComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.MarkCatalogNewAdditionsPageOpenedComposer;
    import com.sulake.habbo.catalog.navigation.CatalogNavigator;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceLogic;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetGiftWrappingConfigurationComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageMessageParser;
    import com.sulake.habbo.catalog.viewer.PageLocalization;
    import com.sulake.habbo.catalog.viewer.IPageLocalization;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseNotAllowedMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.NotEnoughBalanceMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.ApproveNameMessageParser;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.purse.CreditBalanceParser;
    import com.sulake.habbo.sound.HabboSoundTypesEnum;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftInfoParser;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerFinishedMessageParser;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerPrizesMessageParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;
    import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.habbo.communication.messages.parser.catalog.SellablePetBreedsParser;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetBreedsEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import com.sulake.habbo.communication.messages.outgoing.catalog.RedeemVoucherMessageComposer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.iid.*;

    public class HabboCatalog extends Component implements IHabboCatalog, IProductDataListener, IUpdateReceiver 
    {

        private static const _SafeStr_10581:uint = 1;

        private const _SafeStr_4231:Point = new Point(100, 20);

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _toolbar:IHabboToolbar;
        private var _configuration:IHabboConfigurationManager;
        private var _roomEngine:IRoomEngine;
        private var _roomSessionManager:IRoomSessionManager;
        private var _roomSession:IRoomSession;
        private var _localization:ICoreLocalizationManager;
        private var _inventory:IHabboInventory;
        private var _sessionDataManager:ISessionDataManager;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _soundManager:IHabboSoundManager;
        private var _friendList:IHabboFriendList;
        private var _initialized:Boolean = false;
        private var _SafeStr_10584:CatalogViewer;
        private var _SafeStr_10585:ICatalogNavigator;
        private var _purse:Purse;
        private var _recycler:RecyclerLogic;
        private var _marketPlace:IMarketPlace;
        private var _mainContainer:IWindowContainer;
        private var _SafeStr_5427:PurchaseConfirmationDialog;
        private var _chargeConfirmationDialog:ChargeConfirmationDialog;
        private var _SafeStr_10589:String = "";
        private var _SafeStr_10590:int = -1;
        private var _SafeStr_10591:int = -1;
        private var _SafeStr_10592:Boolean = true;
        private var _SafeStr_10593:Boolean = true;
        private var _privateRoomSessionActive:Boolean = false;
        private var _giftWrappingConfiguration:GiftWrappingConfiguration;
        private var _clubGiftController:ClubGiftController;
        private var _clubBuyController:ClubBuyController;
        private var _clubExtendController:ClubExtendController;
        private var _SafeStr_10599:Map;
        private var _SafeStr_7797:Boolean = false;
        private var _SafeStr_10600:IPurchasableOffer;
        private var _SafeStr_10601:IDragAndDropDoneReceiver;
        private var _SafeStr_10602:PlacedObjectPurchaseData;
        private var _newAdditionsAvailable:Boolean;
        private var _SafeStr_10604:Boolean;
        private var _roomPreviewer:RoomPreviewer;

        public function HabboCatalog(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._SafeStr_10599 = new Map();
            super(_arg_1, _arg_2, _arg_3);
            this._purse = new Purse();
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDCoreLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDSessionDataManager(), this.sessionDataManagerReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
            registerUpdateReceiver(this, 1);
        }
        public static function setElementImageCentered(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:int=0):void
        {
            var _local_7:IBitmapWrapperWindow;
            var _local_8:IDisplayObjectWrapper;
            if (_arg_2 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.disposed){
                return;
            };
            var _local_4:int = (((_arg_3)>0) ? _arg_3 : _arg_1.height);
            var _local_5:int = ((_arg_1.width - _arg_2.width) / 2);
            var _local_6:int = ((_local_4 - _arg_2.height) / 2);
            if ((_arg_1 as IBitmapWrapperWindow) != null){
                _local_7 = IBitmapWrapperWindow(_arg_1);
                if ((((_local_7.bitmap == null)) || ((_arg_3 > 0)))){
                    _local_7.bitmap = new BitmapData(_arg_1.width, _local_4, true, 0xFFFFFF);
                };
                _local_7.bitmap.fillRect(_local_7.bitmap.rect, 0xFFFFFF);
                _local_7.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_5, _local_6), null, null, false);
                _arg_1.invalidate();
            }
            else {
                if ((_arg_1 as IDisplayObjectWrapper) != null){
                    _local_8 = IDisplayObjectWrapper(_arg_1);
                    _local_8.setDisplayObject(new Bitmap(_arg_2));
                    _arg_1.invalidate();
                    Logger.log(((((((("WRAPPER SET: " + _arg_2.width) + ", ") + _arg_2.height) + ", ") + _local_8.rectangle) + ", ") + _local_8.visible));
                };
            };
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (this._sessionDataManager);
        }
        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (this._avatarRenderManager);
        }
        public function get localization():ICoreLocalizationManager
        {
            return (this._localization);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        public function get connection():IConnection
        {
            return (this._communication.getHabboMainConnection(null));
        }
        public function get giftWrappingConfiguration():GiftWrappingConfiguration
        {
            return (this._giftWrappingConfiguration);
        }
        public function get roomEngine():IRoomEngine
        {
            return (this._roomEngine);
        }
        public function get soundManager():IHabboSoundManager
        {
            return (this._soundManager);
        }
        public function get roomPreviewer():RoomPreviewer
        {
            return (this._roomPreviewer);
        }
        override public function dispose():void
        {
            removeUpdateReceiver(this);
            this.reset(true);
            if (this._toolbar){
                this._toolbar.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
            if (this._soundManager){
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            if (this._sessionDataManager){
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._avatarRenderManager){
                this._avatarRenderManager.release(new IIDAvatarRenderManager());
                this._avatarRenderManager = null;
            };
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
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
                this._localization.release(new IIDCoreLocalizationManager());
                this._localization = null;
            };
            if (this._roomEngine != null){
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this._windowManager != null){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._communication != null){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._SafeStr_5427 != null){
                this._SafeStr_5427.dispose();
                this._SafeStr_5427 = null;
            };
            if (this._chargeConfirmationDialog != null){
                this._chargeConfirmationDialog.dispose();
                this._chargeConfirmationDialog = null;
            };
            if (this._recycler != null){
                this._recycler.dispose();
                this._recycler = null;
            };
            this._purse = null;
            this._marketPlace = null;
            if (this._clubBuyController != null){
                this._clubBuyController.dispose();
                this._clubBuyController = null;
            };
            if (this._clubExtendController != null){
                this._clubExtendController.dispose();
                this._clubExtendController = null;
            };
            if (this._SafeStr_10599 != null){
                this._SafeStr_10599.dispose();
                this._SafeStr_10599 = null;
            };
            this._roomSession = null;
            if (this._roomSessionManager != null){
                this._roomSessionManager.events.removeEventListener(RoomSessionEvent.RSE_STARTED, this.onRoomSessionEvent);
                this._roomSessionManager.events.removeEventListener(RoomSessionEvent.RSE_ENDED, this.onRoomSessionEvent);
                this._roomSessionManager.release(new IIDHabboRoomSessionManager());
                this._roomSessionManager = null;
            };
            this.resetPlacedOfferData();
            this._SafeStr_7797 = false;
            this._SafeStr_10601 = null;
            if (this._roomPreviewer != null){
                this._roomPreviewer.dispose();
                this._roomPreviewer = null;
            };
            super.dispose();
        }
        private function init():void
        {
            if (!this._initialized){
                this.createMainWindow();
                this.createCatalogNavigator();
                this.createCatalogViewer();
                this.refreshCatalogIndex();
                this._initialized = true;
                events.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_INITIALIZED));
                this.updatePurse();
                this.createRecycler();
                this.createMarketPlace();
                this.createClubGiftController();
                this.getGiftWrappingConfiguration();
                this.createClubBuyController();
                this.createClubExtendController();
            };
        }
        private function reset(_arg_1:Boolean=false):void
        {
            var _local_2:Boolean;
            this._initialized = false;
            if (this._SafeStr_10584 != null){
                this._SafeStr_10584.dispose();
                this._SafeStr_10584 = null;
            };
            if (this._SafeStr_10585 != null){
                this._SafeStr_10585.dispose();
                this._SafeStr_10585 = null;
            };
            if (this._mainContainer != null){
                this._mainContainer.dispose();
                this._mainContainer = null;
            };
            if (!_arg_1){
                if (this._sessionDataManager == null){
                    Core.crash("Could not reload product data after reset() because _sessionDataManager was null", Core._SafeStr_9853);
                    return;
                };
                events.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_NOT_READY));
                _local_2 = this._sessionDataManager.loadProductData(this);
                if (_local_2){
                    this.init();
                };
            };
        }
        public function loadCatalogPage(_arg_1:int, _arg_2:int):void
        {
            this._communication.getHabboMainConnection(null).send(new GetCatalogPageComposer(_arg_1, _arg_2));
        }
        public function purchaseProduct(_arg_1:int, _arg_2:int, _arg_3:String=""):void
        {
            var _local_4:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_4 == null){
                return;
            };
            _local_4.send(new PurchaseFromCatalogComposer(_arg_1, _arg_2, _arg_3));
        }
        public function purchaseVipMembershipExtension(_arg_1:int):void
        {
            var _local_2:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_2 == null){
                return;
            };
            _local_2.send(new PurchaseVipMembershipExtensionComposer(_arg_1));
        }
        public function purchaseBasicMembershipExtension(_arg_1:int):void
        {
            var _local_2:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_2 == null){
                return;
            };
            _local_2.send(new PurchaseBasicMembershipExtensionComposer(_arg_1));
        }
        public function purchaseProductAsGift(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:int, _arg_8:int):void
        {
            var _local_9:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_9 == null){
                return;
            };
            _local_9.send(new PurchaseFromCatalogAsGiftComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8));
        }
        public function approveName(_arg_1:String, _arg_2:int):void
        {
            this._communication.getHabboMainConnection(null).send(new ApproveNameMessageComposer(_arg_1, _arg_2));
        }
        public function getRecyclerStatus():void
        {
            this._communication.getHabboMainConnection(null).send(new GetRecyclerStatusMessageComposer());
        }
        public function getRecyclerPrizes():void
        {
            this._communication.getHabboMainConnection(null).send(new GetRecyclerPrizesMessageComposer());
        }
        public function sendRecycleItems(_arg_1:Array):void
        {
            this._communication.getHabboMainConnection(null).send(new RecycleItemsMessageComposer(_arg_1));
        }
        public function showPurchaseConfirmation(_arg_1:IPurchasableOffer, _arg_2:int, _arg_3:String="", _arg_4:Boolean=true):void
        {
            var _local_5:Array;
            Logger.log(("buy: " + [_arg_1.offerId, _arg_3]));
            if ((((_arg_1.priceInCredits > 0)) && ((_arg_1.priceInCredits > this._purse.credits)))){
                this.showNotEnoughCreditsAlert();
                return;
            };
            if ((((_arg_1.priceInActivityPoints > 0)) && ((_arg_1.priceInActivityPoints > this._purse.getActivityPointsForType(_arg_1.activityPointType))))){
                this.showNotEnoughActivityPointsAlert(_arg_1.activityPointType);
                return;
            };
            if ((_arg_1 is Offer)){
                if ((((this._SafeStr_5427 == null)) || (this._SafeStr_5427.disposed))){
                    this._SafeStr_5427 = new PurchaseConfirmationDialog(this._localization);
                };
                _local_5 = [];
                if (this._friendList != null){
                    _local_5 = this._friendList.getFriendNames();
                };
                this._SafeStr_5427.showOffer(this, this._roomEngine, _arg_1, _arg_2, _arg_3, _local_5);
                if (_arg_4){
                    this._communication.getHabboMainConnection(null).send(new GetIsOfferGiftableComposer(_arg_1.offerId));
                };
            }
            else {
                if ((_arg_1 is ClubBuyOfferData)){
                    this._clubBuyController.showConfirmation((_arg_1 as ClubBuyOfferData), _arg_2);
                };
            };
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = (_arg_2 as IHabboWindowManager);
        }
        private function onCommunicationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communication = (_arg_2 as IHabboCommunicationManager);
            this._communication.addHabboConnectionMessageEvent(new CatalogIndexMessageEvent(this.onCatalogIndex));
            this._communication.addHabboConnectionMessageEvent(new CatalogPageMessageEvent(this.onCatalogPage));
            this._communication.addHabboConnectionMessageEvent(new CatalogPublishedMessageEvent(this.onCatalogPublished));
            this._communication.addHabboConnectionMessageEvent(new PurchaseErrorMessageEvent(this.onPurchaseError));
            this._communication.addHabboConnectionMessageEvent(new PurchaseNotAllowedMessageEvent(this.onPurchaseNotAllowed));
            this._communication.addHabboConnectionMessageEvent(new PurchaseOKMessageEvent(this.onPurchaseOK));
            this._communication.addHabboConnectionMessageEvent(new GiftReceiverNotFoundEvent(this.onGiftReceiverNotFound));
            this._communication.addHabboConnectionMessageEvent(new NotEnoughBalanceMessageEvent(this.onNotEnoughBalance));
            this._communication.addHabboConnectionMessageEvent(new CreditBalanceEvent(this.onCreditBalance));
            this._communication.addHabboConnectionMessageEvent(new HabboActivityPointNotificationMessageEvent(this.onActivityPointNotification));
            this._communication.addHabboConnectionMessageEvent(new ActivityPointsMessageEvent(this.onActivityPoints));
            this._communication.addHabboConnectionMessageEvent(new VoucherRedeemOkMessageEvent(this.onVoucherRedeemOk));
            this._communication.addHabboConnectionMessageEvent(new VoucherRedeemErrorMessageEvent(this.onVoucherRedeemError));
            this._communication.addHabboConnectionMessageEvent(new ApproveNameMessageEvent(this.onApproveNameResult));
            this._communication.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(this.onSubscriptionInfo));
            this._communication.addHabboConnectionMessageEvent(new ClubGiftInfoEvent(this.onClubGiftInfo));
            this._communication.addHabboConnectionMessageEvent(new RecyclerStatusMessageEvent(this.onRecyclerStatus));
            this._communication.addHabboConnectionMessageEvent(new RecyclerFinishedMessageEvent(this.onRecyclerFinished));
            this._communication.addHabboConnectionMessageEvent(new RecyclerPrizesMessageEvent(this.onRecyclerPrizes));
            this._communication.addHabboConnectionMessageEvent(new MarketPlaceOffersEvent(this.onMarketPlaceOffers));
            this._communication.addHabboConnectionMessageEvent(new MarketPlaceOwnOffersEvent(this.onMarketPlaceOwnOffers));
            this._communication.addHabboConnectionMessageEvent(new MarketplaceBuyOfferResultEvent(this.onMarketPlaceBuyResult));
            this._communication.addHabboConnectionMessageEvent(new MarketplaceCancelOfferResultEvent(this.onMarketPlaceCancelResult));
            this._communication.addHabboConnectionMessageEvent(new GiftWrappingConfigurationEvent(this.onGiftWrappingConfiguration));
            this._communication.addHabboConnectionMessageEvent(new MarketplaceItemStatsEvent(this.onMarketplaceItemStats));
            this._communication.addHabboConnectionMessageEvent(new IsOfferGiftableMessageEvent(this.onIsOfferGiftable));
            this._communication.addHabboConnectionMessageEvent(new MarketplaceConfigurationEvent(this.onMarketplaceConfiguration));
            this._communication.addHabboConnectionMessageEvent(new MarketplaceMakeOfferResult(this.onMarketplaceMakeOfferResult));
            this._communication.addHabboConnectionMessageEvent(new HabboClubOffersMessageEvent(this.onHabboClubOffers));
            this._communication.addHabboConnectionMessageEvent(new HabboClubExtendOfferMessageEvent(this.onHabboClubExtendOffer));
            this._communication.addHabboConnectionMessageEvent(new ChargeInfoMessageEvent(this.onChargeInfo));
            this._communication.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            this._communication.addHabboConnectionMessageEvent(new SellablePetBreedsMessageEvent(this.onSellableBreeds));
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._toolbar = (_arg_2 as IHabboToolbar);
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._configuration = (_arg_2 as IHabboConfigurationManager);
            this._SafeStr_10604 = this.isNewItemsNotificationEnabled();
            this.initializeRoomPreviewer();
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localization = (_arg_2 as ICoreLocalizationManager);
        }
        private function onInventoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._inventory = (_arg_2 as IHabboInventory);
            this._inventory.events.addEventListener(HabboInventoryItemAddedEvent.HABBO_INVENTORY_ITEM_ADDED, this.onItemAddedToInventory);
        }
        private function sessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
            this._sessionDataManager.loadProductData(this);
        }
        private function onAvatarRenderManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._avatarRenderManager = (_arg_2 as IAvatarRenderManager);
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._roomEngine = (_arg_2 as IRoomEngine);
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.onObjectPlaced);
            this.initializeRoomPreviewer();
        }
        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._soundManager = (_arg_2 as IHabboSoundManager);
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:IRoomSessionManager = IRoomSessionManager(_arg_2);
            _local_3.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.onRoomSessionEvent);
            _local_3.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.onRoomSessionEvent);
        }
        private function onFriendListReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._friendList = (_arg_2 as IHabboFriendList);
        }
        private function initializeRoomPreviewer():void
        {
            if (((((!((this._roomEngine == null))) && (!((this._configuration == null))))) && ((this._configuration.getKey("catalog.furniture.animation", "false") == "true")))){
                if (this._roomPreviewer == null){
                    this._roomPreviewer = new RoomPreviewer(this._roomEngine);
                };
            };
        }
        private function isNewItemsNotificationEnabled():Boolean
        {
            return (this._configuration.getBoolean("toolbar.new_additions.notification.enabled", false));
        }
        public function openCatalog():void
        {
            this.cancelFurniInMover();
            this.toggleCatalog(true);
        }
        public function openCatalogPage(_arg_1:String, _arg_2:Boolean=false):void
        {
            this.cancelFurniInMover();
            if (_arg_2){
                _arg_1 = this.getLocalizedPageName(_arg_1);
            };
            if (((((!(this._initialized)) || (!(this._SafeStr_10585)))) || (!(this._SafeStr_10585.isInitialized())))){
                this.toggleCatalog(true);
                this._SafeStr_10590 = -1;
                this._SafeStr_10589 = _arg_1;
            }
            else {
                this.toggleCatalog(true);
                this._SafeStr_10585.openPage(_arg_1);
            };
        }
        public function openCatalogPageById(_arg_1:int, _arg_2:int):void
        {
            if (this._initialized){
                this.toggleCatalog(true);
                this._SafeStr_10585.openPageById(_arg_1, _arg_2);
            }
            else {
                this.toggleCatalog();
                this._SafeStr_10590 = _arg_1;
                this._SafeStr_10591 = _arg_2;
                this._SafeStr_10589 = null;
            };
        }
        private function getLocalizedPageName(_arg_1:String):String
        {
            var _local_2:ILocalization = this._localization.getLocalization(_arg_1);
            if (_local_2 != null){
                _arg_1 = _local_2.value;
            };
            return (_arg_1);
        }
        public function openInventoryCategory(_arg_1:String):void
        {
            if (this._inventory == null){
                return;
            };
            this._inventory.toggleInventoryPage(_arg_1);
        }
        public function openCreditsHabblet():void
        {
            var _local_2:String;
            if (this._configuration == null){
                return;
            };
            var _local_1 = (this._configuration.getKey("client.credits.embed.enabled", "false") == "true");
            if (((ExternalInterface.available) && (_local_1))){
                ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
            }
            else {
                _local_2 = this._configuration.getKey("link.format.credits", "/credits");
                this._windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                HabboWebTools.navigateToURL(_local_2, "habboMain");
            };
        }
        public function setupInventoryForRecycler(_arg_1:Boolean):void
        {
            if (this._inventory == null){
                return;
            };
            this._inventory.setupRecycler(_arg_1);
        }
        public function get privateRoomSessionActive():Boolean
        {
            return (this._privateRoomSessionActive);
        }
        public function get tradingActive():Boolean
        {
            if (this._inventory == null){
                return (false);
            };
            return (this._inventory.tradingActive);
        }
        public function requestInventoryFurniToRecycler():int
        {
            if (this._inventory == null){
                return (0);
            };
            return (this._inventory.requestSelectedFurniToRecycler());
        }
        public function returnInventoryFurniFromRecycler(_arg_1:int):Boolean
        {
            if (this._inventory == null){
                return (false);
            };
            return (this._inventory.returnInventoryFurniFromRecycler(_arg_1));
        }
        public function getProductData(_arg_1:String):IProductData
        {
            return (this._sessionDataManager.getProductData(_arg_1));
        }
        public function getFurnitureData(_arg_1:int, _arg_2:String):IFurnitureData
        {
            var _local_3:IFurnitureData;
            if (_arg_2 == ProductTypeEnum._SafeStr_5017){
                _local_3 = this._sessionDataManager.getFloorItemData(_arg_1);
            };
            if (_arg_2 == ProductTypeEnum._SafeStr_5019){
                _local_3 = this._sessionDataManager.getWallItemData(_arg_1);
            };
            return (_local_3);
        }
        public function getPurse():IPurse
        {
            return (this._purse);
        }
        public function getRecycler():IRecycler
        {
            return (this._recycler);
        }
        public function getMarketPlace():IMarketPlace
        {
            return (this._marketPlace);
        }
        public function getClubGiftController():ClubGiftController
        {
            return (this._clubGiftController);
        }
        public function getClubBuyController():ClubBuyController
        {
            return (this._clubBuyController);
        }
        public function getClubExtendController():ClubExtendController
        {
            return (this._clubExtendController);
        }
        public function getPublicMarketPlaceOffers(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):void
        {
            this._communication.getHabboMainConnection(null).send(new GetOffersMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4));
        }
        public function getOwnMarketPlaceOffers():void
        {
            this._communication.getHabboMainConnection(null).send(new GetOwnOffersMessageComposer());
        }
        public function buyMarketPlaceOffer(_arg_1:int):void
        {
            this._communication.getHabboMainConnection(null).send(new BuyOfferMessageComposer(_arg_1));
        }
        public function redeemSoldMarketPlaceOffers():void
        {
            this._communication.getHabboMainConnection(null).send(new RedeemOfferCreditsMessageComposer());
        }
        public function redeemExpiredMarketPlaceOffer(_arg_1:int):void
        {
            this._communication.getHabboMainConnection(null).send(new CancelOfferMessageComposer(_arg_1));
        }
        public function getMarketplaceItemStats(_arg_1:int, _arg_2:int):void
        {
            if (!this._communication){
                return;
            };
            var _local_3:IConnection = this._communication.getHabboMainConnection(null);
            if (!_local_3){
                return;
            };
            _local_3.send(new GetMarketplaceItemStatsComposer(_arg_1, _arg_2));
        }
        public function getPixelEffectIcon(_arg_1:int):BitmapData
        {
            var _local_2:BitmapDataAsset = ((this._inventory as Component).assets.getAssetByName((("fx_icon_" + _arg_1) + "_png")) as BitmapDataAsset);
            if (_local_2 != null){
                return ((_local_2.content as BitmapData).clone());
            };
            return (new BitmapData(1, 1, true, 0xFFFFFF));
        }
        public function getSubscriptionProductIcon(_arg_1:int):BitmapData
        {
            var _local_2:BitmapDataAsset = (assets.getAssetByName("ctlg_icon_deal_hc") as BitmapDataAsset);
            if (_local_2 != null){
                return ((_local_2.content as BitmapData).clone());
            };
            return (new BitmapData(1, 1, true, 0xFFFFFF));
        }
        public function getSellablePetBreeds(_arg_1:String):Array
        {
            var _local_2:Array = this._SafeStr_10599.getValue(_arg_1);
            if (_local_2 != null){
                return (_local_2.slice());
            };
            this._communication.getHabboMainConnection(null).send(new GetSellablePetBreedsComposer(_arg_1));
            return (null);
        }
        private function updatePurse():void
        {
            var _local_2:String;
            if (this._mainContainer == null){
                return;
            };
            this._localization.registerParameter("catalog.purse.creditbalance", "balance", String(this._purse.credits));
            this._localization.registerParameter("catalog.purse.pixelbalance", "balance", String(this._purse.getActivityPointsForType(ActivityPointTypeEnum.PIXEL)));
            var _local_1:uint = HabboIconType._SafeStr_7426;
            if (!this._purse.hasClubLeft){
                _local_2 = "catalog.purse.club.join";
            }
            else {
                if (this._purse.isVIP){
                    _local_2 = "catalog.purse.vipdays";
                    _local_1 = HabboIconType._SafeStr_7427;
                }
                else {
                    _local_2 = "catalog.purse.clubdays";
                };
                this._localization.registerParameter(_local_2, "days", String(this._purse.clubDays));
                this._localization.registerParameter(_local_2, "months", String(this._purse.clubPeriods));
            };
            var _local_3:IIconWindow = (this._mainContainer.findChildByName("clubIcon") as IIconWindow);
            if (_local_3){
                _local_3.style = _local_1;
            };
            var _local_4:ITextWindow = (this._mainContainer.findChildByName("clubText") as ITextWindow);
            if (_local_4){
                _local_4.caption = this._localization.getKey(_local_2);
            };
        }
        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if ((((_arg_1.iconId == HabboToolbarIconEnum.CATALOGUE)) && ((_arg_1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK)))){
                this.toggleCatalog();
            };
        }
        private function toggleCatalog(_arg_1:Boolean=false):void
        {
            this.cancelFurniInMover();
            if (this._mainContainer == null){
                return;
            };
            if (((!(this.mainWindowVisible())) || (_arg_1))){
                if (this._newAdditionsAvailable){
                    this._newAdditionsAvailable = false;
                    events.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_NEW_ITEMS_HIDE));
                    this.markNewAdditionPageOpened();
                };
                this.showMainWindow();
            }
            else {
                if (!WindowToggle.isHiddenByOtherWindows(this._mainContainer)){
                    this.hideMainWindow();
                };
            };
            if (this.mainWindowVisible()){
                this._mainContainer.activate();
                HabboTracking.getInstance().trackGoogle("catalogue", "open");
            };
            if (this.mainWindowVisible()){
                events.dispatchEvent(new Event(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN));
                if (((!((this._recycler == null))) && ((this.getCurrentLayoutCode() == "recycler")))){
                    this._recycler.activate();
                };
            }
            else {
                events.dispatchEvent(new Event(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE));
                if (((!((this._recycler == null))) && ((this.getCurrentLayoutCode() == "recycler")))){
                    this._recycler.cancel();
                };
            };
            this.setupInventoryForRecycler(((this._recycler.active) && (this.mainWindowVisible())));
        }
        private function getCurrentLayoutCode():String
        {
            if (this._SafeStr_10584 == null){
                return ("");
            };
            return (this._SafeStr_10584.getCurrentLayoutCode());
        }
        private function refreshCatalogIndex():void
        {
            this._communication.getHabboMainConnection(null).send(new GetCatalogIndexComposer());
        }
        private function markNewAdditionPageOpened():void
        {
            this._communication.getHabboMainConnection(null).send(new MarkCatalogNewAdditionsPageOpenedComposer());
        }
        private function createCatalogNavigator():void
        {
            var _local_1:IWindowContainer = (this._mainContainer.findChildByName("navigatorMain") as IWindowContainer);
            this._SafeStr_10585 = (new CatalogNavigator(this, _local_1) as ICatalogNavigator);
            var _local_2:BitmapDataAsset = (assets.getAssetByName("purse_coins_small") as BitmapDataAsset);
            this.setElementImage("creditsIcon", (_local_2.content as BitmapData));
            var _local_3:BitmapDataAsset = (assets.getAssetByName("purse_pixels_small") as BitmapDataAsset);
            this.setElementImage("pixelsIcon", (_local_3.content as BitmapData));
            var _local_4:BitmapDataAsset = (assets.getAssetByName("purse_club_small") as BitmapDataAsset);
            this.setElementImage("clubIcon", (_local_4.content as BitmapData));
        }
        private function createCatalogViewer():void
        {
            var _local_1:IWindowContainer = (this._mainContainer.findChildByName("layoutContainer") as IWindowContainer);
            this._SafeStr_10584 = new CatalogViewer(this, _local_1, this._roomEngine);
            this._SafeStr_10584.habboCatalog = this;
        }
        private function createMainWindow():void
        {
            var _local_1:String = "catalog";
            if (this._configuration.getBoolean("catalog.show.purse", false)){
                _local_1 = "catalog_with_purse";
            };
            var _local_2:XmlAsset = (assets.getAssetByName(_local_1) as XmlAsset);
            this._mainContainer = (this._windowManager.buildFromXML((_local_2.content as XML), _SafeStr_10581) as IWindowContainer);
            this._mainContainer.tags.push("habbo_catalog");
            this._mainContainer.position = this._SafeStr_4231;
            this.hideMainWindow();
            var _local_3:BitmapDataAsset = (assets.getAssetByName("layout_bg") as BitmapDataAsset);
            this.setElementImage("layoutBackground", (_local_3.content as BitmapData));
            var _local_4:IWindowContainer = (this._mainContainer.findChildByName("navigatorMain") as IWindowContainer);
            _local_4.setParamFlag(WindowParam._SafeStr_7486, false);
            var _local_5:IWindow = this._mainContainer.findChildByName("titlebar_close_button");
            if (_local_5 == null){
                _local_5 = this._mainContainer.findChildByTag("close");
            };
            if (_local_5 != null){
                _local_5.procedure = this.onWindowClose;
            };
        }
        private function onRoomSessionEvent(_arg_1:RoomSessionEvent):void
        {
            switch (_arg_1.type){
                case RoomSessionEvent.RSE_STARTED:
                    this._privateRoomSessionActive = _arg_1.session.isPrivateRoom;
                    this._roomSession = _arg_1.session;
                    if (this._recycler != null){
                        this._recycler.setRoomSessionActive(true);
                    };
                    return;
                case RoomSessionEvent.RSE_ENDED:
                    this._privateRoomSessionActive = false;
                    this._roomSession = null;
                    if (this._recycler != null){
                        this._recycler.setRoomSessionActive(false);
                    };
                    return;
            };
        }
        private function createRecycler():void
        {
            this._recycler = new RecyclerLogic(this, this._windowManager);
            this.getRecyclerPrizes();
        }
        private function createMarketPlace():void
        {
            if (this._marketPlace == null){
                this._marketPlace = new MarketPlaceLogic(this, this._windowManager, this._roomEngine);
            };
        }
        private function createClubGiftController():void
        {
            if (this._clubGiftController == null){
                this._clubGiftController = new ClubGiftController(this);
            };
        }
        private function createClubBuyController():void
        {
            if (this._clubBuyController == null){
                this._clubBuyController = new ClubBuyController(this);
            };
        }
        private function createClubExtendController():void
        {
            if (this._clubExtendController == null){
                this._clubExtendController = new ClubExtendController(this);
            };
        }
        private function getGiftWrappingConfiguration():void
        {
            var _local_1:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_1 == null){
                return;
            };
            _local_1.send(new GetGiftWrappingConfigurationComposer());
        }
        public function getHabboClubOffers():void
        {
            var _local_1:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_1 == null){
                return;
            };
            _local_1.send(new GetClubOffersMessageComposer());
        }
        public function getHabboClubExtendOffer():void
        {
            var _local_1:IConnection = this._communication.getHabboMainConnection(null);
            if (_local_1 == null){
                return;
            };
            _local_1.send(new GetHabboClubExtendOfferMessageComposer());
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.hideMainWindow();
            if (this._SafeStr_10584 != null){
                this._SafeStr_10584.catalogWindowClosed();
            };
            if (((!((this._recycler == null))) && ((this.getCurrentLayoutCode() == "recycler")))){
                this._recycler.cancel();
                this.setupInventoryForRecycler(false);
            };
        }
        private function onCatalogIndex(_arg_1:IMessageEvent):void
        {
            if ((_arg_1 as CatalogIndexMessageEvent) == null){
                return;
            };
            if (this._SafeStr_10585 == null){
                return;
            };
            var _local_2:NodeData = (_arg_1 as CatalogIndexMessageEvent).root;
            this._newAdditionsAvailable = (_arg_1 as CatalogIndexMessageEvent).newAdditionsAvailable;
            this._SafeStr_10585.buildCatalogIndex(_local_2);
            if (((this._SafeStr_10589) && (!((this._SafeStr_10589 == ""))))){
                this._SafeStr_10585.openPage(this._SafeStr_10589);
                this._SafeStr_10589 = "";
                this._SafeStr_10590 = -1;
            }
            else {
                if (this._SafeStr_10590 > -1){
                    this._SafeStr_10585.openPageById(this._SafeStr_10590, this._SafeStr_10591);
                    this._SafeStr_10590 = -1;
                    this._SafeStr_10591 = -1;
                    this._SafeStr_10589 = "";
                }
                else {
                    if (((this._newAdditionsAvailable) && (this._SafeStr_10604))){
                        events.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_NEW_ITEMS_SHOW));
                        this._SafeStr_10585.loadNewAdditionsPage(this.getLocalizedPageName(CatalogPageName._SafeStr_6009));
                    }
                    else {
                        this._SafeStr_10585.loadFrontPage();
                    };
                };
            };
        }
        private function onCatalogPage(_arg_1:IMessageEvent):void
        {
            var _local_2:CatalogPageMessageEvent = (_arg_1 as CatalogPageMessageEvent);
            var _local_3:CatalogPageMessageParser = _local_2.getParser();
            var _local_4:int = _local_3.pageId;
            var _local_5:String = _local_3.layoutCode;
            var _local_6:Array = _local_3.localization.images.concat();
            var _local_7:Array = _local_3.localization.texts.concat();
            var _local_8:IPageLocalization = new PageLocalization(_local_6, _local_7);
            var _local_9:int = _local_3.offerId;
            this._SafeStr_10584.showCatalogPage(_local_4, _local_5, _local_8, _local_3.offers, _local_9);
        }
        private function onCatalogPublished(_arg_1:IMessageEvent):void
        {
            var _local_2:Boolean;
            if (this._mainContainer != null){
                _local_2 = this.mainWindowVisible();
            };
            this.reset();
            if (_local_2){
                this._windowManager.alert("${catalog.alert.published.title}", "${catalog.alert.published.description}", 0, this.alertDialogEventProcessor);
            };
        }
        private function onPurchaseError(_arg_1:IMessageEvent):void
        {
            this._windowManager.alert("${catalog.alert.purchaseerror.title}", "${catalog.alert.purchaseerror.description}", 0, this.alertDialogEventProcessor);
        }
        private function onPurchaseNotAllowed(_arg_1:IMessageEvent):void
        {
            var _local_2:PurchaseNotAllowedMessageEvent = (_arg_1 as PurchaseNotAllowedMessageEvent);
            var _local_3:PurchaseNotAllowedMessageParser = _local_2.getParser();
            var _local_4:int = _local_3.errorCode;
            var _local_5:String = "";
            switch (_local_4){
                case 1:
                    _local_5 = "${catalog.alert.purchasenotallowed.hc.description}";
                    break;
                default:
                    _local_5 = "${catalog.alert.purchasenotallowed.unknown.description}";
            };
            this._windowManager.alert("${catalog.alert.purchasenotallowed.title}", _local_5, 0, this.alertDialogEventProcessor);
        }
        private function onPurchaseOK(_arg_1:IMessageEvent):void
        {
            if (this._SafeStr_5427 != null){
                this._SafeStr_5427.dispose();
            };
            this._SafeStr_5427 = null;
        }
        private function onGiftReceiverNotFound(_arg_1:GiftReceiverNotFoundEvent):void
        {
            if (this._SafeStr_5427 != null){
                this._SafeStr_5427.receiverNotFound();
            };
        }
        private function onNotEnoughBalance(_arg_1:IMessageEvent):void
        {
            var _local_2:NotEnoughBalanceMessageEvent = (_arg_1 as NotEnoughBalanceMessageEvent);
            var _local_3:NotEnoughBalanceMessageParser = _local_2.getParser();
            if (_local_3.notEnoughCredits > 0){
                this.showNotEnoughCreditsAlert();
            }
            else {
                if (_local_3.notEnoughActivityPoints > 0){
                    this.showNotEnoughActivityPointsAlert(_local_3.activityPointType);
                };
            };
            if (this._SafeStr_5427 != null){
                this._SafeStr_5427.notEnoughCredits();
            };
        }
        public function showNotEnoughCreditsAlert():void
        {
            if (!this._windowManager){
                return;
            };
            this._windowManager.confirm("${catalog.alert.notenough.title}", "${catalog.alert.notenough.credits.description}", 0, this.noCreditsConfirmDialogEventProcessor);
        }
        private function showNotEnoughActivityPointsAlert(_arg_1:int):void
        {
            var _local_2:String = ("catalog.alert.notenough.activitypoints.title." + _arg_1);
            var _local_3:String = ("catalog.alert.notenough.activitypoints.description." + _arg_1);
            if (_arg_1 == 0){
                this._windowManager.confirm(this.localization.getKey(_local_2), this.localization.getKey(_local_3), 0, this.noPixelsConfirmDialogEventProcessor);
            }
            else {
                this._windowManager.alert(this.localization.getKey(_local_2), this.localization.getKey(_local_3), 0, this.alertDialogEventProcessor);
            };
        }
        private function onVoucherRedeemOk(_arg_1:VoucherRedeemOkMessageEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:String = "${catalog.alert.voucherredeem.ok.description}";
            if (_arg_1.productName != ""){
                _local_2 = "catalog.alert.voucherredeem.ok.description.furni";
                this._localization.registerParameter(_local_2, "productName", _arg_1.productName);
                this._localization.registerParameter(_local_2, "productDescription", _arg_1.productDescription);
                _local_2 = (("${" + _local_2) + "}");
            };
            this._windowManager.alert("${catalog.alert.voucherredeem.ok.title}", _local_2, 0, this.alertDialogEventProcessor);
        }
        private function onVoucherRedeemError(_arg_1:VoucherRedeemErrorMessageEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:String = "${catalog.alert.voucherredeem.error.title}";
            var _local_3 = (("${catalog.alert.voucherredeem.error.description." + _arg_1.errorCode) + "}");
            this._windowManager.alert(_local_2, _local_3, 0, this.alertDialogEventProcessor);
        }
        private function onApproveNameResult(_arg_1:ApproveNameMessageEvent):void
        {
            if ((((_arg_1 == null)) || ((this._SafeStr_10584 == null)))){
                return;
            };
            var _local_2:ApproveNameMessageParser = _arg_1.getParser();
            this._SafeStr_10584.dispatchWidgetEvent(new CatalogWidgetApproveNameResultEvent(_local_2.result, _local_2.nameValidationInfo));
        }
        private function onCreditBalance(_arg_1:IMessageEvent):void
        {
            var _local_2:CreditBalanceEvent = (_arg_1 as CreditBalanceEvent);
            var _local_3:CreditBalanceParser = _local_2.getParser();
            this._purse.credits = _local_3.balance;
            this.updatePurse();
            if (((!(this._SafeStr_10592)) && (!((this._soundManager == null))))){
                this._soundManager.playSound(HabboSoundTypesEnum._SafeStr_10666);
            };
            this._SafeStr_10592 = false;
            if (((!((this._chargeConfirmationDialog == null))) && (!(this._chargeConfirmationDialog.disposed)))){
                this._chargeConfirmationDialog.refresh();
            };
            events.dispatchEvent(new PurseEvent(PurseEvent.RWPUE_CREDIT_BALANCE, this._purse.credits));
            events.dispatchEvent(new PurseUpdateEvent());
        }
        private function onActivityPointNotification(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboActivityPointNotificationMessageEvent = (_arg_1 as HabboActivityPointNotificationMessageEvent);
            this._purse.activityPoints[_local_2.type] = _local_2.amount;
            this.updatePurse();
            if (((!(this._SafeStr_10593)) && (!((this._soundManager == null))))){
                this._soundManager.playSound(HabboSoundTypesEnum._SafeStr_10667);
            };
            this._SafeStr_10593 = false;
            if (((!((this._chargeConfirmationDialog == null))) && (!(this._chargeConfirmationDialog.disposed)))){
                this._chargeConfirmationDialog.refresh();
            };
            if (_local_2.type == ActivityPointTypeEnum.PIXEL){
                events.dispatchEvent(new PurseEvent(PurseEvent.RWPUE_PIXEL_BALANCE, _local_2.amount));
            };
            if (_local_2.type == ActivityPointTypeEnum._SafeStr_6442){
                events.dispatchEvent(new PurseEvent(PurseEvent.RWPUE_SHELL_BALANCE, _local_2.amount));
            };
            events.dispatchEvent(new PurseUpdateEvent());
        }
        private function onActivityPoints(_arg_1:IMessageEvent):void
        {
            var _local_2:ActivityPointsMessageEvent = (_arg_1 as ActivityPointsMessageEvent);
            this._purse.activityPoints = _local_2.points;
            this.updatePurse();
            if (_local_2.points[ActivityPointTypeEnum.PIXEL] != null){
                events.dispatchEvent(new PurseEvent(PurseEvent.RWPUE_PIXEL_BALANCE, _local_2.points[ActivityPointTypeEnum.PIXEL]));
            };
            if (_local_2.points[ActivityPointTypeEnum._SafeStr_6442] != null){
                events.dispatchEvent(new PurseEvent(PurseEvent.RWPUE_SHELL_BALANCE, _local_2.points[ActivityPointTypeEnum._SafeStr_6442]));
            };
            events.dispatchEvent(new PurseUpdateEvent());
        }
        private function onSubscriptionInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:ScrSendUserInfoMessageParser = (_arg_1 as ScrSendUserInfoEvent).getParser();
            this._purse.clubDays = Math.max(0, _local_2.daysToPeriodEnd);
            this._purse.clubPeriods = Math.max(0, _local_2.periodsSubscribedAhead);
            this._purse.isVIP = _local_2.isVIP;
            this._purse.pastClubDays = _local_2.pastClubDays;
            this._purse.pastVipDays = _local_2.pastVipDays;
            this._purse.isExpiring = (((_local_2.responseType)==ScrSendUserInfoMessageParser._SafeStr_5852) ? true : false);
            this.updatePurse();
            if (_local_2.responseType == ScrSendUserInfoMessageParser.RESPONSE_TYPE_PURCHASE){
                this.reset();
            };
        }
        private function onClubGiftInfo(_arg_1:ClubGiftInfoEvent):void
        {
            if (((!(_arg_1)) || (!(this._clubGiftController)))){
                return;
            };
            var _local_2:ClubGiftInfoParser = _arg_1.getParser();
            if (!_local_2){
                return;
            };
            this._clubGiftController.setInfo(_local_2.daysUntilNextGift, _local_2.giftsAvailable, _local_2.offers, _local_2.giftData);
        }
        private function onRecyclerStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:RecyclerStatusMessageParser = (_arg_1 as RecyclerStatusMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._recycler == null)))){
                return;
            };
            this._recycler.setSystemStatus(_local_2.recyclerStatus, _local_2.recyclerTimeoutSeconds);
        }
        private function onRecyclerFinished(_arg_1:IMessageEvent):void
        {
            var _local_2:RecyclerFinishedMessageParser = (_arg_1 as RecyclerFinishedMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._recycler == null)))){
                return;
            };
            this._recycler.setFinished(_local_2.recyclerFinishedStatus, _local_2.prizeId);
        }
        private function onRecyclerPrizes(_arg_1:IMessageEvent):void
        {
            var _local_2:RecyclerPrizesMessageParser = (_arg_1 as RecyclerPrizesMessageEvent).getParser();
            if ((((_local_2 == null)) || ((this._recycler == null)))){
                return;
            };
            this._recycler.storePrizeTable(_local_2.prizeLevels);
        }
        private function onMarketPlaceOffers(_arg_1:IMessageEvent):void
        {
            if (this._marketPlace != null){
                this._marketPlace.onOffers(_arg_1);
            };
        }
        private function onMarketPlaceOwnOffers(_arg_1:IMessageEvent):void
        {
            if (this._marketPlace != null){
                this._marketPlace.onOwnOffers(_arg_1);
            };
        }
        private function onMarketPlaceBuyResult(_arg_1:IMessageEvent):void
        {
            if (this._marketPlace != null){
                this._marketPlace.onBuyResult(_arg_1);
            };
        }
        private function onMarketPlaceCancelResult(_arg_1:IMessageEvent):void
        {
            if (this._marketPlace != null){
                this._marketPlace.onCancelResult(_arg_1);
            };
        }
        private function onGiftWrappingConfiguration(_arg_1:GiftWrappingConfigurationEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            this._giftWrappingConfiguration = new GiftWrappingConfiguration(_arg_1);
        }
        private function onIsOfferGiftable(_arg_1:IsOfferGiftableMessageEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            if (this._SafeStr_5427 != null){
                this._SafeStr_5427.onIsOfferGiftable(_arg_1.getParser());
            };
        }
        private function onMarketplaceItemStats(_arg_1:MarketplaceItemStatsEvent):void
        {
            if (((!(_arg_1)) || (!(this._marketPlace)))){
                return;
            };
            var _local_2:MarketplaceItemStatsParser = _arg_1.getParser();
            if (!_local_2){
                return;
            };
            var _local_3:MarketplaceItemStats = new MarketplaceItemStats();
            _local_3.averagePrice = _local_2.averagePrice;
            _local_3.offerCount = _local_2.offerCount;
            _local_3.historyLength = _local_2.historyLength;
            _local_3.dayOffsets = _local_2.dayOffsets;
            _local_3.averagePrices = _local_2.averagePrices;
            _local_3.soldAmounts = _local_2.soldAmounts;
            _local_3.furniCategoryId = _local_2.furniCategoryId;
            _local_3.furniTypeId = _local_2.furniTypeId;
            this._marketPlace.itemStats = _local_3;
        }
        private function onMarketplaceConfiguration(_arg_1:MarketplaceConfigurationEvent):void
        {
            if (((!(_arg_1)) || (!(this._marketPlace)))){
                return;
            };
            var _local_2:MarketplaceConfigurationParser = _arg_1.getParser();
            if (!_local_2){
                return;
            };
            this._marketPlace.averagePricePeriod = _local_2.averagePricePeriod;
        }
        private function onMarketplaceMakeOfferResult(_arg_1:MarketplaceMakeOfferResult):void
        {
            if (((!(_arg_1)) || (!(this._marketPlace)))){
                return;
            };
            var _local_2:MarketplaceMakeOfferResultParser = _arg_1.getParser();
            if (!_local_2){
                return;
            };
            if (_local_2.result == 1){
                this._marketPlace.refreshOffers();
            };
        }
        private function onHabboClubOffers(_arg_1:HabboClubOffersMessageEvent):void
        {
            if (this._clubBuyController != null){
                this._clubBuyController.onOffers(_arg_1);
            };
        }
        private function onHabboClubExtendOffer(_arg_1:HabboClubExtendOfferMessageEvent):void
        {
            this._clubExtendController.onOffer(_arg_1);
        }
        private function onChargeInfo(_arg_1:ChargeInfoMessageEvent):void
        {
            var _local_2:ChargeInfo = _arg_1.getParser().chargeInfo;
            if ((((this._chargeConfirmationDialog == null)) || (this._chargeConfirmationDialog.disposed))){
                this._chargeConfirmationDialog = new ChargeConfirmationDialog(this, this._localization);
            };
            this._chargeConfirmationDialog.showChargeInfo(_local_2);
        }
        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            if (this._chargeConfirmationDialog != null){
                this._chargeConfirmationDialog.close();
            };
        }
        private function onSellableBreeds(_arg_1:SellablePetBreedsMessageEvent):void
        {
            var _local_2:SellablePetBreedsParser = _arg_1.getParser();
            this._SafeStr_10599.remove(_local_2.productCode);
            var _local_3:Array = _local_2.sellableBreeds;
            if (_local_3 != null){
                this._SafeStr_10599.add(_local_2.productCode, _local_3.slice());
                this._SafeStr_10584.dispatchWidgetEvent(new CatalogWidgetSellablePetBreedsEvent(_local_2.productCode, _local_3.slice()));
            };
        }
        private function setElementImage(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (this._mainContainer.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3 != null){
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(0, 0));
            }
            else {
                Logger.log(("Could not find element: " + _arg_1));
            };
        }
        private function alertDialogEventProcessor(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            this.resetPlacedOfferData();
        }
        private function noCreditsConfirmDialogEventProcessor(_arg_1:IConfirmDialog, _arg_2:WindowEvent):void
        {
            var _local_3:String;
            _arg_1.dispose();
            this.resetPlacedOfferData();
            if (_arg_2.type == WindowEvent.WE_OK){
                if (((ExternalInterface.available) && (("true" == this._configuration.getKey("client.credits.embed.enabled"))))){
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
                }
                else {
                    _local_3 = this._configuration.getKey("link.format.credits");
                    if (_local_3 != ""){
                        this._windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                        HabboWebTools.navigateToURL(_local_3, "habboMain");
                    };
                };
            };
        }
        private function noPixelsConfirmDialogEventProcessor(_arg_1:IConfirmDialog, _arg_2:WindowEvent):void
        {
            var _local_3:String;
            _arg_1.dispose();
            this.resetPlacedOfferData();
            if (_arg_2.type == WindowEvent.WE_OK){
                _local_3 = this._configuration.getKey("link.format.pixels");
                if (_local_3 != ""){
                    this._windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                    HabboWebTools.navigateToURL(_local_3, "habboMain");
                };
            };
        }
        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        public function redeemVoucher(_arg_1:String):void
        {
            var _local_2:IMessageComposer = new RedeemVoucherMessageComposer(_arg_1);
            this._communication.getHabboMainConnection(null).send(_local_2);
            _local_2.dispose();
            _local_2 = null;
        }
        public function productDataReady():void
        {
            this.init();
        }
        public function isDraggable(_arg_1:Offer):Boolean
        {
            if (((!(this._configuration.keyExists("catalog.drag_and_drop"))) || (!((this._configuration.getKey("catalog.drag_and_drop") == "true"))))){
                return (false);
            };
            if (((!(this._roomSession)) || (!(this._roomSession.isRoomOwner)))){
                return (false);
            };
            var _local_2:IProduct = _arg_1.productContainer.firstProduct;
            var _local_3:Boolean = true;
            switch (_local_2.productType){
                case ProductTypeEnum._SafeStr_5021:
                    _local_3 = false;
                    break;
                case ProductTypeEnum._SafeStr_5023:
                    _local_3 = false;
                    break;
            };
            return (_local_3);
        }
        private function updateRoom(_arg_1:String, _arg_2:String):void
        {
            var _local_3:String = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5786);
            var _local_4:String = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5784);
            var _local_5:String = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5788);
            _local_3 = ((((_local_3) && ((_local_3.length > 0)))) ? _local_3 : "101");
            _local_4 = ((((_local_4) && ((_local_4.length > 0)))) ? _local_4 : "101");
            _local_5 = ((((_local_5) && ((_local_5.length > 0)))) ? _local_5 : "1.1");
            switch (_arg_1){
                case "floor":
                    this._roomEngine.updateObjectRoom(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, _arg_2, _local_3, _local_5, true);
                    return;
                case "wallpaper":
                    this._roomEngine.updateObjectRoom(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, _local_4, _arg_2, _local_5, true);
                    return;
                case "landscape":
                    this._roomEngine.updateObjectRoom(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, _local_4, _local_3, _arg_2, true);
                    return;
                default:
                    this._roomEngine.updateObjectRoom(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, _local_4, _local_3, _local_5, true);
            };
        }
        public function requestSelectedItemToMover(_arg_1:IDragAndDropDoneReceiver, _arg_2:Offer):void
        {
            var _local_4:int;
            if (!this.isDraggable(_arg_2)){
                return;
            };
            var _local_3:IProduct = _arg_2.productContainer.firstProduct;
            switch (_local_3.productType){
                case ProductTypeEnum._SafeStr_5017:
                    _local_4 = RoomObjectCategoryEnum._SafeStr_4329;
                    break;
                case ProductTypeEnum._SafeStr_5019:
                    _local_4 = RoomObjectCategoryEnum._SafeStr_4330;
                    break;
            };
            var _local_5:Boolean = this._roomEngine.initializeRoomObjectInsert(-(_arg_2.offerId), _local_4, _local_3.productClassId, _local_3.extraParam.toString());
            if (_local_5){
                this._SafeStr_10600 = _arg_2;
                this._SafeStr_10601 = _arg_1;
                this.hideMainWindow();
                this._SafeStr_7797 = true;
            };
        }
        private function onObjectPlaced(_arg_1:RoomEngineObjectPlacedEvent):void
        {
            var _local_2:int;
            var _local_3:IProduct;
            var _local_4:Boolean;
            var _local_5:IDragAndDropDoneReceiver;
            var _local_6:IRoomObjectController;
            if (((this._SafeStr_7797) && ((_arg_1.type == RoomEngineObjectEvent.REOB_OBJECT_PLACED)))){
                this.resetPlacedOfferData(true);
                if ((((this._SafeStr_10600 == null)) || (this._SafeStr_10600.disposed))){
                    this.resetObjectMover();
                    return;
                };
                _local_2 = _arg_1.category;
                _local_3 = this._SafeStr_10600.productContainer.firstProduct;
                _local_4 = false;
                if (_local_2 == RoomObjectCategoryEnum._SafeStr_4330){
                    switch (_local_3.furnitureData.name){
                        case "floor":
                        case "wallpaper":
                        case "landscape":
                            _local_4 = ((_arg_1.placedOnFloor) || (_arg_1.placedOnWall));
                            break;
                        default:
                            _local_4 = _arg_1.placedInRoom;
                    };
                }
                else {
                    _local_4 = _arg_1.placedInRoom;
                };
                if (!_local_4){
                    this.resetObjectMover();
                    return;
                };
                this._SafeStr_10602 = new PlacedObjectPurchaseData(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _arg_1.category, _arg_1.wallLocation, _arg_1.x, _arg_1.y, _arg_1.direction, this._SafeStr_10600);
                _local_5 = this._SafeStr_10601;
                if (_local_5 != null){
                    _local_5.onDragAndDropDone(true);
                };
                if (_local_2 == RoomObjectCategoryEnum._SafeStr_4329){
                    this._roomEngine.addObjectFurniture(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _local_3.productClassId, new Vector3d(_arg_1.x, _arg_1.y, _arg_1.z), new Vector3d(_arg_1.direction, 0, 0), 0, "");
                }
                else {
                    if (_local_2 == RoomObjectCategoryEnum._SafeStr_4330){
                        switch (_local_3.furnitureData.name){
                            case "floor":
                            case "wallpaper":
                            case "landscape":
                                this.updateRoom(_local_3.furnitureData.name, _local_3.extraParam);
                                break;
                            default:
                                this._roomEngine.addObjectWallItem(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _local_3.productClassId, new Vector3d(_arg_1.x, _arg_1.y, _arg_1.z), new Vector3d((_arg_1.direction * 45), 0, 0), 0, _arg_1.instanceData, false);
                        };
                    };
                };
                _local_6 = (this._roomEngine.getRoomObject(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _arg_1.category) as IRoomObjectController);
                if (_local_6){
                    _local_6.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_5760, 0.5);
                };
            };
        }
        private function resetObjectMover():void
        {
            this._SafeStr_7797 = false;
            this.showMainWindow();
            this._SafeStr_10601 = null;
        }
        public function syncPlacedOfferWithPurchase(_arg_1:IPurchasableOffer):void
        {
            if (this._SafeStr_10602){
                if (this._SafeStr_10602.offerId != _arg_1.offerId){
                    this.resetPlacedOfferData();
                };
            };
        }
        public function resetPlacedOfferData(_arg_1:Boolean=false):void
        {
            if (!_arg_1){
                this.resetObjectMover();
            };
            if (this._SafeStr_10602 != null){
                if (this._SafeStr_10602.category == RoomObjectCategoryEnum._SafeStr_4329){
                    this._roomEngine.disposeObjectFurniture(this._SafeStr_10602.roomId, this._SafeStr_10602.roomCategory, this._SafeStr_10602.objectId);
                }
                else {
                    if (this._SafeStr_10602.category == RoomObjectCategoryEnum._SafeStr_4330){
                        switch (this._SafeStr_10602.furniData.name){
                            case "floor":
                            case "wallpaper":
                            case "landscape":
                                this.updateRoom("reset", "");
                                break;
                            default:
                                this._roomEngine.disposeObjectWallItem(this._SafeStr_10602.roomId, this._SafeStr_10602.roomCategory, this._SafeStr_10602.objectId);
                        };
                    }
                    else {
                        this._roomEngine.deleteRoomObject(this._SafeStr_10602.objectId, this._SafeStr_10602.category);
                    };
                };
                this._SafeStr_10602.dispose();
                this._SafeStr_10602 = null;
            };
        }
        public function cancelFurniInMover():void
        {
            if (this._SafeStr_10600 != null){
                this._roomEngine.cancelRoomObjectInsert();
                this._SafeStr_7797 = false;
                this._SafeStr_10600 = null;
            };
        }
        private function onItemAddedToInventory(_arg_1:HabboInventoryItemAddedEvent):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            if (((!((this._SafeStr_10602 == null))) && ((this._SafeStr_10602.productClassId == _arg_1.classId)))){
                if ((((this._SafeStr_10602.roomCategory == this._roomEngine.activeRoomCategory)) && ((this._SafeStr_10602.roomId == this._roomEngine.activeRoomId)))){
                    _local_2 = _arg_1.stripId;
                    _local_3 = this._SafeStr_10602.category;
                    _local_4 = this._SafeStr_10602.wallLocation;
                    _local_5 = this._SafeStr_10602.x;
                    _local_6 = this._SafeStr_10602.y;
                    _local_7 = this._SafeStr_10602.direction;
                    switch (_arg_1.category){
                        case FurniCategory._SafeStr_7052:
                            _local_8 = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5784);
                            if (this._SafeStr_10602.extraParameter != _local_8){
                                this._communication.getHabboMainConnection(null).send(new RequestRoomPropertySet(_local_2));
                            };
                            break;
                        case FurniCategory._SafeStr_7051:
                            _local_9 = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5786);
                            if (this._SafeStr_10602.extraParameter != _local_9){
                                this._communication.getHabboMainConnection(null).send(new RequestRoomPropertySet(_local_2));
                            };
                            break;
                        case FurniCategory._SafeStr_7053:
                            _local_10 = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum._SafeStr_5788);
                            if (this._SafeStr_10602.extraParameter != _local_10){
                                this._communication.getHabboMainConnection(null).send(new RequestRoomPropertySet(_local_2));
                            };
                            break;
                        default:
                            this._communication.getHabboMainConnection(null).send(new PlaceObjectMessageComposer(_local_2, _local_3, _local_4, _local_5, _local_6, _local_7));
                    };
                    this.resetPlacedOfferData();
                };
            };
        }
        public function setImageFromAsset(_arg_1:IWindow, _arg_2:String, _arg_3:Function):void
        {
            if (((!(_arg_2)) || (!(assets)))){
                return;
            };
            var _local_4:BitmapDataAsset = (assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (_local_4 == null){
                this.retrievePreviewAsset(_arg_2, _arg_3);
                return;
            };
            if (_arg_1){
                HabboCatalog.setElementImageCentered(_arg_1, (_local_4.content as BitmapData));
            };
        }
        private function retrievePreviewAsset(_arg_1:String, _arg_2:Function):void
        {
            if (((!(_arg_1)) || (!(assets)))){
                return;
            };
            var _local_3:String = this._configuration.getKey("image.library.catalogue.url");
            var _local_4 = ((_local_3 + _arg_1) + ".png");
            var _local_5:URLRequest = new URLRequest(_local_4);
            var _local_6:AssetLoaderStruct = assets.loadAssetFromFile(_arg_1, _local_5, "image/png");
            if (!_local_6){
                return;
            };
            _local_6.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, _arg_2);
        }
        private function showMainWindow():void
        {
            var _local_1:IDesktopWindow;
            if (((((!((this._windowManager == null))) && (!((this._mainContainer == null))))) && ((this._mainContainer.parent == null)))){
                _local_1 = this._windowManager.getDesktop(_SafeStr_10581);
                if (_local_1 != null){
                    _local_1.addChild(this._mainContainer);
                };
            };
        }
        private function hideMainWindow():void
        {
            var _local_1:IDesktopWindow;
            if (((((!((this._windowManager == null))) && (!((this._mainContainer == null))))) && (!((this._mainContainer.parent == null))))){
                _local_1 = this._windowManager.getDesktop(_SafeStr_10581);
                if (_local_1 != null){
                    _local_1.removeChild(this._mainContainer);
                    if (this._SafeStr_10584 != null){
                        this._SafeStr_10584.catalogWindowClosed();
                    };
                };
            };
        }
        private function mainWindowVisible():Boolean
        {
            if (((((!((this._windowManager == null))) && (!((this._mainContainer == null))))) && (!((this._mainContainer.parent == null))))){
                return (true);
            };
            return (false);
        }
        public function update(_arg_1:uint):void
        {
            if (this._roomPreviewer != null){
                this._roomPreviewer.updatePreviewRoomView();
            };
        }

    }
}//package com.sulake.habbo.catalog

// IID = "_-3KV" (String#7712, DoABC#2)
// sellableBreeds = "_-2ie" (String#6923, DoABC#2)
// onCommunicationReady = "_-3Ix" (String#372, DoABC#2)
// onOwnOffers = "_-0LM" (String#3987, DoABC#2)
// onBuyResult = "_-3Ea" (String#7604, DoABC#2)
// onCancelResult = "_-4T" (String#7756, DoABC#2)
// refreshOffers = "_-0gr" (String#4443, DoABC#2)
// itemStats = "_-2mo" (String#7016, DoABC#2)
// getPublicMarketPlaceOffers = "_-1kA" (String#5754, DoABC#2)
// getOwnMarketPlaceOffers = "_-2ye" (String#7252, DoABC#2)
// getMarketplaceItemStats = "_-0Ya" (String#4274, DoABC#2)
// showNotEnoughCreditsAlert = "_-20s" (String#6062, DoABC#2)
// redeemExpiredMarketPlaceOffer = "_-29g" (String#6244, DoABC#2)
// redeemSoldMarketPlaceOffers = "_-2lU" (String#6992, DoABC#2)
// buyMarketPlaceOffer = "_-2t" (String#7137, DoABC#2)
// buildCatalogIndex = "_-0KM" (String#3963, DoABC#2)
// openPageById = "_-0qZ" (String#4651, DoABC#2)
// loadFrontPage = "_-0fU" (String#4415, DoABC#2)
// loadNewAdditionsPage = "_-2Cc" (String#6295, DoABC#2)
// loadCatalogPage = "_-2Go" (String#6383, DoABC#2)
// onExternalLink = "_-022" (String#575, DoABC#2)
// getRecyclerStatus = "_-2YN" (String#6734, DoABC#2)
// setupInventoryForRecycler = "_-0uu" (String#4742, DoABC#2)
// setSystemStatus = "_-0f-" (String#15628, DoABC#2)
// setFinished = "_-6w" (String#22497, DoABC#2)
// requestInventoryFurniToRecycler = "_-0Vk" (String#4222, DoABC#2)
// returnInventoryFurniFromRecycler = "_-81" (String#2057, DoABC#2)
// sendRecycleItems = "_-3GL" (String#7633, DoABC#2)
// privateRoomSessionActive = "_-2CC" (String#6289, DoABC#2)
// setRoomSessionActive = "_-H3" (String#22892, DoABC#2)
// tradingActive = "_-1-4" (String#1595, DoABC#2)
// storePrizeTable = "_-ZN" (String#23611, DoABC#2)
// getRecyclerPrizes = "_-iN" (String#8565, DoABC#2)
// onApproveNameResult = "_-0aR" (String#1505, DoABC#2)
// approveName = "_-2HO" (String#19700, DoABC#2)
// getSellablePetBreeds = "_-0zI" (String#16400, DoABC#2)
// requestSelectedItemToMover = "_-Xj" (String#23551, DoABC#2)
// isDraggable = "_-0PX" (String#15044, DoABC#2)
// roomPreviewer = "_-1vc" (String#18781, DoABC#2)
// openCatalogPageById = "_-1I6" (String#5209, DoABC#2)
// openInventoryCategory = "_-10J" (String#4878, DoABC#2)
// _SafeStr_10581 = "_-1X4" (String#17779, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// _roomSession = "_-2CB" (String#1832, DoABC#2)
// _SafeStr_10584 = "_-2Zh" (String#20428, DoABC#2)
// _SafeStr_10585 = "_-0Np" (String#14983, DoABC#2)
// _purse = "_-1kp" (String#5763, DoABC#2)
// _recycler = "_-08U" (String#14385, DoABC#2)
// _marketPlace = "_-3LE" (String#22335, DoABC#2)
// _SafeStr_10589 = "_-2yG" (String#21404, DoABC#2)
// _SafeStr_10590 = "_-1g5" (String#18143, DoABC#2)
// _SafeStr_10591 = "_-37m" (String#21796, DoABC#2)
// _SafeStr_10592 = "_-1wL" (String#18814, DoABC#2)
// _SafeStr_10593 = "_-0nR" (String#15954, DoABC#2)
// _privateRoomSessionActive = "_-2g-" (String#20692, DoABC#2)
// _giftWrappingConfiguration = "_-07j" (String#14352, DoABC#2)
// _clubGiftController = "_-1gZ" (String#18161, DoABC#2)
// _clubBuyController = "_-2Vb" (String#20265, DoABC#2)
// _clubExtendController = "_-37u" (String#21801, DoABC#2)
// _SafeStr_10599 = "_-1pi" (String#18532, DoABC#2)
// _SafeStr_10600 = "_-1y8" (String#18893, DoABC#2)
// _SafeStr_10601 = "_-UE" (String#23417, DoABC#2)
// _SafeStr_10602 = "_-O7" (String#23174, DoABC#2)
// _newAdditionsAvailable = "_-1Tn" (String#5428, DoABC#2)
// _SafeStr_10604 = "_-1LE" (String#17323, DoABC#2)
// _roomPreviewer = "_-uB" (String#24457, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// sessionDataManagerReady = "_-1tn" (String#18708, DoABC#2)
// onFriendListReady = "_-1N-" (String#849, DoABC#2)
// setElementImageCentered = "_-0mD" (String#15904, DoABC#2)
// onRoomSessionEvent = "_-10q" (String#1603, DoABC#2)
// createCatalogNavigator = "_-32v" (String#21617, DoABC#2)
// createCatalogViewer = "_-0Em" (String#14634, DoABC#2)
// refreshCatalogIndex = "_-1gj" (String#18165, DoABC#2)
// updatePurse = "_-3GD" (String#22128, DoABC#2)
// createRecycler = "_-Le" (String#23067, DoABC#2)
// createMarketPlace = "_-2YC" (String#20364, DoABC#2)
// createClubGiftController = "_-2Jk" (String#19800, DoABC#2)
// getGiftWrappingConfiguration = "_-i-" (String#23964, DoABC#2)
// createClubBuyController = "_-1Ca" (String#16967, DoABC#2)
// createClubExtendController = "_-1iR" (String#18225, DoABC#2)
// loadProductData = "_-0cU" (String#4353, DoABC#2)
// showNotEnoughActivityPointsAlert = "_-05p" (String#14275, DoABC#2)
// onCatalogIndex = "_-2kJ" (String#20857, DoABC#2)
// onCatalogPage = "_-05F" (String#14253, DoABC#2)
// onCatalogPublished = "_-01a" (String#14114, DoABC#2)
// onPurchaseError = "_-jZ" (String#24020, DoABC#2)
// onPurchaseNotAllowed = "_-B4" (String#22658, DoABC#2)
// onGiftReceiverNotFound = "_-2EV" (String#19585, DoABC#2)
// onNotEnoughBalance = "_-2aj" (String#20476, DoABC#2)
// onActivityPointNotification = "_-2Rs" (String#20113, DoABC#2)
// onActivityPoints = "_-QE" (String#23259, DoABC#2)
// onVoucherRedeemOk = "_-EZ" (String#22795, DoABC#2)
// onVoucherRedeemError = "_-1io" (String#18237, DoABC#2)
// onSubscriptionInfo = "_-3-R" (String#1981, DoABC#2)
// onClubGiftInfo = "_-fR" (String#23864, DoABC#2)
// onRecyclerStatus = "_-3Bg" (String#21949, DoABC#2)
// onRecyclerFinished = "_-0RM" (String#4120, DoABC#2)
// onRecyclerPrizes = "_-1Wj" (String#17768, DoABC#2)
// onMarketPlaceOffers = "_-0lO" (String#15879, DoABC#2)
// onMarketPlaceOwnOffers = "_-2Iq" (String#19761, DoABC#2)
// onMarketPlaceBuyResult = "_-2PJ" (String#20014, DoABC#2)
// onMarketPlaceCancelResult = "_-M4" (String#23085, DoABC#2)
// onGiftWrappingConfiguration = "_-2tM" (String#21215, DoABC#2)
// onMarketplaceItemStats = "_-xw" (String#8837, DoABC#2)
// onMarketplaceConfiguration = "_-xL" (String#8831, DoABC#2)
// onMarketplaceMakeOfferResult = "_-OR" (String#8172, DoABC#2)
// onHabboClubOffers = "_-0e0" (String#15585, DoABC#2)
// onHabboClubExtendOffer = "_-2bY" (String#20507, DoABC#2)
// onChargeInfo = "_-0yY" (String#16376, DoABC#2)
// onSellableBreeds = "_-5" (String#22419, DoABC#2)
// initializeRoomPreviewer = "_-21A" (String#19058, DoABC#2)
// onItemAddedToInventory = "_-1xn" (String#18880, DoABC#2)
// toggleCatalog = "_-13T" (String#16597, DoABC#2)
// getLocalizedPageName = "_-2Bi" (String#19470, DoABC#2)
// setupRecycler = "_-2Iv" (String#6420, DoABC#2)
// getClubExtendController = "_-23P" (String#19149, DoABC#2)
// mainWindowVisible = "_-385" (String#21806, DoABC#2)
// markNewAdditionPageOpened = "_-2Gl" (String#19672, DoABC#2)
// showMainWindow = "_-0oD" (String#15985, DoABC#2)
// hideMainWindow = "_-1cs" (String#18007, DoABC#2)
// getHabboClubExtendOffer = "_-t1" (String#24407, DoABC#2)
// alertDialogEventProcessor = "_-2aA" (String#20448, DoABC#2)
// notEnoughActivityPoints = "_-2kI" (String#20856, DoABC#2)
// noCreditsConfirmDialogEventProcessor = "_-2Fg" (String#19629, DoABC#2)
// noPixelsConfirmDialogEventProcessor = "_-2em" (String#20636, DoABC#2)
// _SafeStr_10666 = "_-218" (String#19056, DoABC#2)
// _SafeStr_10667 = "_-1Ze" (String#17876, DoABC#2)
// giftData = "_-2mv" (String#20957, DoABC#2)
// chargeInfo = "_-2xn" (String#21387, DoABC#2)
// keyExists = "_-2ME" (String#6487, DoABC#2)
// updateRoom = "_-20h" (String#19039, DoABC#2)
// resetObjectMover = "_-0Up" (String#15236, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RecyclerFinishedMessageEvent = "_-Iu" (String#22964, DoABC#2)
// PurchaseOKMessageEvent = "_-38y" (String#21841, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// ScrSendUserInfoEvent = "_-202" (String#6048, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RecyclerFinishedMessageParser = "_-0EN" (String#3835, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// ScrSendUserInfoMessageParser = "_-1vA" (String#18764, DoABC#2)
// IMarketPlace = "_-1xE" (String#5977, DoABC#2)
// IPurse = "_-0GN" (String#3880, DoABC#2)
// IRecycler = "_-0fo" (String#4421, DoABC#2)
// ICatalogNavigator = "_-24D" (String#6126, DoABC#2)
// CatalogNavigator = "_-11c" (String#4908, DoABC#2)
// CatalogEvent = "_-Sw" (String#23361, DoABC#2)
// VoucherRedeemOkMessageEvent = "_-2Af" (String#19432, DoABC#2)
// GetGiftWrappingConfigurationComposer = "_-1KN" (String#17289, DoABC#2)
// BuyOfferMessageComposer = "_-wh" (String#24558, DoABC#2)
// MarketplaceBuyOfferResultEvent = "_-0Q7" (String#15066, DoABC#2)
// MarketplaceMakeOfferResult = "_-0tP" (String#4715, DoABC#2)
// IDragAndDropDoneReceiver = "_-Vz" (String#8320, DoABC#2)
// CreditBalanceParser = "_-2Xi" (String#6717, DoABC#2)
// RecyclerStatusMessageParser = "_-0fr" (String#4422, DoABC#2)
// VoucherRedeemErrorMessageEvent = "_-2Yt" (String#20390, DoABC#2)
// MarketplaceMakeOfferResultParser = "_-G-" (String#22853, DoABC#2)
// NotEnoughBalanceMessageParser = "_-Oj" (String#8179, DoABC#2)
// NotEnoughBalanceMessageEvent = "_-2Ju" (String#6437, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// PurchaseFromCatalogComposer = "_-1Vz" (String#17741, DoABC#2)
// RecyclerStatusMessageEvent = "_-8f" (String#22567, DoABC#2)
// CancelOfferMessageComposer = "_-0zq" (String#16420, DoABC#2)
// HabboIconType = "_-23Y" (String#6115, DoABC#2)
// RecycleItemsMessageComposer = "_-24X" (String#19202, DoABC#2)
// HabboSoundTypesEnum = "_-0vP" (String#16253, DoABC#2)
// CatalogWidgetSellablePetBreedsEvent = "_-eO" (String#23818, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// ApproveNameMessageComposer = "_-2IA" (String#19733, DoABC#2)
// RedeemOfferCreditsMessageComposer = "_-3EZ" (String#22058, DoABC#2)
// ClubGiftInfoEvent = "_-TI" (String#23377, DoABC#2)
// GiftWrappingConfigurationEvent = "_-1tN" (String#18692, DoABC#2)
// PlacedObjectPurchaseData = "_-0JL" (String#14815, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// CatalogWidgetApproveNameResultEvent = "_-By" (String#22687, DoABC#2)
// GetOffersMessageComposer = "_-1rt" (String#18626, DoABC#2)
// GetIsOfferGiftableComposer = "_-16u" (String#16731, DoABC#2)
// MarketplaceItemStats = "_-2Fw" (String#19640, DoABC#2)
// ClubBuyController = "_-2RB" (String#6584, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// WindowToggle = "_-1Ud" (String#17689, DoABC#2)
// IsOfferGiftableMessageEvent = "_-3Dt" (String#22029, DoABC#2)
// GetRecyclerPrizesMessageComposer = "_-1d9" (String#18019, DoABC#2)
// PurchaseConfirmationDialog = "_-1qd" (String#5866, DoABC#2)
// GetCatalogIndexComposer = "_-cD" (String#23723, DoABC#2)
// HabboClubOffersMessageEvent = "_-347" (String#21664, DoABC#2)
// MarketPlaceOffersEvent = "_-sl" (String#24391, DoABC#2)
// PurchaseBasicMembershipExtensionComposer = "_-3Hc" (String#22184, DoABC#2)
// GiftWrappingConfiguration = "_-0BE" (String#14495, DoABC#2)
// HabboInventoryItemAddedEvent = "_-1m1" (String#18379, DoABC#2)
// CatalogPublishedMessageEvent = "_-2Om" (String#19995, DoABC#2)
// MarketPlaceOwnOffersEvent = "_-2c-" (String#20524, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// ActivityPointTypeEnum = "_-11n" (String#16529, DoABC#2)
// Purse = "_-M9" (String#8125, DoABC#2)
// CatalogPageMessageEvent = "_-31o" (String#21570, DoABC#2)
// MarketplaceCancelOfferResultEvent = "_-2jK" (String#20816, DoABC#2)
// CatalogPageMessageParser = "_-1gI" (String#5668, DoABC#2)
// SellablePetBreedsParser = "_-0eF" (String#4395, DoABC#2)
// RedeemVoucherMessageComposer = "_-0bE" (String#15486, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// ClubBuyOfferData = "_-2XP" (String#6709, DoABC#2)
// PurchaseVipMembershipExtensionComposer = "_-E5" (String#22775, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// ChargeConfirmationDialog = "_-4D" (String#7749, DoABC#2)
// PurseEvent = "_-kO" (String#24049, DoABC#2)
// SellablePetBreedsMessageEvent = "_-07I" (String#14338, DoABC#2)
// GetClubOffersMessageComposer = "_-2Z2" (String#20398, DoABC#2)
// RoomEngineObjectPlacedEvent = "_-2zd" (String#21445, DoABC#2)
// GetMarketplaceItemStatsComposer = "_-DI" (String#22741, DoABC#2)
// PurseUpdateEvent = "_-11t" (String#16533, DoABC#2)
// IPageLocalization = "_-0gS" (String#4433, DoABC#2)
// PageLocalization = "_-37h" (String#21794, DoABC#2)
// ChargeInfoMessageEvent = "_-1mO" (String#18395, DoABC#2)
// PurchaseErrorMessageEvent = "_-Gq" (String#22884, DoABC#2)
// RecyclerPrizesMessageParser = "_-J7" (String#8064, DoABC#2)
// ClubGiftInfoParser = "_-1gX" (String#5674, DoABC#2)
// PurchaseNotAllowedMessageParser = "_-1D6" (String#5128, DoABC#2)
// GetSellablePetBreedsComposer = "_-2Jj" (String#19799, DoABC#2)
// GetCatalogPageComposer = "_-2oJ" (String#21015, DoABC#2)
// RecyclerPrizesMessageEvent = "_-095" (String#14412, DoABC#2)
// GetRecyclerStatusMessageComposer = "_-3JD" (String#22250, DoABC#2)
// GetHabboClubExtendOfferMessageComposer = "_-1U7" (String#17671, DoABC#2)
// NodeData = "_-02P" (String#3615, DoABC#2)
// ClubGiftController = "_-33f" (String#7378, DoABC#2)
// CreditBalanceEvent = "_-lg" (String#24097, DoABC#2)
// MarketplaceItemStatsParser = "_-Fz" (String#22851, DoABC#2)
// MarketPlaceLogic = "_-8V" (String#7832, DoABC#2)
// PurchaseFromCatalogAsGiftComposer = "_-zC" (String#24659, DoABC#2)
// RecyclerLogic = "_-21p" (String#6082, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// PlaceObjectMessageComposer = "_-1To" (String#17657, DoABC#2)
// ClubExtendController = "_-2UZ" (String#6657, DoABC#2)
// MarketplaceConfigurationEvent = "_-2eI" (String#6839, DoABC#2)
// ApproveNameMessageEvent = "_-2DN" (String#19542, DoABC#2)
// ActivityPointsMessageEvent = "_-0Fl" (String#14673, DoABC#2)
// RequestRoomPropertySet = "_-6-" (String#22465, DoABC#2)
// CatalogViewer = "_-0IW" (String#3924, DoABC#2)
// MarketplaceConfigurationParser = "_-0-L" (String#14026, DoABC#2)
// MarketplaceItemStatsEvent = "_-2iN" (String#6918, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// HabboClubExtendOfferMessageEvent = "_-2CH" (String#19495, DoABC#2)
// HabboActivityPointNotificationMessageEvent = "_-cn" (String#23745, DoABC#2)
// PurchaseNotAllowedMessageEvent = "_-2I7" (String#19731, DoABC#2)
// ChargeInfo = "_-1bU" (String#5587, DoABC#2)
// MarkCatalogNewAdditionsPageOpenedComposer = "_-1F4" (String#17074, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// ApproveNameMessageParser = "_-1i-" (String#5708, DoABC#2)
// CatalogIndexMessageEvent = "_-Xi" (String#23550, DoABC#2)
// IConfirmDialog = "_-35c" (String#7421, DoABC#2)
// RoomPreviewer = "_-fc" (String#23871, DoABC#2)
// GetOwnOffersMessageComposer = "_-2-4" (String#18974, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IProductDataListener = "_-0H" (String#3894, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RWPUE_CREDIT_BALANCE = "_-31Q" (String#21556, DoABC#2)
// onCreditBalance = "_-2Mm" (String#886, DoABC#2)
// isHiddenByOtherWindows = "_-1OQ" (String#17449, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// setElementImage = "_-1IU" (String#302, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _SafeStr_4231 = "_-37t" (String#2006, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// recyclerFinishedStatus = "_-2UK" (String#20212, DoABC#2)
// recyclerStatus = "_-2v4" (String#21281, DoABC#2)
// recyclerTimeoutSeconds = "_-3Db" (String#22017, DoABC#2)
// prizeLevels = "_-2CI" (String#19496, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// onDragAndDropDone = "_-05o" (String#3681, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// showCatalogPage = "_-0nw" (String#4589, DoABC#2)
// dispatchWidgetEvent = "_-2V-" (String#1888, DoABC#2)
// getCurrentLayoutCode = "_-nh" (String#2189, DoABC#2)
// habboCatalog = "_-2De" (String#19551, DoABC#2)
// catalogWindowClosed = "_-2fZ" (String#20672, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// disposeObjectFurniture = "_-0Sj" (String#1477, DoABC#2)
// disposeObjectWallItem = "_-0aH" (String#1502, DoABC#2)
// updatePreviewRoomView = "_-3-F" (String#21472, DoABC#2)
// addObjectFurniture = "_-0G1" (String#1439, DoABC#2)
// addObjectWallItem = "_-J0" (String#2084, DoABC#2)
// updateObjectRoom = "_-DR" (String#2076, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// furnitureData = "_-2GE" (String#6370, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// setImageFromAsset = "_-1q7" (String#18549, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// getPixelEffectIcon = "_-1HA" (String#5192, DoABC#2)
// _SafeStr_5021 = "_-h-" (String#23930, DoABC#2)
// getSubscriptionProductIcon = "_-dz" (String#8484, DoABC#2)
// _SafeStr_5023 = "_-hJ" (String#23942, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// getClubGiftController = "_-3B" (String#21920, DoABC#2)
// productDataReady = "_-0HL" (String#3901, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// RWPUE_SHELL_BALANCE = "_-0Se" (String#15158, DoABC#2)
// RWPUE_PIXEL_BALANCE = "_-16-" (String#16697, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// openCreditsHabblet = "_-0D5" (String#3811, DoABC#2)
// _avatarRenderManager = "_-2uU" (String#454, DoABC#2)
// _SafeStr_5427 = "_-au" (String#638, DoABC#2)
// onOffers = "_-1x1" (String#5973, DoABC#2)
// showOffer = "_-2nW" (String#20980, DoABC#2)
// getHabboClubOffers = "_-16e" (String#5009, DoABC#2)
// purchaseProduct = "_-na" (String#24175, DoABC#2)
// hasClubLeft = "_-1Sl" (String#5409, DoABC#2)
// daysUntilNextGift = "_-12R" (String#16556, DoABC#2)
// giftsAvailable = "_-GA" (String#22860, DoABC#2)
// setInfo = "_-2pW" (String#21058, DoABC#2)
// onOffer = "_-3Ge" (String#22147, DoABC#2)
// purchaseVipMembershipExtension = "_-0mj" (String#15926, DoABC#2)
// purchaseBasicMembershipExtension = "_-0JV" (String#14821, DoABC#2)
// getClubBuyController = "_-2nZ" (String#20982, DoABC#2)
// showPurchaseConfirmation = "_-2zh" (String#21447, DoABC#2)
// wallLocation = "_-12C" (String#16544, DoABC#2)
// syncPlacedOfferWithPurchase = "_-2mj" (String#20950, DoABC#2)
// onIsOfferGiftable = "_-0hn" (String#4463, DoABC#2)
// giftWrappingConfiguration = "_-19O" (String#16832, DoABC#2)
// purchaseProductAsGift = "_-0Dk" (String#14597, DoABC#2)
// resetPlacedOfferData = "_-1cp" (String#18004, DoABC#2)
// receiverNotFound = "_-79" (String#22507, DoABC#2)
// notEnoughCredits = "_-0aV" (String#15455, DoABC#2)
// showChargeInfo = "_-re" (String#24346, DoABC#2)
// getActivityPointsForType = "_-1c9" (String#5603, DoABC#2)
// REOB_OBJECT_PLACED = "_-2hu" (String#20768, DoABC#2)
// placedInRoom = "_-1ZC" (String#17861, DoABC#2)
// placedOnFloor = "_-1pD" (String#18509, DoABC#2)
// placedOnWall = "_-1Oh" (String#17457, DoABC#2)
// _SafeStr_5760 = "_-2gS" (String#20707, DoABC#2)
// _SafeStr_5784 = "_-2G-" (String#19644, DoABC#2)
// _SafeStr_5786 = "_-1SC" (String#17588, DoABC#2)
// _SafeStr_5788 = "_-Nt" (String#23160, DoABC#2)
// newAdditionsAvailable = "_-2p" (String#21040, DoABC#2)
// images = "_-0TG" (String#15181, DoABC#2)
// texts = "_-2Lf" (String#19872, DoABC#2)
// _SafeStr_5852 = "_-1gA" (String#18147, DoABC#2)
// daysToPeriodEnd = "_-3L6" (String#22328, DoABC#2)
// periodsSubscribedAhead = "_-08y" (String#14405, DoABC#2)
// responseType = "_-0wX" (String#16291, DoABC#2)
// pastClubDays = "_-2W7" (String#6687, DoABC#2)
// pastVipDays = "_-373" (String#7449, DoABC#2)
// requestSelectedFurniToRecycler = "_-2P" (String#6543, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// toggleInventoryPage = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_6009 = "_-2X8" (String#20329, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isExpiring = "_-YW" (String#8383, DoABC#2)
// _SafeStr_6442 = "_-mm" (String#24141, DoABC#2)
// activityPoints = "_-0j3" (String#15794, DoABC#2)
// stripId = "_-28E" (String#19340, DoABC#2)
// getFriendNames = "_-3BP" (String#7538, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// _SafeStr_7051 = "_-AU" (String#22635, DoABC#2)
// _SafeStr_7052 = "_-0OP" (String#15005, DoABC#2)
// _SafeStr_7053 = "_-19z" (String#16856, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// onHabboToolbarEvent = "_-0Ve" (String#435, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// getFloorItemData = "_-08L" (String#3728, DoABC#2)
// getWallItemData = "_-Hc" (String#8029, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// deleteRoomObject = "_-1YS" (String#5529, DoABC#2)
// isPrivateRoom = "_-1Wr" (String#5489, DoABC#2)
// _SafeStr_7426 = "_-3Ki" (String#22312, DoABC#2)
// _SafeStr_7427 = "_-4r" (String#22412, DoABC#2)
// _SafeStr_7486 = "_-2NN" (String#19938, DoABC#2)
// _SafeStr_7797 = "_-Gh" (String#8012, DoABC#2)
// onObjectPlaced = "_-CM" (String#7922, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// cancelFurniInMover = "_-1Xa" (String#17797, DoABC#2)
// cancelRoomObjectInsert = "_-0w6" (String#4772, DoABC#2)
// initializeRoomObjectInsert = "_-QC" (String#8205, DoABC#2)
// openCatalog = "_-RM" (String#8233, DoABC#2)
// getRoomStringValue = "_-Ht" (String#2080, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onInventoryReady = "_-dE" (String#374, DoABC#2)
// onSoundManagerReady = "_-2hg" (String#369, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// historyLength = "_-1dq" (String#18052, DoABC#2)
// dayOffsets = "_-1hM" (String#18187, DoABC#2)
// averagePrices = "_-2fx" (String#20689, DoABC#2)
// soldAmounts = "_-z4" (String#24653, DoABC#2)
// furniTypeId = "_-2n-" (String#20961, DoABC#2)
// furniCategoryId = "_-0bd" (String#15499, DoABC#2)
// averagePricePeriod = "_-0lE" (String#4528, DoABC#2)
// HabboCatalogTrackingEvent = "_-307" (String#21506, DoABC#2)
// openPage = "_-6Z" (String#2052, DoABC#2)
// retrievePreviewAsset = "_-04a" (String#579, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)
// isInitialized = "_-1Cr" (String#840, DoABC#2)
// crash = "_-1--" (String#16429, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// _SafeStr_9853 = "_-1CI" (String#16955, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


