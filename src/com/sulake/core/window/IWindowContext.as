
package com.sulake.core.window
{
    import com.sulake.core.window.services.IInternalWindowServices;
    import com.sulake.core.window.utils.IWindowParser;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.geom.Rectangle;

    public interface IWindowContext 
    {

        function getWindowServices():IInternalWindowServices;
        function getWindowParser():IWindowParser;
        function getDesktopWindow():IDesktopWindow;
        function registerLocalizationListener(_arg_1:String, _arg_2:IWindow):void;
        function removeLocalizationListener(_arg_1:String, _arg_2:IWindow):void;
        function findWindowByName(_arg_1:String):IWindow;
        function create(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:uint, _arg_5:uint, _arg_6:Rectangle, _arg_7:Function, _arg_8:IWindow, _arg_9:uint, _arg_10:Array=null, _arg_11:Array=null):IWindow;
        function destroy(_arg_1:IWindow):Boolean;
        function invalidate(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):void;
        function getLastError():Error;
        function getLastErrorCode():int;
        function flushError():void;
        function addMouseEventTracker(_arg_1:IWindowContextStateListener):void;
        function removeMouseEventTracker(_arg_1:IWindowContextStateListener):void;

    }
}//package com.sulake.core.window

// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IInternalWindowServices = "_-2Ry" (String#6605, DoABC#2)
// IWindowParser = "_-14A" (String#4960, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// findWindowByName = "_-0I5" (String#3917, DoABC#2)
// getLastError = "_-8" (String#7822, DoABC#2)
// getLastErrorCode = "_-oV" (String#8683, DoABC#2)
// flushError = "_-wd" (String#8816, DoABC#2)
// addMouseEventTracker = "_-0WZ" (String#1491, DoABC#2)
// removeMouseEventTracker = "_-0Ak" (String#1417, DoABC#2)


