
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.IIterable;

    public interface IItemListWindow extends IWindow, IScrollableWindow, IIterable 
    {

        function get spacing():int;
        function set spacing(_arg_1:int):void;
        function get scaleToFitItems():Boolean;
        function set scaleToFitItems(_arg_1:Boolean):void;
        function get autoArrangeItems():Boolean;
        function set autoArrangeItems(_arg_1:Boolean):void;
        function get resizeOnItemUpdate():Boolean;
        function set resizeOnItemUpdate(_arg_1:Boolean):void;
        function get numListItems():int;
        function addListItem(_arg_1:IWindow):IWindow;
        function addListItemAt(_arg_1:IWindow, _arg_2:uint):IWindow;
        function getListItemAt(_arg_1:uint):IWindow;
        function getListItemByID(_arg_1:uint):IWindow;
        function getListItemByName(_arg_1:String):IWindow;
        function getListItemByTag(_arg_1:String):IWindow;
        function getListItemIndex(_arg_1:IWindow):int;
        function removeListItem(_arg_1:IWindow):IWindow;
        function removeListItemAt(_arg_1:int):IWindow;
        function setListItemIndex(_arg_1:IWindow, _arg_2:int):void;
        function swapListItems(_arg_1:IWindow, _arg_2:IWindow):void;
        function groupListItemsWithID(_arg_1:uint, _arg_2:Array, _arg_3:Boolean=false):uint;
        function groupListItemsWithTag(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):uint;
        function swapListItemsAt(_arg_1:int, _arg_2:int):void;
        function removeListItems():void;
        function destroyListItems():void;
        function arrangeListItems():void;
        function populate(_arg_1:Array):void;

    }
}//package com.sulake.core.window.components

// IIterable = "_-2BO" (String#6275, DoABC#2)
// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// addListItemAt = "_-2CT" (String#6293, DoABC#2)
// destroyListItems = "_-0xF" (String#4796, DoABC#2)
// removeListItems = "_-aG" (String#8425, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// groupListItemsWithTag = "_-0gQ" (String#4432, DoABC#2)
// removeListItemAt = "_-Td" (String#8279, DoABC#2)
// resizeOnItemUpdate = "_-2es" (String#6849, DoABC#2)
// scaleToFitItems = "_-Xo" (String#8364, DoABC#2)
// getListItemByID = "_-29k" (String#6245, DoABC#2)
// getListItemByTag = "_-Ml" (String#8136, DoABC#2)
// setListItemIndex = "_-2ZB" (String#6748, DoABC#2)
// swapListItems = "_-1We" (String#5485, DoABC#2)
// swapListItemsAt = "_-2JU" (String#6429, DoABC#2)
// groupListItemsWithID = "_-CS" (String#7927, DoABC#2)
// arrangeListItems = "_-0fG" (String#4411, DoABC#2)


