
package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;

    public interface IHabboFriendList extends IUnknown 
    {

        function get events():IEventDispatcher;
        function canBeAskedForAFriend(_arg_1:int):Boolean;
        function askForAFriend(_arg_1:int, _arg_2:String):Boolean;
        function getFriend(_arg_1:int):IFriend;
        function openFriendList():void;
        function openFriendRequests():void;
        function openFriendSearch():void;
        function close():void;
        function IssueBrowser():Boolean;
        function getFriendCount(_arg_1:Boolean, _arg_2:Boolean):int;
        function openHabboWebPage(_arg_1:String, _arg_2:Dictionary, _arg_3:int, _arg_4:int):void;
        function HabboFriendList():Array;
        function acceptFriendRequest(_arg_1:int):void;
        function acceptAllFriendRequests():void;
        function declineFriendRequest(_arg_1:int):void;
        function declineAllFriendRequests():void;
        function get mainWindow():IWindowContainer;

    }
}//package com.sulake.habbo.friendlist

// openFriendRequests = "_-20l" (String#6059, DoABC#2)
// getFriendCount = "_-1oZ" (String#5833, DoABC#2)
// openHabboWebPage = "_-2w" (String#7202, DoABC#2)
// openFriendSearch = "_-yV" (String#8846, DoABC#2)
// IFriend = "_-2ET" (String#6332, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// HabboFriendList = "_-3BP" (String#7538, DoABC#2)
// askForAFriend = "_-3Iw" (String#7688, DoABC#2)
// canBeAskedForAFriend = "_-di" (String#8480, DoABC#2)
// getFriend = "_-WG" (String#8329, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)


