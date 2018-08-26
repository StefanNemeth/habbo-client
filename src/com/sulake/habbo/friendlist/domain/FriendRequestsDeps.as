
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.habbo.friendlist.IFriendRequestsView;

    public class FriendRequestsDeps implements IFriendRequestsDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendRequestsDeps(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
        }
        public function get view():IFriendRequestsView
        {
            return ((this._friendList.tabs.findTab(FriendListTab._SafeStr_11145).tabView as IFriendRequestsView));
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _SafeStr_11145 = "_-1wt" (String#18841, DoABC#2)
// tabView = "_-1CV" (String#16966, DoABC#2)
// findTab = "_-055" (String#14246, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// IFriendRequestsDeps = "_-0Tc" (String#4171, DoABC#2)
// FriendRequestsDeps = "_-0JU" (String#3943, DoABC#2)
// IFriendRequestsView = "_-0Uk" (String#4198, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)


