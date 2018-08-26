
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
    import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.utils.Dictionary;
    import flash.external.ExternalInterface;
    import flash.ui.Keyboard;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class SearchView implements ITabView, ISearchView 
    {

        private var _friendList:HabboFriendList;
        private var _searchStr:ITextFieldWindow;
        private var _content:IItemListWindow;
        private var _SafeStr_11247:AvatarPopupCtrl;

        public function init(_arg_1:HabboFriendList):void
        {
            this._friendList = _arg_1;
            this._SafeStr_11247 = new AvatarPopupCtrl(this._friendList);
        }
        public function getEntryCount():int
        {
            if (this._friendList.searchResults.friends == null){
                return (0);
            };
            return ((this._friendList.searchResults.friends.length + this._friendList.searchResults.others.length));
        }
        public function fillList(_arg_1:IItemListWindow):void
        {
            this._content = _arg_1;
        }
        public function fillFooter(_arg_1:IWindowContainer):void
        {
            this._searchStr = ITextFieldWindow(_arg_1.findChildByName("search_str"));
            this._searchStr.procedure = this.onSearchInput;
            this._searchStr.addEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.onSearchStrInput);
            _arg_1.findChildByName("search_but").procedure = this.onSearchButtonClick;
            this._friendList.refreshButton(_arg_1, "search", true, null, 0);
        }
        public function tabClicked(_arg_1:int):void
        {
        }
        public function refreshList():void
        {
            var _local_3:HabboSearchResultData;
            var _local_4:HabboSearchResultData;
            var _local_5:Boolean;
            this._content.autoArrangeItems = false;
            var _local_1:AvatarSearchResults = this._friendList.searchResults;
            var _local_2:int;
            while (true) {
                if (_local_2 == 0){
                    this.refreshEntry(true, _local_2, null, null, this.getFriendsCaption(), false, false, false, 0);
                }
                else {
                    if (_local_2 <= _local_1.friends.length){
                        _local_3 = _local_1.friends[(_local_2 - 1)];
                        this.refreshEntry(true, _local_2, _local_3.avatarFigure, _local_3.avatarName, null, !(_local_3.isAvatarOnline), _local_3.isAvatarOnline, false, _local_3.avatarId);
                    }
                    else {
                        if (_local_2 == (_local_1.friends.length + 1)){
                            this.refreshEntry(true, _local_2, null, null, this.getOthersCaption(), false, false, false, 0);
                        }
                        else {
                            if (_local_2 <= ((_local_1.friends.length + _local_1.others.length) + 1)){
                                _local_4 = _local_1.others[((_local_2 - 2) - _local_1.friends.length)];
                                this.refreshEntry(true, _local_2, _local_4.avatarFigure, _local_4.avatarName, null, false, false, ((!((_local_4.avatarId == this._friendList.avatarId))) && (!(this._friendList.searchResults.isFriendRequestSent(_local_4.avatarId)))), _local_4.avatarId);
                            }
                            else {
                                _local_5 = this.refreshEntry(false, _local_2, null, null, null, false, false, false, 0);
                                if (_local_5) break;
                            };
                        };
                    };
                };
                _local_2++;
            };
            this.refreshShading();
            this._content.autoArrangeItems = true;
        }
        private function refreshShading():void
        {
            var _local_1:int;
            while (_local_1 < this._content.numListItems) {
                this._content.getListItemAt(_local_1).color = this._friendList.laf.getRowShadingColor(FriendListTab._view, ((_local_1 % 2) == 1));
                _local_1++;
            };
        }
        public function setSearchStr(_arg_1:String):void
        {
            this._searchStr.text = _arg_1;
        }
        private function getFriendsCaption():String
        {
            if (this._friendList.searchResults.friends.length == 0){
                return ("${friendlist.search.nofriendsfound}");
            };
            this._friendList.registerParameter("friendlist.search.friendscaption", "cnt", ("" + this._friendList.searchResults.friends.length));
            return ("${friendlist.search.friendscaption}");
        }
        private function getOthersCaption():String
        {
            if (this._friendList.searchResults.others.length == 0){
                return ("${friendlist.search.noothersfound}");
            };
            this._friendList.registerParameter("friendlist.search.otherscaption", "cnt", ("" + this._friendList.searchResults.others.length));
            return ("${friendlist.search.otherscaption}");
        }
        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Boolean, _arg_9:int):Boolean
        {
            var _local_10:IWindowContainer = (this._content.getListItemAt(_arg_2) as IWindowContainer);
            if (_local_10 == null){
                if (!_arg_1){
                    return (true);
                };
                _local_10 = IWindowContainer(this._friendList.getXmlWindow("search_entry"));
                _local_10.procedure = this.onSearchEntry;
                this._content.addListItem(_local_10);
            };
            if (_arg_1){
                _local_10.height = 20;
                _local_10.visible = true;
            }
            else {
                _local_10.height = 0;
                _local_10.visible = false;
            };
            _local_10.id = _arg_9;
            this.refreshFigure(_local_10, _arg_3);
            this._friendList.refreshText(_local_10, "name", !((_arg_4 == null)), _arg_4);
            this._friendList.refreshText(_local_10, "caption", !((_arg_5 == null)), _arg_5);
            this._friendList.refreshButton(_local_10, "minimail", _arg_6, this.onMinimailButtonClick, _arg_9);
            this._friendList.refreshButton(_local_10, "start_chat", _arg_7, this.onChatButtonClick, _arg_9);
            this._friendList.refreshButton(_local_10, "ask_for_friend", _arg_8, this.onAskForFriendButtonClick, _arg_9);
            return (false);
        }
        private function refreshFigure(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_3:IBitmapWrapperWindow = (_arg_1.getChildByName(HabboFriendList._SafeStr_11259) as IBitmapWrapperWindow);
            if ((((_arg_2 == null)) || ((_arg_2 == "")))){
                _local_3.visible = false;
            }
            else {
                _local_3.bitmap = this._friendList.getAvatarFaceBitmap(_arg_2);
                _local_3.width = _local_3.bitmap.width;
                _local_3.height = _local_3.bitmap.height;
                _local_3.visible = true;
            };
        }
        private function onSearchEntry(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:HabboSearchResultData;
            if (_arg_2.id < 1){
                return;
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                _local_3 = this._friendList.searchResults.getResult(_arg_2.id);
                if (_local_3 == null){
                    return;
                };
                this._SafeStr_11247.setData(_local_3.isAvatarOnline, _local_3.avatarName, _local_3.avatarMotto, _local_3.avatarFigure, _local_3.lastOnlineDate, _local_3.realName);
                this._SafeStr_11247.PopupCtrl(this._friendList.view.mainWindow, IWindowContainer(_arg_2));
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    this._SafeStr_11247.PopupCtrl();
                };
            };
        }
        private function onSearchButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.search}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log(("Search clicked: " + _arg_2.name));
            this.searchAvatar();
        }
        private function onAskForFriendButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.addfriend}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log(("Ask for friend clicked: " + _arg_2.id));
            var _local_3:HabboSearchResultData = this._friendList.searchResults.getResult(_arg_2.id);
            if (_local_3 == null){
                Logger.log(("No search result found with id: " + _arg_2.id));
                return;
            };
            Logger.log(("Search result found: " + _local_3.avatarName));
            var _local_4:Boolean = this._friendList.askForAFriend(_local_3.avatarId, _local_3.avatarName);
            if (!_local_4){
                this._friendList.showLimitReachedAlert();
            }
            else {
                this.showFriendRequestSentAlert(_local_3.avatarName);
                this.refreshEntry(true, this.findIndexFor(_local_3.avatarId), _local_3.avatarFigure, _local_3.avatarName, null, false, false, false, _local_3.avatarId);
            };
        }
        private function findIndexFor(_arg_1:int):int
        {
            var _local_2:int;
            while (_local_2 < this._content.numListItems) {
                if (this._content.getListItemAt(_local_2).id == _arg_1){
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }
        private function showFriendRequestSentAlert(_arg_1:String):void
        {
            this._friendList.registerParameter("friendlist.friendrequestsent.text", "user_name", _arg_1);
            new SimpleAlertView(this._friendList, "${friendlist.friendrequestsent.title}", "${friendlist.friendrequestsent.text}").show();
        }
        private function onMinimailButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.mail}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:HabboSearchResultData = this._friendList.searchResults.getResult(_arg_2.id);
            if (_local_3 == null){
                Logger.log(("No search result found with id: " + _arg_2.id));
                return;
            };
            var _local_4:Dictionary = new Dictionary();
            _local_4["recipientid"] = ("" + _local_3.avatarId);
            _local_4["random"] = ("" + Math.round((Math.random() * 100000000)));
            var _local_5:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (this._friendList.isEmbeddedMinimailEnabled()){
                if (ExternalInterface.available){
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", (((("#mail/compose/" + _local_4["recipientid"]) + "/") + _local_4["random"]) + "/"));
                };
            }
            else {
                this._friendList.openHabboWebPage("link.format.mail.compose", _local_4, _local_5.stageX, _local_5.stageY);
            };
        }
        private function onChatButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.im}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:HabboSearchResultData = this._friendList.searchResults.getResult(_arg_2.id);
            if (_local_3 == null){
                Logger.log(("No search result found with id: " + _arg_2.id));
                return;
            };
            this._friendList.messenger.startConversation(_local_3.avatarId);
        }
        private function onSearchInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.searchstr}");
        }
        private function onSearchStrInput(_arg_1:WindowKeyboardEvent):void
        {
            var _local_3:Keyboard;
            var _local_4:int;
            var _local_5:String;
            var _local_2:IWindow = IWindow(_arg_1.target);
            Logger.log(((((("Test key event " + _arg_1) + ", ") + _arg_1.type) + " ") + _local_2.name));
            if (_arg_1.charCode == Keyboard.ENTER){
                this.searchAvatar();
            }
            else {
                _local_4 = 25;
                _local_5 = this._searchStr.text;
                if (_local_5.length > _local_4){
                    this._searchStr.text = _local_5.substring(0, _local_4);
                };
            };
        }
        private function searchAvatar():void
        {
            var _local_1:String = this._searchStr.text;
            Logger.log(("Search avatar: " + _local_1));
            if (_local_1 == ""){
                Logger.log("No text...");
                return;
            };
            this._friendList.send(new HabboSearchMessageComposer(_local_1));
        }

    }
}//package com.sulake.habbo.friendlist

