
package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.ComponentContext;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.habbo.ui.widget.RoomWidgetFactory;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboAvatarEditor;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboModeration;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.advertisement.events.InterstitialEvent;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.habbo.session.events.RoomSessionViralFurniStatusEvent;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.session.events.RoomSessionVoteEvent;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;
    import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDanceEvent;
    import com.sulake.habbo.toolbar.HabboToolbarEnum;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.core.assets.XmlAsset;

    public class RoomUI extends ComponentContext implements IRoomUI, IUpdateReceiver 
    {

        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _roomSessionManager:IRoomSessionManager;
        private var _roomWidgetFactory:IRoomWidgetFactory;
        private var _sessionDataManager:ISessionDataManager;
        private var _friendList:IHabboFriendList;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _inventory:IHabboInventory;
        private var _toolbar:IHabboToolbar;
        private var _navigator:IHabboNavigator;
        private var _avatarEditor:IHabboAvatarEditor = null;
        private var _catalog:IHabboCatalog;
        private var _adManager:IAdManager;
        private var _localization:IHabboLocalizationManager;
        private var _habboHelp:IHabboHelp;
        private var _moderation:IHabboModeration;
        private var _config:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var _SafeStr_14349:Map;
        private var _SafeStr_14350:int;
        private var _SafeStr_14351:Boolean;
        private var _interstitialRoomId:int;
        private var _SafeStr_14352:int;
        private var _connection:IConnection;
        private var _habboTracking:IHabboTracking;
        private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;

        public function RoomUI(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._SafeStr_14350 = RoomDesktop._SafeStr_14293;
            super(_arg_1, _arg_2, _arg_3);
            var _local_4:RoomWidgetFactory = new RoomWidgetFactory(this, 0, _arg_3);
            this._roomWidgetFactory = _local_4;
            IContext(_local_4, []);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboAvatarEditor(), this.onAvatarEditorReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboAdManager(), this.onAdManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
            queueInterface(new IIDHabboHelp(), this.onHabboHelpReady);
            queueInterface(new IIDHabboModeration(), this.onHabboModerationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboUserDefinedRoomEvents(), this.onUserDefinedRoomEventsReady);
            queueInterface(new IIDHabboTracking(), this.onHabboTrackingReady);
            this._SafeStr_14349 = new Map();
            IContext(this, 0);
        }
        override public function dispose():void
        {
            var _local_1:String;
            var _local_2:RoomDesktop;
            if (this._windowManager != null){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._roomEngine != null){
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this._roomSessionManager != null){
                this._roomSessionManager.release(new IIDHabboRoomSessionManager());
                this._roomSessionManager = null;
            };
            if (this._roomWidgetFactory != null){
                this._roomWidgetFactory.dispose();
                this._roomWidgetFactory = null;
            };
            if (this._inventory != null){
                this._inventory.release(new IIDHabboInventory());
                this._inventory = null;
            };
            if (this._toolbar != null){
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
            if (this._config != null){
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this._soundManager != null){
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            if (this._adManager != null){
                this._adManager.release(new IIDHabboAdManager());
                this._adManager = null;
            };
            if (this._avatarRenderManager != null){
                this._avatarRenderManager.release(new IIDAvatarRenderManager());
                this._avatarRenderManager = null;
            };
            if (this._catalog != null){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._friendList != null){
                this._friendList.release(new IIDHabboFriendList());
                this._friendList = null;
            };
            if (this._habboHelp != null){
                this._habboHelp.release(new IIDHabboHelp());
                this._habboHelp = null;
            };
            if (this._localization != null){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._moderation != null){
                this._moderation.release(new IIDHabboModeration());
                this._moderation = null;
            };
            if (this._navigator != null){
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            };
            if (this._sessionDataManager != null){
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._habboTracking != null){
                this._habboTracking.release(new IIDHabboTracking());
                this._habboTracking = null;
            };
            if (this._userDefinedRoomEvents){
                this._userDefinedRoomEvents.release(new IIDHabboUserDefinedRoomEvents());
                this._userDefinedRoomEvents = null;
            };
            this._avatarEditor = null;
            this._connection = null;
            if (this._SafeStr_14349){
                while (this._SafeStr_14349.length > 0) {
                    _local_1 = (this._SafeStr_14349.getKey(0) as String);
                    _local_2 = (this._SafeStr_14349.remove(_local_1) as RoomDesktop);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                };
                this._SafeStr_14349.dispose();
                this._SafeStr_14349 = null;
            };
            removeUpdateReceiver(this);
            super.dispose();
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._windowManager = (_arg_2 as IHabboWindowManager);
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomSessionManager = (_arg_2 as IRoomSessionManager);
            this.registerSessionEvents();
            if (((((!((this._roomSessionManager == null))) && (!((this._roomEngine == null))))) && (this._roomEngine.isInitialized))){
                this._roomSessionManager.roomEngineReady = true;
            };
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
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
        private function onInventoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._inventory = (_arg_2 as IHabboInventory);
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._toolbar = (_arg_2 as IHabboToolbar);
        }
        private function onNavigatorReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._navigator = (_arg_2 as IHabboNavigator);
        }
        private function onAvatarEditorReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._avatarEditor = (_arg_2 as IHabboAvatarEditor);
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._catalog = (_arg_2 as IHabboCatalog);
        }
        private function onAdManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._adManager = (_arg_2 as IAdManager);
            if (((!((this._adManager == null))) && (!((this._adManager.events == null))))){
                this._adManager.events.addEventListener(InterstitialEvent.AE_INTERSTITIAL_COMPLETE, this.interstitialCompleteEventHandler);
                this._adManager.events.addEventListener(InterstitialEvent.AE_INTERSTITIAL_SHOW, this.adEventHandler);
                this._adManager.events.addEventListener(AdEvent.AE_ROOM_AD_SHOW, this.adEventHandler);
            };
        }
        private function onLocalizationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._localization = (_arg_2 as IHabboLocalizationManager);
        }
        private function onHabboHelpReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._habboHelp = (_arg_2 as IHabboHelp);
        }
        private function onHabboModerationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._moderation = (_arg_2 as IHabboModeration);
            Logger.log(("XXXX GOT HABBO MODERATION: " + this._moderation));
        }
        private function onConfigurationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._config = (_arg_2 as IHabboConfigurationManager);
        }
        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._soundManager = (_arg_2 as IHabboSoundManager);
        }
        private function registerSessionEvents():void
        {
            if (this._roomSessionManager){
                this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_CREATED, this.roomSessionStateEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.roomSessionStateEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.roomSessionStateEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionChatEvent.RSCE_CHAT_EVENT, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionChatEvent.RSCE_FLOOD_EVENT, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionUserBadgesEvent.RWUBUE_USER_BADGES, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionDoorbellEvent.RSDE_DOORBELL, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionDoorbellEvent.RWDE_REJECTED, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionDoorbellEvent.RWDE_ACCEPTED, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionPresentEvent.RSPE_PRESENT_OPENED, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_REQUESTED, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_RESULT, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionViralFurniStatusEvent.RSVFS_STATUS, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionViralFurniStatusEvent.RSVFS_RECEIVED, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_CANT_TRADE_STUFF, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_INVALID_ITEM_LOC, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_CANT_SET_NOT_OWNER, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_DOOR_NOT_INSTALLED, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_DOOR_OTHER_DELETED, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_MAX_FURNITURE, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_MAX_QUEUE, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_MAX_SOUND, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_MAX_STICKIES, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_KICKED, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_GUIDE_EXISTS, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_GUIDE_BUSY, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_PETS_FORBIDDEN_IN_HOTEL, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_PETS_FORBIDDEN_IN_FLAT, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_MAX_PETS, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_NO_FREE_TILES_FOR_PET, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionErrorMessageEvent.RSEME_SELECTED_TILE_NOT_FREE_FOR_PET, this.roomSessionDialogEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionQueueEvent.RSQE_QUEUE_STATUS, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionVoteEvent.RWPUE_VOTE_QUESTION, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionVoteEvent.RWPUE_VOTE_RESULT, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionPollEvent.RWPUW_CONTENT, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionPollEvent.RWPUW_ERROR, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionPollEvent.RWPUW_OFFER, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionDimmerPresetsEvent.RSDPE_PRESETS, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionFriendRequestEvent.RSFRE_FRIEND_REQUEST, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionUserNotificationEvent.RSUN_USER_NOTIFICATION, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionUserDataUpdateEvent._SafeStr_4720, this.roomSessionEventHandler);
                this._roomSessionManager.events.addEventListener(RoomSessionDanceEvent.RSDE_DANCE, this.roomSessionEventHandler);
            };
        }
        private function roomSessionStateEventHandler(_arg_1:RoomSessionEvent):void
        {
            if (this._roomEngine == null){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionEvent.RSE_CREATED:
                    this.createDesktop(_arg_1.session);
                    return;
                case RoomSessionEvent.RSE_STARTED:
                    this._toolbar.setToolbarState(HabboToolbarEnum.HTE_STATE_ROOM_VIEW);
                    return;
                case RoomSessionEvent.RSE_ENDED:
                    if (_arg_1.session != null){
                        this.disposeDesktop(this.getRoomIdentifier(_arg_1.session.roomId, _arg_1.session.roomCategory));
                        this._toolbar.setToolbarState(HabboToolbarEnum.HTE_STATE_HOTEL_VIEW);
                    };
                    return;
            };
        }
        private function roomSessionEventHandler(_arg_1:RoomSessionEvent):void
        {
            var _local_2:String;
            var _local_3:IRoomDesktop;
            if (this._roomEngine == null){
                return;
            };
            if (_arg_1.session != null){
                _local_2 = this.getRoomIdentifier(_arg_1.session.roomId, _arg_1.session.roomCategory);
                _local_3 = this.getDesktop(_local_2);
                if (_local_3 != null){
                    _local_3.IRoomWidgetHandler(_arg_1);
                };
            };
        }
        private function roomSessionDialogEventHandler(event:RoomSessionEvent):void
        {
            var errorMessage:String;
            var errorTitle:String = "${error.title}";
            switch (event.type){
                case RoomSessionErrorMessageEvent.RSEME_CANT_TRADE_STUFF:
                    errorMessage = "${room.error.cant_trade_stuff}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_INVALID_ITEM_LOC:
                    errorMessage = "${room.error.cant_set_item}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_CANT_SET_NOT_OWNER:
                    errorMessage = "${room.error.cant_set_not_owner}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_MAX_FURNITURE:
                    errorMessage = "${room.error.max_furniture}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_MAX_PETS:
                    errorMessage = "${room.error.max_pets}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_MAX_QUEUE:
                    errorMessage = "${room.error.max_queuetiles}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_MAX_SOUND:
                    errorMessage = "${room.error.max_soundfurni}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_MAX_STICKIES:
                    errorMessage = "${room.error.max_stickies}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_KICKED:
                    errorMessage = "${room.error.kicked}";
                    errorTitle = "${generic.alert.title}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_GUIDE_BUSY:
                    errorMessage = "${room.error.guide.not.available}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_GUIDE_EXISTS:
                    errorMessage = "${room.error.guide.already.exists}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_PETS_FORBIDDEN_IN_HOTEL:
                    errorMessage = "${room.error.pets.forbidden_in_hotel}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_PETS_FORBIDDEN_IN_FLAT:
                    errorMessage = "${room.error.pets.forbidden_in_flat}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_NO_FREE_TILES_FOR_PET:
                    errorMessage = "${room.error.pets.no_free_tiles}";
                    break;
                case RoomSessionErrorMessageEvent.RSEME_SELECTED_TILE_NOT_FREE_FOR_PET:
                    errorMessage = "${room.error.pets.selected_tile_not_free}";
                    break;
                default:
                    return;
            };
            this._windowManager.alert(errorTitle, errorMessage, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        private function interstitialCompleteEventHandler(_arg_1:InterstitialEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:String = this.getRoomIdentifier(this._interstitialRoomId, this._SafeStr_14352);
            var _local_3:RoomDesktop = (this.getDesktop(_local_2) as RoomDesktop);
            if (_local_3 == null){
                return;
            };
            _local_3.IRoomWidgetHandler(_arg_1);
            this._SafeStr_14351 = false;
        }
        private function adEventHandler(_arg_1:AdEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:String = this.getRoomIdentifier(_arg_1.roomId, _arg_1.roomCategory);
            var _local_3:RoomDesktop = (this.getDesktop(_local_2) as RoomDesktop);
            if (_local_3 == null){
                return;
            };
            _local_3.IRoomWidgetHandler(_arg_1);
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomEngine = (_arg_2 as IRoomEngine);
            this.initializeRoomEngineEvents();
            if (((((!((this._roomSessionManager == null))) && (!((this._roomEngine == null))))) && (this._roomEngine.isInitialized))){
                this._roomSessionManager.roomEngineReady = true;
            };
        }
        private function onCommunicationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            var _local_3:IHabboCommunicationManager = (_arg_2 as IHabboCommunicationManager);
            if (_local_3 != null){
                this._connection = _local_3.HabboCommunicationManager(this.onConnectionReady);
                if (this._connection != null){
                    this.onConnectionReady(this._connection);
                };
            };
        }
        private function onUserDefinedRoomEventsReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._userDefinedRoomEvents = (_arg_2 as IHabboUserDefinedRoomEvents);
        }
        private function onHabboTrackingReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._habboTracking = (_arg_2 as IHabboTracking);
        }
        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (disposed){
                return;
            };
            if (_arg_1 != null){
                this._connection = _arg_1;
            };
        }
        private function initializeRoomEngineEvents():void
        {
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.events == null))))){
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_ENGINE_INITIALIZED, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_INITIALIZED, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_DISPOSED, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_NORMAL_MODE, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_GAME_MODE, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineDimmerStateEvent.RWDSUE_DIMMER_STATE, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineRoomColorEvent.REE_ROOM_COLOR, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_OBJECT_SELECTED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_OBJECT_DESELECTED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_ADDED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_OBJECT_REMOVED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_REQUEST_MOVE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.ROE_MOUSE_ENTER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.ROE_MOUSE_LEAVE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_STICKIE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PRESENT, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TROPHY, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TEASER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_ECOTRONBOX, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PLACEHOLDER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_DIMMER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_CLICK, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_DOUBLE_CLICK, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_SHOW, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_HIDE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOR_REMOVE_DIMMER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOR_REQUEST_CLOTHING_CHANGE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_DISPOSE, this.roomObjectEventHandler);
            };
        }
        private function roomEngineEventHandler(_arg_1:RoomEngineEvent):void
        {
            var _local_2:String;
            var _local_3:RoomDesktop;
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.type == RoomEngineEvent.REE_ENGINE_INITIALIZED){
                if (this._roomSessionManager != null){
                    this._roomSessionManager.roomEngineReady = true;
                };
            }
            else {
                if ((((_arg_1.type == RoomEngineEvent.REE_GAME_MODE)) || ((_arg_1.type == RoomEngineEvent.REE_NORMAL_MODE)))){
                    _local_2 = this.getRoomIdentifier(_arg_1.roomId, _arg_1.roomCategory);
                    _local_3 = (this.getDesktop(_local_2) as RoomDesktop);
                    if (_local_3 == null){
                        return;
                    };
                    _local_3.roomEngineEventHandler(_arg_1);
                };
            };
        }
        private function roomEventHandler(_arg_1:RoomEngineEvent):void
        {
            var _local_4:IRoomSession;
            var _local_5:Boolean;
            var _local_6:RoomEngineRoomColorEvent;
            if (_arg_1 == null){
                return;
            };
            if (this._roomEngine == null){
                return;
            };
            var _local_2:String = this.getRoomIdentifier(_arg_1.roomId, _arg_1.roomCategory);
            var _local_3:RoomDesktop = (this.getDesktop(_local_2) as RoomDesktop);
            if (_local_3 == null){
                if (this._roomSessionManager == null){
                    return;
                };
                _local_4 = this._roomSessionManager.getSession(_arg_1.roomId, _arg_1.roomCategory);
                if (_local_4 != null){
                    _local_3 = (this.createDesktop(_local_4) as RoomDesktop);
                };
            };
            if (_local_3 == null){
                return;
            };
            switch (_arg_1.type){
                case RoomEngineEvent.REE_INITIALIZED:
                    _local_5 = false;
                    _local_3.createRoomView(this.getActiveCanvasId(_arg_1.roomId, _arg_1.roomCategory));
                    if (this._roomEngine != null){
                        this._roomEngine.setActiveRoom(_arg_1.roomId, _arg_1.roomCategory);
                        if (this._roomEngine.RoomEngine(this._roomEngine.RoomEngine(_arg_1.roomId, _arg_1.roomCategory))){
                            _local_5 = true;
                        };
                    };
                    _local_3.disposeWidget(RoomWidgetEnum.RWE_ROOM_QUEUE);
                    _local_3.createWidget(RoomWidgetEnum.RWE_CHAT_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_INFOSTAND);
                    if (!_local_3.session.isSpectatorMode){
                        _local_3.createWidget(RoomWidgetEnum.RWE_ME_MENU);
                        _local_3.createWidget(RoomWidgetEnum.RWE_CHAT_INPUT_WIDGET);
                        _local_3.createWidget(RoomWidgetEnum.RSFRE_FRIEND_REQUEST);
                        if (this._config.getKey("avatar.widget.enabled", "0") == "1"){
                            _local_3.createWidget(RoomWidgetEnum.RWAIE_AVATAR_INFO);
                        };
                    };
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_PLACEHOLDER);
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_CREDIT_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_STICKIE_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_PRESENT_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_TROPHY_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_TEASER_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_ECOTRONBOX_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_PET_PACKAGE_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RSDE_DOORBELL);
                    _local_3.createWidget(RoomWidgetEnum.RWE_ROOM_POLL);
                    _local_3.createWidget(RoomWidgetEnum.RWE_ROOM_VOTE);
                    _local_3.createWidget(RoomWidgetEnum.RWE_ROOM_DIMMER);
                    _local_3.createWidget(RoomWidgetEnum.RWE_CLOTHING_CHANGE);
                    _local_3.createWidget(RoomWidgetEnum.RWE_CONVERSION_TRACKING);
                    _local_3.createWidget(RoomWidgetEnum.RSUN_USER_NOTIFICATION);
                    _local_3.createWidget(RoomWidgetEnum.RWE_WELCOME_GIFT);
                    _local_3.createWidget(RoomWidgetEnum.RWE_EFFECTS);
                    if (!_local_5){
                        _local_3.createWidget(RoomWidgetEnum.RWE_FURNI_CHOOSER);
                    };
                    _local_3.createWidget(RoomWidgetEnum.RWE_USER_CHOOSER);
                    if (this._SafeStr_14350 != RoomDesktop._SafeStr_14293){
                        _local_3.initializeWidget(RoomWidgetEnum.RWE_USER_CHOOSER, this._SafeStr_14350);
                    };
                    if (this._adManager != null){
                        this._adManager.RoomEngine(_arg_1.roomId, _arg_1.roomCategory);
                    };
                    _local_3.createWidget(RoomWidgetEnum.RWE_PLAYLIST_EDITOR_WIDGET);
                    _local_3.createWidget(RoomWidgetEnum.RWE_SPAMWALL_POSTIT_WIDGET);
                    return;
                case RoomEngineEvent.REE_DISPOSED:
                    this.disposeDesktop(_local_2);
                    return;
                case RoomEngineRoomColorEvent.REE_ROOM_COLOR:
                    _local_6 = (_arg_1 as RoomEngineRoomColorEvent);
                    if (_local_6 == null) break;
                    if (_local_6.bgOnly){
                        _local_3.IRoomWidgetHandlerContainer(0xFFFFFF, 0xFF);
                    }
                    else {
                        _local_3.IRoomWidgetHandlerContainer(_local_6.color, _local_6.brightness);
                    };
                    return;
                case RoomEngineDimmerStateEvent.RWDSUE_DIMMER_STATE:
                    _local_3.IRoomWidgetHandler(_arg_1);
                    return;
            };
        }
        private function roomObjectEventHandler(_arg_1:RoomEngineObjectEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            if (this._roomEngine == null){
                return;
            };
            var _local_2:String = this.getRoomIdentifier(_arg_1.roomId, _arg_1.roomCategory);
            var _local_3:RoomDesktop = (this.getDesktop(_local_2) as RoomDesktop);
            if (_local_3 == null){
                return;
            };
            _local_3.roomObjectEventHandler(_arg_1);
        }
        public function processWidgetMessage(_arg_1:int, _arg_2:int, _arg_3:RoomWidgetMessage):void
        {
            if (_arg_3 == null){
                return;
            };
            if (this._roomEngine == null){
                return;
            };
            var _local_4:String = this.getRoomIdentifier(_arg_1, _arg_2);
            var _local_5:RoomDesktop = (this.getDesktop(_local_4) as RoomDesktop);
            if (_local_5 == null){
                return;
            };
            _local_5.processWidgetMessage(_arg_3);
        }
        public function createDesktop(_arg_1:IRoomSession):IRoomDesktop
        {
            if (_arg_1 == null){
                return (null);
            };
            if (this._roomEngine == null){
                return (null);
            };
            var _local_2:String = this.getRoomIdentifier(_arg_1.roomId, _arg_1.roomCategory);
            var _local_3:RoomDesktop = (this.getDesktop(_local_2) as RoomDesktop);
            if (_local_3 != null){
                return (_local_3);
            };
            _local_3 = new RoomDesktop(_arg_1, assets, this._connection);
            _local_3.roomEngine = this._roomEngine;
            _local_3.windowManager = this._windowManager;
            _local_3.roomWidgetFactory = this._roomWidgetFactory;
            _local_3.sessionDataManager = this._sessionDataManager;
            _local_3.roomSessionManager = this._roomSessionManager;
            _local_3.friendList = this._friendList;
            _local_3.avatarRenderManager = this._avatarRenderManager;
            _local_3.inventory = this._inventory;
            _local_3.toolbar = this._toolbar;
            _local_3.navigator = this._navigator;
            _local_3.avatarEditor = this._avatarEditor;
            _local_3.catalog = this._catalog;
            _local_3.adManager = this._adManager;
            _local_3.localization = this._localization;
            _local_3.habboHelp = this._habboHelp;
            _local_3.moderation = this._moderation;
            _local_3.config = this._config;
            _local_3.soundManager = this._soundManager;
            _local_3.habboTracking = this._habboTracking;
            _local_3.userDefinedRoomEvents = this._userDefinedRoomEvents;
            var _local_4:XmlAsset = (assets.getAssetByName("room_desktop_layout_xml") as XmlAsset);
            if (_local_4 != null){
                _local_3.layout = (_local_4.content as XML);
            };
            _local_3.createWidget(RoomWidgetEnum.RWE_LOADINGBAR);
            _local_3.createWidget(RoomWidgetEnum.RWE_ROOM_QUEUE);
            _local_3.init();
            if (_local_3.showInterstitial()){
                this._SafeStr_14351 = true;
                this._interstitialRoomId = _arg_1.roomId;
                this._SafeStr_14352 = _arg_1.roomCategory;
            }
            else {
                this._SafeStr_14351 = false;
            };
            this._SafeStr_14349.add(_local_2, _local_3);
            return (_local_3);
        }
        public function disposeDesktop(_arg_1:String):void
        {
            var _local_3:int;
            var _local_2:RoomDesktop = (this._SafeStr_14349.remove(_arg_1) as RoomDesktop);
            if (_local_2 != null){
                _local_3 = _local_2.getWidgetState(RoomWidgetEnum.RWE_USER_CHOOSER);
                if (_local_3 != RoomDesktop._SafeStr_14293){
                    this._SafeStr_14350 = _local_3;
                };
                _local_2.dispose();
                this._SafeStr_14351 = false;
            };
        }
        public function getDesktop(_arg_1:String):IRoomDesktop
        {
            return ((this._SafeStr_14349.getValue(_arg_1) as RoomDesktop));
        }
        public function getActiveCanvasId(_arg_1:int, _arg_2:int):int
        {
            return (1);
        }
        public function update(_arg_1:uint):void
        {
            var _local_3:RoomDesktop;
            var _local_2:int;
            while (_local_2 < this._SafeStr_14349.length) {
                _local_3 = (this._SafeStr_14349.getWithIndex(_local_2) as RoomDesktop);
                if (_local_3 != null){
                    _local_3.update();
                };
                _local_2++;
            };
        }
        private function getRoomIdentifier(_arg_1:int, _arg_2:int):String
        {
            return ("hard_coded_room_id");
        }

    }
}//package com.sulake.habbo.ui

