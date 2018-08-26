
package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;
    import com.sulake.habbo.navigator.inroom.RoomInfoViewCtrl;
    import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailRenderer;
    import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.core.runtime.IContext;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.enum.HabboProtocolOption;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.tracking.HabboTracking;

    public class HabboNavigator extends Component implements IHabboNavigator 
    {

        private var _communication:IHabboCommunicationManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:IHabboConfigurationManager;
        private var _sessionData:ISessionDataManager;
        private var _catalog:IHabboCatalog;
        private var _mainViewCtrl:MainViewCtrl;
        private var _roomInfoViewCtrl:RoomInfoViewCtrl;
        private var _roomCreateViewCtrl:RoomCreateViewCtrl;
        private var _data:NavigatorData;
        private var _tabs:Tabs;
        private var _assetLibrary:IAssetLibrary;
        private var _SafeStr_11492:IncomingMessages;
        private var _toolbar:IHabboToolbar;
        private var _roomSettingsCtrls:Array;
        private var _thumbRenderer:RoomThumbnailRenderer;
        private var _passwordInput:GuestRoomPasswordInput;
        private var _doorbell:GuestRoomDoorbell;
        private var _officialRoomEntryManager:OfficialRoomEntryManager;

        public function HabboNavigator(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._roomSettingsCtrls = new Array();
            super(_arg_1, _arg_2, _arg_3);
            Logger.log("Navigator initialized");
            queueInterface(new IIDHabboCommunicationManager(), this.HabboUserDefinedRoomEvents);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            this._assetLibrary = new AssetLibraryCollection("NavigatorComponent");
            this._data = new NavigatorData(this);
            this._mainViewCtrl = new MainViewCtrl(this);
            this._roomInfoViewCtrl = new RoomInfoViewCtrl(this);
            this._roomCreateViewCtrl = new RoomCreateViewCtrl(this);
            this._thumbRenderer = new RoomThumbnailRenderer(this);
            this._passwordInput = new GuestRoomPasswordInput(this);
            this._doorbell = new GuestRoomDoorbell(this);
            this._tabs = new Tabs(this);
            this._officialRoomEntryManager = new OfficialRoomEntryManager(this);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get data():NavigatorData
        {
            return (this._data);
        }
        public function get mainViewCtrl():MainViewCtrl
        {
            return (this._mainViewCtrl);
        }
        public function get tabs():Tabs
        {
            return (this._tabs);
        }
        public function get roomInfoViewCtrl():RoomInfoViewCtrl
        {
            return (this._roomInfoViewCtrl);
        }
        public function get roomCreateViewCtrl():RoomCreateViewCtrl
        {
            return (this._roomCreateViewCtrl);
        }
        public function get assetLibrary():IAssetLibrary
        {
            return (this._assetLibrary);
        }
        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }
        public function get roomSettingsCtrls():Array
        {
            return (this._roomSettingsCtrls);
        }
        public function get thumbRenderer():RoomThumbnailRenderer
        {
            return (this._thumbRenderer);
        }
        public function get sessionData():ISessionDataManager
        {
            return (this._sessionData);
        }
        public function get passwordInput():GuestRoomPasswordInput
        {
            return (this._passwordInput);
        }
        public function get doorbell():GuestRoomDoorbell
        {
            return (this._doorbell);
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        public function get officialRoomEntryManager():OfficialRoomEntryManager
        {
            return (this._officialRoomEntryManager);
        }
        override public function dispose():void
        {
            if (this._mainViewCtrl){
                this._mainViewCtrl.dispose();
                this._mainViewCtrl = null;
            };
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._roomSessionManager){
                this._roomSessionManager.release(new IIDHabboRoomSessionManager());
                this._roomSessionManager = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._localization){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._sessionData){
                this._sessionData.release(new IIDSessionDataManager());
                this._sessionData = null;
            };
            if (this._catalog){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._toolbar){
                if (this._toolbar.events){
                    this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
                };
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
            if (this._roomInfoViewCtrl){
                this._roomInfoViewCtrl.dispose();
                this._roomInfoViewCtrl = null;
            };
            if (this._roomCreateViewCtrl){
                this._roomCreateViewCtrl.dispose();
                this._roomCreateViewCtrl = null;
            };
            if (this._officialRoomEntryManager){
                this._officialRoomEntryManager.dispose();
                this._officialRoomEntryManager = null;
            };
            super.dispose();
        }
        public function goToRoom(_arg_1:int, _arg_2:Boolean, _arg_3:String="", _arg_4:int=-1):void
        {
            var _local_5:int;
            Logger.log(("GO TO ROOM: " + _arg_1));
            if (this._roomSessionManager){
                if (_arg_2){
                    this._mainViewCtrl.close();
                };
                this._roomInfoViewCtrl.close();
                this._roomSessionManager.RoomSessionManager(false, _arg_1, _arg_3);
                if (this.tabs.ISelectorWindow()){
                    _local_5 = (((_arg_4 > -1)) ? (_arg_4 + 1) : 0);
                    switch (this.tabs.ISelectorWindow().id){
                        case Tabs._SafeStr_4287:
                            this.trackNavigationDataPoint(this.tabs.ISelectorWindow().tabPageDecorator.filterCategory, "go.official", String(_arg_1), _local_5);
                            return;
                        case Tabs._SafeStr_4286:
                            this.trackNavigationDataPoint(this.tabs.ISelectorWindow().tabPageDecorator.filterCategory, "go.me", String(_arg_1), _local_5);
                            return;
                        case Tabs._SafeStr_4288:
                            this.trackNavigationDataPoint(this.tabs.ISelectorWindow().tabPageDecorator.filterCategory, "go.rooms", String(_arg_1), _local_5);
                            return;
                        case Tabs._SafeStr_4285:
                            this.trackNavigationDataPoint("Events", "go.events", String(_arg_1), _local_5);
                            return;
                        case Tabs._SafeStr_4151:
                            this.trackNavigationDataPoint("Search", "go.search", String(_arg_1), _local_5);
                            return;
                    };
                };
            };
        }
        public function goToPublicSpace(_arg_1:int, _arg_2:String):void
        {
            Logger.log(("GO TO PUBLIC SPACE: " + _arg_1));
            if (this._roomSessionManager){
                this._roomInfoViewCtrl.close();
                this._roomSessionManager.RoomSessionManager(true, _arg_1, "", _arg_2);
            };
        }
        public function goToHomeRoom():Boolean
        {
            if (this._data.homeRoomId < 1){
                Logger.log("No home room set while attempting to go to home room");
                return (false);
            };
            this.goToRoom(this._data.homeRoomId, true);
            return (true);
        }
        public function send(_arg_1:IMessageComposer, _arg_2:Boolean=false):void
        {
            this._communication.HabboCommunicationManager(null).send(_arg_1, ((_arg_2) ? HabboProtocolOption.OLD_STYLE : -1));
        }
        public function getXmlWindow(name:String, layer:uint=1):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try {
                asset = assets.getAssetByName((name + "_xml"));
                xmlAsset = XmlAsset(asset);
                window = this._windowManager.buildFromXML(XML(xmlAsset.content), layer);
            }
            catch(e:Error) {
                ErrorReportStorage.addDebugData("HabboNavigator", (((((("Failed to build window " + name) + "_xml, ") + asset) + ", ") + _windowManager) + "!"));
                throw (e);
            };
            return (window);
        }
        public function getText(_arg_1:String):String
        {
            var _local_2:String = this._localization.getKey(_arg_1);
            if ((((_local_2 == null)) || ((_local_2 == "")))){
                _local_2 = _arg_1;
            };
            return (_local_2);
        }
        public function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            this._localization.registerParameter(_arg_1, _arg_2, _arg_3);
        }
        public function getButton(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:int=0, _arg_5:int=0, _arg_6:int=0):IBitmapWrapperWindow
        {
            var _local_7:BitmapData = this.getButtonImage(_arg_2);
            var _local_8:IBitmapWrapperWindow = IBitmapWrapperWindow(this._windowManager.createWindow(_arg_1, "", HabboWindowType._SafeStr_6022, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_3731 | HabboWindowParam._SafeStr_6023), new Rectangle(_arg_4, _arg_5, _local_7.width, _local_7.height), _arg_3, _arg_6));
            _local_8.bitmap = _local_7;
            return (_local_8);
        }
        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int, _arg_6:String=null):void
        {
            if (!_arg_6){
                _arg_6 = _arg_2;
            };
            var _local_7:IBitmapWrapperWindow = (_arg_1.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (!_local_7){
                Logger.log(("Could not locate button in navigator: " + _arg_2));
            };
            if (!_arg_3){
                _local_7.visible = false;
            }
            else {
                this.HabboUserDefinedRoomEvents(_local_7, _arg_6, _arg_4, _arg_5);
                _local_7.visible = true;
            };
        }
        private function HabboUserDefinedRoomEvents(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            _arg_1.id = _arg_4;
            _arg_1.procedure = _arg_3;
            if (_arg_1.bitmap != null){
                return;
            };
            _arg_1.bitmap = this.getButtonImage(_arg_2);
            _arg_1.width = _arg_1.bitmap.width;
            _arg_1.height = _arg_1.bitmap.height;
        }
        public function getButtonImage(_arg_1:String, _arg_2:String="_png"):BitmapData
        {
            var _local_7:BitmapData;
            var _local_3:String = (_arg_1 + _arg_2);
            var _local_4:IAsset = assets.getAssetByName(_local_3);
            var _local_5:BitmapDataAsset = BitmapDataAsset(_local_4);
            var _local_6:BitmapData = BitmapData(_local_5.content);
            _local_7 = new BitmapData(_local_6.width, _local_6.height, true, 0);
            _local_7.draw(_local_6);
            return (_local_7);
        }
        private function HabboUserDefinedRoomEvents(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Navigator: communication available " + [_arg_1, _arg_2]));
            this._communication = IHabboCommunicationManager(_arg_2);
            this._SafeStr_11492 = new IncomingMessages(this);
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomSessionManager = IRoomSessionManager(_arg_2);
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._toolbar = (IHabboToolbar(_arg_2) as IHabboToolbar);
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._catalog = (IHabboCatalog(_arg_2) as IHabboCatalog);
        }
        public function openCatalogClubPage():void
        {
            if (this._catalog == null){
                return;
            };
            this._catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionData = (_arg_2 as ISessionDataManager);
        }
        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK){
                if (_arg_1.iconId == HabboToolbarIconEnum.NAVIGATOR){
                    this._mainViewCtrl.MainViewCtrl();
                }
                else {
                    if (_arg_1.iconId == HabboToolbarIconEnum.ROOMINFO){
                        this._roomInfoViewCtrl.toggle();
                    };
                };
            };
        }
        public function onAuthOk():void
        {
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_4:int;
            Logger.log(("Navigator: configuration " + [_arg_1, _arg_2]));
            this._configuration = (_arg_2 as IHabboConfigurationManager);
            var _local_3:String = this._configuration.getKey("navigator.default_tab");
            switch (_local_3){
                case "popular":
                    _local_4 = Tabs._SafeStr_4288;
                    break;
                case "official":
                    _local_4 = Tabs._SafeStr_4287;
                    break;
                case "me":
                    _local_4 = Tabs._SafeStr_4286;
                    break;
                case "events":
                default:
                    _local_4 = Tabs._SafeStr_4285;
            };
            this.tabs.setSelectedTab(_local_4);
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Navigator: localization " + [_arg_1, _arg_2]));
            this._localization = IHabboLocalizationManager(_arg_2);
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(_arg_2);
        }
        public function performTagSearch(_arg_1:String):void
        {
            if (this._mainViewCtrl == null){
                return;
            };
            this._mainViewCtrl.startSearch(Tabs._SafeStr_4151, Tabs._SafeStr_4152, _arg_1);
            this.trackNavigationDataPoint("Search", "search.tag", _arg_1);
            this._mainViewCtrl.mainWindow.activate();
        }
        public function showOwnRooms():void
        {
            if (this._mainViewCtrl == null){
                return;
            };
            this._mainViewCtrl.startSearch(Tabs._SafeStr_4286, Tabs._SafeStr_4301);
            this._tabs.getTab(Tabs._SafeStr_4286).tabPageDecorator.tabSelected();
        }
        public function getPublicSpaceName(_arg_1:String, _arg_2:int):String
        {
            var _local_3 = (((("nav_venue_" + _arg_1) + "/") + _arg_2) + "_name");
            var _local_4:String = this.getText(_local_3);
            if (_local_4 != _local_3){
                return (_local_4);
            };
            return (this.getText((("nav_venue_" + _arg_1) + "_name")));
        }
        public function getPublicSpaceDesc(_arg_1:String, _arg_2:int):String
        {
            return (this.getText((((("nav_venue_" + _arg_1) + "/") + _arg_2) + "_desc")));
        }
        public function trackNavigationDataPoint(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:int=0):void
        {
            HabboTracking.getInstance().trackEventLog("Navigation", _arg_1, _arg_2, _arg_3, _arg_4);
        }

    }
}//package com.sulake.habbo.navigator

