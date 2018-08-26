
package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class DropMenuItemController extends ButtonController implements IDropMenuItemWindow, ITouchAwareWindow 
    {

        public function DropMenuItemController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get menu():IDropMenuWindow
        {
            var _local_1:IWindow = parent;
            while (_local_1) {
                if ((_local_1 is IDropMenuWindow)) break;
                _local_1 = _local_1.parent;
            };
            return ((_local_1 as IDropMenuWindow));
        }

    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// IDropMenuItemWindow = "_-11J" (String#1605, DoABC#2)
// ITouchAwareWindow = "_-QS" (String#8212, DoABC#2)
// ButtonController = "_-Mw" (String#8140, DoABC#2)
// DropMenuItemController = "_-A5" (String#7867, DoABC#2)


