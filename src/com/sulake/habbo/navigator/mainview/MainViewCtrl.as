
package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.navigator.TextSearchInputs;
    import flash.utils.Timer;
    import com.sulake.habbo.utils.WindowToggle;
    import flash.events.TimerEvent;
    import com.sulake.habbo.navigator.domain.Tab;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.navigator.IViewCtrl;
    import flash.events.Event;
    import com.sulake.habbo.navigator.events.HabboNavigatorTrackingEvent;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTagSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.LatestEventsSearchMessageComposer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;

    public class MainViewCtrl implements IUpdateReceiver, IDisposable 
    {

        public static const _SafeStr_4223:int = 1;
        public static const _SafeStr_4224:int = 2;
        public static const _SafeStr_4225:int = 3;
        public static const _SafeStr_4226:int = 4;
        private static const _SafeStr_4227:int = 1;
        private static const _SafeStr_4228:int = 2;
        private static const _SafeStr_4229:int = 3;
        private static const _SafeStr_4230:int = 4;
        private static const SCROLLBAR_WIDTH:int = 22;

        private const _SafeStr_4231:Point = new Point(100, 10);

        private var _navigator:HabboNavigator;
        private var _mainWindow:IFrameWindow;
        private var _content:IWindowContainer;
        private var _SafeStr_4232:IWindowContainer;
        private var _SafeStr_4233:IWindowContainer;
        private var _SafeStr_4234:IWindowContainer;
        private var _SafeStr_4235:PopularTagsListCtrl;
        private var _SafeStr_4236:GuestRoomListCtrl;
        private var _SafeStr_4237:OfficialRoomListCtrl;
        private var _SafeStr_4238:ITabContextWindow;
        private var _SafeStr_4239:Boolean;
        private var _SafeStr_4240:int;
        private var _SafeStr_4241:Boolean = true;
        private var _SafeStr_4242:int = 0;
        private var _SafeStr_4243:IWindow;
        private var _SafeStr_4244:IRegionWindow;
        private var _SafeStr_4245:int = 0;
        private var _SafeStr_4246:TextSearchInputs;
        private var _SafeStr_4247:Timer;
        private var _disposed:Boolean = false;
        private var _SafeStr_4248:WindowToggle;

        public function MainViewCtrl(_arg_1:HabboNavigator):void
        {
            this._navigator = _arg_1;
            this._SafeStr_4235 = new PopularTagsListCtrl(this._navigator);
            this._SafeStr_4236 = new GuestRoomListCtrl(this._navigator);
            this._SafeStr_4237 = new OfficialRoomListCtrl(this._navigator);
            this._SafeStr_4247 = new Timer(300, 1);
            this._SafeStr_4247.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function onNavigatorToolBarIconClick():Boolean
        {
            if (!this._mainWindow){
                this.reloadData();
                return (true);
            };
            if (((!(this._SafeStr_4248)) || (this._SafeStr_4248.disposed))){
                this._SafeStr_4248 = new WindowToggle(this._mainWindow, this._mainWindow.desktop, this.reloadData, this.close);
            };
            var _local_1:int = this._SafeStr_4248.toggle();
            return ((_local_1 == WindowToggle.RESULT_SHOW));
        }
        private function reloadData():void
        {
            var _local_1:Tab = this._navigator.tabs.getSelected();
            _local_1.tabPageDecorator.navigatorOpenedWhileInTab();
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
                this._navigator = null;
                if (this._mainWindow){
                    this._mainWindow.dispose();
                    this._mainWindow = null;
                };
                if (this._SafeStr_4248){
                    this._SafeStr_4248.dispose();
                    this._SafeStr_4248 = null;
                };
                if (this._content){
                    this._content.dispose();
                    this._content = null;
                };
                if (this._SafeStr_4247){
                    this._SafeStr_4247.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                    this._SafeStr_4247.reset();
                    this._SafeStr_4247 = null;
                };
                if (this._SafeStr_4235){
                    this._SafeStr_4235.dispose();
                    this._SafeStr_4235 = null;
                };
                if (this._SafeStr_4236){
                    this._SafeStr_4236.dispose();
                    this._SafeStr_4236 = null;
                };
                if (this._SafeStr_4237){
                    this._SafeStr_4237.dispose();
                    this._SafeStr_4237 = null;
                };
                if (this._SafeStr_4246){
                    this._SafeStr_4246.dispose();
                    this._SafeStr_4246 = null;
                };
            };
        }
        public function open():void
        {
            if (this._mainWindow == null){
                this.prepare();
            };
            this.refresh();
            this._mainWindow.visible = true;
            this._mainWindow.activate();
        }
        public function isOpen():Boolean
        {
            return (((!((this._mainWindow == null))) && (this._mainWindow.visible)));
        }
        public function close():void
        {
            if (this._mainWindow != null){
                this._mainWindow.visible = false;
            };
        }
        public function get mainWindow():IFrameWindow
        {
            return (this._mainWindow);
        }
        private function prepare():void
        {
            var _local_2:Tab;
            var _local_3:ITabButtonWindow;
            this._mainWindow = IFrameWindow(this._navigator.getXmlWindow("grs_main_window"));
            this._SafeStr_4238 = ITabContextWindow(this._mainWindow.findChildByName("tab_context"));
            this._content = IWindowContainer(this._mainWindow.findChildByName("tab_content"));
            this._SafeStr_4232 = IWindowContainer(this._mainWindow.findChildByName("custom_content"));
            this._SafeStr_4234 = IWindowContainer(this._mainWindow.findChildByName("list_content"));
            this._SafeStr_4233 = IWindowContainer(this._mainWindow.findChildByName("custom_footer"));
            this._SafeStr_4243 = this._mainWindow.findChildByName("loading_text");
            var _local_1:IWindow = this._mainWindow.findChildByTag("close");
            if (_local_1 != null){
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onWindowClose);
            };
            this._SafeStr_4244 = IRegionWindow(this._mainWindow.findChildByName("to_hotel_view"));
            if (this._SafeStr_4244 != null){
                this._SafeStr_4244.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onHotelViewMouseOver);
                this._SafeStr_4244.addEventListener(WindowMouseEvent.WME_OUT, this.onHotelViewMouseOut);
                this._SafeStr_4244.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onHotelViewMouseClick);
            };
            this.refreshToHotelViewButton(false);
            this._mainWindow.addEventListener(WindowEvent.WE_RESIZED, this.onWindowResized);
            for each (_local_2 in this._navigator.tabs.tabs) {
                _local_3 = this._SafeStr_4238.getTabItemByID(_local_2.id);
                if (_local_3 != null){
                    _local_3.addEventListener(WindowEvent.WE_SELECTED, this.onTabSelected);
                    _local_2.button = _local_3;
                };
            };
            this._mainWindow.scaler.setParamFlag(HabboWindowParam._SafeStr_4267, false);
            this._mainWindow.scaler.setParamFlag(HabboWindowParam._SafeStr_4268, true);
            this._mainWindow.position = this._SafeStr_4231;
            this.createSearchInput();
        }
        private function createSearchInput():void
        {
            var _local_3:IWindowContainer;
            var _local_1:String = "search_header";
            if (this._SafeStr_4246 == null){
                _local_3 = (this._mainWindow.findChildByName(_local_1) as IWindowContainer);
                this._SafeStr_4246 = new TextSearchInputs(this._navigator, _local_3);
            };
            var _local_2:IWindowContainer = (this._mainWindow.findChildByName(_local_1) as IWindowContainer);
            _local_2.visible = true;
        }
        public function refresh():void
        {
            if (this._mainWindow == null){
                return;
            };
            this.refreshTab();
            this.refreshCustomContent();
            this.refreshListContent(true);
            this.refreshFooter();
            this._SafeStr_4232.height = Util.getLowestPoint(this._SafeStr_4232);
            this._SafeStr_4233.height = Util.getLowestPoint(this._SafeStr_4233);
            var _local_1:int = this._SafeStr_4234.y;
            Util.moveChildrenToColumn(this._content, ["custom_content", "list_content"], this._SafeStr_4232.y, 8);
            this._SafeStr_4234.height = ((((this._SafeStr_4234.height + _local_1) - this._SafeStr_4234.y) - this._SafeStr_4233.height) + this._SafeStr_4245);
            Util.moveChildrenToColumn(this._content, ["list_content", "custom_footer"], this._SafeStr_4234.y, 0);
            this._SafeStr_4245 = this._SafeStr_4233.height;
            this.onResizeTimer(null);
        }
        private function refreshTab():void
        {
            var _local_1:Tab = this._navigator.tabs.getSelected();
            var _local_2:ISelectableWindow = this._SafeStr_4238.selector.getSelected();
            if (_local_1.button != _local_2){
                this._SafeStr_4239 = true;
                this._SafeStr_4238.selector.setSelected(_local_1.button);
            };
        }
        private function refreshCustomContent():void
        {
            Util.hideChildren(this._SafeStr_4232);
            var _local_1:Tab = this._navigator.tabs.getSelected();
            _local_1.tabPageDecorator.refreshCustomContent(this._SafeStr_4232);
            if (Util.hasVisibleChildren(this._SafeStr_4232)){
                this._SafeStr_4232.visible = true;
            }
            else {
                this._SafeStr_4232.visible = false;
                this._SafeStr_4232.blend = 1;
            };
        }
        private function refreshFooter():void
        {
            Util.hideChildren(this._SafeStr_4233);
            var _local_1:Tab = this._navigator.tabs.getSelected();
            _local_1.tabPageDecorator.refreshFooter(this._SafeStr_4233);
            if (Util.hasVisibleChildren(this._SafeStr_4233)){
                this._SafeStr_4233.visible = true;
            }
            else {
                this._SafeStr_4233.visible = false;
            };
        }
        private function refreshListContent(_arg_1:Boolean):void
        {
            Util.hideChildren(this._SafeStr_4234);
            this.refreshGuestRooms(_arg_1, this._navigator.data.guestRoomSearchArrived);
            this.refreshPopularTags(_arg_1, this._navigator.data.popularTagsArrived);
            this.refreshOfficialRooms(_arg_1, this._navigator.data.officialRoomsArrived);
        }
        private function refreshGuestRooms(_arg_1:Boolean, _arg_2:Boolean):void
        {
            this.refreshList(_arg_1, _arg_2, this._SafeStr_4236, "guest_rooms");
        }
        private function refreshPopularTags(_arg_1:Boolean, _arg_2:Boolean):void
        {
            this.refreshList(_arg_1, _arg_2, this._SafeStr_4235, "popular_tags");
        }
        private function refreshOfficialRooms(_arg_1:Boolean, _arg_2:Boolean):void
        {
            this.refreshList(_arg_1, _arg_2, this._SafeStr_4237, "official_rooms");
        }
        private function refreshList(_arg_1:Boolean, _arg_2:Boolean, _arg_3:IViewCtrl, _arg_4:String):void
        {
            var _local_5:IWindow;
            if (_arg_2){
                if (_arg_3.content == null){
                    _local_5 = this._SafeStr_4234.findChildByName(_arg_4);
                    _arg_3.content = IWindowContainer(_local_5);
                };
                if (_arg_1){
                    _arg_3.refresh();
                };
                _arg_3.content.visible = true;
            };
        }
        private function onWindowClose(_arg_1:WindowEvent):void
        {
            Logger.log("Close navigator window");
            this.close();
        }
        private function onTabSelected(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            var _local_3:int = _local_2.id;
            if (this._SafeStr_4239){
                this._SafeStr_4239 = false;
                return;
            };
            var _local_4:Tab = this._navigator.tabs.getTab(_local_3);
            _local_4.sendSearchRequest();
            switch (_local_4.id){
                case Tabs._SafeStr_4285:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS));
                    return;
                case Tabs._SafeStr_4286:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME));
                    return;
                case Tabs._SafeStr_4287:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL));
                    return;
                case Tabs._SafeStr_4288:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS));
                    return;
                case Tabs._SafeStr_4151:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH));
                    return;
            };
        }
        public function reloadRoomList(_arg_1:int):Boolean
        {
            ErrorReportStorage.addDebugData("MainViewCtrl", "Reloading RoomList");
            if (((((this.isOpen()) && (!((this._navigator.data.guestRoomSearchResults == null))))) && ((this._navigator.data.guestRoomSearchResults.searchType == _arg_1)))){
                this.startSearch(this._navigator.tabs.getSelected().id, _arg_1, "");
                return (true);
            };
            return (false);
        }
        public function startSearch(_arg_1:int, _arg_2:int, _arg_3:String="-1", _arg_4:int=1):void
        {
            var _local_5:Tab = this._navigator.tabs.getSelected();
            this._navigator.tabs.setSelectedTab(_arg_1);
            var _local_6:Tab = this._navigator.tabs.getSelected();
            ErrorReportStorage.addDebugData("StartSearch", ((("Start search " + _local_5.id) + " => ") + _local_6.id));
            this._SafeStr_4241 = !((_local_5 == _local_6));
            if (_local_5 != _local_6){
                _local_6.tabPageDecorator.tabSelected();
            };
            this._navigator.data.startLoading();
            if (_arg_4 == _SafeStr_4223){
                this._navigator.send(this.getSearchMsg(_arg_2, _arg_3));
            }
            else {
                if (_arg_4 == _SafeStr_4224){
                    this._navigator.send(new GetPopularRoomTagsMessageComposer());
                }
                else {
                    this._navigator.send(new GetOfficialRoomsMessageComposer(this._navigator.data.adIndex));
                };
            };
            if (!this.isOpen()){
                this.open();
                this._SafeStr_4240 = _SafeStr_4228;
                this._SafeStr_4234.blend = 0;
                if (this._SafeStr_4232.visible){
                    this._SafeStr_4232.blend = 0;
                    this._SafeStr_4233.blend = 0;
                };
            }
            else {
                this._SafeStr_4240 = _SafeStr_4227;
            };
            this._SafeStr_4242 = 0;
            this._navigator.registerUpdateReceiver(this, 2);
            this.sendTrackingEvent(_arg_2);
        }
        private function sendTrackingEvent(_arg_1:int):void
        {
            switch (_arg_1){
                case Tabs._SafeStr_4297:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS));
                    return;
                case Tabs._SafeStr_4298:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES));
                    return;
                case Tabs._SafeStr_4299:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS));
                    return;
                case Tabs._SafeStr_4300:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY));
                    return;
                case Tabs._SafeStr_4301:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS));
                    return;
                case Tabs._SafeStr_4302:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS));
                    return;
                case Tabs._SafeStr_4303:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS));
                    return;
                case Tabs._SafeStr_4304:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE));
                    return;
                case Tabs._SafeStr_4305:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE));
                    return;
                case Tabs._SafeStr_4152:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH));
                    return;
                case Tabs._SafeStr_4306:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH));
                    return;
            };
        }
        private function getSearchMsg(_arg_1:int, _arg_2:String):IMessageComposer
        {
            if (_arg_1 == Tabs._SafeStr_4298){
                return (new MyFavouriteRoomsSearchMessageComposer());
            };
            if (_arg_1 == Tabs._SafeStr_4299){
                return (new MyFriendsRoomsSearchMessageComposer());
            };
            if (_arg_1 == Tabs._SafeStr_4300){
                return (new MyRoomHistorySearchMessageComposer());
            };
            if (_arg_1 == Tabs._SafeStr_4301){
                return (new MyRoomsSearchMessageComposer());
            };
            if (_arg_1 == Tabs._SafeStr_4303){
                return (new PopularRoomsSearchMessageComposer(_arg_2, this._navigator.data.adIndex));
            };
            if (_arg_1 == Tabs._SafeStr_4304){
                return (new RoomsWhereMyFriendsAreSearchMessageComposer());
            };
            if (_arg_1 == Tabs._SafeStr_4305){
                return (new RoomsWithHighestScoreSearchMessageComposer(this._navigator.data.adIndex));
            };
            if (_arg_1 == Tabs._SafeStr_4152){
                return (new RoomTagSearchMessageComposer(_arg_2));
            };
            if (_arg_1 == Tabs._SafeStr_4306){
                return (new RoomTextSearchMessageComposer(_arg_2));
            };
            if (_arg_1 == Tabs._SafeStr_4297){
                return (new LatestEventsSearchMessageComposer(_arg_2, this._navigator.data.adIndex));
            };
            Logger.log(("No message for searchType: " + _arg_1));
            return (null);
        }
        public function update(_arg_1:uint):void
        {
            var _local_3:Number;
            if (this._SafeStr_4234 == null){
                return;
            };
            var _local_2:Number = (_arg_1 / 150);
            if (this._SafeStr_4240 == _SafeStr_4227){
                _local_3 = Math.min(1, Math.max(0, (this._SafeStr_4234.blend - _local_2)));
                this._SafeStr_4234.blend = _local_3;
                this._SafeStr_4232.blend = ((this._SafeStr_4241) ? _local_3 : 1);
                this._SafeStr_4233.blend = ((this._SafeStr_4241) ? _local_3 : 1);
                if (_local_3 == 0){
                    this._SafeStr_4240 = _SafeStr_4228;
                };
            }
            else {
                if (this._SafeStr_4240 == _SafeStr_4228){
                    if ((this._SafeStr_4242 % 10) == 1){
                        this._SafeStr_4243.visible = !(this._SafeStr_4243.visible);
                    };
                    this._SafeStr_4242++;
                    if (!this._navigator.data.isLoading()){
                        this._SafeStr_4240 = _SafeStr_4229;
                    };
                }
                else {
                    if (this._SafeStr_4240 == _SafeStr_4229){
                        this.refresh();
                        this._SafeStr_4240 = _SafeStr_4230;
                    }
                    else {
                        this._SafeStr_4243.visible = false;
                        _local_3 = Math.min(1, Math.max(0, (this._SafeStr_4234.blend + _local_2)));
                        this._SafeStr_4234.blend = _local_3;
                        this._SafeStr_4232.blend = ((this._SafeStr_4241) ? _local_3 : 1);
                        this._SafeStr_4233.blend = ((this._SafeStr_4241) ? _local_3 : 1);
                        if (this._SafeStr_4234.blend >= 1){
                            this._navigator.removeUpdateReceiver(this);
                        };
                    };
                };
            };
        }
        private function onWindowResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            if (_local_2 != this._mainWindow){
                return;
            };
            if (!this._SafeStr_4247.running){
                this._SafeStr_4247.reset();
                this._SafeStr_4247.start();
            };
        }
        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            this.refreshScrollbar(this._SafeStr_4235);
            this.refreshScrollbar(this._SafeStr_4236);
        }
        private function refreshScrollbar(_arg_1:IViewCtrl):void
        {
            if ((((_arg_1.content == null)) || (!(_arg_1.content.visible)))){
                return;
            };
            var _local_2:IItemListWindow = IItemListWindow(_arg_1.content.findChildByName("item_list"));
            var _local_3:IWindow = _arg_1.content.findChildByName("scroller");
            var _local_4 = (_local_2.scrollableRegion.height > _local_2.height);
            if (_local_3.visible){
                if (_local_4){
                    return;
                };
                _local_3.visible = false;
                _local_2.width = (_local_2.width + SCROLLBAR_WIDTH);
            }
            else {
                if (_local_4){
                    _local_3.visible = true;
                    _local_2.width = (_local_2.width - SCROLLBAR_WIDTH);
                }
                else {
                    return;
                };
            };
        }
        public function stretchNewEntryIfNeeded(_arg_1:IViewCtrl, _arg_2:IWindowContainer):void
        {
            var _local_3:IWindow = _arg_1.content.findChildByName("scroller");
            if (_local_3.visible){
                return;
            };
            _arg_2.width = (_arg_2.width + SCROLLBAR_WIDTH);
        }
        private function refreshToHotelViewButton(_arg_1:Boolean):void
        {
            this._navigator.refreshButton(this._SafeStr_4244, "icon_hotelview", !(_arg_1), null, 0);
            this._navigator.refreshButton(this._SafeStr_4244, "icon_hotelview_reactive", _arg_1, null, 0);
        }
        private function onHotelViewMouseOver(_arg_1:WindowEvent):void
        {
            this.refreshToHotelViewButton(true);
        }
        private function onHotelViewMouseOut(_arg_1:WindowEvent):void
        {
            this.refreshToHotelViewButton(false);
        }
        private function onHotelViewMouseClick(_arg_1:WindowEvent):void
        {
            this._navigator.send(new QuitMessageComposer());
        }

    }
}//package com.sulake.habbo.navigator.mainview

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowToggle = "_-1Ud" (String#17689, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// QuitMessageComposer = "_-FM" (String#22827, DoABC#2)
// PopularRoomsSearchMessageComposer = "_-WK" (String#23503, DoABC#2)
// RoomsWithHighestScoreSearchMessageComposer = "_-34D" (String#21668, DoABC#2)
// RoomTagSearchMessageComposer = "_-0sl" (String#16151, DoABC#2)
// IViewCtrl = "_-D9" (String#7935, DoABC#2)
// GuestRoomListCtrl = "_-302" (String#7304, DoABC#2)
// MyFriendsRoomsSearchMessageComposer = "_-1I4" (String#17196, DoABC#2)
// MyFavouriteRoomsSearchMessageComposer = "_-4m" (String#22408, DoABC#2)
// RoomsWhereMyFriendsAreSearchMessageComposer = "_-JM" (String#22979, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// PopularTagsListCtrl = "_-0Ay" (String#3776, DoABC#2)
// LatestEventsSearchMessageComposer = "_-Ad" (String#22641, DoABC#2)
// TextSearchInputs = "_-22k" (String#6101, DoABC#2)
// OfficialRoomListCtrl = "_-0ZB" (String#4283, DoABC#2)
// MyRoomHistorySearchMessageComposer = "_-1nc" (String#18445, DoABC#2)
// GetPopularRoomTagsMessageComposer = "_-3Jr" (String#22278, DoABC#2)
// RoomTextSearchMessageComposer = "_-hy" (String#23963, DoABC#2)
// GetOfficialRoomsMessageComposer = "_-30z" (String#21537, DoABC#2)
// MyRoomsSearchMessageComposer = "_-d3" (String#23759, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _mainWindow = "_-1P" (String#361, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// adIndex = "_-0RB" (String#15110, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// _SafeStr_4151 = "_-5z" (String#22464, DoABC#2)
// _SafeStr_4152 = "_-2NE" (String#19932, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// guestRoomSearchResults = "_-fX" (String#23866, DoABC#2)
// stretchNewEntryIfNeeded = "_-1D8" (String#16986, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// _SafeStr_4223 = "_-2Wh" (String#20312, DoABC#2)
// _SafeStr_4224 = "_-2gj" (String#20718, DoABC#2)
// _SafeStr_4225 = "_-2Bl" (String#19472, DoABC#2)
// _SafeStr_4226 = "_-1kG" (String#18300, DoABC#2)
// _SafeStr_4227 = "_-1C5" (String#16947, DoABC#2)
// _SafeStr_4228 = "_-2Gn" (String#19673, DoABC#2)
// _SafeStr_4229 = "_-0Nm" (String#14981, DoABC#2)
// _SafeStr_4230 = "_-M7" (String#23088, DoABC#2)
// _SafeStr_4231 = "_-37t" (String#2006, DoABC#2)
// _SafeStr_4232 = "_-0pc" (String#16039, DoABC#2)
// _SafeStr_4233 = "_-Kp" (String#8099, DoABC#2)
// _SafeStr_4234 = "_-0T0" (String#15171, DoABC#2)
// _SafeStr_4235 = "_-1iI" (String#18220, DoABC#2)
// _SafeStr_4236 = "_-2Wy" (String#20321, DoABC#2)
// _SafeStr_4237 = "_-4x" (String#22417, DoABC#2)
// _SafeStr_4238 = "_-1WR" (String#1704, DoABC#2)
// _SafeStr_4239 = "_-Bp" (String#22680, DoABC#2)
// _SafeStr_4240 = "_-1sj" (String#18665, DoABC#2)
// _SafeStr_4241 = "_-2pJ" (String#21051, DoABC#2)
// _SafeStr_4242 = "_-EM" (String#22785, DoABC#2)
// _SafeStr_4243 = "_-1tO" (String#18693, DoABC#2)
// _SafeStr_4244 = "_-2V5" (String#20242, DoABC#2)
// _SafeStr_4245 = "_-2qR" (String#21100, DoABC#2)
// _SafeStr_4246 = "_-1Qm" (String#17542, DoABC#2)
// _SafeStr_4247 = "_-0RI" (String#586, DoABC#2)
// _SafeStr_4248 = "_-25w" (String#6159, DoABC#2)
// onNavigatorToolBarIconClick = "_-2Ic" (String#19751, DoABC#2)
// reloadData = "_-1nZ" (String#18443, DoABC#2)
// toggle = "_-2MR" (String#19903, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// navigatorOpenedWhileInTab = "_-2IQ" (String#6410, DoABC#2)
// tabPageDecorator = "_-09G" (String#14418, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// onHotelViewMouseOver = "_-2ck" (String#20554, DoABC#2)
// onHotelViewMouseOut = "_-5g" (String#22448, DoABC#2)
// onHotelViewMouseClick = "_-1sf" (String#18662, DoABC#2)
// refreshToHotelViewButton = "_-1rd" (String#18614, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// onWindowResized = "_-0gF" (String#15684, DoABC#2)
// getTabItemByID = "_-2aw" (String#6771, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// onTabSelected = "_-2da" (String#6822, DoABC#2)
// _SafeStr_4267 = "_-36k" (String#21755, DoABC#2)
// _SafeStr_4268 = "_-325" (String#21584, DoABC#2)
// createSearchInput = "_-0c4" (String#15516, DoABC#2)
// refreshTab = "_-26v" (String#6182, DoABC#2)
// refreshCustomContent = "_-1cv" (String#1724, DoABC#2)
// refreshListContent = "_-0Y9" (String#15364, DoABC#2)
// refreshFooter = "_-1IP" (String#1655, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// hasVisibleChildren = "_-0js" (String#15823, DoABC#2)
// refreshGuestRooms = "_-2vM" (String#21291, DoABC#2)
// guestRoomSearchArrived = "_-019" (String#14097, DoABC#2)
// refreshPopularTags = "_-20f" (String#19037, DoABC#2)
// popularTagsArrived = "_-29b" (String#19388, DoABC#2)
// refreshOfficialRooms = "_-nO" (String#24166, DoABC#2)
// officialRoomsArrived = "_-18J" (String#16787, DoABC#2)
// refreshList = "_-3Kn" (String#635, DoABC#2)
// getTab = "_-0mC" (String#15903, DoABC#2)
// sendSearchRequest = "_-27J" (String#19305, DoABC#2)
// _SafeStr_4285 = "_-20q" (String#19046, DoABC#2)
// _SafeStr_4286 = "_-3k" (String#22364, DoABC#2)
// _SafeStr_4287 = "_-2Xo" (String#20350, DoABC#2)
// _SafeStr_4288 = "_-1Ja" (String#17261, DoABC#2)
// reloadRoomList = "_-1n6" (String#18428, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// searchType = "_-2UR" (String#20218, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// startLoading = "_-241" (String#19177, DoABC#2)
// getSearchMsg = "_-uq" (String#24484, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// sendTrackingEvent = "_-1di" (String#18045, DoABC#2)
// _SafeStr_4297 = "_-36W" (String#21748, DoABC#2)
// _SafeStr_4298 = "_-0Jm" (String#14833, DoABC#2)
// _SafeStr_4299 = "_-2ob" (String#21028, DoABC#2)
// _SafeStr_4300 = "_-0Q4" (String#15063, DoABC#2)
// _SafeStr_4301 = "_-1o0" (String#18463, DoABC#2)
// _SafeStr_4302 = "_-1xH" (String#18859, DoABC#2)
// _SafeStr_4303 = "_-21q" (String#19083, DoABC#2)
// _SafeStr_4304 = "_-0CH" (String#14541, DoABC#2)
// _SafeStr_4305 = "_-0qO" (String#16066, DoABC#2)
// _SafeStr_4306 = "_-1Y7" (String#17819, DoABC#2)
// isLoading = "_-2Lx" (String#19882, DoABC#2)
// refreshScrollbar = "_-34H" (String#21669, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// HabboNavigatorTrackingEvent = "_-0Vu" (String#15273, DoABC#2)


