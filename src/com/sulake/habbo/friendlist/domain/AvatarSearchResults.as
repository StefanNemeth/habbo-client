
package com.sulake.habbo.friendlist.domain
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;

    public class AvatarSearchResults 
    {

        private var _SafeStr_4674:IAvatarSearchDeps;
        private var _friends:Array;
        private var _others:Array;
        private var _SafeStr_11166:Dictionary;

        public function AvatarSearchResults(_arg_1:IAvatarSearchDeps)
        {
            this._SafeStr_11166 = new Dictionary();
            super();
            this._SafeStr_4674 = _arg_1;
        }
        public function getResult(_arg_1:int):HabboSearchResultData
        {
            var _local_2:HabboSearchResultData;
            var _local_3:HabboSearchResultData;
            for each (_local_2 in this._friends) {
                if (_local_2.avatarId == _arg_1){
                    return (_local_2);
                };
            };
            for each (_local_3 in this._others) {
                if (_local_3.avatarId == _arg_1){
                    return (_local_3);
                };
            };
            return (null);
        }
        public function searchReceived(_arg_1:Array, _arg_2:Array):void
        {
            this._friends = _arg_1;
            this._others = _arg_2;
            this._SafeStr_4674.view.refreshList();
        }
        public function get friends():Array
        {
            return (this._friends);
        }
        public function get others():Array
        {
            return (this._others);
        }
        public function setFriendRequestSent(_arg_1:int):void
        {
            this._SafeStr_11166[_arg_1] = "yes";
        }
        public function isFriendRequestSent(_arg_1:int):Boolean
        {
            return (!((this._SafeStr_11166[_arg_1] == null)));
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _SafeStr_11166 = "_-2cH" (String#20535, DoABC#2)
// getResult = "_-0mf" (String#15923, DoABC#2)
// searchReceived = "_-39d" (String#21867, DoABC#2)
// setFriendRequestSent = "_-1kf" (String#18315, DoABC#2)
// isFriendRequestSent = "_-9L" (String#22593, DoABC#2)
// AvatarSearchResults = "_-2jF" (String#20813, DoABC#2)
// IAvatarSearchDeps = "_-1OU" (String#5324, DoABC#2)
// HabboSearchResultData = "_-1Ub" (String#5446, DoABC#2)
// refreshList = "_-3Kn" (String#635, DoABC#2)
// _friends = "_-02K" (String#576, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// _others = "_-5r" (String#7778, DoABC#2)
// others = "_-224" (String#19094, DoABC#2)
// _SafeStr_4674 = "_-2UU" (String#620, DoABC#2)


