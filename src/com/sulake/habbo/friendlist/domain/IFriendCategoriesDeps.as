
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.IFriendsView;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.notifications.IHabboNotifications;

    public interface IFriendCategoriesDeps 
    {

        function get view():IFriendsView;
        function get messenger():IHabboMessenger;
        function get notifications():IHabboNotifications;

    }
}//package com.sulake.habbo.friendlist.domain

// notifications = "_-1zJ" (String#1789, DoABC#2)
// IFriendCategoriesDeps = "_-32N" (String#7354, DoABC#2)
// IHabboNotifications = "_-0uT" (String#4734, DoABC#2)
// IFriendsView = "_-0TY" (String#4169, DoABC#2)
// IHabboMessenger = "_-0EF" (String#3832, DoABC#2)


