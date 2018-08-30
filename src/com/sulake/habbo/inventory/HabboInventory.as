
package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.inventory.purse.Purse;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.events.RoomSessionPropertyUpdateEvent;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.inventory.effects.EffectsModel;
    import com.sulake.habbo.inventory.badges.BadgesModel;
    import com.sulake.habbo.inventory.recycler.RecyclerModel;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.GetCreditsInfoComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.iid.*;

    public class HabboInventory extends Component implements IHabboInventory 
    {

        private const _SafeStr_11679:int = 500;

        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_11492:IncomingMessages;
        private var _windowManager:IHabboWindowManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _localization:IHabboLocalizationManager;
        private var _config:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:InventoryMainView;
        private var _SafeStr_11680:Map;
        private var _roomEngine:IRoomEngine;
        private var _roomSession:IRoomSession;
        private var _SafeStr_11681:Array;
        private var _purse:Purse;
        private var _avatarRenderer:IAvatarRenderManager;
        private var _catalog:IHabboCatalog;
        private var _toolbar:IHabboToolbar;
        private var _isInitialized:Boolean;
        private var _SafeStr_11682:Boolean;
        private var _SafeStr_11683:int;

        public function HabboInventory(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._assetLibrary = _arg_3;
            this._purse = new Purse();
            this._SafeStr_11681 = new Array();
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationComponentInit);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
        }
        public function get isVisible():Boolean
        {
            return (this._view.isVisible);
        }
        public function get isMainViewActive():Boolean
        {
            return (this._view.isActive);
        }
        override public function dispose():void
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:String;
            var _local_4:IInventoryModel;
            super.dispose();
            if (this._SafeStr_11680){
                _local_1 = this._SafeStr_11680.getKeys();
                _local_2 = 0;
                while (_local_2 < _local_1.length) {
                    _local_3 = _local_1[_local_2];
                    _local_4 = (this._SafeStr_11680.getValue(_local_3) as IInventoryModel);
                    if (_local_4 != null){
                        _local_4.dispose();
                    };
                    _local_2++;
                };
                this._SafeStr_11680.dispose();
                this._SafeStr_11680 = null;
            };
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
            this._roomSession = null;
            this._SafeStr_11492 = null;
            if (this._communication != null){
                release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._SafeStr_11492 != null){
                this._SafeStr_11492.dispose();
            };
            if (this._windowManager != null){
                release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._localization != null){
                release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._roomEngine != null){
                release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this._config){
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this._sessionDataManager){
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._avatarRenderer){
                this._avatarRenderer.release(new IIDAvatarRenderManager());
                this._avatarRenderer = null;
            };
            if (this._catalog){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._roomSessionManager != null){
                this._roomSessionManager.events.removeEventListener(RoomSessionEvent.RSE_STARTED, this.roomSessionEventHandler);
                this._roomSessionManager.events.removeEventListener(RoomSessionEvent.RSE_ENDED, this.roomSessionEventHandler);
                this._roomSessionManager.events.removeEventListener(RoomSessionPropertyUpdateEvent.RSDUE_ALLOW_PETS, this.roomSessionEventHandler);
                this._roomSessionManager.release(new IIDHabboRoomSessionManager());
                this._roomSessionManager = null;
            };
            if (this._soundManager != null){
                this._soundManager = null;
            };
            if (this._toolbar){
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
        }
        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }
        public function get furniModel():FurniModel
        {
            if (disposed){
                return (null);
            };
            return (FurniModel(this._SafeStr_11680.getValue(InventoryCategory._SafeStr_5995)));
        }
        public function get tradingModel():TradingModel
        {
            if (disposed){
                return (null);
            };
            return (TradingModel(this._SafeStr_11680.getValue(InventorySubCategory._SafeStr_7064)));
        }
        public function get effectsModel():EffectsModel
        {
            if (disposed){
                return (null);
            };
            return (EffectsModel(this._SafeStr_11680.getValue(InventoryCategory.RWE_EFFECTS)));
        }
        public function get badgesModel():BadgesModel
        {
            if (disposed){
                return (null);
            };
            return (BadgesModel(this._SafeStr_11680.getValue(InventoryCategory._SafeStr_7061)));
        }
        public function get recyclerModel():RecyclerModel
        {
            if (disposed){
                return (null);
            };
            return (RecyclerModel(this._SafeStr_11680.getValue(InventorySubCategory._SafeStr_7065)));
        }
        public function get petsModel():PetsModel
        {
            if (disposed){
                return (null);
            };
            return (PetsModel(this._SafeStr_11680.getValue(InventoryCategory._SafeStr_5996)));
        }
        public function get marketplaceModel():MarketplaceModel
        {
            if (disposed){
                return (null);
            };
            return ((this._SafeStr_11680.getValue(InventoryCategory._SafeStr_7062) as MarketplaceModel));
        }
        public function get sessionData():ISessionDataManager
        {
            return (this._sessionDataManager);
        }
        public function get roomSession():IRoomSession
        {
            return (this._roomSession);
        }
        public function get clubDays():int
        {
            return (this._purse.clubDays);
        }
        public function get clubPeriods():int
        {
            return (this._purse.clubPeriods);
        }
        public function get clubPastPeriods():int
        {
            return (this._purse.clubPastPeriods);
        }
        public function get clubHasEverBeenMember():Boolean
        {
            return (this._purse.clubHasEverBeenMember);
        }
        public function get clubIsExpiring():Boolean
        {
            return (this._purse.clubIsExpiring);
        }
        public function get clubLevel():int
        {
            if ((((this.clubDays == 0)) && ((this.clubPeriods == 0)))){
                return (HabboClubLevelEnum._SafeStr_3942);
            };
            if (this._purse.isVIP){
                return (HabboClubLevelEnum._SafeStr_3939);
            };
            return (HabboClubLevelEnum._SafeStr_3943);
        }
        public function get hasRoomSession():Boolean
        {
            return (!((this._roomSession == null)));
        }
        public function getCategoryViewId():String
        {
            return (this._view.getCategoryViewId());
        }
        public function getSubCategoryViewId():String
        {
            return (this._view.getSubCategoryViewId());
        }
        public function setClubStatus(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean):void
        {
            this._purse.clubPeriods = _arg_1;
            this._purse.clubDays = _arg_2;
            this._purse.clubHasEverBeenMember = _arg_3;
            this._purse.isVIP = _arg_4;
            this._purse.clubIsExpiring = _arg_5;
            this._view.setClubStatus(this.clubPeriods, this.clubDays);
        }
        private function onCommunicationComponentInit(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(_arg_2);
            this._SafeStr_11492 = new IncomingMessages(this);
            this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
            this.initInventory();
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(_arg_2);
            this.initInventory();
        }
        private function onLocalizationManagerReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._localization = (_arg_2 as IHabboLocalizationManager);
            this.initInventory();
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._roomEngine = IRoomEngine(_arg_2);
            this.initInventory();
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._sessionDataManager = ISessionDataManager(_arg_2);
            this.initInventory();
        }
        private function onConfigurationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._config = (_arg_2 as IHabboConfigurationManager);
            this.initInventory();
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._catalog = (_arg_2 as IHabboCatalog);
            this.initInventory();
        }
        private function onAvatarRenderManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._avatarRenderer = (_arg_2 as IAvatarRenderManager);
            this.initInventory();
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._roomSessionManager = IRoomSessionManager(_arg_2);
            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.roomSessionEventHandler);
            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.roomSessionEventHandler);
            this._roomSessionManager.events.addEventListener(RoomSessionPropertyUpdateEvent.RSDUE_ALLOW_PETS, this.roomSessionEventHandler);
            this.initInventory();
        }
        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._soundManager = IHabboSoundManager(_arg_2);
            this.initInventory();
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._toolbar = IHabboToolbar(_arg_2);
            this.initInventory();
        }
        private function onAuthenticationOK(_arg_1:IMessageEvent):void
        {
            if (!this._isInitialized){
                this._SafeStr_11682 = true;
                return;
            };
            this.requestData();
        }
        private function requestData():void
        {
            this._communication.getHabboMainConnection(null).send(new GetCreditsInfoComposer());
            this._communication.getHabboMainConnection(null).send(new ScrGetUserInfoMessageComposer("habbo_club"));
            this._communication.getHabboMainConnection(null).send(new GetBadgePointLimitsComposer());
        }
        private function roomSessionEventHandler(_arg_1:RoomSessionEvent):void
        {
            if (!this._isInitialized){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionEvent.RSE_STARTED:
                    this._roomSession = _arg_1.session;
                    if (this.petsModel != null){
                        this.petsModel.updatePetsAllowed();
                    };
                    if (this.furniModel != null){
                        this.furniModel.updateView();
                    };
                    return;
                case RoomSessionEvent.RSE_ENDED:
                    this._roomSession = null;
                    this.deselectAllEffects();
                    return;
                case RoomSessionPropertyUpdateEvent.RSDUE_ALLOW_PETS:
                    if (this.petsModel != null){
                        this.petsModel.updatePetsAllowed();
                    };
                    return;
            };
        }
        private function initInventory():void
        {
            if (((((((((((((((((((((!(this._communication)) || (!(this._windowManager)))) || (!(this._localization)))) || (!(this._roomEngine)))) || (!(this._sessionDataManager)))) || (!(this._config)))) || (!(this._catalog)))) || (!(this._avatarRenderer)))) || (!(this._roomSessionManager)))) || (!(this._toolbar)))) || (!(this._soundManager)))){
                return;
            };
            this._view = new InventoryMainView(this, this._windowManager, this._assetLibrary);
            this._view.setToolbar(this._toolbar);
            this._SafeStr_11680 = new Map();
            var _local_1:MarketplaceModel = new MarketplaceModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization, this._config);
            this._SafeStr_11680.add(InventoryCategory._SafeStr_7062, _local_1);
            var _local_2:FurniModel = new FurniModel(this, _local_1, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._catalog, this._soundManager);
            this._SafeStr_11680.add(InventoryCategory._SafeStr_5995, _local_2);
            var _local_3:BadgesModel = new BadgesModel(this, this._windowManager, this._communication, this._assetLibrary, this._sessionDataManager);
            this._SafeStr_11680.add(InventoryCategory._SafeStr_7061, _local_3);
            var _local_4:EffectsModel = new EffectsModel(this, this._windowManager, this._communication, this._assetLibrary, this._localization);
            this._SafeStr_11680.add(InventoryCategory.RWE_EFFECTS, _local_4);
            var _local_5:TradingModel = new TradingModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization, this._soundManager);
            this._SafeStr_11680.add(InventorySubCategory._SafeStr_7064, _local_5);
            var _local_6:RecyclerModel = new RecyclerModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization);
            this._SafeStr_11680.add(InventorySubCategory._SafeStr_7065, _local_6);
            var _local_7:PetsModel = new PetsModel(this, this._windowManager, this._communication, this._assetLibrary, this._localization, this._roomEngine, this._avatarRenderer, this._catalog);
            this._SafeStr_11680.add(InventoryCategory._SafeStr_5996, _local_7);
            _local_2.petsModel = _local_7;
            _local_7.furniModel = _local_2;
            this._isInitialized = true;
            if (this._SafeStr_11682){
                this.requestData();
            };
        }
        public function getCategoryWindowContainer(_arg_1:String):IWindowContainer
        {
            var _local_2:IInventoryModel = IInventoryModel(this._SafeStr_11680.getValue(_arg_1));
            if (_local_2 == null){
                return (null);
            };
            return (_local_2.getWindowContainer());
        }
        public function getCategorySubWindowContainer(_arg_1:String):IWindowContainer
        {
            var _local_2:IInventoryModel = IInventoryModel(this._SafeStr_11680.getValue(_arg_1));
            if (_local_2 == null){
                return (null);
            };
            return (_local_2.getWindowContainer());
        }
        public function getActivatedAvatarEffects():Array
        {
            var _local_1:EffectsModel = this.effectsModel;
            if (_local_1 == null){
                return (new Array());
            };
            return (_local_1.getEffects(1));
        }
        public function getAvatarEffects():Array
        {
            var _local_1:EffectsModel = this.effectsModel;
            if (_local_1 == null){
                return (new Array());
            };
            return (_local_1.getEffects());
        }
        public function setEffectSelected(_arg_1:int):void
        {
            var _local_2:EffectsModel = this.effectsModel;
            if (_local_2 == null){
                return;
            };
            _local_2.useEffect(_arg_1);
            this.notifyChangedEffects();
        }
        public function setEffectDeselected(_arg_1:int):void
        {
            var _local_2:EffectsModel = this.effectsModel;
            if (_local_2 == null){
                return;
            };
            _local_2.stopUsingEffect(_arg_1, true);
            this.notifyChangedEffects();
        }
        public function deselectAllEffects():void
        {
            var _local_1:EffectsModel = this.effectsModel;
            if (_local_1 == null){
                return;
            };
            _local_1.stopUsingAllEffects();
            this.notifyChangedEffects();
        }
        public function closeView():void
        {
            this._view.hideInventory();
        }
        public function showView():void
        {
            this._view.showInventory();
        }
        public function toggleInventoryPage(_arg_1:String, _arg_2:Boolean=false):void
        {
            this._view.toggleCategoryView(_arg_1, false, _arg_2);
            this.inventoryViewOpened(_arg_1);
            if (!this.isVisible){
                events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED));
            };
        }
        public function toggleInventorySubPage(_arg_1:String):void
        {
            var _local_3:IInventoryModel;
            this._view.toggleSubCategoryView(_arg_1, false);
            var _local_2:int;
            while (_local_2 < this._SafeStr_11680.length) {
                _local_3 = (this._SafeStr_11680.getWithIndex(_local_2) as IInventoryModel);
                _local_3.subCategorySwitch(_arg_1);
                _local_2++;
            };
            switch (_arg_1){
                case InventorySubCategory._SafeStr_7064:
                    this._view.toggleCategoryView(InventoryCategory._SafeStr_5995, false);
                    return;
            };
        }
        public function updateSubView():void
        {
            this._view.updateSubCategoryView();
        }
        public function closingInventoryView():void
        {
            var _local_2:IInventoryModel;
            var _local_1:int;
            while (_local_1 < this._SafeStr_11680.length) {
                _local_2 = (this._SafeStr_11680.getWithIndex(_local_1) as IInventoryModel);
                _local_2.closingInventoryView();
                _local_1++;
            };
            events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED));
        }
        public function inventoryViewOpened(_arg_1:String):void
        {
            var _local_3:IInventoryModel;
            var _local_2:int;
            while (_local_2 < this._SafeStr_11680.length) {
                _local_3 = (this._SafeStr_11680.getWithIndex(_local_2) as IInventoryModel);
                _local_3.categorySwitch(_arg_1);
                _local_2++;
            };
        }
        public function setupTrading(_arg_1:int, _arg_2:String):void
        {
            var _local_3:TradingModel = this.tradingModel;
            if (_local_3 == null){
                return;
            };
            _local_3.requestOpenTrading(_arg_1);
        }
        public function get tradingActive():Boolean
        {
            var _local_1:TradingModel = this.tradingModel;
            if (_local_1 == null){
                return (false);
            };
            return (_local_1.running);
        }
        public function setupRecycler(_arg_1:Boolean):void
        {
            if (this.recyclerModel != null){
                if (_arg_1){
                    this.recyclerModel.startRecycler();
                }
                else {
                    this.recyclerModel.stopRecycler();
                };
            };
        }
        public function requestSelectedFurniToRecycler():int
        {
            if (this.recyclerModel != null){
                return (this.recyclerModel.lockSelectedFurni());
            };
            return (0);
        }
        public function returnInventoryFurniFromRecycler(_arg_1:int):Boolean
        {
            if (this.recyclerModel != null){
                return (this.recyclerModel.releaseFurni(_arg_1));
            };
            return (false);
        }
        public function canUserOfferToTrade():Boolean
        {
            var _local_1:TradingModel = this.tradingModel;
            return ((((_local_1)!=null) ? _local_1.ownUserCanTrade : false));
        }
        public function setInventoryCategoryInit(_arg_1:String, _arg_2:Boolean=true):void
        {
            var _local_3:int;
            if (_arg_2){
                if (this._SafeStr_11681.indexOf(_arg_1) == -1){
                    this._SafeStr_11681.push(_arg_1);
                };
            }
            else {
                _local_3 = this._SafeStr_11681.indexOf(_arg_1);
                if (_local_3 >= 0){
                    this._SafeStr_11681.splice(_local_3, 1);
                };
            };
        }
        public function isInventoryCategoryInit(_arg_1:String):Boolean
        {
            if (this._SafeStr_11681.indexOf(_arg_1) >= 0){
                return (true);
            };
            return (false);
        }
        public function checkCategoryInitilization(_arg_1:String):Boolean
        {
            if (this.isInventoryCategoryInit(_arg_1)){
                return (true);
            };
            this.requestInventoryCategoryInit(_arg_1);
            return (false);
        }
        public function requestInventoryCategoryInit(_arg_1:String):void
        {
            var _local_2:IInventoryModel = (this._SafeStr_11680.getValue(_arg_1) as IInventoryModel);
            if (_local_2 != null){
                _local_2.requestInitialization(this._SafeStr_11679);
            };
        }
        public function notifyChangedEffects():void
        {
            events.dispatchEvent(new HabboInventoryEffectsEvent(HabboInventoryEffectsEvent.HIEE_EFFECTS_CHANGED));
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }
        public function getItemById(_arg_1:String, _arg_2:int):IItem
        {
            var _local_4:int;
            var _local_5:GroupItem;
            var _local_6:IItem;
            var _local_3:Array = this.furniModel.getCategoryContent(_arg_1);
            if (_local_3 != null){
                _local_4 = 0;
                while (_local_4 < _local_3.length) {
                    _local_5 = (_local_3[_local_4] as GroupItem);
                    _local_6 = _local_5.getItem(_arg_2);
                    if (_local_6 != null){
                        return (_local_6);
                    };
                    _local_4++;
                };
            };
            return (null);
        }
        public function updateUnseenItemCounts():void
        {
            var _local_1:int = this.furniModel.getUnseenItemCount();
            _local_1 = (_local_1 + this.petsModel.getUnseenItemCount());
            _local_1 = (_local_1 + this.badgesModel.getUnseenItemCount());
            if (_local_1 != this._SafeStr_11683){
                this._SafeStr_11683 = _local_1;
                this._view.updateUnseenItemCounts();
                this._toolbar.setUnseenItemCount(HabboToolbarIconEnum.INVENTORY, _local_1);
            };
        }

    }
}//package com.sulake.habbo.inventory

