
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class CanvasController extends WindowController implements ICanvasWindow 
    {

        public function CanvasController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function retrieveDrawBuffer(_arg_1:Point, _arg_2:Rectangle):BitmapData
        {
            WindowController(_arg_2);
            return ((WindowController() as BitmapData));
        }

    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ICanvasWindow = "_-1Ij" (String#1656, DoABC#2)
// CanvasController = "_-0SU" (String#4149, DoABC#2)
// retrieveDrawBuffer = "_-ak" (String#8433, DoABC#2)
// WindowController = "_-0xH" (String#1582, DoABC#2)
// WindowController = "_-0oc" (String#1553, DoABC#2)


