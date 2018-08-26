
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.habbo.friendlist.domain.FriendCategory;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.friendlist.domain.Friend;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import flash.external.ExternalInterface;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.ITextWindow;

    public class FriendsView implements ITabView, IFriendsView 
    {

        public static const _SafeStr_11290:String = "bg";

        private var _friendList:HabboFriendList;
        private var _SafeStr_11291:IContainerButtonWindow;
        private var _SafeStr_11292:IContainerButtonWindow;
        private var _SafeStr_11293:IContainerButtonWindow;
        private var _removeButton:IContainerButtonWindow;
        private var _content:IItemListWindow;
        private var _SafeStr_11247:AvatarPopupCtrl;

        public function init(_arg_1:HabboFriendList):void
        {
            this._friendList = _arg_1;
            this._SafeStr_11247 = new AvatarPopupCtrl(this._friendList);
        }
        public function getEntryCount():int
        {
            return (this._friendList.categories.getFriendCount(true));
        }
        public function fillFooter(_arg_1:IWindowContainer):void
        {
            this._SafeStr_11291 = this.initButton("open_minimail", this.onMinimailButtonClick, _arg_1);
            this._SafeStr_11292 = this.initButton("open_homepage", this.onHomeButtonClick, _arg_1);
            this._SafeStr_11293 = this.initButton("room_invite", this.onInviteButtonClick, _arg_1);
            this._removeButton = this.initButton("remove_friend", this.onRemoveButtonClick, _arg_1);
            this.ModActionCtrl();
        }
        public function fillList(_arg_1:IItemListWindow):void
        {
            this._content = _arg_1;
            this.refreshList();
        }
        public function tabClicked(_arg_1:int):void
        {
        }
        public function setNewMessageArrived():void
        {
            this._friendList.tabs.findTab(FriendListTab._SafeStr_11144).setNewMessageArrived(true);
        }
        public function refreshList():void
        {
            var _local_2:FriendCategory;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Boolean;
            if (this._content == null){
                return;
            };
            this._content.autoArrangeItems = false;
            var _local_1:int;
            for each (_local_2 in this._friendList.categories.getCategories()) {
                this.refreshEntry(true, _local_1, _local_2, null);
                _local_1++;
                if (_local_2.open){
                    _local_3 = _local_2.getStartFriendIndex();
                    _local_4 = _local_2.getEndFriendIndex();
                    _local_5 = _local_3;
                    while (_local_5 < _local_4) {
                        this.refreshEntry(true, _local_1, _local_2, _local_2.friends[_local_5]);
                        _local_1++;
                        _local_5++;
                    };
                };
            };
            while (true) {
                _local_6 = this.refreshEntry(false, _local_1, null, null);
                if (_local_6) break;
                _local_1++;
            };
            this._content.autoArrangeItems = true;
            this.ModActionCtrl();
        }
        private function initButton(_arg_1:String, _arg_2:Function, _arg_3:IWindowContainer):IContainerButtonWindow
        {
            var _local_4:IContainerButtonWindow = IContainerButtonWindow(_arg_3.findChildByName(("button_" + _arg_1)));
            _local_4.procedure = _arg_2;
            var _local_5:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_4.findChildByName("icon"));
            _local_5.bitmap = this._friendList.getButtonImage(_arg_1);
            _local_5.width = _local_5.bitmap.width;
            _local_5.height = _local_5.bitmap.height;
            return (_local_4);
        }
        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:FriendCategory, _arg_4:Friend):Boolean
        {
            var _local_5 = ((_arg_2 % 2) == 1);
            var _local_6:IWindowContainer = (this._content.getListItemAt(_arg_2) as IWindowContainer);
            if (_local_6 == null){
                if (!_arg_1){
                    return (true);
                };
                _local_6 = IWindowContainer(this._friendList.getXmlWindow("friend_entry"));
                this._content.addListItem(_local_6);
            };
            Util.InfostandWidget(_local_6);
            if (!_arg_1){
                _local_6.height = 0;
                _local_6.visible = false;
                return (false);
            };
            _local_6.height = 20;
            _local_6.visible = true;
            _local_6.color = this._friendList.laf.getRowShadingColor(FriendListTab._SafeStr_11144, _local_5);
            if (_arg_4 == null){
                _arg_3.view = _local_6;
                this.AchievementController(_arg_3, _local_5);
            }
            else {
                _arg_4.view = _local_6;
                this.refreshFriendEntry(_arg_3, _arg_4);
            };
            return (false);
        }
        public function AchievementController(_arg_1:FriendCategory, _arg_2:Boolean):void
        {
            if (this._content == null){
                return;
            };
            var _local_3:IWindowContainer = _arg_1.view;
            _local_3.tags.splice(0, _local_3.tags.length);
            _local_3.tags.push(_arg_1.id);
            this._friendList.refreshText(_local_3, "caption", true, (((_arg_1.name + " (") + _arg_1.friends.length) + ")"));
            this.refreshCatIcon(_local_3, "arrow_down_black", _arg_1.open, _arg_1.id, 6);
            this.refreshCatIcon(_local_3, "arrow_right_black", !(_arg_1.open), _arg_1.id, 9);
            _local_3.procedure = this.onCategoryClick;
            _local_3.visible = false;
            this.refreshPager(_arg_1, _arg_2);
            _local_3.height = Math.max(Util.getLowestPoint(_local_3), 20);
            _local_3.visible = true;
        }
        private function refreshFriendEntry(_arg_1:FriendCategory, _arg_2:Friend):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            var _local_3:IWindowContainer = _arg_2.view;
            if (_local_3 == null){
                return;
            };
            _local_3.id = _arg_2.id;
            _local_3.procedure = this.onFriendClick;
            _local_3.visible = true;
            if (_arg_2.selected){
                _local_3.color = this._friendList.laf.getSelectedEntryBgColor();
            };
            ILabelWindow(_arg_2.view.findChildByName("name")).textColor = this._friendList.laf.getFriendTextColor(_arg_2.selected);
            var _local_4:String = _arg_2.name;
            if (((!((_arg_2.realName == null))) && (!((_arg_2.realName == ""))))){
                _local_4 = (((_local_4 + " (") + _arg_2.realName) + ")");
            };
            this._friendList.refreshText(_local_3, "name", true, _local_4);
            this._friendList.refreshButton(_local_3, "start_chat", _arg_2.online, this.onChatButtonClick, _arg_2.id);
            this._friendList.refreshButton(_local_3, "follow_friend", _arg_2.followingAllowed, this.onFollowButtonClick, _arg_2.id);
            this.refreshFigure(_local_3, _arg_2);
        }
        private function refreshCatIcon(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:int, _arg_5:int):void
        {
            var _local_6:ILabelWindow;
            var _local_7:IWindow;
            this._friendList.refreshButton(_arg_1, _arg_2, _arg_3, this.onCategoryClick, _arg_4);
            if (_arg_3){
                _local_6 = ILabelWindow(_arg_1.findChildByName("caption"));
                _local_7 = _arg_1.findChildByName(_arg_2);
                _local_7.x = (_local_6.textWidth + _arg_5);
            };
        }
        private function refreshFigure(_arg_1:IWindowContainer, _arg_2:Friend):void
        {
            var _local_4:BitmapData;
            if (!_arg_1){
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: e is null!");
            };
            if (!_arg_2){
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: f is null!");
            };
            var _local_3:IBitmapWrapperWindow = (_arg_1.getChildByName(HabboFriendList._SafeStr_11259) as IBitmapWrapperWindow);
            if (!_local_3){
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: child is null!");
            };
            if (!this._friendList){
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: _friendList is null!");
            };
            if ((((_arg_2.figure == null)) || ((_arg_2.figure == "")))){
                _local_3.visible = false;
            }
            else {
                if (_arg_2.face == null){
                    _arg_2.face = this._friendList.getAvatarFaceBitmap(_arg_2.figure);
                };
                if (_local_3.bitmap == null){
                    _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height);
                };
                if (_local_3.tags[0] != _arg_2.figure){
                    _local_3.tags.splice(0, _local_3.tags.length);
                    _local_3.tags.push(_arg_2.figure);
                    _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0);
                    _local_4 = _arg_2.face;
                    if (_local_4){
                        _local_3.bitmap.copyPixels(_local_4, _local_4.rect, new Point(0, 0), null, null, true);
                    };
                }
                else {
                    Logger.log(("Figure unchanged: " + _local_3.tags[0]));
                };
                _local_3.visible = true;
            };
        }
        private function getBgColor(_arg_1:Boolean):uint
        {
            return (this._friendList.laf.getRowShadingColor(FriendListTab._SafeStr_11144, _arg_1));
        }
        private function ModActionCtrl():void
        {
            var _local_1:Array = this._friendList.categories.getSelectedFriends();
            this.setEnabled(this._SafeStr_11291, this.isEnableMinimailButton(_local_1));
            this.setEnabled(this._SafeStr_11292, this.isEnableHomeButton(_local_1));
            this.setEnabled(this._SafeStr_11293, this.isEnableInviteButton(_local_1));
            this.setEnabled(this._removeButton, this.isEnableRemoveButton(_local_1));
        }
        private function setEnabled(_arg_1:IContainerButtonWindow, _arg_2:Boolean):void
        {
            if (_arg_2){
                _arg_1.enable();
            }
            else {
                _arg_1.disable();
            };
        }
        private function isEnableMinimailButton(_arg_1:Array):Boolean
        {
            return (((this._friendList.isEmbeddedMinimailEnabled()) || ((_arg_1.length == 1))));
        }
        private function isEnableHomeButton(_arg_1:Array):Boolean
        {
            return ((_arg_1.length == 1));
        }
        private function isEnableInviteButton(_arg_1:Array):Boolean
        {
            var _local_2:Friend;
            if (_arg_1.length < 1){
                return (false);
            };
            for each (_local_2 in _arg_1) {
                if (_local_2.online){
                    return (true);
                };
            };
            return (true);
        }
        private function isEnableRemoveButton(_arg_1:Array):Boolean
        {
            return ((_arg_1.length > 0));
        }
        private function onCategoryClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log(((("Category clicked: " + _arg_2.name) + ", ") + _arg_2.tags[0]));
            if (_arg_2.tags.length == 0){
                _arg_2 = _arg_2.parent;
            };
            Logger.log(((("Category id: " + _arg_2.name) + ", ") + _arg_2.tags[0]));
            var _local_3:int = _arg_2.tags[0];
            Logger.log(("Cat id: " + _local_3));
            var _local_4:FriendCategory = this._friendList.categories.findCategory(_local_3);
            _local_4.setOpen(!(_local_4.open));
            this.refreshList();
            this._friendList.view.refresh("Cat open/closed");
        }
        private function onFriendClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Friend;
            var _local_4:Friend;
            if (_arg_2 == null){
                return;
            };
            if (_arg_2.id == 0){
                _arg_2 = _arg_2.parent;
                if (_arg_2 == null){
                    return;
                };
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                _local_3 = this._friendList.categories.findFriend(_arg_2.id);
                this._SafeStr_11247.setData(_local_3.online, _local_3.name, _local_3.motto, _local_3.figure, _local_3.lastAccess);
                this._SafeStr_11247.PopupCtrl(this._friendList.view.mainWindow, _local_3.view);
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    this._SafeStr_11247.PopupCtrl();
                }
                else {
                    if ((((_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)) || ((_arg_1.type == WindowMouseEvent.WME_DOUBLE_CLICK)))){
                        _local_4 = this._friendList.categories.findFriend(_arg_2.id);
                        _local_4.selected = !(_local_4.selected);
                        this.ModActionCtrl();
                        this.refreshList();
                        if ((((_arg_1.type == WindowMouseEvent.WME_DOUBLE_CLICK)) && (_local_4.online))){
                            this._friendList.messenger.startConversation(_local_4.id);
                        };
                    };
                };
            };
        }
        private function onChatButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.im}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log(((("chat clicked: " + _arg_2.name) + ", ") + _arg_2.id));
            this._friendList.messenger.startConversation(_arg_2.id);
        }
        private function onFollowButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.follow}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._friendList.send(new FollowFriendMessageComposer(_arg_2.id));
            this._friendList.send(new EventLogMessageComposer("Navigation", "Friend List", "go.friendlist"));
        }
        private function onMinimailButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.compose}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:Array = this._friendList.categories.getSelectedFriends();
            if (_local_3.length == 0){
                Logger.log("No friend found when minimail clicked");
                if (this._friendList.isEmbeddedMinimailEnabled()){
                    if (ExternalInterface.available){
                        ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", "#mail/inbox/");
                    };
                };
                return;
            };
            var _local_4:Dictionary = new Dictionary();
            var _local_5:Array = new Array();
            var _local_6:int;
            while ((((_local_6 < _local_3.length)) && ((_local_6 < 50)))) {
                _local_5.push(_local_3[_local_6].id);
                _local_6++;
            };
            _local_4["recipientid"] = _local_5.join(",");
            _local_4["random"] = ("" + Math.round((Math.random() * 100000000)));
            var _local_7:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (this._friendList.isEmbeddedMinimailEnabled()){
                if (ExternalInterface.available){
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", (((("#mail/compose/" + _local_4["recipientid"]) + "/") + _local_4["random"]) + "/"));
                };
            }
            else {
                this._friendList.openHabboWebPage("link.format.mail.compose", _local_4, _local_7.stageX, _local_7.stageY);
            };
        }
        private function onHomeButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.home}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:Friend = this._friendList.categories.getSelectedFriend();
            if (_local_3 == null){
                Logger.log("No friend found when home clicked");
                return;
            };
            var _local_4:Dictionary = new Dictionary();
            _local_4["ID"] = ("" + _local_3.id);
            var _local_5:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            this._friendList.openHabboWebPage("link.format.userpage", _local_4, _local_5.stageX, _local_5.stageY);
        }
        private function onInviteButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.invite}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            new RoomInviteView(this._friendList).show();
        }
        private function onRemoveButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.remove}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            new FriendRemoveView(this._friendList).show();
        }
        private function refreshPager(_arg_1:FriendCategory, _arg_2:Boolean):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.view.findChildByName("pager"));
            if ((((_arg_1.getPageCount() < 2)) || (!(_arg_1.open)))){
                Logger.log(((("PAGER NOT VISIBLE: " + _arg_1.open) + ", ") + _arg_1.getPageCount()));
                _local_3.visible = false;
                return;
            };
            _local_3.visible = true;
            Util.InfostandWidget(_local_3);
            var _local_4:int;
            while (_local_4 < _arg_1.getPageCount()) {
                this.refreshPageLink(_local_3, _local_4, _arg_1.pageIndex, _arg_2);
                _local_4++;
            };
            Util.layoutChildrenInArea(_local_3, _local_3.width, 15);
            _local_3.height = Util.getLowestPoint(_local_3);
        }
        private function refreshPageLink(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int, _arg_4:Boolean):void
        {
            var _local_5:String = ("page." + _arg_2);
            var _local_6:ITextWindow = ITextWindow(_arg_1.getChildByName(_local_5));
            if (_local_6 == null){
                _local_6 = ITextWindow(this._friendList.getXmlWindow("pagelink"));
                _local_6.name = _local_5;
                _arg_1.addChild(_local_6);
            };
            _local_6.underline = !((_arg_2 == _arg_3));
            _local_6.text = ((("" + ((_arg_2 * FriendCategory._SafeStr_11171) + 1)) + "-") + ("" + ((_arg_2 + 1) * FriendCategory._SafeStr_11171)));
            _local_6.id = _arg_2;
            _local_6.procedure = this.onPageLinkClick;
            _local_6.width = (_local_6.textWidth + 5);
            _local_6.color = this._friendList.laf.getRowShadingColor(FriendListTab._SafeStr_11144, _arg_4);
            _local_6.visible = true;
        }
        private function onPageLinkClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:ITextWindow = ITextWindow(_arg_2);
            var _local_4:int = _local_3.parent.parent.tags[0];
            var _local_5:int = _local_3.id;
            Logger.log(((("Page link clicked: " + _local_4) + ", ") + _local_5));
            var _local_6:FriendCategory = this._friendList.categories.findCategory(_local_4);
            _local_6.pageIndex = _local_5;
            this.refreshList();
        }

    }
}//package com.sulake.habbo.friendlist

