
package com.sulake.habbo.friendlist
{
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.core.window.IWindow;
    import flash.utils.Dictionary;

    public class FriendListView 
    {

        private static const _SafeStr_10176:Point = new Point(110, 50);

        private var _friendList:HabboFriendList;
        private var _SafeStr_11215:FriendListTabsView;
        private var _InventoryMainView:IFrameWindow;
        private var _SafeStr_11216:IWindowContainer;
        private var _SafeStr_4233:IWindowContainer;
        private var _SafeStr_11217:ITextWindow;
        private var _SafeStr_11218:int = -1;
        private var _SafeStr_11219:int = -1;
        private var _SafeStr_11220:Boolean;

        public function FriendListView(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
            this._SafeStr_11215 = new FriendListTabsView(this._friendList);
        }
        public function isFriendListOpen():Boolean
        {
            return (((!((this._InventoryMainView == null))) && (this._InventoryMainView.visible)));
        }
        public function openFriendList():void
        {
            if (this._InventoryMainView == null){
                this.prepare();
                this._InventoryMainView.position = _SafeStr_10176;
            }
            else {
                this._InventoryMainView.visible = true;
                this._InventoryMainView.activate();
            };
        }
        public function showInfo(_arg_1:WindowEvent, _arg_2:String):void
        {
            var _local_3:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (_local_3 == null){
                return;
            };
            if (_local_3.type == WindowMouseEvent.WME_OUT){
                this._SafeStr_11217.text = "";
            }
            else {
                if (_local_3.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    this._SafeStr_11217.text = _arg_2;
                };
            };
        }
        public function refresh(_arg_1:String):void
        {
            if (this._InventoryMainView == null){
                return;
            };
            this._SafeStr_11215.refresh(_arg_1);
            this.refreshWindowSize();
        }
        public function close():void
        {
            if (this._InventoryMainView != null){
                this._InventoryMainView.visible = false;
            };
        }
        public function IssueBrowser():Boolean
        {
            return (((this._InventoryMainView) && (this._InventoryMainView.visible)));
        }
        private function prepare():void
        {
            this._InventoryMainView = IFrameWindow(this._friendList.getXmlWindow("main_window"));
            this._InventoryMainView.findChildByTag("close").procedure = this.onWindowClose;
            this._SafeStr_11216 = IWindowContainer(this._InventoryMainView.content.findChildByName("main_content"));
            this._SafeStr_4233 = IWindowContainer(this._InventoryMainView.content.findChildByName("footer"));
            this._SafeStr_11215.prepare(this._SafeStr_11216);
            this._InventoryMainView.procedure = this.RoomVisitsCtrl;
            this._InventoryMainView.content.setParamFlag(HabboWindowParam._SafeStr_7463, false);
            this._InventoryMainView.content.setParamFlag(HabboWindowParam._SafeStr_7455, true);
            this._InventoryMainView.header.setParamFlag(HabboWindowParam._SafeStr_7453, false);
            this._InventoryMainView.header.setParamFlag(HabboWindowParam._SafeStr_7446, true);
            this._InventoryMainView.content.setParamFlag(HabboWindowParam._SafeStr_7453, false);
            this._InventoryMainView.content.setParamFlag(HabboWindowParam._SafeStr_7446, true);
            this._InventoryMainView.findChildByName("open_edit_ctgs_but").procedure = this.onEditCategoriesButtonClick;
            this._SafeStr_11217 = ITextWindow(this._InventoryMainView.findChildByName("info_text"));
            this._SafeStr_11217.text = "";
            this._friendList.refreshButton(this._InventoryMainView, "open_edit_ctgs", true, null, 0);
            this._InventoryMainView.title.color = 0xFFFAC200;
            this._InventoryMainView.title.textColor = 4287851525;
            this.refresh("prepare");
            this._InventoryMainView.height = 350;
            this._InventoryMainView.width = 230;
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Close window");
            this._InventoryMainView.visible = false;
            this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
        }
        private function RoomVisitsCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!((_arg_1.type == WindowEvent.WE_RESIZED))) || (!((_arg_2 == this._InventoryMainView))))){
                return;
            };
            if (this._SafeStr_11220){
                return;
            };
            var _local_3:int = (((this._SafeStr_11218 == -1)) ? 0 : (this._InventoryMainView.height - this._SafeStr_11218));
            var _local_4:int = (((this._SafeStr_11219 == -1)) ? 0 : (this._InventoryMainView.width - this._SafeStr_11219));
            this._friendList.tabs.tabContentHeight = Math.max(100, (this._friendList.tabs.tabContentHeight + _local_3));
            this._friendList.tabs.windowWidth = Math.max(147, (this._friendList.tabs.windowWidth + _local_4));
            this.refresh(("resize: " + _local_3));
        }
        private function refreshWindowSize():void
        {
            this._SafeStr_11220 = true;
            this._SafeStr_4233.visible = false;
            this._SafeStr_4233.y = Util.getLowestPoint(this._InventoryMainView.content);
            this._SafeStr_4233.width = this._friendList.tabs.windowWidth;
            this._SafeStr_4233.visible = true;
            this._InventoryMainView.content.height = Util.getLowestPoint(this._InventoryMainView.content);
            this._InventoryMainView.content.width = (this._friendList.tabs.windowWidth - 10);
            this._InventoryMainView.header.width = (this._friendList.tabs.windowWidth - 10);
            this._InventoryMainView.height = (this._InventoryMainView.content.height + 30);
            this._InventoryMainView.width = this._friendList.tabs.windowWidth;
            this._SafeStr_11220 = false;
            this._InventoryMainView.scaler.setParamFlag(HabboWindowParam._SafeStr_4267, false);
            this._InventoryMainView.scaler.setParamFlag(HabboWindowParam._SafeStr_7493, !((this._friendList.tabs.findSelectedTab() == null)));
            this._InventoryMainView.scaler.setParamFlag(HabboWindowParam._SafeStr_7453, false);
            this._InventoryMainView.scaler.setParamFlag(HabboWindowParam._SafeStr_7463, false);
            this._InventoryMainView.scaler.x = (this._InventoryMainView.width - this._InventoryMainView.scaler.width);
            this._InventoryMainView.scaler.y = (this._InventoryMainView.height - this._InventoryMainView.scaler.height);
            this._SafeStr_11218 = this._InventoryMainView.height;
            this._SafeStr_11219 = this._InventoryMainView.width;
            Logger.log(("RESIZED: " + this._friendList.tabs.windowWidth));
        }
        private function onEditCategoriesButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.preferences}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Edit categories clicked");
            var _local_3:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            this._friendList.openHabboWebPage("link.format.friendlist.pref", new Dictionary(), _local_3.stageX, _local_3.stageY);
        }
        public function get mainWindow():IWindowContainer
        {
            return (this._InventoryMainView);
        }

    }
}//package com.sulake.habbo.friendlist

