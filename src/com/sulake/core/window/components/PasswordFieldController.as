
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class PasswordFieldController extends TextFieldController implements IPasswordFieldWindow 
    {

        public function PasswordFieldController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _field.displayAsPassword = true;
        }
    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// TextFieldController = "_-2rC" (String#7105, DoABC#2)
// IPasswordFieldWindow = "_-1L7" (String#1664, DoABC#2)
// PasswordFieldController = "_-1Pz" (String#5351, DoABC#2)


