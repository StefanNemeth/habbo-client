
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;

    public interface IDesktopWindow extends IWindowContainer, IDisplayObjectWrapper 
    {

        function get mouseX():int;
        function get mouseY():int;
        function getActiveWindow():IWindow;
        function IDesktopWindow(_arg_1:IWindow):IWindow;
        function WindowController(_arg_1:Point, _arg_2:Array, _arg_3:uint=0):void;

    }
}//package com.sulake.core.window.components

// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// getActiveWindow = "_-1h8" (String#1744, DoABC#2)
// IDesktopWindow = "_-Lc" (String#8117, DoABC#2)
// WindowController = "_-ZD" (String#8399, DoABC#2)


