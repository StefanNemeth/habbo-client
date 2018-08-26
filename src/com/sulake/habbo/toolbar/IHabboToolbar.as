
package com.sulake.habbo.toolbar
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public interface IHabboToolbar extends IUnknown 
    {

        function get events():IEventDispatcher;
        function getIconVerticalLocation(_arg_1:String):int;
        function setUnseenItemCount(_arg_1:String, _arg_2:int):void;
        function setToolbarState(_arg_1:String):void;
        function setIconBitmap(_arg_1:String, _arg_2:BitmapData):void;
        function getRect():Rectangle;
        function get extensionView():IExtensionView;

    }
}//package com.sulake.habbo.toolbar

// getIconVerticalLocation = "_-1P2" (String#5334, DoABC#2)
// setUnseenItemCount = "_-1B5" (String#5095, DoABC#2)
// setToolbarState = "_-2Gw" (String#6384, DoABC#2)
// IExtensionView = "_-1z2" (String#6016, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// setIconBitmap = "_-27Q" (String#1818, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)