// IID = "_-3KV" (String#7712, DoABC#2)
// _avatarEditor = "_-28H" (String#1820, DoABC#2)
// onCommunicationReady = "_-3Ix" (String#372, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// onFriendListReady = "_-1N-" (String#849, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// onLocalizationManagerReady = "_-Za" (String#936, DoABC#2)
// onConfigurationManagerReady = "_-1OV" (String#604, DoABC#2)
// roomSessionEventHandler = "_-On" (String#8182, DoABC#2)
// IHabboAvatarEditor = "_-N2" (String#8144, DoABC#2)
// onNavigatorReady = "_-1uN" (String#1781, DoABC#2)
// _habboHelp = "_-0ms" (String#1548, DoABC#2)
// onHabboHelpReady = "_-2ht" (String#6904, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// RoomEngine = "_-G6" (String#7996, DoABC#2)
// RoomEngine = "_-1VC" (String#5459, DoABC#2)
// _adManager = "_-0si" (String#825, DoABC#2)
// onAdManagerReady = "_-0Xv" (String#1496, DoABC#2)
// getRoomIdentifier = "_-0yJ" (String#1587, DoABC#2)
// roomObjectEventHandler = "_-0ub" (String#1574, DoABC#2)
// registerSessionEvents = "_-0mt" (String#4564, DoABC#2)
// roomEngineReady = "_-0Qo" (String#4107, DoABC#2)
// HTE_STATE_HOTEL_VIEW = "_-25X" (String#19240, DoABC#2)
// HTE_STATE_ROOM_VIEW = "_-0lU" (String#15882, DoABC#2)
// setToolbarState = "_-2Gw" (String#6384, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// _SafeStr_14293 = "_-el" (String#23833, DoABC#2)
// _roomWidgetFactory = "_-6I" (String#7787, DoABC#2)
// _moderation = "_-10A" (String#4873, DoABC#2)
// _userDefinedRoomEvents = "_-Pe" (String#8195, DoABC#2)
// roomWidgetFactory = "_-1y0" (String#5994, DoABC#2)
// adManager = "_-2ZK" (String#20411, DoABC#2)
// disposeWidget = "_-0P2" (String#15027, DoABC#2)
// roomEngineEventHandler = "_-2g" (String#6866, DoABC#2)
// createRoomView = "_-ag" (String#23659, DoABC#2)
// IRoomWidgetHandlerContainer = "_-1-s" (String#4865, DoABC#2)
// initializeWidget = "_-28Z" (String#19353, DoABC#2)
// getWidgetState = "_-1g-" (String#18139, DoABC#2)
// createDesktop = "_-2Oo" (String#6537, DoABC#2)
// disposeDesktop = "_-34F" (String#7394, DoABC#2)
// _SafeStr_14349 = "_-1Yd" (String#17836, DoABC#2)
// _SafeStr_14350 = "_-26K" (String#19266, DoABC#2)
// _SafeStr_14351 = "_-3Cr" (String#21989, DoABC#2)
// _SafeStr_14352 = "_-1gO" (String#18153, DoABC#2)
// onAvatarEditorReady = "_-3-O" (String#21477, DoABC#2)
// onHabboModerationReady = "_-39q" (String#21878, DoABC#2)
// onUserDefinedRoomEventsReady = "_-1Nt" (String#17430, DoABC#2)
// onHabboTrackingReady = "_-2le" (String#20904, DoABC#2)
// interstitialCompleteEventHandler = "_-2-k" (String#19002, DoABC#2)
// adEventHandler = "_-0n0" (String#15940, DoABC#2)
// roomSessionDialogEventHandler = "_-2e7" (String#20608, DoABC#2)
// initializeRoomEngineEvents = "_-8W" (String#22561, DoABC#2)
// roomEventHandler = "_-Gb" (String#22873, DoABC#2)
// getActiveCanvasId = "_-2sJ" (String#21172, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IRoomDesktop = "_-2iD" (String#6912, DoABC#2)
// RoomDesktop = "_-20r" (String#6061, DoABC#2)
// RoomSessionDanceEvent = "_-nx" (String#24188, DoABC#2)
// InterstitialEvent = "_-2PZ" (String#6552, DoABC#2)
// RoomSessionDoorbellEvent = "_-30k" (String#7320, DoABC#2)
// RoomSessionPollEvent = "_-26l" (String#6181, DoABC#2)
// RoomSessionUserDataUpdateEvent = "_-10F" (String#16473, DoABC#2)
// RoomSessionDimmerPresetsEvent = "_-1lO" (String#5773, DoABC#2)
// RoomSessionPresentEvent = "_-30Q" (String#7312, DoABC#2)
// RoomSessionPetPackageEvent = "_-0sq" (String#4702, DoABC#2)
// RoomSessionViralFurniStatusEvent = "_-2OF" (String#6524, DoABC#2)
// RoomEngineRoomColorEvent = "_-2AM" (String#19420, DoABC#2)
// HabboToolbarEnum = "_-1RO" (String#17561, DoABC#2)
// RoomSessionFriendRequestEvent = "_-31R" (String#21557, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomEngineDimmerStateEvent = "_-kD" (String#24044, DoABC#2)
// RoomSessionUserNotificationEvent = "_-0pw" (String#4633, DoABC#2)
// RoomSessionErrorMessageEvent = "_-2Xn" (String#6720, DoABC#2)
// RoomSessionVoteEvent = "_-19h" (String#5071, DoABC#2)
// RoomSessionUserBadgesEvent = "_-0-O" (String#14028, DoABC#2)
// RoomSessionQueueEvent = "_-0n4" (String#4569, DoABC#2)
// RoomSessionChatEvent = "_-2e3" (String#6834, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// RWE_ROOM_VOTE = "_-1yq" (String#18921, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)
// bgOnly = "_-320" (String#21580, DoABC#2)
// RWE_CHAT_WIDGET = "_-2dZ" (String#20586, DoABC#2)
// RWE_INFOSTAND = "_-0SA" (String#15142, DoABC#2)
// RWE_ME_MENU = "_-1P1" (String#17469, DoABC#2)
// RWE_CHAT_INPUT_WIDGET = "_-L1" (String#23048, DoABC#2)
// RWE_FURNI_PLACEHOLDER = "_-A-" (String#22617, DoABC#2)
// RWE_FURNI_CREDIT_WIDGET = "_-2b9" (String#20495, DoABC#2)
// RWE_FURNI_STICKIE_WIDGET = "_-05M" (String#14258, DoABC#2)
// RWE_FURNI_TROPHY_WIDGET = "_-2lt" (String#20911, DoABC#2)
// RWE_FURNI_TEASER_WIDGET = "_-2Qe" (String#20070, DoABC#2)
// RWE_FURNI_PRESENT_WIDGET = "_-2S0" (String#20119, DoABC#2)
// RWE_FURNI_ECOTRONBOX_WIDGET = "_-0R8" (String#15107, DoABC#2)
// RWE_FURNI_PET_PACKAGE_WIDGET = "_-0tQ" (String#16176, DoABC#2)
// RWE_PLAYLIST_EDITOR_WIDGET = "_-0b8" (String#15481, DoABC#2)
// RSDE_DOORBELL = "_-0bt" (String#15507, DoABC#2)
// RWE_LOADINGBAR = "_-3IO" (String#22216, DoABC#2)
// RWE_ROOM_QUEUE = "_-0WD" (String#15288, DoABC#2)
// RWE_ROOM_POLL = "_-Y" (String#23560, DoABC#2)
// RWE_USER_CHOOSER = "_-1-0" (String#16430, DoABC#2)
// RWE_FURNI_CHOOSER = "_-0aa" (String#15458, DoABC#2)
// RWE_ROOM_DIMMER = "_-2cE" (String#20532, DoABC#2)
// RSFRE_FRIEND_REQUEST = "_-2Wu" (String#20318, DoABC#2)
// RWE_CLOTHING_CHANGE = "_-1Q2" (String#17511, DoABC#2)
// RWE_CONVERSION_TRACKING = "_-30V" (String#21521, DoABC#2)
// RSUN_USER_NOTIFICATION = "_-0ni" (String#15964, DoABC#2)
// RWAIE_AVATAR_INFO = "_-2QK" (String#20059, DoABC#2)
// RWE_WELCOME_GIFT = "_-OF" (String#23177, DoABC#2)
// RWE_SPAMWALL_POSTIT_WIDGET = "_-SH" (String#23335, DoABC#2)
// RWE_EFFECTS = "_-mU" (String#24127, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// RSDE_DANCE = "_-0-n" (String#14045, DoABC#2)
// RWDE_REJECTED = "_-1MV" (String#17378, DoABC#2)
// RWPUW_OFFER = "_-2v3" (String#21280, DoABC#2)
// RWPUW_ERROR = "_-0CA" (String#14535, DoABC#2)
// RWPUW_CONTENT = "_-su" (String#24399, DoABC#2)
// _SafeStr_4720 = "_-XT" (String#23542, DoABC#2)
// RSDPE_PRESETS = "_-3B3" (String#21925, DoABC#2)
// RSPE_PRESENT_OPENED = "_-1eK" (String#18071, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_REQUESTED = "_-FG" (String#22824, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_RESULT = "_-2JR" (String#19786, DoABC#2)
// RSVFS_STATUS = "_-W" (String#23492, DoABC#2)
// RSVFS_RECEIVED = "_-3n" (String#22366, DoABC#2)
// RSEME_DOOR_OTHER_DELETED = "_-1tU" (String#18697, DoABC#2)
// RSEME_DOOR_NOT_INSTALLED = "_-3CD" (String#21969, DoABC#2)
// RSEME_CANT_TRADE_STUFF = "_-1qQ" (String#18560, DoABC#2)
// RSEME_INVALID_ITEM_LOC = "_-0ad" (String#15460, DoABC#2)
// RSEME_CANT_SET_NOT_OWNER = "_-11R" (String#16514, DoABC#2)
// RSEME_MAX_STICKIES = "_-A0" (String#22618, DoABC#2)
// RSEME_MAX_FURNITURE = "_-3f" (String#22360, DoABC#2)
// RSEME_MAX_QUEUE = "_-0vV" (String#16257, DoABC#2)
// RSEME_MAX_SOUND = "_-37I" (String#21780, DoABC#2)
// RSEME_KICKED = "_-1Ip" (String#17229, DoABC#2)
// RSEME_GUIDE_BUSY = "_-0OL" (String#15002, DoABC#2)
// RSEME_GUIDE_EXISTS = "_-0O6" (String#14993, DoABC#2)
// RSEME_PETS_FORBIDDEN_IN_HOTEL = "_-7b" (String#22526, DoABC#2)
// RSEME_PETS_FORBIDDEN_IN_FLAT = "_-2Zv" (String#20437, DoABC#2)
// RSEME_MAX_PETS = "_-LM" (String#23061, DoABC#2)
// RSEME_NO_FREE_TILES_FOR_PET = "_-lQ" (String#24085, DoABC#2)
// RSEME_SELECTED_TILE_NOT_FREE_FOR_PET = "_-2DI" (String#19538, DoABC#2)
// RWPUE_VOTE_QUESTION = "_-1cE" (String#17980, DoABC#2)
// RWPUE_VOTE_RESULT = "_-1I3" (String#17195, DoABC#2)
// RWUBUE_USER_BADGES = "_-21B" (String#19059, DoABC#2)
// RSQE_QUEUE_STATUS = "_-0JP" (String#14818, DoABC#2)
// RSCE_CHAT_EVENT = "_-0km" (String#15857, DoABC#2)
// RSCE_FLOOD_EVENT = "_-2Pn" (String#20035, DoABC#2)
// RSE_CREATED = "_-1XM" (String#17790, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// REOB_OBJECT_ADDED = "_-rY" (String#24341, DoABC#2)
// REE_INITIALIZED = "_-0c3" (String#15515, DoABC#2)
// createWidget = "_-2kN" (String#1932, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// _avatarRenderManager = "_-2uU" (String#454, DoABC#2)
// REOE_OBJECT_SELECTED = "_-Ss" (String#23359, DoABC#2)
// REOE_OBJECT_DESELECTED = "_-1yB" (String#18894, DoABC#2)
// REOE_OBJECT_REMOVED = "_-2ma" (String#20945, DoABC#2)
// REOB_OBJECT_PLACED = "_-2hu" (String#20768, DoABC#2)
// REOB_OBJECT_REQUEST_MOVE = "_-0np" (String#15970, DoABC#2)
// ROE_MOUSE_ENTER = "_-9-" (String#22579, DoABC#2)
// ROE_MOUSE_LEAVE = "_-0o9" (String#15981, DoABC#2)
// REOE_WIDGET_REQUEST_PLACEHOLDER = "_-0mW" (String#15918, DoABC#2)
// REOE_WIDGET_REQUEST_STICKIE = "_-IJ" (String#22941, DoABC#2)
// REOE_WIDGET_REQUEST_PRESENT = "_-3D0" (String#21997, DoABC#2)
// REOE_WIDGET_REQUEST_TROPHY = "_-0gt" (String#15704, DoABC#2)
// REOE_WIDGET_REQUEST_TEASER = "_-0u1" (String#16204, DoABC#2)
// REOE_WIDGET_REQUEST_ECOTRONBOX = "_-mP" (String#24123, DoABC#2)
// REOE_WIDGET_REQUEST_DIMMER = "_-2Sl" (String#20149, DoABC#2)
// REOR_REMOVE_DIMMER = "_-1pt" (String#18537, DoABC#2)
// REOR_REQUEST_CLOTHING_CHANGE = "_-8e" (String#22566, DoABC#2)
// REOR_WIDGET_REQUEST_PLAYLIST_EDITOR = "_-0k" (String#15828, DoABC#2)
// REOE_ROOM_AD_FURNI_CLICK = "_-Ox" (String#23204, DoABC#2)
// REOE_ROOM_AD_FURNI_DOUBLE_CLICK = "_-2ph" (String#21068, DoABC#2)
// REOE_ROOM_AD_TOOLTIP_SHOW = "_-PN" (String#23220, DoABC#2)
// REOE_ROOM_AD_TOOLTIP_HIDE = "_-yL" (String#24628, DoABC#2)
// REE_ROOM_COLOR = "_-00T" (String#14072, DoABC#2)
// RWDSUE_DIMMER_STATE = "_-0A5" (String#14451, DoABC#2)
// REE_ENGINE_INITIALIZED = "_-2KW" (String#19823, DoABC#2)
// REE_DISPOSED = "_-rn" (String#24352, DoABC#2)
// REE_GAME_MODE = "_-131" (String#16581, DoABC#2)
// REE_NORMAL_MODE = "_-1fp" (String#18130, DoABC#2)
// ROSM_JUKEBOX_DISPOSE = "_-gi" (String#23919, DoABC#2)
// AE_INTERSTITIAL_SHOW = "_-2Fx" (String#19641, DoABC#2)
// AE_INTERSTITIAL_COMPLETE = "_-7z" (String#22543, DoABC#2)
// AE_ROOM_AD_SHOW = "_-18f" (String#16799, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// avatarEditor = "_-1mJ" (String#5786, DoABC#2)
// ComponentContext = "_-0jP" (String#4488, DoABC#2)
// IHabboUserDefinedRoomEvents = "_-2Ae" (String#6258, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// moderation = "_-Id" (String#8055, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// habboTracking = "_-1ZQ" (String#5552, DoABC#2)
// roomSessionManager = "_-1bj" (String#5594, DoABC#2)
// userDefinedRoomEvents = "_-2pN" (String#7068, DoABC#2)
// IHabboHelp = "_-2o3" (String#7041, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// onInventoryReady = "_-dE" (String#374, DoABC#2)
// onSoundManagerReady = "_-2hg" (String#369, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// AdEvent = "_-1xT" (String#18868, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// IAdManager = "_-S5" (String#8249, DoABC#2)
// IHabboModeration = "_-1nO" (String#5806, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// isInitialized = "_-1Cr" (String#840, DoABC#2)
// IContext = "_-1G" (String#5169, DoABC#2)
// IRoomUI = "_-2g2" (String#6867, DoABC#2)
// showInterstitial = "_-1Rf" (String#5389, DoABC#2)
// RoomEngine = "_-1ii" (String#1747, DoABC#2)
// RoomWidgetFactory = "_-1pj" (String#18533, DoABC#2)
// onConnectionReady = "_-0k8" (String#359, DoABC#2)


