
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;

    public class FriendListTabsDeps implements IFriendListTabsDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendListTabsDeps(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
        }
        public function getFriendList():HabboFriendList
        {
            return (this._friendList);
        }
        public function getWindowHeight():int
        {
            return (this._friendList.view.mainWindow.height);
        }

    }
}//package com.sulake.habbo.friendlist.domain

// getFriendList = "_-xG" (String#8830, DoABC#2)
// getWindowHeight = "_-2R9" (String#6583, DoABC#2)
// IFriendListTabsDeps = "_-Re" (String#8240, DoABC#2)
// FriendListTabsDeps = "_-2Nu" (String#6519, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)


