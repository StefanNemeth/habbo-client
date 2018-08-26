
package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class RadioButtonController extends SelectableController implements IRadioButtonWindow 
    {

        public function RadioButtonController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// SelectableController = "_-13l" (String#4949, DoABC#2)
// RadioButtonController = "_-Jz" (String#8083, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)


