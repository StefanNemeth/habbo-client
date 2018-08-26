
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IItemListWindow;

    public class FriendListTabsView 
    {

        private var _friendList:HabboFriendList;
        private var _content:IWindowContainer;

        public function FriendListTabsView(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
        }
        public function prepare(_arg_1:IWindowContainer):void
        {
            this._content = _arg_1;
            this.refresh("prepare");
        }
        public function refresh(_arg_1:String):void
        {
            var _local_3:FriendListTab;
            var _local_4:IWindowContainer;
            var _local_5:int;
            Logger.log(("TABS: REFRESH: " + _arg_1));
            this._content.width = this._friendList.tabs.tabContentWidth;
            this._content.findChildByName("bg").width = this._friendList.tabs.tabContentWidth;
            var _local_2:int = 1;
            for each (_local_3 in this._friendList.tabs.getTabs()) {
                _local_4 = (this._content.getChildByName(("flt_" + _local_3.id)) as IWindowContainer);
                if (!this.isTabVisible(_local_3.id)){
                    _local_4.visible = false;
                }
                else {
                    _local_4.visible = true;
                    _local_4.width = this._friendList.tabs.tabContentWidth;
                    _local_4.y = _local_2;
                    _local_5 = this.refreshHeader(_local_3, _local_4);
                    this.refreshTabContent(_local_3, _local_4);
                    _local_4.height = (_local_5 + ((_local_3.selected) ? this._friendList.tabs.tabContentHeight : 0));
                    _local_2 = (_local_2 + _local_4.height);
                };
            };
            this._content.height = (_local_2 + 1);
            this._content.findChildByName("bg").height = this._content.height;
            Logger.log("TABS: REFRESH END");
        }
        private function isTabVisible(_arg_1:int):Boolean
        {
            if (_arg_1 != FriendListTab._SafeStr_11145){
                return (true);
            };
            return ((this._friendList.friendRequests.requests.length > 0));
        }
        private function refreshTabContent(_arg_1:FriendListTab, _arg_2:IWindowContainer):void
        {
            if (_arg_1.selected){
                if (_arg_1.view == null){
                    _arg_1.view = (this.getTabContent(_arg_1) as IWindowContainer);
                };
                this.refreshTabContentDims(_arg_1.view);
                this.ChatlogCtrl(_arg_1.view);
                _arg_2.addChild(_arg_1.view);
            }
            else {
                if (_arg_1.view != null){
                    _arg_2.removeChild(_arg_1.view);
                };
            };
        }
        private function refreshHeader(_arg_1:FriendListTab, _arg_2:IWindowContainer):int
        {
            var _local_3:IWindowContainer = (_arg_2.getChildByName("header") as IWindowContainer);
            _local_3.width = this._friendList.tabs.tabContentWidth;
            this.showBgImage(_local_3, _arg_1.newMessageArrived, "hdr_hilite");
            this.showBgImage(_local_3, !(_arg_1.newMessageArrived), _arg_1.headerPicName);
            var _local_4:Boolean = (((_arg_1.id == FriendListTab._SafeStr_11144)) && (!(_arg_1.newMessageArrived)));
            Logger.log(((((("TAB " + _arg_1.id) + ", ") + _arg_1.name) + ", ") + _local_4));
            this.refreshArrowIcon(_local_3, "arrow_down_black", ((_arg_1.selected) && (_local_4)), 12);
            this.refreshArrowIcon(_local_3, "arrow_right_black", ((!(_arg_1.selected)) && (_local_4)), 15);
            this.refreshArrowIcon(_local_3, "arrow_down_white", ((_arg_1.selected) && (!(_local_4))), 12);
            this.refreshArrowIcon(_local_3, "arrow_right_white", ((!(_arg_1.selected)) && (!(_local_4))), 15);
            this.refreshTabText(_arg_1, _local_3);
            return (_local_3.height);
        }
        private function showBgImage(_arg_1:IWindowContainer, _arg_2:Boolean, _arg_3:String):void
        {
            Logger.log(((("REFRESHING BG IMAGE: " + _arg_2) + ", ") + _arg_3));
            var _local_4:IBitmapWrapperWindow = (_arg_1.getChildByName(_arg_3) as IBitmapWrapperWindow);
            if (!_arg_2){
                if (_local_4 != null){
                    _local_4.visible = false;
                };
            }
            else {
                if (_local_4.bitmap == null){
                    _local_4.bitmap = this._friendList.getButtonImage(_arg_3);
                    _local_4.height = _local_4.bitmap.height;
                    _arg_1.height = _local_4.bitmap.height;
                    _local_4.procedure = this.onTabClick;
                };
                _local_4.width = this._friendList.tabs.tabContentWidth;
                _local_4.visible = true;
            };
        }
        private function refreshArrowIcon(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:int):void
        {
            var _local_5:ITextWindow;
            var _local_6:IWindow;
            this._friendList.refreshButton(_arg_1, _arg_2, _arg_3, null, 0);
            if (_arg_3){
                _local_5 = ITextWindow(_arg_1.findChildByName("caption_text"));
                _local_6 = IWindow(_arg_1.findChildByName(_arg_2));
                _local_6.x = (_local_5.textWidth + _arg_4);
            };
        }
        private function refreshTabText(_arg_1:FriendListTab, _arg_2:IWindowContainer):void
        {
            var _local_3:ITextWindow = (_arg_2.findChildByName("caption_text") as ITextWindow);
            _local_3.text = (((_arg_1.name + " (") + _arg_1.tabView.getEntryCount()) + ")");
            _local_3.textColor = this._friendList.laf.getTabTextColor(_arg_1.newMessageArrived, _arg_1.id);
        }
        private function onTabClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:FriendListTab;
            this._friendList.view.showInfo(_arg_1, (("${friendlist.tip.tab." + _arg_2.id) + "}"));
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("TAB CLICKED!");
            var _local_3:FriendListTab = this._friendList.tabs.findTab(_arg_2.id);
            for each (_local_4 in this._friendList.tabs.getTabs()) {
                _local_4.tabView.tabClicked(_local_3.id);
            };
            this._friendList.tabs.toggleSelected(_local_3);
            this._friendList.view.refresh("tabClick");
            if (_local_3.selected){
                switch (_local_3.id){
                    case FriendListTab._SafeStr_11144:
                        this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS);
                        break;
                    case FriendListTab._view:
                        this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH);
                        break;
                    case FriendListTab._SafeStr_11145:
                        this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST);
                        break;
                };
            }
            else {
                this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_MINIMZED);
            };
        }
        private function getTabContent(_arg_1:FriendListTab):IWindow
        {
            var _local_2:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow("tab_content"));
            _local_2.background = true;
            _local_2.color = this._friendList.laf.getTabBgColor(_arg_1.id);
            _local_2.addChild(this.getTabContentFooter(_arg_1));
            var _local_3:IItemListWindow = IItemListWindow(_local_2.findChildByName("list_content"));
            _local_3.color = this._friendList.laf.getTabBgColor(_arg_1.id);
            _arg_1.tabView.fillList(_local_3);
            return (_local_2);
        }
        private function refreshTabContentDims(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = (_arg_1.getChildByName("footer") as IWindowContainer);
            var _local_3:IWindowContainer = (_arg_1.getChildByName("list") as IWindowContainer);
            var _local_4:IWindow = (_local_3.getChildByName("scroller") as IWindow);
            var _local_5:IItemListWindow = IItemListWindow(_local_3.getChildByName("list_content"));
            var _local_6:IWindow = _local_3.parent;
            var _local_7:int = this._friendList.tabs.tabContentWidth;
            var _local_8:int = this._friendList.tabs.tabContentHeight;
            _local_6.height = Math.max(0, _local_8);
            _local_6.width = _local_7;
            var _local_9:int = Math.max(((_local_8 - _local_3.y) - _local_2.height), 0);
            _local_3.height = _local_9;
            _local_4.height = _local_9;
            _local_5.height = _local_9;
            _local_3.width = _local_7;
            _local_5.width = _local_7;
            _local_4.x = (_local_7 - 27);
            _local_2.y = (_local_8 - _local_2.height);
            _local_2.width = _local_7;
        }
        private function ChatlogCtrl(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = (_arg_1.getChildByName("list") as IWindowContainer);
            var _local_3:IWindow = (_local_2.getChildByName("scroller") as IWindow);
            var _local_4:IItemListWindow = IItemListWindow(_local_2.getChildByName("list_content"));
            var _local_5 = (_local_4.scrollableRegion.height > _local_4.height);
            var _local_6:int = 22;
            var _local_7:int = (this._friendList.tabs.tabContentWidth - 10);
            var _local_8:int = (_local_7 - _local_6);
            var _local_9:int = ((_local_5) ? _local_8 : _local_7);
            _local_3.visible = _local_5;
            _local_4.width = _local_9;
            this.change(_local_4, _local_9);
        }
        private function change(_arg_1:IItemListWindow, _arg_2:int):void
        {
            var _local_4:IWindow;
            var _local_3:int;
            while (_local_3 < _arg_1.numListItems) {
                _local_4 = _arg_1.getListItemAt(_local_3);
                _local_4.width = _arg_2;
                _local_3++;
            };
        }
        private function getTabContentFooter(_arg_1:FriendListTab):IWindow
        {
            var _local_2:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow(_arg_1.footerName));
            _arg_1.tabView.fillFooter(_local_2);
            return (_local_2);
        }

    }
}//package com.sulake.habbo.friendlist

