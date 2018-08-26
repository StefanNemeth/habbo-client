
package com.sulake.habbo.tracking
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.communication.connection.IConnection;
    import flash.utils.Timer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.external.ExternalInterface;
    import flash.system.Capabilities;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.navigator.events.HabboNavigatorTrackingEvent;
    import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
    import com.sulake.habbo.navigator.events.HabboNavigatorEvent;
    import com.sulake.habbo.catalog.enum.HabboCatalogTrackingEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.habbo.help.enum.HabboHelpTrackingEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.enum.HabboCommunicationEvent;
    import com.sulake.habbo.communication.enum.HabboHotelViewEvent;
    import flash.events.Event;
    import com.sulake.habbo.window.enum.HabboWindowTrackingEvent;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.system.System;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import com.sulake.core.runtime.events.ErrorEvent;
    import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import flash.utils.getTimer;
    import com.sulake.iid.*;

    public class HabboTracking extends Component implements IHabboTracking, IUpdateReceiver 
    {

        private static const _SafeStr_13849:uint = 11;
        private static var _instance:HabboTracking;

        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var _communication:IHabboCommunicationManager;
        private var _adManager:IAdManager;
        private var _catalog:IHabboCatalog;
        private var _navigator:IHabboNavigator;
        private var _inventory:IHabboInventory;
        private var _SafeStr_13850:IHabboFriendList;
        private var _SafeStr_13851:IHabboWindowManager;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_11411:IHabboHelp;
        private var _SafeStr_13852:Array;
        private var _crashed:Boolean = false;
        private var _SafeStr_13853:PerformanceTracker = null;
        private var _SafeStr_13854:FramerateTracker = null;
        private var _SafeStr_13855:LatencyTracker = null;
        private var _SafeStr_13856:LagWarningLogger = null;
        private var _SafeStr_13857:ToolbarClickTracker = null;
        private var _roomEngine:IRoomEngine = null;
        private var _connection:IConnection = null;
        private var _SafeStr_13858:Boolean = false;
        private var _SafeStr_13859:int = -1;
        private var _SafeStr_13860:int = 0;
        private var _SafeStr_13861:int = 0;
        private var _SafeStr_13862:Timer;
        private var _SafeStr_13863:int = 0;

        public function HabboTracking(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            if (_instance == null){
                _instance = this;
            };
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_13853 = new PerformanceTracker();
            this._SafeStr_13854 = new FramerateTracker();
            this._SafeStr_13855 = new LatencyTracker();
            this._SafeStr_13856 = new LagWarningLogger();
            this._SafeStr_13857 = new ToolbarClickTracker(this);
            this._SafeStr_13852 = new Array(_SafeStr_13849);
            var _local_4:uint;
            while (_local_4 < _SafeStr_13849) {
                this._SafeStr_13852[_local_4] = 0;
                _local_4++;
            };
            var _local_5:IContext = _arg_1.root;
            if (_local_5 != null){
                _local_5.events.addEventListener(Component.COMPONENT_EVENT_ERROR, this.onError);
                _local_5.events.addEventListener(Component.COMPONENT_EVENT_RUNNING, this.onCoreRunning);
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13793, new Date().getTime().toString());
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13794, ((ExternalInterface.available) ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown"));
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13795, Capabilities.serverString);
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13797, String(false));
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13796, String(0));
            };
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendlistReady);
            queueInterface(new IIDHabboHelp(), this.onHelpReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboAdManager(), this.onAdManagerReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            IContext(this, 1);
        }
        public static function getInstance():HabboTracking
        {
            return (_instance);
        }

        override public function dispose():void
        {
            if (!disposed){
                if (_instance == this){
                    _instance = null;
                };
                if (this._communication){
                    this._communication.release(new IIDHabboCommunicationManager());
                    this._communication = null;
                };
                if (this._configuration){
                    this._configuration.release(new IIDHabboConfigurationManager());
                    this._configuration = null;
                };
                if (this._localization){
                    this._localization.release(new IIDHabboLocalizationManager());
                    this._localization = null;
                };
                if (this._SafeStr_13851){
                    this._SafeStr_13851.release(new IIDHabboWindowManager());
                    this._SafeStr_13851 = null;
                };
                if (this._adManager){
                    this._adManager.release(new IIDHabboAdManager());
                    this._adManager = null;
                };
                if (this._navigator){
                    if (!this._navigator.disposed){
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorEvent.HTIE_ICON_ZOOM, this.onZoomToggle);
                    };
                    this._navigator.release(new IIDHabboNavigator());
                    this._navigator = null;
                };
                if (this._catalog){
                    if (!this._catalog.disposed){
                        this._catalog.events.removeEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE, this.onCatalogTrackingEvent);
                        this._catalog.events.removeEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN, this.onCatalogTrackingEvent);
                    };
                    this._catalog.release(new IIDHabboCatalog());
                    this._catalog = null;
                };
                if (this._inventory){
                    if (!this._inventory.disposed){
                        Component(this._inventory).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED, this.onInvetoryTrackingEvent);
                        Component(this._inventory).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI, this.onInvetoryTrackingEvent);
                        Component(this._inventory).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS, this.onInvetoryTrackingEvent);
                        Component(this._inventory).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES, this.onInvetoryTrackingEvent);
                        Component(this._inventory).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS, this.onInvetoryTrackingEvent);
                        Component(this._inventory).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING, this.onInvetoryTrackingEvent);
                    };
                    this._inventory.release(new IIDHabboInventory());
                    this._inventory = null;
                };
                if (this._SafeStr_13850){
                    if (!this._SafeStr_13850.disposed){
                        Component(this._SafeStr_13850).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED, this.onFriendlistTrackingEvent);
                        Component(this._SafeStr_13850).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS, this.onFriendlistTrackingEvent);
                        Component(this._SafeStr_13850).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH, this.onFriendlistTrackingEvent);
                        Component(this._SafeStr_13850).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST, this.onFriendlistTrackingEvent);
                        Component(this._SafeStr_13850).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_MINIMZED, this.onFriendlistTrackingEvent);
                    };
                    this._SafeStr_13850.release(new IIDHabboFriendList());
                    this._SafeStr_13850 = null;
                };
                if (this._SafeStr_11411){
                    if (!this._SafeStr_11411.disposed){
                        this._SafeStr_11411.events.removeEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED, this.onHelpTrackingEvent);
                        this._SafeStr_11411.events.removeEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT, this.onHelpTrackingEvent);
                    };
                    this._SafeStr_11411.release(new IIDHabboHelp());
                    this._SafeStr_11411 = null;
                };
                if (this._toolbar){
                    if (!this._toolbar.disposed){
                        this._toolbar.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onToolbarClick);
                    };
                    this._toolbar.release(new IIDHabboToolbar());
                    this._toolbar = null;
                };
                if (this._roomEngine){
                    if (!this._roomEngine.disposed){
                        this._roomEngine.events.removeEventListener(RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK, this.onRoomAdClick);
                        this._roomEngine.events.removeEventListener(RoomEngineEvent.REE_INITIALIZED, this.onRoomAction);
                        this._roomEngine.events.removeEventListener(RoomEngineEvent.REE_DISPOSED, this.onRoomAction);
                    };
                    this._roomEngine.release(new IIDRoomEngine());
                    this._roomEngine = null;
                };
                removeUpdateReceiver(this);
                if (this._SafeStr_13853 != null){
                    this._SafeStr_13853.dispose();
                    this._SafeStr_13853 = null;
                };
                if (this._SafeStr_13854 != null){
                    this._SafeStr_13854.dispose();
                    this._SafeStr_13854 = null;
                };
                if (this._SafeStr_13855 != null){
                    this._SafeStr_13855.dispose();
                    this._SafeStr_13855 = null;
                };
                if (this._SafeStr_13857){
                    this._SafeStr_13857.dispose();
                    this._SafeStr_13857 = null;
                };
                if (this._SafeStr_13862){
                    this._SafeStr_13862.stop();
                    this._SafeStr_13862.removeEventListener(TimerEvent.TIMER, this.onRoomActionTimerEvent);
                    this._SafeStr_13862 = null;
                };
                this._connection = null;
                super.dispose();
            };
        }
        private function setErrorContextFlag(_arg_1:uint, _arg_2:uint):void
        {
            this._SafeStr_13852[_arg_2] = _arg_1;
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._configuration = IHabboConfigurationManager(_arg_2);
            if (this._configuration){
                if (this._SafeStr_13855 != null){
                    this._SafeStr_13855.configuration = this._configuration;
                };
                if (this._SafeStr_13853 != null){
                    this._SafeStr_13853.configuration = this._configuration;
                };
                this.setErrorContextFlag(1, 0);
                this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13811);
                if (this._configuration){
                    if (this._SafeStr_13856 != null){
                        this._SafeStr_13856.FramerateTracker(this._configuration);
                    };
                    if (this._SafeStr_13854 != null){
                        this._SafeStr_13854.FramerateTracker(this._configuration);
                    };
                    if (this._SafeStr_13857 != null){
                        this._SafeStr_13857.FramerateTracker(this._configuration);
                    };
                };
            };
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localization = IHabboLocalizationManager(_arg_2);
            this.setErrorContextFlag(1, 1);
            this.trackLoginStep(HabboLoginTrackingStep.LOCALIZATION_EVENT_LOCALIZATION_LOADED);
        }
        private function onCommunicationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(_arg_2);
            if (this._communication != null){
                this._communication.HabboCommunicationManager(new AuthenticationOKMessageEvent(this.onAuthOK));
                this._communication.HabboCommunicationManager(new RoomEntryInfoMessageEvent(this.onRoomEnter));
                this._communication.HabboCommunicationManager(new HabboAchievementNotificationMessageEvent(this.onAchievementNotification));
                this._connection = this._communication.HabboCommunicationManager(this.onConnectionReady);
                if (this._connection != null){
                    this.onConnectionReady(this._connection);
                };
            };
            Component(context).events.addEventListener(HabboCommunicationEvent.INIT, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_ESTABLISHED, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKING, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKED, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.HABBO_CONNECTION_EVENT_AUTHENTICATED, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboHotelViewEvent.HHVE_START_LOAD, this.onHotelViewEvent);
            Component(context).events.addEventListener(HabboHotelViewEvent.RWPUW_ERROR, this.onHotelViewEvent);
            Component(context).events.addEventListener(HabboHotelViewEvent.HHVE_LOADED, this.onHotelViewEvent);
        }
        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (disposed){
                return;
            };
            if (_arg_1 != null){
                this._connection = _arg_1;
                if (this._SafeStr_13853 != null){
                    this._SafeStr_13853.connection = _arg_1;
                };
                if (this._SafeStr_13855 != null){
                    this._SafeStr_13855.communication = this._communication;
                    this._SafeStr_13855.connection = _arg_1;
                };
                if (this._SafeStr_13856 != null){
                    this._SafeStr_13856.connection = _arg_1;
                };
            };
        }
        private function onHotelViewEvent(_arg_1:Event):void
        {
            if (_arg_1.type == HabboHotelViewEvent.HHVE_START_LOAD){
                this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13817);
            }
            else {
                if (_arg_1.type == HabboHotelViewEvent.HHVE_LOADED){
                    this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13818);
                }
                else {
                    if (_arg_1.type == HabboHotelViewEvent.RWPUW_ERROR){
                        this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13819);
                    };
                };
            };
        }
        private function onConnectionEvent(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HabboCommunicationEvent.INIT:
                    this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13814);
                    break;
                case HabboCommunicationEvent.HABBO_CONNECTION_EVENT_ESTABLISHED:
                    this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13815, String(this._communication.port));
                    break;
                case HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKING:
                    this.trackLoginStep(HabboLoginTrackingStep.HABBO_CONNECTION_EVENT_HANDSHAKING);
                    break;
                case HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL:
                    this.trackLoginStep(HabboLoginTrackingStep.HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL);
                    break;
                case HabboCommunicationEvent.HABBO_CONNECTION_EVENT_HANDSHAKED:
                    this.setErrorContextFlag(2, 0);
                    this.trackLoginStep(HabboLoginTrackingStep.HABBO_CONNECTION_EVENT_HANDSHAKED);
                    break;
                case HabboCommunicationEvent.HABBO_CONNECTION_EVENT_AUTHENTICATED:
                    this.setErrorContextFlag(3, 0);
                    this.trackLoginStep(HabboLoginTrackingStep.HABBO_CONNECTION_EVENT_AUTHENTICATED);
                    if (this._SafeStr_13855 != null){
                        this._SafeStr_13855.init();
                    };
                    break;
            };
            if (this._communication){
                Component(context).events.removeEventListener(_arg_1.type, this.onConnectionEvent);
            };
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._SafeStr_13851 = IHabboWindowManager(_arg_2);
            if (this._SafeStr_13851){
                Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT, this.onWindowEvent);
                Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER, this.onWindowEvent);
                Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP, this.onWindowEvent);
            };
        }
        private function onWindowEvent(_arg_1:Event):void
        {
            if (_arg_1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP){
                this.setErrorContextFlag(0, 3);
            }
            else {
                if (_arg_1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER){
                    this.setErrorContextFlag(1, 3);
                }
                else {
                    if (_arg_1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT){
                        this.setErrorContextFlag(2, 3);
                    };
                };
            };
        }
        private function onError(_arg_1:ErrorEvent):void
        {
            var _local_2:String;
            var _local_3:URLRequest;
            var _local_4:URLVariables;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:int;
            var _local_8:String;
            var _local_9:uint;
            if (((_arg_1.critical) && (!(this._crashed)))){
                this._crashed = true;
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_3408, new Date().getTime().toString());
                if (this._configuration){
                    if (this._configuration.keyExists("client.fatal.error.url")){
                        _local_2 = this._configuration.getKey("client.fatal.error.url");
                        _local_3 = new URLRequest(_local_2);
                        _local_4 = new URLVariables();
                        _local_5 = ErrorReportStorage.getParameterNames();
                        _local_6 = _local_5.length;
                        _local_7 = 0;
                        while (_local_7 < _local_6) {
                            _local_4[_local_5[_local_7]] = ErrorReportStorage.getParameter(_local_5[_local_7]);
                            _local_7++;
                        };
                        _local_8 = "";
                        for each (_local_9 in this._SafeStr_13852) {
                            _local_8 = (_local_8 + String(_local_9));
                        };
                        _local_4[HabboErrorVariableEnum._SafeStr_3409] = _local_8;
                        if (this._SafeStr_13853 != null){
                            _local_4[HabboErrorVariableEnum._SafeStr_3410] = this._SafeStr_13853.flashVersion;
                            _local_4[HabboErrorVariableEnum._SafeStr_3411] = this._SafeStr_13853.averageUpdateInterval;
                        };
                        ErrorReportStorage.addDebugData("Flash memory usage", (("Memory usage: " + Math.round((System.totalMemory / (0x0400 * 0x0400)))) + " MB"));
                        _local_4[HabboErrorVariableEnum._SafeStr_3412] = ErrorReportStorage.getDebugData();
                        _local_3.data = _local_4;
                        _local_3.method = URLRequestMethod.POST;
                        navigateToURL(_local_3, "_self");
                    };
                };
            };
            this.logError(context.root.getLastErrorMessage());
        }
        private function onCoreRunning(_arg_1:Event):void
        {
            this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13810);
            if (((context) && (context.root))){
                context.root.events.removeEventListener(HabboLoginTrackingStep._SafeStr_13810, this.onCoreRunning);
            };
        }
        private function onNavigatorReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._navigator = (IHabboNavigator(_arg_2) as IHabboNavigator);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorEvent.HTIE_ICON_ZOOM, this.onZoomToggle);
        }
        private function onNavigatorTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS:
                    this.setErrorContextFlag(1, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS:
                    this.setErrorContextFlag(2, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME:
                    this.setErrorContextFlag(3, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL:
                    this.setErrorContextFlag(4, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH:
                    this.setErrorContextFlag(5, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS:
                    this.legacyTrackGoogle("navigator", "latest_events");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES:
                    this.legacyTrackGoogle("navigator", "my_favorites");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS:
                    this.legacyTrackGoogle("navigator", "my_friends_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY:
                    this.legacyTrackGoogle("navigator", "my_history");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS:
                    this.legacyTrackGoogle("navigator", "my_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS:
                    this.legacyTrackGoogle("navigator", "official_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS:
                    this.legacyTrackGoogle("navigator", "popular_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE:
                    this.legacyTrackGoogle("navigator", "rooms_where_my_friends_are");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE:
                    this.legacyTrackGoogle("navigator", "highest_score");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH:
                    this.legacyTrackGoogle("navigator", "tag_search");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH:
                    this.legacyTrackGoogle("navigator", "text_search");
                    return;
            };
        }
        private function onRoomSettingsTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 7);
                    return;
                case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT:
                    this.setErrorContextFlag(1, 7);
                    return;
                case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED:
                    this.setErrorContextFlag(2, 7);
                    return;
            };
        }
        private function onInventoryReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._inventory = (_arg_2 as IHabboInventory);
            Component(this._inventory).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED, this.onInvetoryTrackingEvent);
            Component(this._inventory).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI, this.onInvetoryTrackingEvent);
            Component(this._inventory).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS, this.onInvetoryTrackingEvent);
            Component(this._inventory).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES, this.onInvetoryTrackingEvent);
            Component(this._inventory).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS, this.onInvetoryTrackingEvent);
            Component(this._inventory).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING, this.onInvetoryTrackingEvent);
        }
        private function onInvetoryTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI:
                    this.setErrorContextFlag(1, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS:
                    this.setErrorContextFlag(2, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES:
                    this.setErrorContextFlag(3, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS:
                    this.setErrorContextFlag(4, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING:
                    this.setErrorContextFlag(5, 5);
                    return;
            };
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._catalog = (IHabboCatalog(_arg_2) as IHabboCatalog);
            this._catalog.events.addEventListener(CatalogPageOpenedEvent.CATALOG_PAGE_OPENED, this.onCatalogPageOpened);
            this._catalog.events.addEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN, this.onCatalogTrackingEvent);
            this._catalog.events.addEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE, this.onCatalogTrackingEvent);
        }
        private function onAchievementNotification(_arg_1:HabboAchievementNotificationMessageEvent):void
        {
            var _local_2:HabboAchievementNotificationMessageParser = _arg_1.getParser();
            this.legacyTrackGoogle("achievement", "achievement", [_local_2.data.badgeCode]);
        }
        private function onCatalogPageOpened(_arg_1:CatalogPageOpenedEvent):void
        {
            this.legacyTrackGoogle("catalogue", "page", [_arg_1.pageLocalization]);
        }
        private function onCatalogTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN:
                    this.setErrorContextFlag(1, 9);
                    return;
                case HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE:
                    this.setErrorContextFlag(0, 9);
                    return;
            };
        }
        private function onFriendlistReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_13850 = (_arg_2 as IHabboFriendList);
            Component(this._SafeStr_13850).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED, this.onFriendlistTrackingEvent);
            Component(this._SafeStr_13850).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS, this.onFriendlistTrackingEvent);
            Component(this._SafeStr_13850).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH, this.onFriendlistTrackingEvent);
            Component(this._SafeStr_13850).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST, this.onFriendlistTrackingEvent);
            Component(this._SafeStr_13850).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_MINIMZED, this.onFriendlistTrackingEvent);
        }
        private function onFriendlistTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 6);
                    return;
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS:
                    this.setErrorContextFlag(1, 6);
                    return;
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH:
                    this.setErrorContextFlag(2, 6);
                    return;
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST:
                    this.setErrorContextFlag(3, 6);
                    return;
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_MINIMZED:
                    this.setErrorContextFlag(4, 6);
                    return;
            };
        }
        private function onHelpReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_11411 = (_arg_2 as IHabboHelp);
            this._SafeStr_11411.events.addEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED, this.onHelpTrackingEvent);
            this._SafeStr_11411.events.addEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT, this.onHelpTrackingEvent);
        }
        private function onHelpTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 10);
                    return;
                case HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT:
                    this.setErrorContextFlag(1, 10);
                    return;
            };
        }
        private function onAuthOK(_arg_1:IMessageEvent):void
        {
            this.legacyTrackGoogle("authentication", "authok");
        }
        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            if (!this._SafeStr_13858){
                this.trackLoginStep(HabboLoginTrackingStep._SafeStr_13816);
                this._SafeStr_13858 = true;
            };
            var _local_2:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(_arg_1).getParser();
            if (_local_2.privateRoom){
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13796, String(_local_2.guestRoomId));
                ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13797, String(true));
                this.legacyTrackGoogle("navigator", "private", [_local_2.guestRoomId]);
            }
            else {
                if (_local_2.publicSpace != null){
                    if (_local_2.publicSpace.worldId == 0){
                        this.legacyTrackGoogle("navigator", "public", [_local_2.publicSpace.unitPropertySet]);
                    }
                    else {
                        this.legacyTrackGoogle("navigator", "public", [((_local_2.publicSpace.unitPropertySet + "/") + _local_2.publicSpace.worldId)]);
                    };
                };
            };
        }
        private function onRoomLeave(_arg_1:CloseConnectionMessageEvent):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13797, String(false));
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._roomEngine = (_arg_2 as IRoomEngine);
            if (this._roomEngine == null){
                return;
            };
            Component(this._roomEngine).events.addEventListener(RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK, this.onRoomAdClick);
            Component(this._roomEngine).events.addEventListener(RoomEngineEvent.REE_INITIALIZED, this.onRoomAction);
            Component(this._roomEngine).events.addEventListener(RoomEngineEvent.REE_DISPOSED, this.onRoomAction);
        }
        private function onAdManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._adManager = (_arg_2 as IAdManager);
            this._adManager.events.addEventListener(AdEvent.AE_ROOM_AD_SHOW, this.onRoomAdLoad);
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._toolbar = (_arg_2 as IHabboToolbar);
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onToolbarClick);
        }
        private function onRoomAdLoad(_arg_1:AdEvent):void
        {
            this.legacyTrackGoogle("room_ad", "show", [this.getAliasFromAdTechUrl(_arg_1.clickUrl)]);
        }
        private function onRoomAdClick(_arg_1:RoomObjectRoomAdEvent):void
        {
            this.legacyTrackGoogle("room_ad", "click", [this.getAliasFromAdTechUrl(_arg_1.clickUrl)]);
        }
        private function getAliasFromAdTechUrl(_arg_1:String):String
        {
            var _local_2:Array = _arg_1.match(/;alias=([^;]+)/);
            if (((!((_local_2 == null))) && ((_local_2.length > 1)))){
                return (_local_2[1]);
            };
            return ("unknown");
        }
        private function onRoomAction(_arg_1:RoomEngineEvent):void
        {
            if (_arg_1.type == RoomEngineEvent.REE_INITIALIZED){
                if (this._SafeStr_13863 < 1){
                    if (!this._SafeStr_13862){
                        this._SafeStr_13862 = new Timer((60 * 1000), 1);
                        this._SafeStr_13862.addEventListener(TimerEvent.TIMER, this.onRoomActionTimerEvent);
                        this._SafeStr_13862.start();
                    };
                };
            }
            else {
                if (_arg_1.type == RoomEngineEvent.REE_DISPOSED){
                    if (this._SafeStr_13862){
                        this._SafeStr_13862.removeEventListener(TimerEvent.TIMER, this.onRoomActionTimerEvent);
                        this._SafeStr_13862.stop();
                        this._SafeStr_13862 = null;
                    };
                };
            };
        }
        private function onRoomActionTimerEvent(_arg_1:TimerEvent):void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:int;
            if (!disposed){
                if (this._connection){
                    if (this._SafeStr_13854){
                        _local_2 = null;
                        if (this._roomEngine){
                            _local_3 = this._roomEngine.IRoomSpriteCanvasContainer(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                            _local_4 = (this._roomEngine.IRoomSpriteCanvasContainer(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectCategoryEnum._SafeStr_4329) + this._roomEngine.IRoomSpriteCanvasContainer(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectCategoryEnum._SafeStr_4330));
                            _local_2 = ((("Avatars: " + _local_3) + ", Objects: ") + _local_4);
                        };
                        this.trackEventLog("Performance", "fps", String(this._SafeStr_13854.frameRate), _local_2);
                        this._SafeStr_13863++;
                    };
                };
            };
        }
        private function onToolbarClick(_arg_1:HabboToolbarEvent):void
        {
            if (this._SafeStr_13857){
                this._SafeStr_13857.track(_arg_1.iconName);
            };
        }
        private function onZoomToggle(_arg_1:HabboNavigatorEvent):void
        {
            if (this._SafeStr_13857){
                this._SafeStr_13857.track(_arg_1.type);
            };
        }
        public function legacyTrackGoogle(_arg_1:String, _arg_2:String, _arg_3:Array=null):void
        {
            Logger.log((((((("legacyTrackGoogle(" + _arg_1) + ", ") + _arg_2) + ", ") + _arg_3) + ")"));
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.legacyTrack", _arg_1, _arg_2, (((_arg_3 == null)) ? [] : _arg_3));
            }
            else {
                Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
            };
        }
        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            Logger.log((((((("trackGoogle(" + _arg_1) + ", ") + _arg_2) + ", ") + _arg_3) + ")"));
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.track", _arg_1, _arg_2, _arg_3);
            }
            else {
                Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
            };
        }
        public function trackLoginStep(_arg_1:String, _arg_2:String=null):void
        {
            if (((!((this._configuration == null))) && (!(Boolean(this._configuration.getKey("processlog.enabled")))))){
                return;
            };
            Logger.log(("* Track Login Step: " + _arg_1));
            if (ExternalInterface.available){
                if (_arg_2 != null){
                    ExternalInterface.call("FlashExternalInterface.logLoginStep", _arg_1, _arg_2);
                }
                else {
                    ExternalInterface.call("FlashExternalInterface.logLoginStep", _arg_1);
                };
            }
            else {
                Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
            };
        }
        public function trackEventLog(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="", _arg_5:int=0):void
        {
            if (((this._connection) && (this._connection.connected))){
                this._connection.send(new EventLogMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            };
        }
        public function logError(_arg_1:String):void
        {
            Logger.log((("logError(" + _arg_1) + ")"));
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.logError", _arg_1);
            }
            else {
                Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
            };
        }
        public function chatLagDetected(_arg_1:int):void
        {
            this._SafeStr_13856.chatLagDetected(_arg_1);
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:int = getTimer();
            if ((((this._SafeStr_13859 > -1)) && ((_local_2 < this._SafeStr_13859)))){
                this._SafeStr_13860++;
                ErrorReportStorage.addDebugData("Invalid time counter", ("Invalid times: " + this._SafeStr_13860));
            };
            if ((((this._SafeStr_13859 > -1)) && (((_local_2 - this._SafeStr_13859) > (15 * 1000))))){
                this._SafeStr_13861++;
                ErrorReportStorage.addDebugData("Time leap counter", ("Time leaps: " + this._SafeStr_13861));
            };
            this._SafeStr_13859 = _local_2;
            if (this._SafeStr_13853 != null){
                this._SafeStr_13853.update(_arg_1, this._SafeStr_13859);
            };
            if (this._SafeStr_13855 != null){
                this._SafeStr_13855.update(_arg_1, this._SafeStr_13859);
            };
            if (this._SafeStr_13854 != null){
                this._SafeStr_13854.FramerateTracker(_arg_1, this, this._SafeStr_13859);
            };
            if (this._SafeStr_13856 != null){
                this._SafeStr_13856.update(this._SafeStr_13859);
            };
        }

    }
}//package com.sulake.habbo.tracking

