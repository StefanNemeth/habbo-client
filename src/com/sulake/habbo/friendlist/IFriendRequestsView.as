
package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.FriendRequest;

    public interface IFriendRequestsView 
    {

        function refreshShading(_arg_1:FriendRequest, _arg_2:Boolean):void;
        function refreshRequestEntry(_arg_1:FriendRequest):void;
        function addRequest(_arg_1:FriendRequest):void;
        function removeRequest(_arg_1:FriendRequest):void;
        function acceptRequest(_arg_1:int):void;
        function acceptAllRequests():void;
        function declineRequest(_arg_1:int):void;
        function declineAllRequests():void;

    }
}//package com.sulake.habbo.friendlist

// refreshShading = "_-2Mr" (String#1866, DoABC#2)
// refreshRequestEntry = "_-3KJ" (String#7711, DoABC#2)
// acceptAllRequests = "_-3H1" (String#7647, DoABC#2)
// declineAllRequests = "_-0hJ" (String#4453, DoABC#2)
// IFriendRequestsView = "_-0Uk" (String#4198, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// addRequest = "_-2i" (String#1927, DoABC#2)
// removeRequest = "_-1qi" (String#1769, DoABC#2)
// acceptRequest = "_-3CU" (String#7565, DoABC#2)
// declineRequest = "_-1A2" (String#5078, DoABC#2)


