
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.habbo.friendlist.ISearchView;

    public class AvatarSearchDeps implements IAvatarSearchDeps 
    {

        private var _friendList:HabboFriendList;

        public function AvatarSearchDeps(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
        }
        public function get view():ISearchView
        {
            return ((this._friendList.tabs.findTab(FriendListTab._view).tabView as ISearchView));
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _view = "_-01Y" (String#14113, DoABC#2)
// tabView = "_-1CV" (String#16966, DoABC#2)
// findTab = "_-055" (String#14246, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// IAvatarSearchDeps = "_-1OU" (String#5324, DoABC#2)
// AvatarSearchDeps = "_-yr" (String#8857, DoABC#2)
// ISearchView = "_-R" (String#8228, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)


