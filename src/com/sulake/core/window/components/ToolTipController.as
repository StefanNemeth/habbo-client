
package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class ToolTipController extends ButtonController implements IToolTipWindow 
    {

        public function ToolTipController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IToolTipWindow = "_-0GV" (String#3884, DoABC#2)
// ButtonController = "_-Mw" (String#8140, DoABC#2)
// ToolTipController = "_-33w" (String#7386, DoABC#2)


