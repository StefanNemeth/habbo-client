
package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class HeaderController extends ContainerController implements IHeaderWindow 
    {

        private static const _TITLE:String = "_TITLE";
        private static const _CONTROLS:String = "_CONTROLS";

        public function HeaderController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get title():ILabelWindow
        {
            return ((findChildByTag(_TITLE) as ILabelWindow));
        }
        public function get controls():IItemListWindow
        {
            return ((findChildByTag(_CONTROLS) as IItemListWindow));
        }
        override public function set caption(value:String):void
        {
            super.caption = value;
            try {
                this.title.text = value;
            }
            catch(e:Error) {
                Logger.log("Header contains no title element!");
            };
        }
        override public function set color(_arg_1:uint):void
        {
            var _local_3:IWindow;
            super.color = _arg_1;
            var _local_2:Array = new Array();
            groupChildrenWithTag(_COLORIZE, _local_2, true);
            for each (_local_3 in _local_2) {
                _local_3.color = _arg_1;
            };
        }

    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IHeaderWindow = "_-1zq" (String#1792, DoABC#2)
// ContainerController = "_-1v4" (String#5943, DoABC#2)
// HeaderController = "_-il" (String#8572, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _TITLE = "_-zu" (String#8882, DoABC#2)
// _CONTROLS = "_-0vd" (String#16262, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)
// _COLORIZE = "_-EQ" (String#22789, DoABC#2)


