
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IIterable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowEvent;

    public class TabContextController extends WindowController implements ITabContextWindow, IIterable 
    {

        private static const _SELECTOR:String = "_SELECTOR";
        private static const _CONTENT:String = "_CONTENT";

        protected var _selector:ITabSelectorWindow;
        protected var _container:IWindowContainer;
        private var _TabSelectorController:Boolean = false;
        private var _initialized:Boolean = false;

        public function TabContextController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            var _local_13:IWindow;
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            var _local_12:Array = new Array();
            WindowController(WindowController.TAG_INTERNAL, _local_12, true);
            for each (_local_13 in _local_12) {
                _local_13.style = _style;
                _local_13.procedure = this.TabContextController;
            };
            this._initialized = true;
        }
        public function get selector():ITabSelectorWindow
        {
            if (this._selector == null){
                this._selector = (findChildByTag(_SELECTOR) as ITabSelectorWindow);
                if (this._selector != null){
                    this._selector.procedure = this.TabContextController;
                };
            };
            return (this._selector);
        }
        public function get container():IWindowContainer
        {
            if (this._container == null){
                this._container = (findChildByTag(_CONTENT) as IWindowContainer);
            };
            return (this._container);
        }
        public function get iterator():IIterator
        {
            return (((this._initialized) ? this.selector.iterator : null));
        }
        public function get numTabItems():uint
        {
            return (this._selector.numSelectables);
        }
        public function TabContextController(_arg_1:ITabButtonWindow):ITabButtonWindow
        {
            return ((this.selector.ISelectorWindow(_arg_1) as ITabButtonWindow));
        }
        public function TabContextController(_arg_1:ITabButtonWindow, _arg_2:uint):ITabButtonWindow
        {
            return ((this.selector.ISelectorWindow(_arg_1, _arg_2) as ITabButtonWindow));
        }
        public function TabContextController(_arg_1:ITabButtonWindow):void
        {
            this.selector.ISelectorWindow(_arg_1);
        }
        public function TabContextController(_arg_1:uint):ITabButtonWindow
        {
            return ((this.selector.ISelectorWindow(_arg_1) as ITabButtonWindow));
        }
        public function TabContextController(_arg_1:String):ITabButtonWindow
        {
            return ((this.selector.ISelectorWindow(_arg_1) as ITabButtonWindow));
        }
        public function TabContextController(_arg_1:uint):ITabButtonWindow
        {
            return ((this.selector.ISelectorWindow(_arg_1) as ITabButtonWindow));
        }
        public function TabContextController(_arg_1:ITabButtonWindow):uint
        {
            return (this.selector.ISelectorWindow(_arg_1));
        }
        private function TabContextController(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowEvent.WE_SELECTED){
                WindowController(_arg_1);
            };
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IIterable = "_-2BO" (String#6275, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)
// TabContextController = "_-2aw" (String#6771, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// ISelectorWindow = "_-0EO" (String#3836, DoABC#2)
// numSelectables = "_-1pQ" (String#5845, DoABC#2)
// ISelectorWindow = "_-1uz" (String#5941, DoABC#2)
// ISelectorWindow = "_-0Vv" (String#4227, DoABC#2)
// ISelectorWindow = "_-2Vc" (String#6675, DoABC#2)
// ISelectorWindow = "_-lI" (String#8633, DoABC#2)
// ISelectorWindow = "_-2bS" (String#6782, DoABC#2)
// ISelectorWindow = "_-i9" (String#8555, DoABC#2)
// numTabItems = "_-2Dt" (String#6317, DoABC#2)
// TabContextController = "_-1Kn" (String#5259, DoABC#2)
// TabContextController = "_-I4" (String#8041, DoABC#2)
// TabContextController = "_-9k" (String#7858, DoABC#2)
// TabContextController = "_-0XL" (String#4256, DoABC#2)
// TabContextController = "_-NX" (String#8155, DoABC#2)
// TabContextController = "_-2kP" (String#6964, DoABC#2)
// WindowController = "_-cU" (String#2141, DoABC#2)
// _TabSelectorController = "_-0V3" (String#4207, DoABC#2)
// _SELECTOR = "_-0wB" (String#16280, DoABC#2)
// _CONTENT = "_-0z" (String#16392, DoABC#2)
// _selector = "_-12r" (String#16575, DoABC#2)
// _container = "_-7x" (String#22541, DoABC#2)
// TabContextController = "_-2eh" (String#20635, DoABC#2)
// WindowController = "_-03d" (String#14188, DoABC#2)


