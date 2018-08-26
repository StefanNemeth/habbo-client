
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.FriendsView;
    import com.sulake.habbo.friendlist.FriendRequestsView;
    import com.sulake.habbo.friendlist.SearchView;
    import com.sulake.habbo.friendlist.*;

    public class FriendListTabs 
    {

        private var _SafeStr_4674:IFriendListTabsDeps;
        private var _tabs:Array;
        private var _SafeStr_11152:FriendListTab;
        private var _tabContentHeight:int = 200;
        private var _SafeStr_11154:int = 200;
        private var _windowWidth:int = 200;

        public function FriendListTabs(_arg_1:IFriendListTabsDeps)
        {
            this._tabs = new Array();
            super();
            this._SafeStr_4674 = _arg_1;
            this._tabs.push(new FriendListTab(this._SafeStr_4674.getFriendList(), FriendListTab._SafeStr_11144, new FriendsView(), "${friendlist.friends}", "friends_footer", "hdr_friends"));
            this._tabs.push(new FriendListTab(this._SafeStr_4674.getFriendList(), FriendListTab._SafeStr_11145, new FriendRequestsView(), "${friendlist.tab.friendrequests}", "friend_requests_footer", "hdr_friend_requests"));
            this._tabs.push(new FriendListTab(this._SafeStr_4674.getFriendList(), FriendListTab._view, new SearchView(), "${generic.search}", "search_footer", "hdr_search"));
            this.toggleSelected(null);
        }
        public function getTabs():Array
        {
            return (this._tabs);
        }
        public function findTab(_arg_1:int):FriendListTab
        {
            var _local_2:FriendListTab;
            for each (_local_2 in this._tabs) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function clearSelections():void
        {
            var _local_1:FriendListTab;
            for each (_local_1 in this._tabs) {
                _local_1.setSelected(false);
            };
        }
        public function findSelectedTab():FriendListTab
        {
            var _local_1:FriendListTab;
            for each (_local_1 in this._tabs) {
                if (_local_1.selected){
                    return (_local_1);
                };
            };
            return (null);
        }
        public function toggleSelected(_arg_1:FriendListTab):void
        {
            var _local_2:FriendListTab = this.findSelectedTab();
            if (_local_2 == null){
                this._tabContentHeight = this._SafeStr_11154;
                this.setSelected(this.determineDisplayedTab(_arg_1), true);
            }
            else {
                if ((((_local_2 == _arg_1)) || ((_arg_1 == null)))){
                    this._SafeStr_11154 = this._tabContentHeight;
                    this._tabContentHeight = 0;
                    this.clearSelections();
                }
                else {
                    this.setSelected(this.determineDisplayedTab(_arg_1), true);
                };
            };
        }
        private function setSelected(_arg_1:FriendListTab, _arg_2:Boolean):void
        {
            var _local_3:FriendListTab = this.findSelectedTab();
            this.clearSelections();
            _arg_1.setSelected(_arg_2);
            if (_arg_2){
                this._SafeStr_11152 = _arg_1;
            };
        }
        private function determineDisplayedTab(_arg_1:FriendListTab):FriendListTab
        {
            if (_arg_1 != null){
                return (_arg_1);
            };
            if (this._SafeStr_11152 != null){
                return (this._SafeStr_11152);
            };
            return (this._tabs[0]);
        }
        public function get tabContentHeight():int
        {
            return (this._tabContentHeight);
        }
        public function get windowWidth():int
        {
            return (this._windowWidth);
        }
        public function get tabContentWidth():int
        {
            return ((this._windowWidth - 2));
        }
        public function set tabContentHeight(_arg_1:int):void
        {
            this._tabContentHeight = _arg_1;
        }
        public function set windowWidth(_arg_1:int):void
        {
            this._windowWidth = _arg_1;
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _SafeStr_11144 = "_-0De" (String#14594, DoABC#2)
// _SafeStr_11145 = "_-1wt" (String#18841, DoABC#2)
// _view = "_-01Y" (String#14113, DoABC#2)
// _SafeStr_11152 = "_-2N2" (String#19927, DoABC#2)
// _tabContentHeight = "_-yZ" (String#24637, DoABC#2)
// _SafeStr_11154 = "_-2TV" (String#20181, DoABC#2)
// _windowWidth = "_-0pt" (String#16048, DoABC#2)
// getFriendList = "_-xG" (String#8830, DoABC#2)
// toggleSelected = "_-0OB" (String#14995, DoABC#2)
// getTabs = "_-qn" (String#24306, DoABC#2)
// findTab = "_-055" (String#14246, DoABC#2)
// findSelectedTab = "_-3KI" (String#22294, DoABC#2)
// determineDisplayedTab = "_-1mR" (String#18397, DoABC#2)
// tabContentHeight = "_-18K" (String#16788, DoABC#2)
// windowWidth = "_-gY" (String#23914, DoABC#2)
// tabContentWidth = "_-2BS" (String#19463, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// FriendListTabs = "_-2a0" (String#6759, DoABC#2)
// IFriendListTabsDeps = "_-Re" (String#8240, DoABC#2)
// FriendRequestsView = "_-1iw" (String#5733, DoABC#2)
// SearchView = "_-1lH" (String#5772, DoABC#2)
// _SafeStr_4674 = "_-2UU" (String#620, DoABC#2)
// clearSelections = "_-2cc" (String#6803, DoABC#2)
// _tabs = "_-0QO" (String#585, DoABC#2)