// IID = "_-3KV" (String#7712, DoABC#2)
// toggleCategoryView = "_-wV" (String#24553, DoABC#2)
// getCategoryWindowContainer = "_-1yQ" (String#18906, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// returnInventoryFurniFromRecycler = "_-81" (String#2057, DoABC#2)
// tradingActive = "_-1-4" (String#1595, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// _roomSession = "_-2CB" (String#1832, DoABC#2)
// _purse = "_-1kp" (String#5763, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// setupRecycler = "_-2Iv" (String#6420, DoABC#2)
// onAuthenticationOK = "_-20A" (String#612, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// onCommunicationComponentInit = "_-1hF" (String#443, DoABC#2)
// _SafeStr_11492 = "_-0aZ" (String#589, DoABC#2)
// onLocalizationManagerReady = "_-Za" (String#936, DoABC#2)
// onConfigurationManagerReady = "_-1OV" (String#604, DoABC#2)
// ownUserCanTrade = "_-0My" (String#14953, DoABC#2)
// toggleInventorySubPage = "_-NR" (String#8153, DoABC#2)
// updateSubView = "_-Ec" (String#22798, DoABC#2)
// requestOpenTrading = "_-05P" (String#14260, DoABC#2)
// effectsModel = "_-0CR" (String#14547, DoABC#2)
// notifyChangedEffects = "_-2Bc" (String#19469, DoABC#2)
// setClubStatus = "_-0VB" (String#15251, DoABC#2)
// badgesModel = "_-mf" (String#24135, DoABC#2)
// isInventoryCategoryInit = "_-3Jx" (String#22282, DoABC#2)
// getCategoryViewId = "_-2Yl" (String#20385, DoABC#2)
// hideInventory = "_-2bi" (String#20512, DoABC#2)
// showInventory = "_-0xY" (String#16334, DoABC#2)
// inventoryViewOpened = "_-zv" (String#24680, DoABC#2)
// toggleSubCategoryView = "_-1KC" (String#17281, DoABC#2)
// updateSubCategoryView = "_-37w" (String#21802, DoABC#2)
// setToolbar = "_-zP" (String#24669, DoABC#2)
// getCategorySubWindowContainer = "_-SM" (String#23340, DoABC#2)
// hasRoomSession = "_-Iw" (String#8059, DoABC#2)
// _SafeStr_11679 = "_-0KS" (String#14857, DoABC#2)
// _SafeStr_11680 = "_-av" (String#23666, DoABC#2)
// _SafeStr_11681 = "_-Pa" (String#23230, DoABC#2)
// _SafeStr_11682 = "_-2PM" (String#20017, DoABC#2)
// _SafeStr_11683 = "_-1LX" (String#17335, DoABC#2)
// roomSessionEventHandler = "_-On" (String#8182, DoABC#2)
// initInventory = "_-2dS" (String#20582, DoABC#2)
// requestData = "_-040" (String#14201, DoABC#2)
// requestInventoryCategoryInit = "_-062" (String#14284, DoABC#2)
// setUnseenItemCount = "_-1B5" (String#5095, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// Purse = "_-M9" (String#8125, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// HabboInventoryEffectsEvent = "_-0Us" (String#15238, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// ScrGetUserInfoMessageComposer = "_-32k" (String#21608, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// TradingModel = "_-1PM" (String#5341, DoABC#2)
// GroupItem = "_-0qS" (String#4647, DoABC#2)
// GetBadgePointLimitsComposer = "_-2-E" (String#18978, DoABC#2)
// BadgesModel = "_-2zV" (String#7278, DoABC#2)
// InventoryMainView = "_-kQ" (String#8610, DoABC#2)
// EffectsModel = "_-ja" (String#8589, DoABC#2)
// InventorySubCategory = "_-1nz" (String#18460, DoABC#2)
// PetsModel = "_-1sv" (String#5899, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// RecyclerModel = "_-25-" (String#6140, DoABC#2)
// RoomSessionPropertyUpdateEvent = "_-2-m" (String#19003, DoABC#2)
// MarketplaceModel = "_-2M1" (String#6484, DoABC#2)
// GetCreditsInfoComposer = "_-1YL" (String#17828, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// RWE_EFFECTS = "_-mU" (String#24127, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// clubPastPeriods = "_-U4" (String#8286, DoABC#2)
// clubHasEverBeenMember = "_-2m" (String#7004, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// clubIsExpiring = "_-0Gw" (String#3893, DoABC#2)
// RSDUE_ALLOW_PETS = "_-1md" (String#18406, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// stopRecycler = "_-0jK" (String#15803, DoABC#2)
// startRecycler = "_-1Am" (String#16893, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// lockSelectedFurni = "_-32j" (String#21607, DoABC#2)
// requestSelectedFurniToRecycler = "_-2P" (String#6543, DoABC#2)
// releaseFurni = "_-Vk" (String#23482, DoABC#2)
// closingInventoryView = "_-0Lx" (String#4000, DoABC#2)
// requestInitialization = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// subCategorySwitch = "_-1Gu" (String#5187, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// toggleInventoryPage = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_5996 = "_-Jg" (String#22993, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// HIEE_EFFECTS_CHANGED = "_-9W" (String#22600, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// getActivatedAvatarEffects = "_-33d" (String#1992, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// _SafeStr_7061 = "_-3KY" (String#22306, DoABC#2)
// _SafeStr_7062 = "_-1SW" (String#17601, DoABC#2)
// _SafeStr_7064 = "_-08P" (String#14380, DoABC#2)
// _SafeStr_7065 = "_-0h6" (String#15713, DoABC#2)
// getAvatarEffects = "_-aN" (String#2133, DoABC#2)
// setEffectSelected = "_-1Ct" (String#1634, DoABC#2)
// setEffectDeselected = "_-2rY" (String#1952, DoABC#2)
// deselectAllEffects = "_-0tu" (String#4721, DoABC#2)
// setupTrading = "_-26E" (String#6170, DoABC#2)
// getItemById = "_-Ap" (String#7883, DoABC#2)
// petsModel = "_-227" (String#19096, DoABC#2)
// setInventoryCategoryInit = "_-0py" (String#16050, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// recyclerModel = "_-26u" (String#19288, DoABC#2)
// getCategoryContent = "_-1lE" (String#18339, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// checkCategoryInitilization = "_-vi" (String#24517, DoABC#2)
// tradingModel = "_-1s3" (String#18635, DoABC#2)
// showView = "_-1gE" (String#860, DoABC#2)
// getSubCategoryViewId = "_-p7" (String#24238, DoABC#2)
// canUserOfferToTrade = "_-1Ic" (String#17218, DoABC#2)
// marketplaceModel = "_-051" (String#14244, DoABC#2)
// closeView = "_-0fQ" (String#15648, DoABC#2)
// isMainViewActive = "_-jz" (String#24031, DoABC#2)
// getUnseenItemCount = "_-133" (String#16582, DoABC#2)
// updateUnseenItemCounts = "_-ik" (String#23988, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// onSoundManagerReady = "_-2hg" (String#369, DoABC#2)
// stopUsingAllEffects = "_-27X" (String#19312, DoABC#2)
// useEffect = "_-3KO" (String#22299, DoABC#2)
// stopUsingEffect = "_-9A" (String#22587, DoABC#2)
// getEffects = "_-1VO" (String#17714, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// HabboInventoryTrackingEvent = "_-1r0" (String#18582, DoABC#2)
// updatePetsAllowed = "_-2UB" (String#20206, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)