// IID = "_-3KV" (String#7712, DoABC#2)
// onCommunicationReady = "_-3Ix" (String#372, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// keyExists = "_-2ME" (String#6487, DoABC#2)
// onAuthOK = "_-lL" (String#2177, DoABC#2)
// _SafeStr_11411 = "_-0kl" (String#822, DoABC#2)
// onNavigatorReady = "_-1uN" (String#1781, DoABC#2)
// onWindowEvent = "_-0zm" (String#4843, DoABC#2)
// onToolbarClick = "_-2UP" (String#6654, DoABC#2)
// _adManager = "_-0si" (String#825, DoABC#2)
// onAdManagerReady = "_-0Xv" (String#1496, DoABC#2)
// chatLagDetected = "_-1JX" (String#5231, DoABC#2)
// legacyTrackGoogle = "_-0A8" (String#3760, DoABC#2)
// logError = "_-2vF" (String#7182, DoABC#2)
// FramerateTracker = "_-2eD" (String#20612, DoABC#2)
// _SafeStr_13793 = "_-1bt" (String#17967, DoABC#2)
// _SafeStr_13794 = "_-1KB" (String#17280, DoABC#2)
// _SafeStr_13795 = "_-0qY" (String#16070, DoABC#2)
// _SafeStr_13796 = "_-rs" (String#24356, DoABC#2)
// _SafeStr_13797 = "_-0v0" (String#16238, DoABC#2)
// FramerateTracker = "_-Mk" (String#23116, DoABC#2)
// _SafeStr_13810 = "_-1vP" (String#18773, DoABC#2)
// _SafeStr_13811 = "_-3HU" (String#22179, DoABC#2)
// _SafeStr_13814 = "_-0f0" (String#15629, DoABC#2)
// _SafeStr_13815 = "_-cv" (String#23752, DoABC#2)
// _SafeStr_13816 = "_-2go" (String#20721, DoABC#2)
// _SafeStr_13817 = "_-2MJ" (String#19896, DoABC#2)
// _SafeStr_13818 = "_-3Bc" (String#21945, DoABC#2)
// _SafeStr_13819 = "_-3L4" (String#22327, DoABC#2)
// flashVersion = "_-a" (String#23632, DoABC#2)
// averageUpdateInterval = "_-1x9" (String#18853, DoABC#2)
// _SafeStr_13849 = "_-0Gu" (String#14715, DoABC#2)
// _SafeStr_13850 = "_-13X" (String#16600, DoABC#2)
// _SafeStr_13851 = "_-2bk" (String#20513, DoABC#2)
// _SafeStr_13852 = "_-1s0" (String#18632, DoABC#2)
// _SafeStr_13853 = "_-0FQ" (String#14662, DoABC#2)
// _SafeStr_13854 = "_-1an" (String#17926, DoABC#2)
// _SafeStr_13855 = "_-1Me" (String#17386, DoABC#2)
// _SafeStr_13856 = "_-1k1" (String#18289, DoABC#2)
// _SafeStr_13857 = "_-1Or" (String#17462, DoABC#2)
// _SafeStr_13858 = "_-1bX" (String#17957, DoABC#2)
// _SafeStr_13859 = "_-1Al" (String#16892, DoABC#2)
// _SafeStr_13860 = "_-1O0" (String#17435, DoABC#2)
// _SafeStr_13861 = "_-0f5" (String#15632, DoABC#2)
// _SafeStr_13862 = "_-0v7" (String#16241, DoABC#2)
// _SafeStr_13863 = "_-tu" (String#24444, DoABC#2)
// onFriendlistReady = "_-2mu" (String#20956, DoABC#2)
// onHelpReady = "_-6A" (String#22472, DoABC#2)
// onNavigatorTrackingEvent = "_-2Fq" (String#19636, DoABC#2)
// onRoomSettingsTrackingEvent = "_-0Qh" (String#15089, DoABC#2)
// onZoomToggle = "_-2xk" (String#21385, DoABC#2)
// onCatalogTrackingEvent = "_-2Gv" (String#19680, DoABC#2)
// onInvetoryTrackingEvent = "_-0RN" (String#15115, DoABC#2)
// onFriendlistTrackingEvent = "_-0dm" (String#15575, DoABC#2)
// onHelpTrackingEvent = "_-1mW" (String#18402, DoABC#2)
// onRoomAdClick = "_-0Fx" (String#14681, DoABC#2)
// onRoomAction = "_-1S9" (String#17587, DoABC#2)
// onRoomActionTimerEvent = "_-05" (String#14241, DoABC#2)
// setErrorContextFlag = "_-1e6" (String#18061, DoABC#2)
// onAchievementNotification = "_-YR" (String#23578, DoABC#2)
// onConnectionEvent = "_-2IS" (String#19744, DoABC#2)
// onHotelViewEvent = "_-36P" (String#21744, DoABC#2)
// onCatalogPageOpened = "_-6C" (String#22474, DoABC#2)
// onRoomLeave = "_-12W" (String#16560, DoABC#2)
// onRoomAdLoad = "_-39E" (String#21854, DoABC#2)
// getAliasFromAdTechUrl = "_-3Eo" (String#22069, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// _SafeStr_3408 = "_-0E6" (String#14611, DoABC#2)
// _SafeStr_3409 = "_-JE" (String#22976, DoABC#2)
// _SafeStr_3410 = "_-4L" (String#22391, DoABC#2)
// _SafeStr_3411 = "_-12B" (String#16543, DoABC#2)
// _SafeStr_3412 = "_-0ut" (String#16234, DoABC#2)
// trackLoginStep = "_-2T-" (String#20162, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// privateRoom = "_-26S" (String#19271, DoABC#2)
// guestRoomId = "_-1NR" (String#17415, DoABC#2)
// publicSpace = "_-1JR" (String#17253, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// HABBO_FRIENDLIST_TRACKIG_EVENT_MINIMZED = "_-0An" (String#14479, DoABC#2)
// unitPropertySet = "_-ix" (String#23996, DoABC#2)
// worldId = "_-2Ip" (String#19760, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// onError = "_-1cU" (String#1723, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// RWPUW_ERROR = "_-0CA" (String#14535, DoABC#2)
// REE_INITIALIZED = "_-0c3" (String#15515, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// RORAE_ROOM_AD_FURNI_CLICK = "_-0v3" (String#16239, DoABC#2)
// LOCALIZATION_EVENT_LOCALIZATION_LOADED = "_-0nu" (String#15973, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// REE_DISPOSED = "_-rn" (String#24352, DoABC#2)
// AE_ROOM_AD_SHOW = "_-18f" (String#16799, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// HHVE_START_LOAD = "_-1TG" (String#17635, DoABC#2)
// HHVE_LOADED = "_-rV" (String#24338, DoABC#2)
// HABBO_CONNECTION_EVENT_ESTABLISHED = "_-24k" (String#19213, DoABC#2)
// HABBO_CONNECTION_EVENT_HANDSHAKING = "_-Zy" (String#23630, DoABC#2)
// HABBO_CONNECTION_EVENT_HANDSHAKED = "_-17L" (String#16750, DoABC#2)
// HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL = "_-is" (String#23993, DoABC#2)
// HABBO_CONNECTION_EVENT_AUTHENTICATED = "_-2hD" (String#20737, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1Hy" (String#1654, DoABC#2)
// pageLocalization = "_-2Re" (String#20106, DoABC#2)
// IHabboHelp = "_-2o3" (String#7041, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// onInventoryReady = "_-dE" (String#374, DoABC#2)
// RoomObjectRoomAdEvent = "_-mk" (String#24139, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// AdEvent = "_-1xT" (String#18868, DoABC#2)
// ToolbarClickTracker = "_-0ke" (String#15854, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// HabboHotelViewEvent = "_-hR" (String#23947, DoABC#2)
// HabboAchievementNotificationMessageParser = "_-Zs" (String#8418, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)
// HabboRoomSettingsTrackingEvent = "_-1NO" (String#17413, DoABC#2)
// IAdManager = "_-S5" (String#8249, DoABC#2)
// HabboErrorVariableEnum = "_-zF" (String#24662, DoABC#2)
// ErrorEvent = "_-cA" (String#8459, DoABC#2)
// HabboCatalogTrackingEvent = "_-307" (String#21506, DoABC#2)
// FramerateTracker = "_-Ud" (String#23432, DoABC#2)
// HabboCommunicationEvent = "_-2do" (String#20593, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// HabboLoginTrackingStep = "_-21m" (String#19082, DoABC#2)
// CatalogPageOpenedEvent = "_-EN" (String#22786, DoABC#2)
// iconName = "_-1Xn" (String#5513, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)
// HabboFriendListTrackingEvent = "_-0It" (String#14795, DoABC#2)
// HabboWindowTrackingEvent = "_-1lw" (String#18372, DoABC#2)
// HabboNavigatorEvent = "_-2Y9" (String#20361, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// HabboNavigatorTrackingEvent = "_-0Vu" (String#15273, DoABC#2)
// HabboAchievementNotificationMessageEvent = "_-2LH" (String#6465, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// HTIE_ICON_ZOOM = "_-0HB" (String#14726, DoABC#2)
// PerformanceTracker = "_-2q2" (String#21082, DoABC#2)
// HabboInventoryTrackingEvent = "_-1r0" (String#18582, DoABC#2)
// LagWarningLogger = "_-2Kc" (String#19828, DoABC#2)
// LatencyTracker = "_-RJ" (String#23297, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// critical = "_-0i8" (String#15754, DoABC#2)
// setParameter = "_-33Y" (String#21643, DoABC#2)
// getDebugData = "_-1wO" (String#18816, DoABC#2)
// getParameter = "_-0Ty" (String#15204, DoABC#2)
// getParameterNames = "_-HY" (String#22915, DoABC#2)
// track = "_-0H4" (String#3897, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)
// onConnectionReady = "_-0k8" (String#359, DoABC#2)


