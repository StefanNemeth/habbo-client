
package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class TabButtonController extends SelectableController implements ITabButtonWindow 
    {

        private static const TAB_BUTTON_CONTENT:String = "TAB_BUTTON_CONTENT";
        private static const TAB_BUTTON_TITLE:String = "TAB_BUTTON_TITLE";
        private static const TAB_BUTTON_ICON:String = "TAB_BUTTON_ICON";

        public function TabButtonController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            var _local_2:IWindow = findChildByTag(TAB_BUTTON_TITLE);
            if (_local_2 != null){
                _local_2.caption = _arg_1;
            };
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_2.type == WindowEvent.WE_CHILD_RESIZED){
                WindowController.resizeToAccommodateChildren(this);
            };
            return (super.update(_arg_1, _arg_2));
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// SelectableController = "_-13l" (String#4949, DoABC#2)
// TabButtonController = "_-og" (String#8685, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)
// TAB_BUTTON_CONTENT = "_-FI" (String#22826, DoABC#2)
// TAB_BUTTON_TITLE = "_-29j" (String#19393, DoABC#2)
// TAB_BUTTON_ICON = "_-Dx" (String#22768, DoABC#2)