// lastAccess = "_-Es" (String#7968, DoABC#2)
// _SafeStr_11144 = "_-0De" (String#14594, DoABC#2)
// findTab = "_-055" (String#14246, DoABC#2)
// _SafeStr_11171 = "_-0mP" (String#15913, DoABC#2)
// getFriendCount = "_-1oZ" (String#5833, DoABC#2)
// getPageCount = "_-2O-" (String#19965, DoABC#2)
// getStartFriendIndex = "_-21d" (String#19079, DoABC#2)
// setOpen = "_-1u7" (String#18721, DoABC#2)
// pageIndex = "_-0GU" (String#14700, DoABC#2)
// getSelectedFriend = "_-1GY" (String#17136, DoABC#2)
// findFriend = "_-1KM" (String#17288, DoABC#2)
// getSelectedEntryBgColor = "_-2cG" (String#20534, DoABC#2)
// getFriendTextColor = "_-K" (String#23004, DoABC#2)
// getRowShadingColor = "_-33K" (String#21634, DoABC#2)
// showInfo = "_-er" (String#23838, DoABC#2)
// openHabboWebPage = "_-2w" (String#7202, DoABC#2)
// fillFooter = "_-0xI" (String#4797, DoABC#2)
// fillList = "_-06y" (String#3702, DoABC#2)
// getEntryCount = "_-56" (String#7766, DoABC#2)
// tabClicked = "_-0VW" (String#4217, DoABC#2)
// laf = "_-07z" (String#14364, DoABC#2)
// _SafeStr_11247 = "_-1xs" (String#1786, DoABC#2)
// refreshFigure = "_-1JQ" (String#846, DoABC#2)
// onMinimailButtonClick = "_-04L" (String#1396, DoABC#2)
// onChatButtonClick = "_-HJ" (String#8024, DoABC#2)
// _SafeStr_11259 = "_-2en" (String#20637, DoABC#2)
// setData = "_-1x" (String#18846, DoABC#2)
// isEmbeddedMinimailEnabled = "_-2F1" (String#19604, DoABC#2)
// _SafeStr_11290 = "_-16T" (String#16717, DoABC#2)
// _SafeStr_11291 = "_-BI" (String#22665, DoABC#2)
// _SafeStr_11292 = "_-0aq" (String#15467, DoABC#2)
// _SafeStr_11293 = "_-0uw" (String#16236, DoABC#2)
// initButton = "_-BZ" (String#7902, DoABC#2)
// onHomeButtonClick = "_-8s" (String#22574, DoABC#2)
// onInviteButtonClick = "_-1j0" (String#18246, DoABC#2)
// onRemoveButtonClick = "_-2C7" (String#19487, DoABC#2)
// AchievementController = "_-1yX" (String#6003, DoABC#2)
// refreshFriendEntry = "_-0UG" (String#15216, DoABC#2)
// refreshCatIcon = "_-3Il" (String#22227, DoABC#2)
// onCategoryClick = "_-0QB" (String#15070, DoABC#2)
// refreshPager = "_-0nl" (String#15966, DoABC#2)
// onFriendClick = "_-0U4" (String#15207, DoABC#2)
// onFollowButtonClick = "_-0BK" (String#3786, DoABC#2)
// isEnableMinimailButton = "_-ym" (String#24642, DoABC#2)
// isEnableHomeButton = "_-HT" (String#22912, DoABC#2)
// isEnableInviteButton = "_-2zg" (String#21446, DoABC#2)
// isEnableRemoveButton = "_-0st" (String#16157, DoABC#2)
// refreshPageLink = "_-2Wd" (String#20309, DoABC#2)
// onPageLinkClick = "_-d8" (String#23764, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// FriendCategory = "_-3FV" (String#7619, DoABC#2)
// FollowFriendMessageComposer = "_-MN" (String#23099, DoABC#2)
// ITabView = "_-0HV" (String#3907, DoABC#2)
// IFriendsView = "_-0TY" (String#4169, DoABC#2)
// RoomInviteView = "_-1xW" (String#5981, DoABC#2)
// FriendRemoveView = "_-02W" (String#3618, DoABC#2)
// AvatarPopupCtrl = "_-17v" (String#5037, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// getBgColor = "_-1GR" (String#600, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// PopupCtrl = "_-0pi" (String#16042, DoABC#2)
// PopupCtrl = "_-1eW" (String#18078, DoABC#2)
// layoutChildrenInArea = "_-0f9" (String#15635, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// refreshList = "_-3Kn" (String#635, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// setNewMessageArrived = "_-0rH" (String#4668, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// setEnabled = "_-05S" (String#1399, DoABC#2)
// getCategories = "_-3E" (String#22033, DoABC#2)
// _removeButton = "_-1-e" (String#4861, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// ModActionCtrl = "_-1ep" (String#859, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)


