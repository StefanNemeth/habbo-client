
package com.sulake.habbo.friendbar.data
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IHabboFriendBarData extends IUnknown 
    {

        function get events():IEventDispatcher;
        function get numFriends():int;
        function getFriendAt(_arg_1:int):IFriendEntity;
        function getFriendByID(_arg_1:int):IFriendEntity;
        function getFriendByName(_arg_1:String):IFriendEntity;
        function get numFriendRequests():int;
        function getFriendRequestAt(_arg_1:int):FriendRequest;
        function getFriendRequestByID(_arg_1:int):FriendRequest;
        function getFriendRequestByName(_arg_1:String):FriendRequest;
        function getFriendRequestList():Array;
        function acceptFriendRequest(_arg_1:int):void;
        function acceptAllFriendRequests():void;
        function declineFriendRequest(_arg_1:int):void;
        function declineAllFriendRequests():void;
        function followToRoom(_arg_1:int):void;
        function startConversation(_arg_1:int):void;
        function findNewFriends():void;
        function toggleFriendList():void;
        function toggleMessenger():void;
        function toggleOfflineStream():void;
        function refreshOfflineStream():void;

    }
}//package com.sulake.habbo.friendbar.data

// numFriends = "_-nN" (String#8666, DoABC#2)
// getFriendAt = "_-1K4" (String#5244, DoABC#2)
// getFriendByID = "_-m3" (String#8644, DoABC#2)
// getFriendByName = "_-0QT" (String#4102, DoABC#2)
// numFriendRequests = "_-0" (String#3548, DoABC#2)
// getFriendRequestAt = "_-3-l" (String#7299, DoABC#2)
// getFriendRequestByID = "_-1LM" (String#5268, DoABC#2)
// getFriendRequestByName = "_-GP" (String#8003, DoABC#2)
// getFriendRequestList = "_-0Wl" (String#4243, DoABC#2)
// toggleFriendList = "_-tA" (String#8753, DoABC#2)
// toggleMessenger = "_-2E7" (String#1838, DoABC#2)
// toggleOfflineStream = "_-2ED" (String#6325, DoABC#2)
// refreshOfflineStream = "_-ul" (String#8779, DoABC#2)
// IHabboFriendBarData = "_-1hC" (String#5689, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)


