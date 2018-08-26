
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;

    public class BackgroundController extends WindowController implements IBackgroundWindow 
    {

        public function BackgroundController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            background = true;
            color = 0xFFFFFFFF;
        }
        public function get iterator():IIterator
        {
            return (new Iterator(this));
        }

    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IBackgroundWindow = "_-7D" (String#2053, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// BackgroundController = "_-1UO" (String#5440, DoABC#2)
// Iterator = "_-G2" (String#7994, DoABC#2)


