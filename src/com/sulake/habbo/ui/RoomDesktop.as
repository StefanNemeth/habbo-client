
package com.sulake.habbo.ui
{
    import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IToolTipWindow;
    import flash.utils.Timer;
    import flash.geom.Rectangle;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.navigator.events.HabboNavigatorEvent;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.ui.widget.IRoomWidget;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.ui.handler.ChatWidgetHandler;
    import com.sulake.habbo.ui.handler.PlayListEditorWidgetHandler;
    import com.sulake.habbo.ui.handler.SpamWallPostItWidgetHandler;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
    import com.sulake.habbo.ui.handler.ChatInputWidgetHandler;
    import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
    import com.sulake.habbo.ui.handler.PlaceholderWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureCreditWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureStickieWidgetHandler;
    import com.sulake.habbo.ui.handler.FurniturePresentWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureTrophyWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureTeaserWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureEcotronBoxWidgetHandler;
    import com.sulake.habbo.ui.handler.PetPackageFurniWidgetHandler;
    import com.sulake.habbo.ui.handler.DoorbellWidgetHandler;
    import com.sulake.habbo.ui.handler.RoomQueueWidgetHandler;
    import com.sulake.habbo.ui.handler.LoadingBarWidgetHandler;
    import com.sulake.habbo.ui.handler.VoteWidgetHandler;
    import com.sulake.habbo.ui.handler.PollWidgetHandler;
    import com.sulake.habbo.ui.handler.FurniChooserWidgetHandler;
    import com.sulake.habbo.ui.handler.UserChooserWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureDimmerWidgetHandler;
    import com.sulake.habbo.ui.handler.FriendRequestWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureClothingChangeWidgetHandler;
    import com.sulake.habbo.ui.handler.ConversionPointWidgetHandler;
    import com.sulake.habbo.ui.handler.UserNotificationWidgetHandler;
    import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
    import com.sulake.habbo.ui.handler.WelcomeGiftWidgetHandler;
    import com.sulake.habbo.ui.handler.EffectsWidgetHandler;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import flash.events.Event;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.room.utils.RoomGeometry;
    import flash.display.DisplayObject;
    import com.sulake.habbo.room.RoomVariableEnum;
    import com.sulake.room.utils.Vector3d;
    import flash.external.ExternalInterface;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.Sprite;
    import flash.display.BlendMode;
    import flash.utils.getTimer;
    import com.sulake.room.utils.ColorConverter;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.filters.BlurFilter;
    import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
    import flash.filters.DisplacementMapFilterMode;
    import flash.filters.DisplacementMapFilter;
    import flash.filters.BitmapFilter;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.ui.handler.*;

    public class RoomDesktop implements IRoomDesktop, IRoomWidgetMessageListener, IRoomWidgetHandlerContainer 
    {

        public static const _SafeStr_14293:int = -1;
        private static const _SafeStr_14294:int = 1000;

        private var _events:EventDispatcher;
        private var _windowManager:IHabboWindowManager = null;
        private var _roomEngine:IRoomEngine = null;
        private var _roomWidgetFactory:IRoomWidgetFactory = null;
        private var _sessionDataManager:ISessionDataManager = null;
        private var _roomSessionManager:IRoomSessionManager = null;
        private var _avatarRenderManager:IAvatarRenderManager = null;
        private var _friendList:IHabboFriendList = null;
        private var _inventory:IHabboInventory = null;
        private var _toolbar:IHabboToolbar = null;
        private var _navigator:IHabboNavigator = null;
        private var _avatarEditor:IHabboAvatarEditor = null;
        private var _catalog:IHabboCatalog = null;
        private var _adManager:IAdManager = null;
        private var _localization:IHabboLocalizationManager = null;
        private var _habboHelp:IHabboHelp = null;
        private var _connection:IConnection = null;
        private var _moderation:IHabboModeration;
        private var _config:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var _habboTracking:IHabboTracking;
        private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
        private var _assets:IAssetLibrary = null;
        private var _session:IRoomSession = null;
        private var _SafeStr_14298:Array;
        private var _SafeStr_5035:Map;
        private var _SafeStr_14299:Map;
        private var _SafeStr_14300:Map;
        private var _updateListeners:Array;
        private var _SafeStr_14301:DesktopLayoutManager;
        private var _SafeStr_14302:Boolean = true;
        private var _SafeStr_14303:Boolean = true;
        private var _SafeStr_14304:Array;
        private var _SafeStr_14305:IToolTipWindow;
        private var _SafeStr_14306:uint = 0xFFFFFF;
        private var _SafeStr_14307:Boolean = false;
        private var _SafeStr_14308:int = 0;
        private var _SafeStr_4247:Timer;
        private var _RoomDesktop:Rectangle;

        public function RoomDesktop(_arg_1:IRoomSession, _arg_2:IAssetLibrary, _arg_3:IConnection)
        {
            this._SafeStr_14298 = [];
            super();
            this._events = new EventDispatcher();
            this._session = _arg_1;
            this._assets = _arg_2;
            this._connection = _arg_3;
            this._SafeStr_5035 = new Map();
            this._SafeStr_14299 = new Map();
            this._SafeStr_14300 = new Map();
            this._SafeStr_14301 = new DesktopLayoutManager();
        }
        public function get roomSession():IRoomSession
        {
            return (this._session);
        }
        public function get sessionDataManager():ISessionDataManager
        {
            return (this._sessionDataManager);
        }
        public function get events():IEventDispatcher
        {
            return (this._events);
        }
        public function get roomEngine():IRoomEngine
        {
            return (this._roomEngine);
        }
        public function get roomSessionManager():IRoomSessionManager
        {
            return (this._roomSessionManager);
        }
        public function get friendList():IHabboFriendList
        {
            return (this._friendList);
        }
        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (this._avatarRenderManager);
        }
        public function get inventory():IHabboInventory
        {
            return (this._inventory);
        }
        public function get toolbar():IHabboToolbar
        {
            return (this._toolbar);
        }
        public function get roomWidgetFactory():IRoomWidgetFactory
        {
            return (this._roomWidgetFactory);
        }
        public function get navigator():IHabboNavigator
        {
            return (this._navigator);
        }
        public function get avatarEditor():IHabboAvatarEditor
        {
            return (this._avatarEditor);
        }
        public function get catalog():IHabboCatalog
        {
            return (this._catalog);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }
        public function get habboHelp():IHabboHelp
        {
            return (this._habboHelp);
        }
        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }
        public function get soundManager():IHabboSoundManager
        {
            return (this._soundManager);
        }
        public function get moderation():IHabboModeration
        {
            return (this._moderation);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get habboTracking():IHabboTracking
        {
            return (this._habboTracking);
        }
        public function get session():IRoomSession
        {
            return (this._session);
        }
        public function set catalog(_arg_1:IHabboCatalog):void
        {
            this._catalog = _arg_1;
        }
        public function set avatarEditor(_arg_1:IHabboAvatarEditor):void
        {
            this._avatarEditor = _arg_1;
        }
        public function set roomWidgetFactory(_arg_1:IRoomWidgetFactory):void
        {
            this._roomWidgetFactory = _arg_1;
        }
        public function set sessionDataManager(_arg_1:ISessionDataManager):void
        {
            this._sessionDataManager = _arg_1;
        }
        public function set roomSessionManager(_arg_1:IRoomSessionManager):void
        {
            this._roomSessionManager = _arg_1;
        }
        public function get userDefinedRoomEvents():IHabboUserDefinedRoomEvents
        {
            return (this._userDefinedRoomEvents);
        }
        public function get connection():IConnection
        {
            return (this._connection);
        }
        public function set friendList(_arg_1:IHabboFriendList):void
        {
            this._friendList = _arg_1;
            if (this._friendList){
                this._friendList.events.addEventListener(FriendRequestEvent.RWDE_ACCEPTED, this.IRoomWidgetHandler);
                this._friendList.events.addEventListener(FriendRequestEvent.FRE_DECLINED, this.IRoomWidgetHandler);
            };
        }
        public function set avatarRenderManager(_arg_1:IAvatarRenderManager):void
        {
            this._avatarRenderManager = _arg_1;
        }
        public function set windowManager(_arg_1:IHabboWindowManager):void
        {
            this._windowManager = _arg_1;
        }
        public function set inventory(_arg_1:IHabboInventory):void
        {
            this._inventory = _arg_1;
        }
        public function set navigator(_arg_1:IHabboNavigator):void
        {
            this._navigator = _arg_1;
            this._navigator.events.addEventListener(HabboNavigatorEvent.HTIE_ICON_ZOOM, this.onNavigatorEvent);
        }
        public function set adManager(_arg_1:IAdManager):void
        {
            this._adManager = _arg_1;
        }
        public function set localization(_arg_1:IHabboLocalizationManager):void
        {
            this._localization = _arg_1;
        }
        public function set habboHelp(_arg_1:IHabboHelp):void
        {
            this._habboHelp = _arg_1;
        }
        public function set moderation(_arg_1:IHabboModeration):void
        {
            this._moderation = _arg_1;
        }
        public function set config(_arg_1:IHabboConfigurationManager):void
        {
            this._config = _arg_1;
        }
        public function set soundManager(_arg_1:IHabboSoundManager):void
        {
            this._soundManager = _arg_1;
        }
        public function set habboTracking(_arg_1:IHabboTracking):void
        {
            this._habboTracking = _arg_1;
        }
        public function set userDefinedRoomEvents(_arg_1:IHabboUserDefinedRoomEvents):void
        {
            this._userDefinedRoomEvents = _arg_1;
        }
        public function set roomEngine(_arg_1:IRoomEngine):void
        {
            this._roomEngine = _arg_1;
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.events == null))))){
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.RCLE_SUCCESS, this.onRoomContentLoaded);
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.RCLE_FAILURE, this.onRoomContentLoaded);
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.RCLE_CANCEL, this.onRoomContentLoaded);
            };
        }
        public function set toolbar(_arg_1:IHabboToolbar):void
        {
            this._toolbar = _arg_1;
        }
        public function set layout(_arg_1:XML):void
        {
            this._SafeStr_14301.setLayout(_arg_1, this._windowManager, this._config);
        }
        public function dispose():void
        {
            var _local_2:IRoomGeometry;
            var _local_3:int;
            var _local_4:String;
            var _local_5:IRoomWidget;
            if (((!((this._roomEngine == null))) && (!((this._session == null))))){
                _local_2 = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, this.IRoomWidgetHandlerContainer());
                if (_local_2 != null){
                    this.trackZoomTime(_local_2.RoomGeometry());
                };
            };
            var _local_1:int;
            if (this._SafeStr_14298 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_14298.length) {
                    _local_3 = this._SafeStr_14298[_local_1];
                    _local_4 = this.getWindowName(_local_3);
                    if (this._windowManager){
                        this._windowManager.removeWindow(_local_4);
                    };
                    _local_1++;
                };
            };
            this._updateListeners = null;
            if (this._SafeStr_5035 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_5035.length) {
                    _local_5 = (this._SafeStr_5035.getWithIndex(_local_1) as IRoomWidget);
                    if (_local_5 != null){
                        _local_5.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_5035.dispose();
                this._SafeStr_5035 = null;
            };
            if (this._SafeStr_14299 != null){
                this._SafeStr_14299.dispose();
                this._SafeStr_14299 = null;
            };
            if (this._SafeStr_14300 != null){
                this._SafeStr_14300.dispose();
                this._SafeStr_14300 = null;
            };
            this._assets = null;
            this._avatarRenderManager = null;
            this._SafeStr_14298 = null;
            this._events = null;
            if (((this._friendList) && (this._friendList.events))){
                this._friendList.events.removeEventListener(FriendRequestEvent.RWDE_ACCEPTED, this.IRoomWidgetHandler);
                this._friendList.events.removeEventListener(FriendRequestEvent.FRE_DECLINED, this.IRoomWidgetHandler);
            };
            this._friendList = null;
            this._SafeStr_14301.dispose();
            this._SafeStr_14301 = null;
            if (((!((this._roomEngine == null))) && (!((this._roomEngine.events == null))))){
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.RCLE_SUCCESS, this.onRoomContentLoaded);
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.RCLE_FAILURE, this.onRoomContentLoaded);
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.RCLE_CANCEL, this.onRoomContentLoaded);
            };
            this._roomEngine = null;
            this._roomSessionManager = null;
            this._roomWidgetFactory = null;
            this._session = null;
            this._sessionDataManager = null;
            this._windowManager = null;
            this._inventory = null;
            this._localization = null;
            this._config = null;
            this._soundManager = null;
            if (((this._navigator) && (this._navigator.events))){
                this._navigator.events.removeEventListener(HabboNavigatorEvent.HTIE_ICON_ZOOM, this.onNavigatorEvent);
                this._navigator = null;
            };
            if (this._SafeStr_14305 != null){
                this._SafeStr_14305.dispose();
                this._SafeStr_14305 = null;
            };
            if (this._SafeStr_4247 != null){
                this._SafeStr_4247.reset();
                this._SafeStr_4247.removeEventListener(TimerEvent.TIMER, this.onResizeTimerEvent);
                this._SafeStr_4247 = null;
            };
            this._RoomDesktop = null;
        }
        public function init():void
        {
            if (((!((this._roomEngine == null))) && (!((this._session == null))))){
                this._SafeStr_14304 = this._roomEngine.RoomEngine(this._session.roomResources);
                if (this._SafeStr_14304.length > 0){
                    this._SafeStr_14303 = false;
                    this.IRoomWidgetHandler(new RoomWidgetLoadingBarUpdateEvent(RoomWidgetLoadingBarUpdateEvent.RWIUE_SHOW));
                };
            };
        }
        public function showInterstitial():Boolean
        {
            if (((!((this._adManager == null))) && ((this._session.state == RoomSessionEvent.RSE_CREATED)))){
                this._SafeStr_14302 = !(this._adManager.showInterstitial());
            };
            return (this.checkInterrupts());
        }
        private function onRoomContentLoaded(_arg_1:RoomContentLoadedEvent):void
        {
            if ((((this._SafeStr_14304 == null)) || ((this._SafeStr_14304.length == 0)))){
                return;
            };
            var _local_2:int = this._SafeStr_14304.indexOf(_arg_1.contentType);
            if (_local_2 != -1){
                this._SafeStr_14304.splice(_local_2, 1);
            };
            if (this._SafeStr_14304.length == 0){
                this._SafeStr_14303 = true;
                this.checkInterrupts();
            };
        }
        public function createWidget(_arg_1:String):void
        {
            var _local_3:Boolean;
            var _local_4:IRoomWidgetHandler;
            var _local_5:ChatWidgetHandler;
            var _local_6:PlayListEditorWidgetHandler;
            var _local_7:SpamWallPostItWidgetHandler;
            var _local_8:Array;
            var _local_9:Array;
            var _local_10:Array;
            var _local_11:String;
            var _local_12:String;
            var _local_13:RoomWidgetRoomViewUpdateEvent;
            if (this._roomWidgetFactory == null){
                return;
            };
            var _local_2:IRoomWidget = (this._SafeStr_5035.getValue(_arg_1) as IRoomWidget);
            if (_local_2 != null){
                return;
            };
            switch (_arg_1){
                case RoomWidgetEnum.RWE_CHAT_WIDGET:
                    _local_5 = new ChatWidgetHandler();
                    _local_5.connection = this._connection;
                    _local_4 = _local_5;
                    _local_3 = true;
                    break;
                case RoomWidgetEnum.RWE_INFOSTAND:
                    _local_4 = new InfoStandWidgetHandler(this._soundManager.musicController);
                    break;
                case RoomWidgetEnum.RWE_CHAT_INPUT_WIDGET:
                    _local_3 = true;
                    _local_4 = new ChatInputWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_ME_MENU:
                    _local_4 = new MeMenuWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_PLACEHOLDER:
                    _local_4 = new PlaceholderWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_CREDIT_WIDGET:
                    _local_4 = new FurnitureCreditWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_STICKIE_WIDGET:
                    _local_4 = new FurnitureStickieWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_PRESENT_WIDGET:
                    _local_4 = new FurniturePresentWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_TROPHY_WIDGET:
                    _local_4 = new FurnitureTrophyWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_TEASER_WIDGET:
                    _local_4 = new FurnitureTeaserWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_ECOTRONBOX_WIDGET:
                    _local_4 = new FurnitureEcotronBoxWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_PET_PACKAGE_WIDGET:
                    _local_4 = new PetPackageFurniWidgetHandler();
                    break;
                case RoomWidgetEnum.RSDE_DOORBELL:
                    _local_4 = new DoorbellWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_ROOM_QUEUE:
                    _local_4 = new RoomQueueWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_LOADINGBAR:
                    _local_4 = new LoadingBarWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_ROOM_VOTE:
                    _local_4 = new VoteWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_ROOM_POLL:
                    _local_4 = new PollWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_FURNI_CHOOSER:
                    _local_4 = new FurniChooserWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_USER_CHOOSER:
                    _local_4 = new UserChooserWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_ROOM_DIMMER:
                    _local_4 = new FurnitureDimmerWidgetHandler();
                    break;
                case RoomWidgetEnum.RSFRE_FRIEND_REQUEST:
                    _local_4 = new FriendRequestWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_CLOTHING_CHANGE:
                    _local_4 = new FurnitureClothingChangeWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_CONVERSION_TRACKING:
                    _local_4 = new ConversionPointWidgetHandler();
                    break;
                case RoomWidgetEnum.RSUN_USER_NOTIFICATION:
                    _local_4 = new UserNotificationWidgetHandler();
                    break;
                case RoomWidgetEnum.RWAIE_AVATAR_INFO:
                    _local_4 = new AvatarInfoWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_WELCOME_GIFT:
                    _local_4 = new WelcomeGiftWidgetHandler();
                    break;
                case RoomWidgetEnum.RWE_PLAYLIST_EDITOR_WIDGET:
                    _local_6 = new PlayListEditorWidgetHandler();
                    _local_6.connection = this._connection;
                    _local_4 = (_local_6 as IRoomWidgetHandler);
                    break;
                case RoomWidgetEnum.RWE_SPAMWALL_POSTIT_WIDGET:
                    _local_7 = new SpamWallPostItWidgetHandler();
                    _local_7.connection = this._connection;
                    _local_4 = (_local_7 as IRoomWidgetHandler);
                    break;
                case RoomWidgetEnum.RWE_EFFECTS:
                    _local_4 = new EffectsWidgetHandler();
                    break;
            };
            if (_local_4 != null){
                _local_4.container = this;
                _local_8 = null;
                _local_9 = _local_4.IRoomWidgetHandler();
                if (_local_9 != null){
                    for each (_local_11 in _local_9) {
                        _local_8 = this._SafeStr_14299.getValue(_local_11);
                        if (_local_8 == null){
                            _local_8 = [];
                            this._SafeStr_14299.add(_local_11, _local_8);
                        }
                        else {
                            Logger.log((("Room widget message '" + _local_11) + "' handled by more than one widget message handler, could cause problems. Be careful!"));
                        };
                        _local_8.push(_local_4);
                    };
                };
                _local_10 = _local_4.IRoomWidgetHandler();
                if (_local_10 != null){
                    for each (_local_12 in _local_10) {
                        _local_8 = this._SafeStr_14300.getValue(_local_12);
                        if (_local_8 == null){
                            _local_8 = [];
                            this._SafeStr_14300.add(_local_12, _local_8);
                        };
                        _local_8.push(_local_4);
                    };
                };
            };
            _local_2 = this._roomWidgetFactory.createWidget(_arg_1, _local_4);
            if (_local_2 == null){
                return;
            };
            _local_2.messageListener = this;
            _local_2.RoomChatWidget(this._events);
            if (!this._SafeStr_5035.add(_arg_1, _local_2)){
                _local_2.dispose();
            }
            else {
                this._SafeStr_14301.addWidgetWindow(_arg_1, _local_2.mainWindow);
            };
            if (_local_3){
                _arg_1 = RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_SIZE_CHANGED;
                _local_13 = new RoomWidgetRoomViewUpdateEvent(_arg_1, this._SafeStr_14301.roomViewRect);
                this.events.dispatchEvent(_local_13);
            };
        }
        public function disposeWidget(_arg_1:String):void
        {
            var _local_2:IRoomWidget;
            if (this._SafeStr_5035 != null){
                _local_2 = this._SafeStr_5035.remove(_arg_1);
                if (_local_2 != null){
                    if (this._SafeStr_14301 != null){
                        this._SafeStr_14301.removeWidgetWindow(_arg_1, _local_2.mainWindow);
                    };
                    _local_2.dispose();
                };
            };
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_3:IRoomWidgetHandler;
            var _local_4:RoomWidgetUpdateEvent;
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:Array = this._SafeStr_14299.getValue(_arg_1.type);
            if (_local_2 != null){
                for each (_local_3 in _local_2) {
                    _local_4 = _local_3.processWidgetMessage(_arg_1);
                    if (_local_4 != null){
                        return (_local_4);
                    };
                };
            };
            return (null);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_3:IRoomWidgetHandler;
            if (!_arg_1){
                return;
            };
            var _local_2:Array = this._SafeStr_14300.getValue(_arg_1.type);
            if (_local_2 != null){
                for each (_local_3 in _local_2) {
                    _local_3.IRoomWidgetHandler(_arg_1);
                };
            };
        }
        private function isFurnitureSelectionDisabled(_arg_1:RoomEngineObjectEvent):Boolean
        {
            var _local_4:IRoomObjectModel;
            var _local_2:Boolean;
            var _local_3:IRoomObject = this.roomEngine.IRoomSpriteCanvasContainer(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _arg_1.category);
            if (_local_3 != null){
                _local_4 = _local_3.getModel();
                if (_local_4 != null){
                    if (_local_4.getNumber(RoomObjectVariableEnum._SafeStr_12472) == 1){
                        _local_2 = true;
                        if (this._sessionDataManager.isAnyRoomController){
                            _local_2 = false;
                        };
                    };
                };
            };
            return (_local_2);
        }
        public function roomObjectEventHandler(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_6:String;
            var _local_7:IUserData;
            if (_arg_1 == null){
                return;
            };
            var _local_2:int = int(_arg_1.objectId);
            var _local_3:int = int(_arg_1.category);
            var _local_4:RoomWidgetRoomObjectUpdateEvent;
            var _local_5:RoomWidgetFurniToWidgetMessage;
            switch (_arg_1.type){
                case RoomEngineObjectEvent.REOE_OBJECT_SELECTED:
                    if (!this.isFurnitureSelectionDisabled(_arg_1)){
                        _local_4 = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    };
                    if (((!((this._moderation == null))) && ((_local_3 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)))){
                        _local_7 = this._session.userDataManager.getUserDataByIndex(_local_2);
                        if (((!((_local_7 == null))) && ((_local_7.type == RoomObjectTypeEnum._SafeStr_3740)))){
                            this._moderation.userSelected(_local_7.webID, _local_7.name);
                        };
                    };
                    break;
                case RoomEngineObjectEvent.REOB_OBJECT_ADDED:
                    switch (_local_3){
                        case RoomObjectCategoryEnum._SafeStr_4329:
                        case RoomObjectCategoryEnum._SafeStr_4330:
                            _local_6 = RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_ADDED;
                            break;
                        case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                            _local_6 = RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_ADDED;
                            break;
                    };
                    if (_local_6 != null){
                        _local_4 = new RoomWidgetRoomObjectUpdateEvent(_local_6, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    };
                    break;
                case RoomEngineObjectEvent.REOE_OBJECT_REMOVED:
                    switch (_local_3){
                        case RoomObjectCategoryEnum._SafeStr_4329:
                        case RoomObjectCategoryEnum._SafeStr_4330:
                            _local_6 = RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED;
                            break;
                        case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                            _local_6 = RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED;
                            break;
                    };
                    if (_local_6 != null){
                        _local_4 = new RoomWidgetRoomObjectUpdateEvent(_local_6, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    };
                    break;
                case RoomEngineObjectEvent.REOE_OBJECT_DESELECTED:
                    _local_4 = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    break;
                case RoomEngineObjectEvent.ROE_MOUSE_ENTER:
                    _local_4 = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OVER, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    break;
                case RoomEngineObjectEvent.ROE_MOUSE_LEAVE:
                    _local_4 = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OUT, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    break;
                case RoomEngineObjectEvent.REOB_OBJECT_REQUEST_MOVE:
                    if (((!(this._session.isRoomController)) && (!(this._sessionDataManager.isAnyRoomController)))){
                        return;
                    };
                    this._roomEngine.RoomEngine(_arg_1.objectId, _arg_1.category, RoomObjectOperationEnum.OBJECT_MOVE);
                    break;
                case RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_CREDITFURNI, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_STICKIE:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_STICKIE, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PRESENT:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PRESENT, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TROPHY:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_TROPHY, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TEASER:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_TEASER, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_ECOTRONBOX:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_DIMMER:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_DIMMER, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PLACEHOLDER:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PLACEHOLDER, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_CLICK:
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_DOUBLE_CLICK:
                    this.handleRoomAdClick(_arg_1);
                    break;
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_SHOW:
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_HIDE:
                    this.handleRoomAdTooltip(_arg_1);
                    break;
                case RoomEngineObjectEvent.REOR_REMOVE_DIMMER:
                    this.IRoomWidgetHandler(_arg_1);
                    break;
                case RoomEngineObjectEvent.REOR_REQUEST_CLOTHING_CHANGE:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineObjectEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR:
                    _local_5 = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR, _local_2, _local_3, _arg_1.roomId, _arg_1.roomCategory);
                    this.processWidgetMessage(_local_5);
                    break;
                case RoomEngineSoundMachineEvent.ROSM_JUKEBOX_DISPOSE:
                    this.IRoomWidgetHandler(_arg_1);
                    break;
            };
            if (_local_4 != null){
                this.events.dispatchEvent(_local_4);
            };
        }
        public function roomEngineEventHandler(_arg_1:RoomEngineEvent):void
        {
            var _local_2:RoomWidgetUpdateEvent;
            switch (_arg_1.type){
                case RoomEngineEvent.REE_NORMAL_MODE:
                    _local_2 = new RoomWidgetRoomEngineUpdateEvent(RoomWidgetRoomEngineUpdateEvent.RWREUE_NORMAL_MODE, _arg_1.roomId, _arg_1.roomCategory);
                    break;
                case RoomEngineEvent.REE_GAME_MODE:
                    _local_2 = new RoomWidgetRoomEngineUpdateEvent(RoomWidgetRoomEngineUpdateEvent._SafeStr_3911, _arg_1.roomId, _arg_1.roomCategory);
                    break;
            };
            if (_local_2 != null){
                this.events.dispatchEvent(_local_2);
            };
        }
        public function createRoomView(_arg_1:int):void
        {
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:IWindow;
            var _local_2:Rectangle = this._SafeStr_14301.roomViewRect;
            var _local_3:int = _local_2.width;
            var _local_4:int = _local_2.height;
            var _local_5:int = RoomGeometry._SafeStr_14327;
            if (this._SafeStr_14298.indexOf(_arg_1) >= 0){
                return;
            };
            if ((((((this._session == null)) || ((this._windowManager == null)))) || ((this._roomEngine == null)))){
                return;
            };
            var _local_6:DisplayObject = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, _arg_1, _local_3, _local_4, _local_5);
            if (_local_6 == null){
                return;
            };
            var _local_7:RoomGeometry = (this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, _arg_1) as RoomGeometry);
            if (_local_7 != null){
                _local_13 = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, RoomVariableEnum._SafeStr_13365);
                _local_14 = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, RoomVariableEnum._SafeStr_13366);
                _local_15 = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, RoomVariableEnum._SafeStr_13367);
                _local_16 = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, RoomVariableEnum._SafeStr_13368);
                _local_17 = ((_local_13 + _local_14) / 2);
                _local_18 = ((_local_15 + _local_16) / 2);
                _local_19 = 20;
                _local_17 = (_local_17 + (_local_19 - 1));
                _local_18 = (_local_18 + (_local_19 - 1));
                _local_20 = (Math.sqrt(((_local_19 * _local_19) + (_local_19 * _local_19))) * Math.tan(((30 / 180) * Math.PI)));
                _local_7.location = new Vector3d(_local_17, _local_18, _local_20);
            };
            ExternalInterface.addCallback("takeRoomShot", this.onRoomShot);
            var _local_8:XmlAsset = (this._assets.getAssetByName("room_view_container_xml") as XmlAsset);
            if (_local_8 == null){
                return;
            };
            var _local_9:IWindowContainer = (this._windowManager.buildFromXML((_local_8.content as XML)) as IWindowContainer);
            if (_local_9 == null){
                return;
            };
            _local_9.width = _local_3;
            _local_9.height = _local_4;
            var _local_10:IDisplayObjectWrapper = (_local_9.findChildByName("room_canvas_wrapper") as IDisplayObjectWrapper);
            if (_local_10 == null){
                return;
            };
            _local_10.setDisplayObject(_local_6);
            _local_10.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.canvasMouseHandler);
            _local_10.addEventListener(WindowMouseEvent.WME_DOUBLE_CLICK, this.canvasMouseHandler);
            _local_10.addEventListener(WindowMouseEvent.WME_MOVE, this.canvasMouseHandler);
            _local_10.addEventListener(WindowMouseEvent.WME_DOWN, this.canvasMouseHandler);
            _local_10.addEventListener(WindowMouseEvent.WME_UP, this.canvasMouseHandler);
            _local_10.addEventListener(WindowMouseEvent.WME_UP_OUTSIDE, this.canvasMouseHandler);
            _local_10.addEventListener(WindowEvent.WE_RESIZED, this.onRoomViewResized);
            var _local_11:Sprite = new Sprite();
            _local_11.mouseEnabled = false;
            _local_11.blendMode = BlendMode.MULTIPLY;
            _local_10 = (_local_9.findChildByName("colorizer_wrapper") as IDisplayObjectWrapper);
            if (_local_10 == null){
                return;
            };
            _local_10.setDisplayObject(_local_11);
            _local_10.addEventListener(WindowEvent.WE_RESIZED, this.resizeColorizer);
            if (this._session.isSpectatorMode){
                _local_21 = this.getSpectatorModeVisualization();
                if (_local_21 != null){
                    _local_21.width = _local_9.width;
                    _local_21.height = _local_9.height;
                    _local_9.addChild(_local_21);
                };
            };
            this._SafeStr_14301.addRoomView(_local_9);
            this._SafeStr_14298.push(_arg_1);
            var _local_12:String = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory);
            if (!this._roomEngine.RoomEngine(_local_12)){
                this._SafeStr_14307 = true;
                this._SafeStr_14308 = getTimer();
            };
        }
        private function resizeColorizer(_arg_1:WindowEvent):void
        {
            var _local_2:IDisplayObjectWrapper = (_arg_1.target as IDisplayObjectWrapper);
            if (_local_2 == null){
                return;
            };
            var _local_3:Sprite = (_local_2.getDisplayObject() as Sprite);
            if (_local_3 == null){
                return;
            };
            _local_3.graphics.clear();
            _local_3.graphics.beginFill(this._SafeStr_14306);
            _local_3.graphics.drawRect(0, 0, _local_2.width, _local_2.height);
            _local_3.graphics.endFill();
        }
        public function IRoomWidgetHandlerContainer(_arg_1:uint, _arg_2:int):void
        {
            var _local_3:IWindowContainer = (this._SafeStr_14301.DesktopLayoutManager() as IWindowContainer);
            if (_local_3 == null){
                return;
            };
            var _local_4:IDisplayObjectWrapper = (_local_3.getChildByName("colorizer_wrapper") as IDisplayObjectWrapper);
            if (_local_4 == null){
                return;
            };
            var _local_5:Sprite = (_local_4.getDisplayObject() as Sprite);
            if (_local_5 == null){
                return;
            };
            var _local_6:int = ColorConverter.rgbToHSL(_arg_1);
            _local_6 = ((_local_6 & 0xFFFF00) + _arg_2);
            _arg_1 = ColorConverter.hslToRGB(_local_6);
            this._SafeStr_14306 = _arg_1;
            _local_5.graphics.clear();
            _local_5.graphics.beginFill(_arg_1);
            _local_5.graphics.drawRect(0, 0, _local_4.width, _local_4.height);
            _local_5.graphics.endFill();
        }
        public function IRoomWidgetHandlerContainer():int
        {
            if (this._SafeStr_14298 != null){
                if (this._SafeStr_14298.length > 0){
                    return (this._SafeStr_14298[0]);
                };
            };
            return (0);
        }
        public function IRoomWidgetHandlerContainer():Rectangle
        {
            if (!this._SafeStr_14301){
                return (null);
            };
            return (this._SafeStr_14301.roomViewRect);
        }
        public function canvasMouseHandler(_arg_1:WindowEvent):void
        {
            var _local_5:Point;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Point;
            if ((((this._roomEngine == null)) || ((this._session == null)))){
                return;
            };
            var _local_2:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:String = "";
            switch (_local_2.type){
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    _local_3 = MouseEvent.CLICK;
                    break;
                case WindowMouseEvent.WME_DOUBLE_CLICK:
                    _local_3 = MouseEvent.DOUBLE_CLICK;
                    break;
                case WindowMouseEvent.WME_DOWN:
                    _local_3 = MouseEvent.MOUSE_DOWN;
                    break;
                case WindowMouseEvent.WME_UP:
                case WindowMouseEvent.WME_UP_OUTSIDE:
                    _local_3 = MouseEvent.MOUSE_UP;
                    break;
                case WindowMouseEvent.WME_MOVE:
                    _local_3 = MouseEvent.MOUSE_MOVE;
                    break;
                default:
                    return;
            };
            var _local_4:IDisplayObjectWrapper = (_local_2.target as IDisplayObjectWrapper);
            if (_local_4 == _local_2.target){
                _local_5 = new Point();
                _local_4.getGlobalPosition(_local_5);
                _local_6 = (_local_2.stageX - _local_5.x);
                _local_7 = (_local_2.stageY - _local_5.y);
                this._roomEngine.setActiveRoom(this._session.roomId, this._session.roomCategory);
                this._roomEngine.RoomEngine(this._SafeStr_14298[0], _local_6, _local_7, _local_3, _local_2.altKey, _local_2.ctrlKey, _local_2.shiftKey, _local_2.buttonDown);
            };
            if ((((_local_3 == MouseEvent.MOUSE_MOVE)) && (!((this._SafeStr_14305 == null))))){
                _local_8 = new Point(_local_2.stageX, _local_2.stageY);
                _local_8.offset((-(this._SafeStr_14305.width) / 2), 15);
                this._SafeStr_14305.WindowController(_local_8);
            };
        }
        private function onRoomViewResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.window;
            this._RoomDesktop = _local_2.rectangle;
            this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, this._SafeStr_14298[0], _local_2.width, _local_2.height);
            if (this._SafeStr_4247 == null){
                this._SafeStr_4247 = new Timer(_SafeStr_14294, 1);
                this._SafeStr_4247.addEventListener(TimerEvent.TIMER, this.onResizeTimerEvent);
            }
            else {
                this._SafeStr_4247.reset();
            };
            this._SafeStr_4247.start();
        }
        private function onResizeTimerEvent(_arg_1:TimerEvent):void
        {
            var _local_2:String = RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_SIZE_CHANGED;
            this.events.dispatchEvent(new RoomWidgetRoomViewUpdateEvent(_local_2, this._RoomDesktop));
        }
        private function trackZoomTime(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            if (this._SafeStr_14307){
                _local_2 = getTimer();
                _local_3 = Math.round(((_local_2 - this._SafeStr_14308) / 1000));
                if (this._habboTracking != null){
                    if (_arg_1){
                        this._habboTracking.trackGoogle("zoomEnded", "in", _local_3);
                    }
                    else {
                        this._habboTracking.trackGoogle("zoomEnded", "out", _local_3);
                    };
                };
                this._SafeStr_14308 = _local_2;
            };
        }
        private function onNavigatorEvent(_arg_1:HabboNavigatorEvent):void
        {
            var _local_2:IRoomGeometry;
            if (_arg_1.type == HabboNavigatorEvent.HTIE_ICON_ZOOM){
                if (this._session != null){
                    _local_2 = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, this.IRoomWidgetHandlerContainer());
                    if (_local_2 != null){
                        this.trackZoomTime(_local_2.RoomGeometry());
                        _local_2.RoomGeometry();
                    };
                };
            };
        }
        public function update():void
        {
            var _local_3:IRoomWidgetHandler;
            if (this._updateListeners == null){
                return;
            };
            var _local_1:int = this._updateListeners.length;
            var _local_2:int;
            while (_local_2 < _local_1) {
                _local_3 = (this._updateListeners.getWithIndex(_local_2) as IRoomWidgetHandler);
                if (_local_3 != null){
                    _local_3.update();
                };
                _local_2++;
            };
        }
        private function getWindowName(_arg_1:int):String
        {
            return (("Room_Engine_Window_" + _arg_1));
        }
        private function createFilter(_arg_1:int, _arg_2:int):Array
        {
            var _local_3:BlurFilter = new BlurFilter(2, 2);
            return ([]);
        }
        private function getBitmapFilter(_arg_1:int, _arg_2:int):BitmapFilter
        {
            var _local_3:BitmapData = new BitmapData(_arg_1, _arg_2);
            _local_3.perlinNoise(_arg_1, _arg_2, 5, (Math.random() * 0x77359400), true, false);
            var _local_4:Point = new Point(0, 0);
            var _local_5:uint = BitmapDataChannel.RED;
            var _local_6:uint = _local_5;
            var _local_7:uint = _local_5;
            var _local_8:Number = (_arg_1 / 20);
            var _local_9:Number = (-(_arg_1) / 25);
            var _local_10:String = DisplacementMapFilterMode.COLOR;
            var _local_11:uint;
            var _local_12:Number = 0;
            return (new DisplacementMapFilter(_local_3, _local_4, _local_6, _local_7, _local_8, _local_9, _local_10, _local_11, _local_12));
        }
        private function checkInterrupts():Boolean
        {
            if (((((((!((this._roomSessionManager == null))) && (!((this._session == null))))) && (this._SafeStr_14302))) && (this._SafeStr_14303))){
                this._roomSessionManager.RoomSessionManager(this._session);
                this.IRoomWidgetHandler(new RoomWidgetLoadingBarUpdateEvent(RoomWidgetLoadingBarUpdateEvent.RWLBUW_HIDE_LOADING_BAR));
                return (true);
            };
            return (false);
        }
        public function IRoomWidgetHandlerContainer():void
        {
            this._SafeStr_14302 = true;
            this.checkInterrupts();
        }
        private function handleRoomAdClick(_arg_1:RoomEngineObjectEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:IRoomObject = this._roomEngine.IRoomSpriteCanvasContainer(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _arg_1.category);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomObjectModel = (_local_2.getModel() as IRoomObjectModel);
            var _local_4:String = _local_3.getString(RoomObjectVariableEnum._SafeStr_12448);
            if ((((_local_4 == null)) || (!((_local_4.indexOf("http") == 0))))){
                return;
            };
            switch (_arg_1.type){
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_CLICK:
                    if (((this._session.isRoomController) || (this._sessionDataManager.isAnyRoomController))){
                        return;
                    };
                    HabboWebTools.HTMLTextController(_local_4);
                    return;
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_DOUBLE_CLICK:
                    if (((!(this._session.isRoomController)) && (!(this._sessionDataManager.isAnyRoomController)))){
                        return;
                    };
                    HabboWebTools.HTMLTextController(_local_4);
                    return;
            };
        }
        private function handleRoomAdTooltip(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:IRoomObject;
            var _local_3:String;
            if (_arg_1 == null){
                return;
            };
            switch (_arg_1.type){
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_SHOW:
                    if (this._SafeStr_14305 != null){
                        return;
                    };
                    _local_2 = this._roomEngine.IRoomSpriteCanvasContainer(_arg_1.roomId, _arg_1.roomCategory, _arg_1.objectId, _arg_1.category);
                    if (_local_2 == null){
                        return;
                    };
                    _local_3 = this._localization.getKey((_local_2.getType() + ".tooltip"), "${ads.roomad.tooltip}");
                    this._SafeStr_14305 = (this._windowManager.createWindow("room_ad_tooltip", _local_3, WindowType._SafeStr_9432, WindowStyle._SafeStr_9310, WindowParam._SafeStr_7445) as IToolTipWindow);
                    this._SafeStr_14305.setParamFlag(WindowParam._SafeStr_7434, false);
                    this._SafeStr_14305.visible = true;
                    this._SafeStr_14305.center();
                    return;
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_HIDE:
                    if (this._SafeStr_14305 == null){
                        return;
                    };
                    this._SafeStr_14305.dispose();
                    this._SafeStr_14305 = null;
                    return;
            };
        }
        private function getSpectatorModeVisualization():IWindow
        {
            var _local_1:XmlAsset = (this._assets.getAssetByName("spectator_mode_xml") as XmlAsset);
            if (_local_1 == null){
                return (null);
            };
            var _local_2:IWindowContainer = (this._windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            if (_local_2 == null){
                return (null);
            };
            this.setBitmap(_local_2.findChildByName("top_left"), "spec_top_left_png");
            this.setBitmap(_local_2.findChildByName("top_middle"), "spec_top_middle_png");
            this.setBitmap(_local_2.findChildByName("top_right"), "spec_top_right_png");
            this.setBitmap(_local_2.findChildByName("middle_left"), "spec_middle_left_png");
            this.setBitmap(_local_2.findChildByName("middle_right"), "spec_middle_right_png");
            this.setBitmap(_local_2.findChildByName("bottom_left"), "spec_bottom_left_png");
            this.setBitmap(_local_2.findChildByName("bottom_middle"), "spec_bottom_middle_png");
            this.setBitmap(_local_2.findChildByName("bottom_right"), "spec_bottom_right_png");
            return (_local_2);
        }
        private function setBitmap(_arg_1:IWindow, _arg_2:String):void
        {
            var _local_3:IBitmapWrapperWindow = (_arg_1 as IBitmapWrapperWindow);
            if ((((_local_3 == null)) || ((this._assets == null)))){
                return;
            };
            var _local_4:BitmapDataAsset = (this._assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (_local_4 == null){
                return;
            };
            var _local_5:BitmapData = (_local_4.content as BitmapData);
            if (_local_5 == null){
                return;
            };
            _local_3.bitmap = _local_5.clone();
        }
        public function initializeWidget(_arg_1:String, _arg_2:int=0):void
        {
            var _local_3:IRoomWidget = this._SafeStr_5035[_arg_1];
            if (_local_3 == null){
                return;
            };
            _local_3.initialize(_arg_2);
        }
        public function getWidgetState(_arg_1:String):int
        {
            var _local_2:IRoomWidget = this._SafeStr_5035[_arg_1];
            if (_local_2 == null){
                return (_SafeStr_14293);
            };
            return (_local_2.state);
        }
        public function IRoomWidgetHandlerContainer(_arg_1:IRoomWidgetHandler):void
        {
            if (this._updateListeners == null){
                this._updateListeners = new Array();
            };
            if (this._updateListeners.indexOf(_arg_1) == -1){
                this._updateListeners.push(_arg_1);
            };
        }
        public function IRoomWidgetHandlerContainer(_arg_1:IRoomWidgetHandler):void
        {
            if (this._updateListeners == null){
                return;
            };
            var _local_2:int = this._updateListeners.indexOf(_arg_1);
            if (_local_2 != -1){
                this._updateListeners.splice(_local_2, 1);
            };
        }
        private function onRoomShot():void
        {
            var _local_2:Rectangle = this._SafeStr_14301.roomViewRect;
            var _local_3:int = _local_2.width;
            var _local_4:int = _local_2.height;
            var _local_5 = 64;
            var _local_6:DisplayObject = this._roomEngine.RoomEngine(this._session.roomId, this._session.roomCategory, 1, _local_3, _local_4, _local_5);
            var _local_22 = new BitmapData(_local_3, _local_4, true, 0);
            _local_22.draw(_local_6);
            ExternalInterface.call("ExternalInterface.onRenderedRoomShot", HabboCommunicationCom.encodeByteArray(HabboAdManagerCom.encode(_local_22)));
        }

    }
}//package com.sulake.habbo.ui