// _SafeStr_11144 = "_-0De" (String#14594, DoABC#2)
// _SafeStr_11145 = "_-1wt" (String#18841, DoABC#2)
// _view = "_-01Y" (String#14113, DoABC#2)
// footerName = "_-2Uy" (String#20236, DoABC#2)
// headerPicName = "_-02r" (String#14153, DoABC#2)
// tabView = "_-1CV" (String#16966, DoABC#2)
// toggleSelected = "_-0OB" (String#14995, DoABC#2)
// getTabs = "_-qn" (String#24306, DoABC#2)
// findTab = "_-055" (String#14246, DoABC#2)
// tabContentHeight = "_-18K" (String#16788, DoABC#2)
// tabContentWidth = "_-2BS" (String#19463, DoABC#2)
// getTabTextColor = "_-1EC" (String#17035, DoABC#2)
// getTabBgColor = "_-1iz" (String#18243, DoABC#2)
// showInfo = "_-er" (String#23838, DoABC#2)
// trackFriendListEvent = "_-1w6" (String#18802, DoABC#2)
// fillFooter = "_-0xI" (String#4797, DoABC#2)
// fillList = "_-06y" (String#3702, DoABC#2)
// getEntryCount = "_-56" (String#7766, DoABC#2)
// tabClicked = "_-0VW" (String#4217, DoABC#2)
// friendRequests = "_-cP" (String#23730, DoABC#2)
// laf = "_-07z" (String#14364, DoABC#2)
// isTabVisible = "_-3EC" (String#22043, DoABC#2)
// refreshTabContent = "_-0om" (String#4610, DoABC#2)
// getTabContent = "_-2Px" (String#20040, DoABC#2)
// refreshTabContentDims = "_-30u" (String#21535, DoABC#2)
// ChatlogCtrl = "_-0E4" (String#1434, DoABC#2)
// showBgImage = "_-0R3" (String#15105, DoABC#2)
// refreshArrowIcon = "_-qd" (String#24298, DoABC#2)
// refreshTabText = "_-Yc" (String#23583, DoABC#2)
// onTabClick = "_-1kH" (String#1752, DoABC#2)
// getTabContentFooter = "_-1SG" (String#17591, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// FriendListTabsView = "_-2wH" (String#7206, DoABC#2)
// HABBO_FRIENDLIST_TRACKIG_EVENT_MINIMZED = "_-0An" (String#14479, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// newMessageArrived = "_-0XG" (String#4255, DoABC#2)
// change = "_-Bl" (String#7908, DoABC#2)
// refreshHeader = "_-18C" (String#834, DoABC#2)
// HabboFriendListTrackingEvent = "_-0It" (String#14795, DoABC#2)