// avatarName = "_-ei" (String#23831, DoABC#2)
// avatarMotto = "_-2Ab" (String#19430, DoABC#2)
// isAvatarOnline = "_-0CQ" (String#14546, DoABC#2)
// lastOnlineDate = "_-kw" (String#24068, DoABC#2)
// refreshShading = "_-2Mr" (String#1866, DoABC#2)
// _view = "_-01Y" (String#14113, DoABC#2)
// getResult = "_-0mf" (String#15923, DoABC#2)
// isFriendRequestSent = "_-9L" (String#22593, DoABC#2)
// getRowShadingColor = "_-33K" (String#21634, DoABC#2)
// showInfo = "_-er" (String#23838, DoABC#2)
// openHabboWebPage = "_-2w" (String#7202, DoABC#2)
// fillFooter = "_-0xI" (String#4797, DoABC#2)
// fillList = "_-06y" (String#3702, DoABC#2)
// getEntryCount = "_-56" (String#7766, DoABC#2)
// tabClicked = "_-0VW" (String#4217, DoABC#2)
// laf = "_-07z" (String#14364, DoABC#2)
// showLimitReachedAlert = "_-1Mi" (String#17389, DoABC#2)
// setSearchStr = "_-Ye" (String#8386, DoABC#2)
// _searchStr = "_-2FL" (String#6350, DoABC#2)
// _SafeStr_11247 = "_-1xs" (String#1786, DoABC#2)
// searchResults = "_-1H2" (String#17153, DoABC#2)
// onSearchInput = "_-2yi" (String#21418, DoABC#2)
// onSearchStrInput = "_-1ha" (String#18193, DoABC#2)
// onSearchButtonClick = "_-0Hj" (String#3912, DoABC#2)
// getFriendsCaption = "_-2BN" (String#19459, DoABC#2)
// getOthersCaption = "_-2n5" (String#20965, DoABC#2)
// onSearchEntry = "_-JY" (String#22985, DoABC#2)
// refreshFigure = "_-1JQ" (String#846, DoABC#2)
// onMinimailButtonClick = "_-04L" (String#1396, DoABC#2)
// onChatButtonClick = "_-HJ" (String#8024, DoABC#2)
// onAskForFriendButtonClick = "_-2f2" (String#20646, DoABC#2)
// _SafeStr_11259 = "_-2en" (String#20637, DoABC#2)
// setData = "_-1x" (String#18846, DoABC#2)
// searchAvatar = "_-O6" (String#23173, DoABC#2)
// showFriendRequestSentAlert = "_-1ar" (String#17928, DoABC#2)
// findIndexFor = "_-qC" (String#24280, DoABC#2)
// isEmbeddedMinimailEnabled = "_-2F1" (String#19604, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// AvatarSearchResults = "_-2jF" (String#20813, DoABC#2)
// HabboSearchMessageComposer = "_-2Ns" (String#19959, DoABC#2)
// ITabView = "_-0HV" (String#3907, DoABC#2)
// ISearchView = "_-R" (String#8228, DoABC#2)
// SearchView = "_-1lH" (String#5772, DoABC#2)
// HabboSearchResultData = "_-1Ub" (String#5446, DoABC#2)
// AvatarPopupCtrl = "_-17v" (String#5037, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// PopupCtrl = "_-0pi" (String#16042, DoABC#2)
// PopupCtrl = "_-1eW" (String#18078, DoABC#2)
// refreshList = "_-3Kn" (String#635, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// others = "_-224" (String#19094, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// askForAFriend = "_-3Iw" (String#7688, DoABC#2)


