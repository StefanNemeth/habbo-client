
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.domain.FriendRequest;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.AcceptBuddyMessageComposer;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.DeclineBuddyMessageComposer;

    public class FriendRequestsView implements ITabView, IFriendRequestsView 
    {

        private static const _SafeStr_11232:String = "no_reqs_info";

        private var _friendList:HabboFriendList;
        private var _content:IItemListWindow;
        private var _SafeStr_11233:IContainerButtonWindow;
        private var _SafeStr_11234:IContainerButtonWindow;

        public function init(_arg_1:HabboFriendList):void
        {
            this._friendList = _arg_1;
        }
        public function getEntryCount():int
        {
            return (this._friendList.friendRequests.getCountOfOpenRequests());
        }
        public function fillFooter(_arg_1:IWindowContainer):void
        {
            this._SafeStr_11233 = IContainerButtonWindow(_arg_1.findChildByName("accept_all_but"));
            this._SafeStr_11234 = IContainerButtonWindow(_arg_1.findChildByName("reject_all_but"));
            this._SafeStr_11234.procedure = this.onDismissAllButtonClick;
            this._SafeStr_11233.procedure = this.onAcceptAllButtonClick;
            this.refreshButtons();
        }
        public function fillList(_arg_1:IItemListWindow):void
        {
            var _local_2:FriendRequest;
            this._content = _arg_1;
            for each (_local_2 in this._friendList.friendRequests.requests) {
                this.getRequestEntry(_local_2);
                this.refreshRequestEntry(_local_2);
                _arg_1.addListItem(_local_2.view);
            };
            this._friendList.friendRequests.refreshShading();
        }
        public function tabClicked(_arg_1:int):void
        {
            if (this._content == null){
                return;
            };
            this._friendList.friendRequests.clearAndUpdateView(true);
        }
        public function refreshShading(_arg_1:FriendRequest, _arg_2:Boolean):void
        {
            if (this._content == null){
                return;
            };
            _arg_1.view.color = this._friendList.laf.getRowShadingColor(FriendListTab._SafeStr_11145, _arg_2);
            this.setButtonBg(_arg_1.view, "reject");
            this.setButtonBg(_arg_1.view, "accept");
        }
        public function refreshRequestEntry(_arg_1:FriendRequest):void
        {
            if (this._content == null){
                return;
            };
            var _local_2:IWindowContainer = _arg_1.view;
            Util.hideChildren(_local_2);
            this._friendList.refreshText(_local_2, "requester_name_text", true, _arg_1.requesterName);
            if (_arg_1.state == FriendRequest._SafeStr_7173){
                this._friendList.refreshIcon(_local_2, "accept", true, this.onAcceptButtonClick, _arg_1.requestId);
                this._friendList.refreshIcon(_local_2, "reject", true, this.onDeclineButtonClick, _arg_1.requestId);
            }
            else {
                if (_arg_1.state == FriendRequest._SafeStr_11184){
                    this._friendList.refreshText(_local_2, "info_text", true, "${friendlist.request.accepted}");
                }
                else {
                    if (_arg_1.state == FriendRequest._SafeStr_11185){
                        this._friendList.refreshText(_local_2, "info_text", true, "${friendlist.request.declined}");
                    }
                    else {
                        if (_arg_1.state == FriendRequest._state){
                            this._friendList.refreshText(_local_2, "info_text", true, "${friendlist.request.failed}");
                        };
                    };
                };
            };
        }
        private function setButtonBg(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_3:IWindow = _arg_1.findChildByName(_arg_2);
            if (_local_3 != null){
                _local_3.color = _arg_1.color;
            };
        }
        public function addRequest(_arg_1:FriendRequest):void
        {
            if (this._content == null){
                return;
            };
            this.getRequestEntry(_arg_1);
            this.refreshRequestEntry(_arg_1);
            this._content.addListItem(_arg_1.view);
            this._friendList.friendRequests.refreshShading();
            this.refreshButtons();
        }
        public function removeRequest(_arg_1:FriendRequest):void
        {
            if (this._content == null){
                return;
            };
            this._content.removeListItem(_arg_1.view);
            this.refreshButtons();
        }
        private function getRequestEntry(_arg_1:FriendRequest):void
        {
            var _local_2:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow("friend_request_entry"));
            _arg_1.view = _local_2;
        }
        private function onAcceptButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.accept}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = _arg_2.id;
            Logger.log(("accept clicked: " + _local_3));
            this.acceptRequest(_local_3);
        }
        public function acceptRequest(_arg_1:int):void
        {
            var _local_2:FriendRequest = this._friendList.friendRequests.getRequest(_arg_1);
            if (!_local_2){
                return;
            };
            _local_2.state = FriendRequest._SafeStr_11184;
            if (this._friendList.categories.getFriendCount(false) >= this._friendList.friendRequests.limit){
                this._friendList.showLimitReachedAlert();
                return;
            };
            var _local_3:AcceptBuddyMessageComposer = new AcceptBuddyMessageComposer();
            _local_3.addAcceptedRequest(_local_2.requestId);
            this._friendList.send(_local_3);
            this.refreshRequestEntry(_local_2);
            this.refresh();
            if (((this._friendList) && (this._friendList.events))){
                this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.RWDE_ACCEPTED, _arg_1));
            };
        }
        public function acceptAllRequests():void
        {
            var _local_2:FriendRequest;
            if ((this._friendList.categories.getFriendCount(false) + this._friendList.friendRequests.requests.length) > this._friendList.friendRequests.limit){
                this._friendList.showLimitReachedAlert();
                return;
            };
            var _local_1:AcceptBuddyMessageComposer = new AcceptBuddyMessageComposer();
            for each (_local_2 in this._friendList.friendRequests.requests) {
                if (((!((_local_2.state == FriendRequest._SafeStr_11184))) && (!((_local_2.state == FriendRequest._SafeStr_11185))))){
                    _local_1.addAcceptedRequest(_local_2.requestId);
                    _local_2.state = FriendRequest._SafeStr_11184;
                    this.refreshRequestEntry(_local_2);
                    if (((this._friendList) && (this._friendList.events))){
                        this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.RWDE_ACCEPTED, _local_2.requestId));
                    };
                };
            };
            this._friendList.send(_local_1);
            this.refresh();
        }
        private function onDeclineButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.decline}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = _arg_2.id;
            Logger.log(("decline clicked: " + _local_3));
            this.declineRequest(_local_3);
        }
        public function declineRequest(_arg_1:int):void
        {
            var _local_2:FriendRequest = this._friendList.friendRequests.getRequest(_arg_1);
            if (!_local_2){
                return;
            };
            _local_2.state = FriendRequest._SafeStr_11185;
            var _local_3:DeclineBuddyMessageComposer = new DeclineBuddyMessageComposer();
            _local_3.addDeclinedRequest(_arg_1);
            this._friendList.send(_local_3);
            this.refreshRequestEntry(_local_2);
            this.refresh();
            if (((this._friendList) && (this._friendList.events))){
                this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.FRE_DECLINED, _arg_1));
            };
        }
        public function declineAllRequests():void
        {
            var _local_2:FriendRequest;
            var _local_1:DeclineBuddyMessageComposer = new DeclineBuddyMessageComposer();
            this._friendList.send(_local_1);
            for each (_local_2 in this._friendList.friendRequests.requests) {
                if (((!((_local_2.state == FriendRequest._SafeStr_11184))) && (!((_local_2.state == FriendRequest._SafeStr_11185))))){
                    _local_2.state = FriendRequest._SafeStr_11185;
                    this.refreshRequestEntry(_local_2);
                    if (((this._friendList) && (this._friendList.events))){
                        this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.FRE_DECLINED, _local_2.requestId));
                    };
                };
            };
            this.refresh();
        }
        private function onDismissAllButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.declineall}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Dismiss all clicked");
            this.declineAllRequests();
        }
        private function onAcceptAllButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            this._friendList.view.showInfo(_arg_1, "${friendlist.tip.acceptall}");
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Accept all clicked");
            this.acceptAllRequests();
        }
        private function refresh():void
        {
            this.refreshButtons();
        }
        private function refreshButtons():void
        {
            var _local_1 = (this._friendList.friendRequests.getCountOfOpenRequests() > 0);
            this.setEnabled(this._SafeStr_11233, _local_1);
            this.setEnabled(this._SafeStr_11234, _local_1);
        }
        private function setEnabled(_arg_1:IContainerButtonWindow, _arg_2:Boolean):void
        {
            if (!_arg_1){
                return;
            };
            if (_arg_2){
                _arg_1.enable();
            }
            else {
                _arg_1.disable();
            };
        }

    }
}//package com.sulake.habbo.friendlist

