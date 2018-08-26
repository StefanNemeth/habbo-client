
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import flash.display.DisplayObject;
    import com.sulake.core.window.events.WindowEvent;

    public class DesktopController extends ActivatorController implements IDesktopWindow, IDisplayObjectWrapper 
    {

        public function DesktopController(_arg_1:String, _arg_2:WindowContext, _arg_3:Rectangle)
        {
            super(_arg_1, 0, 0, 0, _arg_2, _arg_3, null, this.DesktopController, null, null, 0);
        }
        public function get mouseX():int
        {
            return (this.getDisplayObject().stage.mouseX);
        }
        public function get mouseY():int
        {
            return (this.getDisplayObject().stage.mouseY);
        }
        override public function set parent(_arg_1:IWindow):void
        {
            throw (new Error("Desktop window doesn't have parent!"));
        }
        override public function set procedure(_arg_1:Function):void
        {
            _procedure = (((_arg_1)!=null) ? _arg_1 : this.DesktopController);
        }
        override public function get host():IWindow
        {
            return (this);
        }
        override public function get desktop():IDesktopWindow
        {
            return (this);
        }
        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_9166)))){
                _SafeStr_9166 = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_DESKTOP, _rectangle);
                GraphicContext(_SafeStr_9166).mouseEnabled = true;
                GraphicContext(_SafeStr_9166).doubleClickEnabled = true;
            };
            return (_SafeStr_9166);
        }
        public function getActiveWindow():IWindow
        {
            return (getActiveChild());
        }
        public function IDesktopWindow(_arg_1:IWindow):IWindow
        {
            return (setActiveChild(_arg_1));
        }
        public function getDisplayObject():DisplayObject
        {
            return ((this.getGraphicContext(true) as DisplayObject));
        }
        public function setDisplayObject(_arg_1:DisplayObject):void
        {
            this.getGraphicContext(true).setDisplayObject(_arg_1);
        }
        override public function invalidate(_arg_1:Rectangle=null):void
        {
        }
        private function DesktopController(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// GraphicContext = "_-03R" (String#14179, DoABC#2)
// ActivatorController = "_-Wd" (String#8339, DoABC#2)
// DesktopController = "_-03D" (String#3633, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// _SafeStr_9166 = "_-1or" (String#18492, DoABC#2)
// setActiveChild = "_-lC" (String#24077, DoABC#2)
// getActiveChild = "_-1cK" (String#17983, DoABC#2)
// DesktopController = "_-SI" (String#23336, DoABC#2)
// _procedure = "_-1SV" (String#17600, DoABC#2)
// getActiveWindow = "_-1h8" (String#1744, DoABC#2)
// IDesktopWindow = "_-Lc" (String#8117, DoABC#2)