// IID = "_-3KV" (String#7712, DoABC#2)
// _sessionData = "_-2Bw" (String#1831, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// HabboUserDefinedRoomEvents = "_-1hF" (String#443, DoABC#2)
// HabboUserDefinedRoomEvents = "_-08W" (String#807, DoABC#2)
// _SafeStr_11492 = "_-0aZ" (String#589, DoABC#2)
// onAuthOk = "_-0iC" (String#15758, DoABC#2)
// goToPublicSpace = "_-080" (String#14367, DoABC#2)
// roomCreateViewCtrl = "_-0RP" (String#15117, DoABC#2)
// _mainViewCtrl = "_-Z-" (String#23601, DoABC#2)
// _roomInfoViewCtrl = "_-0A7" (String#14453, DoABC#2)
// _roomCreateViewCtrl = "_-2x6" (String#21353, DoABC#2)
// _roomSettingsCtrls = "_-107" (String#16471, DoABC#2)
// _thumbRenderer = "_-PV" (String#8194, DoABC#2)
// _officialRoomEntryManager = "_-3AM" (String#21896, DoABC#2)
// RoomSessionManager = "_-Fa" (String#7986, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// HabboProtocolOption = "_-9Z" (String#7855, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// NavigatorData = "_-1Uq" (String#5451, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// GuestRoomDoorbell = "_-0D1" (String#3810, DoABC#2)
// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// RoomThumbnailRenderer = "_-3Kq" (String#7719, DoABC#2)
// OfficialRoomEntryManager = "_-2OM" (String#6526, DoABC#2)
// GuestRoomPasswordInput = "_-2rH" (String#7108, DoABC#2)
// RoomCreateViewCtrl = "_-1gR" (String#5672, DoABC#2)
// RoomInfoViewCtrl = "_-0ZH" (String#4286, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// thumbRenderer = "_-2Ac" (String#19431, DoABC#2)
// passwordInput = "_-2kR" (String#20861, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// _SafeStr_4151 = "_-5z" (String#22464, DoABC#2)
// _SafeStr_4152 = "_-2NE" (String#19932, DoABC#2)
// getPublicSpaceName = "_-Zw" (String#23629, DoABC#2)
// getPublicSpaceDesc = "_-0-e" (String#14038, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// homeRoomId = "_-0jF" (String#15801, DoABC#2)
// officialRoomEntryManager = "_-aX" (String#23654, DoABC#2)
// MainViewCtrl = "_-2Ic" (String#19751, DoABC#2)
// toggle = "_-2MR" (String#19903, DoABC#2)
// ISelectorWindow = "_-88" (String#7825, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// tabPageDecorator = "_-09G" (String#14418, DoABC#2)
// getTab = "_-0mC" (String#15903, DoABC#2)
// _SafeStr_4285 = "_-20q" (String#19046, DoABC#2)
// _SafeStr_4286 = "_-3k" (String#22364, DoABC#2)
// _SafeStr_4287 = "_-2Xo" (String#20350, DoABC#2)
// _SafeStr_4288 = "_-1Ja" (String#17261, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// _SafeStr_4301 = "_-1o0" (String#18463, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// _doorbell = "_-3-h" (String#7298, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// _SafeStr_6022 = "_-1t4" (String#18679, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// roomInfoViewCtrl = "_-HS" (String#22911, DoABC#2)
// getButton = "_-1sK" (String#18645, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// filterCategory = "_-1T1" (String#5414, DoABC#2)
// trackNavigationDataPoint = "_-17A" (String#16741, DoABC#2)
// _passwordInput = "_-1TS" (String#5422, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// onHabboToolbarEvent = "_-0Ve" (String#435, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// goToHomeRoom = "_-LH" (String#8108, DoABC#2)
// showOwnRooms = "_-0Z5" (String#4281, DoABC#2)
// performTagSearch = "_-29O" (String#6238, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// roomSettingsCtrls = "_-2xJ" (String#21362, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// _tabs = "_-0QO" (String#585, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