// clearAndUpdateView = "_-3Bm" (String#21952, DoABC#2)
// refreshShading = "_-2Mr" (String#1866, DoABC#2)
// _state = "_-1f4" (String#18101, DoABC#2)
// refreshRequestEntry = "_-3KJ" (String#7711, DoABC#2)
// getRequest = "_-365" (String#21732, DoABC#2)
// getCountOfOpenRequests = "_-2Kr" (String#19839, DoABC#2)
// _SafeStr_11145 = "_-1wt" (String#18841, DoABC#2)
// getFriendCount = "_-1oZ" (String#5833, DoABC#2)
// _SafeStr_11184 = "_-1pF" (String#18511, DoABC#2)
// _SafeStr_11185 = "_-2Nc" (String#19949, DoABC#2)
// acceptAllRequests = "_-3H1" (String#7647, DoABC#2)
// declineAllRequests = "_-0hJ" (String#4453, DoABC#2)
// getRowShadingColor = "_-33K" (String#21634, DoABC#2)
// showInfo = "_-er" (String#23838, DoABC#2)
// fillFooter = "_-0xI" (String#4797, DoABC#2)
// fillList = "_-06y" (String#3702, DoABC#2)
// getEntryCount = "_-56" (String#7766, DoABC#2)
// tabClicked = "_-0VW" (String#4217, DoABC#2)
// _SafeStr_11232 = "_-2k4" (String#20849, DoABC#2)
// _SafeStr_11233 = "_-2Gt" (String#19678, DoABC#2)
// _SafeStr_11234 = "_-3s" (String#22370, DoABC#2)
// friendRequests = "_-cP" (String#23730, DoABC#2)
// onDismissAllButtonClick = "_-1yW" (String#18910, DoABC#2)
// onAcceptAllButtonClick = "_-0Zl" (String#15434, DoABC#2)
// getRequestEntry = "_-1PA" (String#17475, DoABC#2)
// laf = "_-07z" (String#14364, DoABC#2)
// setButtonBg = "_-30j" (String#21529, DoABC#2)
// refreshIcon = "_-3EX" (String#7603, DoABC#2)
// onAcceptButtonClick = "_-2rN" (String#21133, DoABC#2)
// onDeclineButtonClick = "_-22F" (String#19101, DoABC#2)
// showLimitReachedAlert = "_-1Mi" (String#17389, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// IFriendRequestsView = "_-0Uk" (String#4198, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// FriendRequestEvent = "_-1SF" (String#17590, DoABC#2)
// DeclineBuddyMessageComposer = "_-jt" (String#24030, DoABC#2)
// AcceptBuddyMessageComposer = "_-3-o" (String#21493, DoABC#2)
// ITabView = "_-0HV" (String#3907, DoABC#2)
// FriendRequestsView = "_-1iw" (String#5733, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// FRE_DECLINED = "_-2IY" (String#19749, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// addDeclinedRequest = "_-0Pt" (String#15057, DoABC#2)
// addAcceptedRequest = "_-5v" (String#22461, DoABC#2)
// addRequest = "_-2i" (String#1927, DoABC#2)
// removeRequest = "_-1qi" (String#1769, DoABC#2)
// acceptRequest = "_-3CU" (String#7565, DoABC#2)
// declineRequest = "_-1A2" (String#5078, DoABC#2)
// setEnabled = "_-05S" (String#1399, DoABC#2)
// requesterName = "_-1ki" (String#18318, DoABC#2)
// _SafeStr_7173 = "_-bS" (String#23691, DoABC#2)
// refreshButtons = "_-1ep" (String#859, DoABC#2)


