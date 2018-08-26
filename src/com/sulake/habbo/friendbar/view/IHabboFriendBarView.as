
package com.sulake.habbo.friendbar.view
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.friendbar.view.tabs.ITab;
    import flash.display.BitmapData;

    public interface IHabboFriendBarView extends IUnknown 
    {

        function set visible(_arg_1:Boolean):void;
        function get visible():Boolean;
        function selectTab(_arg_1:ITab, _arg_2:Boolean):void;
        function deSelect(_arg_1:Boolean):void;
        function getAvatarFaceBitmap(_arg_1:String):BitmapData;
        function setMessengerIconNotify(_arg_1:Boolean):void;
        function setFriendListIconNotify(_arg_1:Boolean):void;
        function setStreamIconNotify(_arg_1:Boolean):void;
        function refreshEventStream():void;

    }
}//package com.sulake.habbo.friendbar.view

// refreshEventStream = "_-1Zw" (String#1711, DoABC#2)
// setStreamIconNotify = "_-0YR" (String#4272, DoABC#2)
// selectTab = "_-F0" (String#2077, DoABC#2)
// setFriendListIconNotify = "_-pG" (String#8696, DoABC#2)
// IHabboFriendBarView = "_-0n8" (String#4571, DoABC#2)


