
package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContext;
    import flash.display.BitmapData;

    public interface IWindowRenderer extends IUpdateReceiver 
    {

        function set debug(_arg_1:Boolean):void;
        function get allocatedByteCount():uint;
        function WindowRenderer(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):void;
        function WindowRenderer():void;
        function invalidate(_arg_1:IWindowContext, _arg_2:Rectangle):void;
        function WindowRenderer(_arg_1:IWindow):BitmapData;

    }
}//package com.sulake.core.window.graphics

// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IWindowRenderer = "_-2Oq" (String#6539, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// WindowRenderer = "_-1zA" (String#6020, DoABC#2)
// WindowRenderer = "_-2wd" (String#7216, DoABC#2)
// WindowRenderer = "_-2bf" (String#6787, DoABC#2)


