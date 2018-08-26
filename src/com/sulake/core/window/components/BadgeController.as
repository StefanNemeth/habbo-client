
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class BadgeController extends WindowController implements IBadgeWindow 
    {

        protected static const _BTN_TEXT:String = "_BTN_TEXT";

        public function BadgeController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            var _local_2:IWindow = getChildByName(_BTN_TEXT);
            if (_local_2 != null){
                _local_2.caption = caption;
            };
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if ((_arg_2 is WindowEvent)){
                switch (_arg_2.type){
                    case WindowEvent.WE_CHILD_RESIZED:
                        width = 0;
                        break;
                };
            };
            return (super.update(_arg_1, _arg_2));
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IBadgeWindow = "_-2C3" (String#6287, DoABC#2)
// BadgeController = "_-0O3" (String#4048, DoABC#2)
// _BTN_TEXT = "_-7L" (String#2054, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)


