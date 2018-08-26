
package com.sulake.habbo.friendlist.domain
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.friendlist.Util;
    import com.sulake.habbo.communication.messages.incoming.friendlist.*;
    import com.sulake.habbo.communication.messages.parser.friendlist.*;

    public class FriendCategories 
    {

        private var _SafeStr_4674:IFriendCategoriesDeps;
        private var _categories:Array;
        private var _friendsById:Dictionary;

        public function FriendCategories(_arg_1:IFriendCategoriesDeps)
        {
            this._categories = new Array();
            this._friendsById = new Dictionary();
            super();
            this._SafeStr_4674 = _arg_1;
        }
        public function addFriend(_arg_1:Friend):FriendCategory
        {
            var _local_2:int = ((_arg_1.online) ? _arg_1.categoryId : FriendCategory._SafeStr_11173);
            var _local_3:FriendCategory = this.findCategory(_local_2);
            if (_local_3 != null){
                _local_3.addFriend(_arg_1);
                this._friendsById[_arg_1.id] = _arg_1;
                return (_local_3);
            };
            Logger.log((((("No category " + _local_2) + " found for friend ") + _arg_1.id) + ". Ignoring"));
            return (null);
        }
        public function getSelectedFriends():Array
        {
            var _local_2:FriendCategory;
            var _local_1:Array = new Array();
            for each (_local_2 in this._categories) {
                _local_2.getSelectedFriends(_local_1);
            };
            return (_local_1);
        }
        public function getSelectedFriend():Friend
        {
            var _local_1:Array = this.getSelectedFriends();
            return ((((_local_1.length == 1)) ? _local_1[0] : null));
        }
        public function getAllFriends():Dictionary
        {
            return (this._friendsById);
        }
        public function getFriendCount(_arg_1:Boolean, _arg_2:Boolean=false):int
        {
            var _local_4:FriendCategory;
            var _local_3:int;
            for each (_local_4 in this._categories) {
                _local_3 = (_local_3 + _local_4.getFriendCount(_arg_1, _arg_2));
            };
            return (_local_3);
        }
        public function getCategories():Array
        {
            return (this._categories);
        }
        public function addCategory(_arg_1:FriendCategory):void
        {
            this._categories.push(_arg_1);
        }
        public function findFriend(_arg_1:int):Friend
        {
            return (this._friendsById[_arg_1]);
        }
        public function findCategory(_arg_1:int):FriendCategory
        {
            var _local_2:FriendCategory;
            for each (_local_2 in this._categories) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function onFriendListUpdate(event:IMessageEvent):void
        {
            var status:int;
            var p:FriendListUpdateMessageParser;
            var removedFriendId:int;
            var updatedFriend:FriendData;
            var addedFriend:FriendData;
            var currentlyOnline:Boolean;
            var wasSelected:Boolean;
            var friend:Friend;
            Logger.log("Received friend list update");
            status = 0;
            try {
                p = (event as FriendListUpdateEvent).getParser();
                status = 1;
                this.updateCategories(p.cats);
                status = 2;
                for each (removedFriendId in p.removedFriendIds) {
                    this.removeFriend(removedFriendId, true);
                };
                status = 3;
                for each (updatedFriend in p.updatedFriends) {
                    Logger.log(((((((("Got UPDATE: " + updatedFriend.id) + ", ") + updatedFriend.online) + ", ") + updatedFriend.name) + ", ") + updatedFriend.followingAllowed));
                    this._SafeStr_4674.messenger.setFollowingAllowed(updatedFriend.id, ((updatedFriend.followingAllowed) && (updatedFriend.online)));
                    currentlyOnline = this.isFriendOnline(updatedFriend.id);
                    if (((currentlyOnline) && (!(updatedFriend.online)))){
                        this._SafeStr_4674.messenger.setOnlineStatus(updatedFriend.id, updatedFriend.online);
                    };
                    if (((!(currentlyOnline)) && (updatedFriend.online))){
                        this._SafeStr_4674.messenger.setOnlineStatus(updatedFriend.id, updatedFriend.online);
                        this._SafeStr_4674.view.setNewMessageArrived();
                    };
                    wasSelected = this.removeFriend(updatedFriend.id, true);
                    friend = new Friend(updatedFriend);
                    friend.selected = wasSelected;
                    this.addFriend(friend);
                };
                status = 4;
                for each (addedFriend in p.addedFriends) {
                    Logger.log(((("Got INSERT: " + addedFriend.id) + ", ") + addedFriend.name));
                    this.removeFriend(addedFriend.id, true);
                    this.addFriend(new Friend(addedFriend));
                };
                status = 5;
                this._SafeStr_4674.view.refreshList();
                status = 6;
            }
            catch(e:Error) {
                ErrorReportStorage.addDebugData("FriendCategories", (("onFriendListUpdate crashed, status = " + String(status)) + "!"));
                throw (e);
            };
        }
        private function updateCategories(_arg_1:Array):void
        {
            var _local_2:FriendCategoryData;
            var _local_3:FriendCategory;
            var _local_4:FriendCategory;
            var _local_5:FriendCategory;
            this.flushReceivedStatus();
            this.findCategory(FriendCategory._SafeStr_11173).received = true;
            this.findCategory(FriendCategory._SafeStr_11172).received = true;
            for each (_local_2 in _arg_1) {
                _local_4 = this.findCategory(_local_2.id);
                if (_local_4 != null){
                    _local_4.received = true;
                    if (_local_4.name != _local_2.name){
                        _local_4.name = _local_2.name;
                    };
                }
                else {
                    _local_5 = new FriendCategory(_local_2.id, _local_2.name);
                    _local_5.received = true;
                    this.addCategory(_local_5);
                };
            };
            for each (_local_3 in this.getCategoriesNotReceived()) {
                if (_local_3.friends.length <= 0){
                    Util.remove(this._categories, _local_3);
                    _local_3.dispose();
                };
            };
        }
        private function removeFriend(_arg_1:int, _arg_2:Boolean):Boolean
        {
            var _local_4:FriendCategory;
            var _local_5:Friend;
            if (_arg_2){
                this._friendsById[_arg_1] = null;
            };
            var _local_3:Boolean;
            for each (_local_4 in this._categories) {
                _local_5 = _local_4.removeFriend(_arg_1);
                if (_local_5 != null){
                    _local_3 = _local_5.selected;
                    if (_arg_2){
                        _local_5.dispose();
                    };
                };
            };
            return (_local_3);
        }
        private function flushReceivedStatus():void
        {
            var _local_1:FriendCategory;
            for each (_local_1 in this._categories) {
                _local_1.received = false;
            };
        }
        private function getCategoriesNotReceived():Array
        {
            var _local_2:FriendCategory;
            var _local_1:Array = new Array();
            for each (_local_2 in this._categories) {
                if (!_local_2.received){
                    _local_1.push(_local_2);
                };
            };
            return (_local_1);
        }
        private function isFriendOnline(_arg_1:int):Boolean
        {
            var _local_2:Friend = this.findFriend(_arg_1);
            return ((((_local_2 == null)) ? false : _local_2.online));
        }
        public function HabboFriendList():Array
        {
            var _local_2:Friend;
            if (this._friendsById == null){
                return ([]);
            };
            var _local_1:Array = [];
            for each (_local_2 in this._friendsById) {
                if (_local_2 != null){
                    _local_1.push(_local_2.name);
                };
            };
            return (_local_1);
        }

    }
}//package com.sulake.habbo.friendlist.domain

