
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.habbo.friendlist.IFriendsView;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.notifications.IHabboNotifications;

    public class FriendCategoriesDeps implements IFriendCategoriesDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendCategoriesDeps(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
        }
        public function get view():IFriendsView
        {
            return ((this._friendList.tabs.findTab(FriendListTab._SafeStr_11144).tabView as IFriendsView));
        }
        public function get messenger():IHabboMessenger
        {
            return (this._friendList.messenger);
        }
        public function get notifications():IHabboNotifications
        {
            return (this._friendList.notifications);
        }

    }
}//package com.sulake.habbo.friendlist.domain

// notifications = "_-1zJ" (String#1789, DoABC#2)
// _SafeStr_11144 = "_-0De" (String#14594, DoABC#2)
// tabView = "_-1CV" (String#16966, DoABC#2)
// findTab = "_-055" (String#14246, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// IFriendCategoriesDeps = "_-32N" (String#7354, DoABC#2)
// FriendCategoriesDeps = "_-1Vp" (String#5469, DoABC#2)
// IHabboNotifications = "_-0uT" (String#4734, DoABC#2)
// IFriendsView = "_-0TY" (String#4169, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// IHabboMessenger = "_-0EF" (String#3832, DoABC#2)


