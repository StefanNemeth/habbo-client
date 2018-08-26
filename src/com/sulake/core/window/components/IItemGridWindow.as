
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
        function IItemGridWindow(_arg_1:IWindow):IWindow;
        function IItemGridWindow(_arg_1:IWindow, _arg_2:uint):IWindow;
        function IItemGridWindow(_arg_1:uint):IWindow;
        function IItemGridWindow(_arg_1:uint):IWindow;
        function IItemGridWindow(_arg_1:String):IWindow;
        function IItemGridWindow(_arg_1:String):IWindow;
        function getGridItemIndex(_arg_1:IWindow):int;
        function IItemGridWindow(_arg_1:IWindow):IWindow;
        function IItemGridWindow(_arg_1:int):IWindow;
        function IItemGridWindow(_arg_1:IWindow, _arg_2:int):void;
        function IItemGridWindow(_arg_1:IWindow, _arg_2:IWindow):void;
        function IItemGridWindow(_arg_1:int, _arg_2:int):void;
        function IItemGridWindow():void;
        function destroyGridItems():void;

    }
}//package com.sulake.core.window.components

// IIterable = "_-2BO" (String#6275, DoABC#2)
// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// IItemGridWindow = "_-1Bp" (String#5106, DoABC#2)
// IItemGridWindow = "_-Rm" (String#8243, DoABC#2)
// IItemGridWindow = "_-2vh" (String#7192, DoABC#2)
// IItemGridWindow = "_-B9" (String#7890, DoABC#2)
// IItemGridWindow = "_-1Xz" (String#5519, DoABC#2)
// IItemGridWindow = "_-3CS" (String#7563, DoABC#2)
// numColumns = "_-1mX" (String#5789, DoABC#2)
// numRows = "_-2Oy" (String#6542, DoABC#2)
// IItemGridWindow = "_-2XX" (String#6712, DoABC#2)
// IItemGridWindow = "_-2o" (String#7040, DoABC#2)
// IItemGridWindow = "_-Tt" (String#8282, DoABC#2)
// IItemGridWindow = "_-0VT" (String#4214, DoABC#2)
// IItemGridWindow = "_-0ny" (String#4590, DoABC#2)
// IItemGridWindow = "_-Ih" (String#8056, DoABC#2)


