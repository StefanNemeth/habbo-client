
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;

    public interface ITabView 
    {

        function init(_arg_1:HabboFriendList):void;
        function fillFooter(_arg_1:IWindowContainer):void;
        function fillList(_arg_1:IItemListWindow):void;
        function getEntryCount():int;
        function tabClicked(_arg_1:int):void;

    }
}//package com.sulake.habbo.friendlist

// fillFooter = "_-0xI" (String#4797, DoABC#2)
// fillList = "_-06y" (String#3702, DoABC#2)
// getEntryCount = "_-56" (String#7766, DoABC#2)
// tabClicked = "_-0VW" (String#4217, DoABC#2)
// ITabView = "_-0HV" (String#3907, DoABC#2)


