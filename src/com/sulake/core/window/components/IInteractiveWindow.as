
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;

    public interface IInteractiveWindow extends IWindow 
    {

        function set toolTipCaption(_arg_1:String):void;
        function get toolTipCaption():String;
        function set toolTipDelay(_arg_1:uint):void;
        function get toolTipDelay():uint;
        function showToolTip(_arg_1:IToolTipWindow):void;
        function hideToolTip():void;
        function setMouseCursorForState(_arg_1:uint, _arg_2:uint):uint;
        function getMouseCursorByState(_arg_1:uint):uint;

    }
}//package com.sulake.core.window.components

// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// IToolTipWindow = "_-0GV" (String#3884, DoABC#2)
// setMouseCursorForState = "_-1lf" (String#5777, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)
// hideToolTip = "_-2VZ" (String#1889, DoABC#2)
// getMouseCursorByState = "_-0Bd" (String#3788, DoABC#2)