// _namespace_1 = ""


// _avatarEditor = "_-28H" (String#1820, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// IHabboAvatarEditor = "_-N2" (String#8144, DoABC#2)
// onRoomViewResized = "_-109" (String#4872, DoABC#2)
// _habboHelp = "_-0ms" (String#1548, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// _SafeStr_12448 = "_-0Jf" (String#14828, DoABC#2)
// _SafeStr_12472 = "_-1zi" (String#18956, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomEngine = "_-G6" (String#7996, DoABC#2)
// _SafeStr_13365 = "_-2Rl" (String#20110, DoABC#2)
// _SafeStr_13366 = "_-1hg" (String#18197, DoABC#2)
// _SafeStr_13367 = "_-Ey" (String#22810, DoABC#2)
// _SafeStr_13368 = "_-H7" (String#22896, DoABC#2)
// RoomEngine = "_-1tf" (String#1777, DoABC#2)
// RoomEngine = "_-2lc" (String#6995, DoABC#2)
// RoomEngine = "_-2JZ" (String#6430, DoABC#2)
// RoomEngine = "_-2u6" (String#7162, DoABC#2)
// RoomEngine = "_-1VC" (String#5459, DoABC#2)
// _adManager = "_-0si" (String#825, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// roomObjectEventHandler = "_-0ub" (String#1574, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// RoomSessionManager = "_-j1" (String#8577, DoABC#2)
// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// RWRVUE_ROOM_VIEW_SIZE_CHANGED = "_-0x5" (String#16316, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// _SafeStr_14293 = "_-el" (String#23833, DoABC#2)
// _SafeStr_14294 = "_-1RG" (String#17556, DoABC#2)
// _roomWidgetFactory = "_-6I" (String#7787, DoABC#2)
// _moderation = "_-10A" (String#4873, DoABC#2)
// _userDefinedRoomEvents = "_-Pe" (String#8195, DoABC#2)
// _SafeStr_14298 = "_-0rA" (String#16093, DoABC#2)
// _SafeStr_14299 = "_-2im" (String#20797, DoABC#2)
// _SafeStr_14300 = "_-3Jh" (String#22271, DoABC#2)
// _SafeStr_14301 = "_-1UZ" (String#17687, DoABC#2)
// _SafeStr_14302 = "_-n-" (String#24153, DoABC#2)
// _SafeStr_14303 = "_-0Bb" (String#14511, DoABC#2)
// _SafeStr_14304 = "_-0VR" (String#15259, DoABC#2)
// _SafeStr_14305 = "_-1rQ" (String#18602, DoABC#2)
// _SafeStr_14306 = "_-1Sb" (String#17606, DoABC#2)
// _SafeStr_14307 = "_-1i9" (String#18216, DoABC#2)
// _SafeStr_14308 = "_-2je" (String#20831, DoABC#2)
// _RoomDesktop = "_-1eN" (String#18072, DoABC#2)
// roomWidgetFactory = "_-1y0" (String#5994, DoABC#2)
// adManager = "_-2ZK" (String#20411, DoABC#2)
// onRoomContentLoaded = "_-l1" (String#24073, DoABC#2)
// setLayout = "_-3F5" (String#22081, DoABC#2)
// trackZoomTime = "_-5E" (String#22430, DoABC#2)
// getWindowName = "_-1Z3" (String#17853, DoABC#2)
// onResizeTimerEvent = "_-13u" (String#16613, DoABC#2)
// checkInterrupts = "_-32t" (String#21615, DoABC#2)
// addWidgetWindow = "_-0YC" (String#15365, DoABC#2)
// roomViewRect = "_-37z" (String#21803, DoABC#2)
// disposeWidget = "_-0P2" (String#15027, DoABC#2)
// removeWidgetWindow = "_-2wZ" (String#21330, DoABC#2)
// isFurnitureSelectionDisabled = "_-Mn" (String#23117, DoABC#2)
// handleRoomAdClick = "_-0Lo" (String#14905, DoABC#2)
// handleRoomAdTooltip = "_-33H" (String#21632, DoABC#2)
// roomEngineEventHandler = "_-2g" (String#6866, DoABC#2)
// createRoomView = "_-ag" (String#23659, DoABC#2)
// _SafeStr_14327 = "_-H5" (String#22894, DoABC#2)
// canvasMouseHandler = "_-1CB" (String#16950, DoABC#2)
// resizeColorizer = "_-2sH" (String#21170, DoABC#2)
// getSpectatorModeVisualization = "_-cE" (String#23724, DoABC#2)
// addRoomView = "_-2Bj" (String#19471, DoABC#2)
// IRoomWidgetHandlerContainer = "_-1-s" (String#4865, DoABC#2)
// DesktopLayoutManager = "_-eY" (String#23824, DoABC#2)
// RoomGeometry = "_-2Oh" (String#6534, DoABC#2)
// createFilter = "_-0l2" (String#15867, DoABC#2)
// getBitmapFilter = "_-3Fz" (String#22113, DoABC#2)
// initializeWidget = "_-28Z" (String#19353, DoABC#2)
// getWidgetState = "_-1g-" (String#18139, DoABC#2)
// IRoomWidgetHandlerContainer = "_-0Vt" (String#4226, DoABC#2)
// IRoomWidgetHandlerContainer = "_-8Y" (String#7833, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// RoomContentLoadedEvent = "_-0sn" (String#16153, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IRoomDesktop = "_-2iD" (String#6912, DoABC#2)
// IRoomWidgetMessageListener = "_-2FI" (String#6349, DoABC#2)
// RoomDesktop = "_-20r" (String#6061, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// IRoomWidget = "_-1r4" (String#5876, DoABC#2)
// RoomVariableEnum = "_-0J6" (String#14804, DoABC#2)
// RoomGeometry = "_-2l9" (String#20887, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// ColorConverter = "_-3Km" (String#7717, DoABC#2)
// IToolTipWindow = "_-0GV" (String#3884, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// FriendRequestEvent = "_-1SF" (String#17590, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// DesktopLayoutManager = "_-g4" (String#8513, DoABC#2)
// WelcomeGiftWidgetHandler = "_-cY" (String#23734, DoABC#2)
// FurnitureTeaserWidgetHandler = "_-0uY" (String#16223, DoABC#2)
// FurnitureTrophyWidgetHandler = "_-0Ha" (String#14741, DoABC#2)
// PlaceholderWidgetHandler = "_-VN" (String#23465, DoABC#2)
// PetPackageFurniWidgetHandler = "_-j0" (String#24001, DoABC#2)
// ChatWidgetHandler = "_-0rx" (String#4685, DoABC#2)
// MeMenuWidgetHandler = "_-1dd" (String#5625, DoABC#2)
// FurnitureCreditWidgetHandler = "_-2UV" (String#20219, DoABC#2)
// FurnitureEcotronBoxWidgetHandler = "_-3HK" (String#7653, DoABC#2)
// ConversionPointWidgetHandler = "_-1xM" (String#18862, DoABC#2)
// FurniturePresentWidgetHandler = "_-0ku" (String#15861, DoABC#2)
// PlayListEditorWidgetHandler = "_-xv" (String#24611, DoABC#2)
// DoorbellWidgetHandler = "_-zx" (String#24682, DoABC#2)
// AvatarInfoWidgetHandler = "_-26a" (String#6178, DoABC#2)
// UserNotificationWidgetHandler = "_-1x8" (String#5975, DoABC#2)
// FurnitureStickieWidgetHandler = "_-0MB" (String#14922, DoABC#2)
// RoomObjectOperationEnum = "_-0Zp" (String#15436, DoABC#2)
// UserChooserWidgetHandler = "_-bh" (String#23700, DoABC#2)
// RoomWidgetRoomViewUpdateEvent = "_-xx" (String#24612, DoABC#2)
// VoteWidgetHandler = "_-134" (String#16583, DoABC#2)
// LoadingBarWidgetHandler = "_-33A" (String#21626, DoABC#2)
// InfoStandWidgetHandler = "_-2fW" (String#6859, DoABC#2)
// SpamWallPostItWidgetHandler = "_-2z5" (String#7266, DoABC#2)
// FriendRequestWidgetHandler = "_-1St" (String#17619, DoABC#2)
// FurnitureClothingChangeWidgetHandler = "_-2s5" (String#21161, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetRoomEngineUpdateEvent = "_-x9" (String#8828, DoABC#2)
// FurniChooserWidgetHandler = "_-25L" (String#19232, DoABC#2)
// RoomWidgetLoadingBarUpdateEvent = "_-0ux" (String#4743, DoABC#2)
// EffectsWidgetHandler = "_-0V2" (String#4206, DoABC#2)
// ChatInputWidgetHandler = "_-Ep" (String#22806, DoABC#2)
// FurnitureDimmerWidgetHandler = "_-1HR" (String#17167, DoABC#2)
// RoomQueueWidgetHandler = "_-1bF" (String#17945, DoABC#2)
// PollWidgetHandler = "_-1wc" (String#18827, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// RWFWM_MESSAGE_REQUEST_CREDITFURNI = "_-20W" (String#19030, DoABC#2)
// RWFWM_MESSAGE_REQUEST_STICKIE = "_-0C3" (String#14529, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PRESENT = "_-2XY" (String#20344, DoABC#2)
// RWFWM_MESSAGE_REQUEST_TROPHY = "_-2dM" (String#20578, DoABC#2)
// RWFWM_MESSAGE_REQUEST_TEASER = "_-2Uv" (String#20235, DoABC#2)
// RWFWM_MESSAGE_REQUEST_DIMMER = "_-30d" (String#21526, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PLACEHOLDER = "_-2S8" (String#20125, DoABC#2)
// RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE = "_-3Af" (String#21907, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR = "_-mx" (String#24151, DoABC#2)
// RWE_ROOM_VOTE = "_-1yq" (String#18921, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// RWROUE_FURNI_REMOVED = "_-2L6" (String#19851, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// _SafeStr_3740 = "_-39-" (String#21844, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// RWROUE_OBJECT_DESELECTED = "_-8G" (String#22552, DoABC#2)
// RWREUE_NORMAL_MODE = "_-w-" (String#24530, DoABC#2)
// _SafeStr_3911 = "native" (String#46040, DoABC#2)
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
// FRE_DECLINED = "_-2IY" (String#19749, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// _SafeStr_4247 = "_-0RI" (String#586, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP_OUTSIDE = "_-2qi" (String#21110, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// RWIUE_SHOW = "_-32i" (String#21606, DoABC#2)
// RWLBUW_HIDE_LOADING_BAR = "_-0-1" (String#14011, DoABC#2)
// HTMLTextController = "_-27c" (String#6194, DoABC#2)
// RSE_CREATED = "_-1XM" (String#17790, DoABC#2)
// _session = "_-32Q" (String#627, DoABC#2)
// REOB_OBJECT_ADDED = "_-rY" (String#24341, DoABC#2)
// RoomEngine = "_-vj" (String#8798, DoABC#2)
// RoomEngine = "_-1Qw" (String#5373, DoABC#2)
// RoomGeometry = "_-1S5" (String#5398, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// _SafeStr_5035 = "_-0aF" (String#4307, DoABC#2)
// createWidget = "_-2kN" (String#1932, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// _avatarRenderManager = "_-2uU" (String#454, DoABC#2)
// REOE_OBJECT_SELECTED = "_-Ss" (String#23359, DoABC#2)
// REOE_OBJECT_DESELECTED = "_-1yB" (String#18894, DoABC#2)
// REOE_OBJECT_REMOVED = "_-2ma" (String#20945, DoABC#2)
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
// REE_GAME_MODE = "_-131" (String#16581, DoABC#2)
// REE_NORMAL_MODE = "_-1fp" (String#18130, DoABC#2)
// ROSM_JUKEBOX_DISPOSE = "_-gi" (String#23919, DoABC#2)
// rgbToHSL = "_-TY" (String#23388, DoABC#2)
// hslToRGB = "_-sE" (String#24369, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// getUserDataByIndex = "_-1XZ" (String#5510, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// RWROUE_FURNI_ADDED = "_-2ER" (String#19583, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// RWROUE_USER_REMOVED = "_-02u" (String#14156, DoABC#2)
// RWROUE_USER_ADDED = "_-0wr" (String#16305, DoABC#2)
// musicController = "_-1Qk" (String#5366, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// RWROUE_OBJECT_SELECTED = "_-0Yn" (String#15392, DoABC#2)
// RWROUE_OBJECT_ROLL_OVER = "_-2vE" (String#21287, DoABC#2)
// RWROUE_OBJECT_ROLL_OUT = "_-2K0" (String#19807, DoABC#2)
// avatarEditor = "_-1mJ" (String#5786, DoABC#2)
// IHabboUserDefinedRoomEvents = "_-2Ae" (String#6258, DoABC#2)
// removeWindow = "_-x0" (String#949, DoABC#2)
// RCLE_SUCCESS = "_-2gW" (String#20711, DoABC#2)
// RCLE_FAILURE = "_-2Qp" (String#20081, DoABC#2)
// RCLE_CANCEL = "_-OH" (String#23179, DoABC#2)
// contentType = "_-1bf" (String#17960, DoABC#2)
// roomResources = "_-9r" (String#7860, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// moderation = "_-Id" (String#8055, DoABC#2)
// IRoomWidgetHandlerContainer = "_-iH" (String#8561, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// habboTracking = "_-1ZQ" (String#5552, DoABC#2)
// IRoomWidgetHandlerContainer = "_-0lq" (String#4543, DoABC#2)
// roomSessionManager = "_-1bj" (String#5594, DoABC#2)
// RoomEngine = "_-09k" (String#3753, DoABC#2)
// userDefinedRoomEvents = "_-2pN" (String#7068, DoABC#2)
// IRoomWidgetHandlerContainer = "_-1ZD" (String#5545, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7445 = "_-3Kg" (String#22311, DoABC#2)
// IHabboHelp = "_-2o3" (String#7041, DoABC#2)
// setBitmap = "_-1k8" (String#5753, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// IAdManager = "_-S5" (String#8249, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// HabboNavigatorEvent = "_-2Y9" (String#20361, DoABC#2)
// HTIE_ICON_ZOOM = "_-0HB" (String#14726, DoABC#2)
// IHabboModeration = "_-1nO" (String#5806, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// _SafeStr_9310 = "_-2-h" (String#19000, DoABC#2)
// _SafeStr_9432 = "_-oz" (String#24234, DoABC#2)
// WindowController = "_-0OJ" (String#4052, DoABC#2)
// showInterstitial = "_-1Rf" (String#5389, DoABC#2)


