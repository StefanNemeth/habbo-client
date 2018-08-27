
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.IIterable;

    public interface IItemGridWindow extends IWindow, IScrollableWindow, IIterable 
    {

        function get numColumns():uint;
        function get numRows():uint;
        function get numGridItems():uint;
        function get autoArrangeItems():Boolean;
        function set autoArrangeItems(_arg_1:Boolean):void;
        function addGridItem(_arg_1:IWindow):IWindow;
        function addGridItemAt(_arg_1:IWindow, _arg_2:uint):IWindow;
        function getGridItemAt(_arg_1:uint):IWindow;
        function getGridItemByID(_arg_1:uint):IWindow;
        function getGridItemByName(_arg_1:String):IWindow;
        function getGridItemByTag(_arg_1:String):IWindow;
        function getGridItemIndex(_arg_1:IWindow):int;
        function removeGridItem(_arg_1:IWindow):IWindow;
        function removeGridItemAt(_arg_1:int):IWindow;
        function setGridItemIndex(_arg_1:IWindow, _arg_2:int):void;
        function swapGridItems(_arg_1:IWindow, _arg_2:IWindow):void;
        function swapGridItemsAt(_arg_1:int, _arg_2:int):void;
        function removeGridItems():void;
        function destroyGridItems():void;

    }
}//package com.sulake.core.window.components

// IIterable = "_-2BO" (String#6275, DoABC#2)
// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// removeGridItems = "_-1Bp" (String#5106, DoABC#2)
// removeGridItemAt = "_-Rm" (String#8243, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// getGridItemAt = "_-B9" (String#7890, DoABC#2)
// addGridItemAt = "_-1Xz" (String#5519, DoABC#2)
// removeGridItem = "_-3CS" (String#7563, DoABC#2)
// numColumns = "_-1mX" (String#5789, DoABC#2)
// numRows = "_-2Oy" (String#6542, DoABC#2)
// getGridItemByID = "_-2XX" (String#6712, DoABC#2)
// getGridItemByName = "_-2o" (String#7040, DoABC#2)
// getGridItemByTag = "_-Tt" (String#8282, DoABC#2)
// setGridItemIndex = "_-0VT" (String#4214, DoABC#2)
// swapGridItems = "_-0ny" (String#4590, DoABC#2)
// swapGridItemsAt = "_-Ih" (String#8056, DoABC#2)


