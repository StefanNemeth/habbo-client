
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.IIterable;
    import com.sulake.core.window.IWindowContainer;

    public interface ITabContextWindow extends IWindow, IIterable 
    {

        function get selector():ITabSelectorWindow;
        function get container():IWindowContainer;
        function get numTabItems():uint;
        function TabContextController(_arg_1:ITabButtonWindow):ITabButtonWindow;
        function TabContextController(_arg_1:ITabButtonWindow, _arg_2:uint):ITabButtonWindow;
        function TabContextController(_arg_1:ITabButtonWindow):void;
        function TabContextController(_arg_1:uint):ITabButtonWindow;
        function TabContextController(_arg_1:String):ITabButtonWindow;
        function TabContextController(_arg_1:uint):ITabButtonWindow;
        function TabContextController(_arg_1:ITabButtonWindow):uint;

    }
}//package com.sulake.core.window.components

// IIterable = "_-2BO" (String#6275, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// TabContextController = "_-2aw" (String#6771, DoABC#2)
// numTabItems = "_-2Dt" (String#6317, DoABC#2)
// TabContextController = "_-1Kn" (String#5259, DoABC#2)
// TabContextController = "_-I4" (String#8041, DoABC#2)
// TabContextController = "_-9k" (String#7858, DoABC#2)
// TabContextController = "_-0XL" (String#4256, DoABC#2)
// TabContextController = "_-NX" (String#8155, DoABC#2)
// TabContextController = "_-2kP" (String#6964, DoABC#2)


