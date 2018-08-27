
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class CheckBoxController extends SelectableController implements ICheckBoxWindow 
    {

        public function CheckBoxController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_1 == this){
                switch (_arg_2.type){
                    case WindowMouseEvent.WME_UP:
                        if (isSelected){
                            unselect();
                        }
                        else {
                            select();
                        };
                        break;
                };
            };
            return (super.update(_arg_1, _arg_2));
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// SelectableController = "_-13l" (String#4949, DoABC#2)
// CheckBoxController = "_-0pH" (String#4619, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// unselect = "_-2aK" (String#6764, DoABC#2)