// _SafeStr_10176 = "_-25d" (String#875, DoABC#2)
// findSelectedTab = "_-3KI" (String#22294, DoABC#2)
// tabContentHeight = "_-18K" (String#16788, DoABC#2)
// windowWidth = "_-gY" (String#23914, DoABC#2)
// _SafeStr_11215 = "_-0TH" (String#15182, DoABC#2)
// _SafeStr_11216 = "_-f6" (String#8498, DoABC#2)
// _SafeStr_11217 = "_-WX" (String#8333, DoABC#2)
// _SafeStr_11218 = "_-38n" (String#21834, DoABC#2)
// _SafeStr_11219 = "_-EP" (String#22788, DoABC#2)
// _SafeStr_11220 = "_-237" (String#19139, DoABC#2)
// isFriendListOpen = "_-10v" (String#16495, DoABC#2)
// showInfo = "_-er" (String#23838, DoABC#2)
// refreshWindowSize = "_-UF" (String#23418, DoABC#2)
// RoomVisitsCtrl = "_-1zg" (String#873, DoABC#2)
// onEditCategoriesButtonClick = "_-1ai" (String#17923, DoABC#2)
// trackFriendListEvent = "_-1w6" (String#18802, DoABC#2)
// openHabboWebPage = "_-2w" (String#7202, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// FriendListView = "_-1CA" (String#5113, DoABC#2)
// FriendListTabsView = "_-2wH" (String#7206, DoABC#2)
// _InventoryMainView = "_-1P" (String#361, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// _SafeStr_4233 = "_-Kp" (String#8099, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// _SafeStr_4267 = "_-36k" (String#21755, DoABC#2)
// _SafeStr_7446 = "_-3GA" (String#22125, DoABC#2)
// _SafeStr_7453 = "_-2yD" (String#21402, DoABC#2)
// _SafeStr_7455 = "_-24N" (String#19194, DoABC#2)
// _SafeStr_7463 = "_-05n" (String#14274, DoABC#2)
// _SafeStr_7493 = "_-0le" (String#15886, DoABC#2)
// HabboFriendListTrackingEvent = "_-0It" (String#14795, DoABC#2)


