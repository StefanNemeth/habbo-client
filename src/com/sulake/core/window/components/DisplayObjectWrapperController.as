
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.display.DisplayObject;

    public class DisplayObjectWrapperController extends WindowController implements IDisplayObjectWrapper 
    {

        public function DisplayObjectWrapperController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 & ~(WindowParam._SafeStr_7443));
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_9161 = false;
        }
        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_9166)))){
                _SafeStr_9166 = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_CONTAINER, _rectangle);
            };
            return (_SafeStr_9166);
        }
        public function getDisplayObject():DisplayObject
        {
            return (IGraphicContextHost(this).getGraphicContext(true).getDisplayObject());
        }
        public function setDisplayObject(_arg_1:DisplayObject):void
        {
            IGraphicContextHost(this).getGraphicContext(true).setDisplayObject(_arg_1);
        }

    }
}//package com.sulake.core.window.components

// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IGraphicContextHost = "_-2on" (String#1945, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// GraphicContext = "_-03R" (String#14179, DoABC#2)
// DisplayObjectWrapperController = "_-1h1" (String#5686, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// _SafeStr_9161 = "_-2-n" (String#19004, DoABC#2)
// _SafeStr_9166 = "_-1or" (String#18492, DoABC#2)