// onFriendListUpdate = "_-2UT" (String#1887, DoABC#2)
// _SafeStr_11172 = "_-0UQ" (String#15220, DoABC#2)
// _SafeStr_11173 = "_-2kn" (String#20876, DoABC#2)
// getFriendCount = "_-1oZ" (String#5833, DoABC#2)
// removeFriend = "_-39O" (String#7499, DoABC#2)
// received = "_-3HA" (String#22170, DoABC#2)
// getSelectedFriend = "_-1GY" (String#17136, DoABC#2)
// getAllFriends = "_-An" (String#22647, DoABC#2)
// addCategory = "_-2MM" (String#19899, DoABC#2)
// findFriend = "_-1KM" (String#17288, DoABC#2)
// updateCategories = "_-1NY" (String#17419, DoABC#2)
// setFollowingAllowed = "_-32S" (String#7358, DoABC#2)
// isFriendOnline = "_-206" (String#19015, DoABC#2)
// setOnlineStatus = "_-0QG" (String#4097, DoABC#2)
// flushReceivedStatus = "_-0bp" (String#15505, DoABC#2)
// getCategoriesNotReceived = "_-0S0" (String#15137, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// IFriendCategoriesDeps = "_-32N" (String#7354, DoABC#2)
// FriendCategoryData = "_-1Pd" (String#5346, DoABC#2)
// FriendCategory = "_-3FV" (String#7619, DoABC#2)
// FriendData = "_-XR" (String#23541, DoABC#2)
// FriendListUpdateEvent = "_-l9" (String#8629, DoABC#2)
// FriendListUpdateMessageParser = "_-1B-" (String#5094, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// refreshList = "_-3Kn" (String#635, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// cats = "_-fa" (String#23869, DoABC#2)
// removedFriendIds = "_-27p" (String#19323, DoABC#2)
// addedFriends = "_-1B0" (String#16900, DoABC#2)
// updatedFriends = "_-D2" (String#22729, DoABC#2)
// _SafeStr_4674 = "_-2UU" (String#620, DoABC#2)
// setNewMessageArrived = "_-0rH" (String#4668, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// getCategories = "_-3E" (String#22033, DoABC#2)
// HabboFriendList = "_-3BP" (String#7538, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)


