
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;

    public class ContainerController extends WindowController implements IWindowContainer 
    {

        public function ContainerController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_9161 = ((((_background) || (testParamFlag(WindowParam._SafeStr_7434)))) || (!(testParamFlag(WindowParam._SafeStr_7443))));
        }
        public function get iterator():IIterator
        {
            return (new Iterator(this));
        }
        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_9166)))){
                _SafeStr_9166 = new GraphicContext((("GC {" + _name) + "}"), ((testParamFlag(WindowParam._SafeStr_7443)) ? GraphicContext.GC_TYPE_CONTAINER : GraphicContext.GC_TYPE_BITMAP), _rectangle);
                _SafeStr_9166.visible = _visible;
            };
            return (_SafeStr_9166);
        }

    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// GraphicContext = "_-03R" (String#14179, DoABC#2)
// ContainerController = "_-1v4" (String#5943, DoABC#2)
// Iterator = "_-G2" (String#7994, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// _SafeStr_9161 = "_-2-n" (String#19004, DoABC#2)
// _background = "_-35x" (String#21726, DoABC#2)
// _SafeStr_9166 = "_-1or" (String#18492, DoABC#2)
// testParamFlag = "_-1ml" (String#5794, DoABC#2)


