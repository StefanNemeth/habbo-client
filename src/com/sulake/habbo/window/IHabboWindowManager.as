
package com.sulake.habbo.window
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.ICoreWindowManager;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.utils.IAlertDialogWithLink;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import com.sulake.core.window.IWindowContextStateListener;

    public interface IHabboWindowManager extends IUnknown, ICoreWindowManager 
    {

        function createWindow(_arg_1:String, _arg_2:String="", _arg_3:uint=0, _arg_4:uint=0, _arg_5:uint=0, _arg_6:Rectangle=null, _arg_7:Function=null, _arg_8:uint=0, _arg_9:uint=1):IWindow;
        function removeWindow(_arg_1:String, _arg_2:uint=1):void;
        function getWindowByName(_arg_1:String, _arg_2:uint=1):IWindow;
        function getActiveWindow(_arg_1:uint=1):IWindow;
        function getWindowContext(_arg_1:uint):IWindowContext;
        function alert(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):IAlertDialog;
        function alertWithLink(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function):IAlertDialogWithLink;
        function confirm(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):IConfirmDialog;
        function registerLocalizationParameter(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="%"):void;
        function addMouseEventTracker(_arg_1:IWindowContextStateListener):void;
        function removeMouseEventTracker(_arg_1:IWindowContextStateListener):void;

    }
}//package com.sulake.habbo.window

// alertWithLink = "_-KV" (String#8092, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IConfirmDialog = "_-35c" (String#7421, DoABC#2)
// getWindowByName = "_-3LJ" (String#7725, DoABC#2)
// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IAlertDialogWithLink = "_-0zQ" (String#4836, DoABC#2)
// ICoreWindowManager = "_-YU" (String#2128, DoABC#2)
// removeWindow = "_-x0" (String#949, DoABC#2)
// getActiveWindow = "_-1h8" (String#1744, DoABC#2)
// addMouseEventTracker = "_-0WZ" (String#1491, DoABC#2)
// removeMouseEventTracker = "_-0Ak" (String#1417, DoABC#2)


