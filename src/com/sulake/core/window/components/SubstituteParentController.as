
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class SubstituteParentController extends WindowController 
    {

        public function SubstituteParentController(_arg_1:WindowContext)
        {
            super("_CONTEXT_SUBSTITUTE_PARENT", 0, 0, WindowParam._SafeStr_7443, _arg_1, new Rectangle(0, 0, 2000, 2000), null, null, null, null, 0);
            _SafeStr_9161 = false;
        }
        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            return (null);
        }
        override public function WindowController():IGraphicContext
        {
            return (null);
        }
        private function childParamUpdated(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.window;
            if (getChildIndex(_local_2) != -1){
                if (!_local_2.IWindow(WindowParam._SafeStr_7443)){
                    _local_2.desktop.addChild(_local_2);
                };
            };
        }
        override public function addChild(_arg_1:IWindow):IWindow
        {
            _children.push(_arg_1);
            return (_arg_1);
        }
        override public function addChildAt(_arg_1:IWindow, _arg_2:int):IWindow
        {
            var _local_3:WindowController = WindowController(_arg_1);
            if (_local_3.parent != null){
                WindowController(_local_3.parent).removeChild(_local_3);
            };
            _children.splice(_arg_2, 0, _arg_1);
            _local_3.parent = this;
            return (_arg_1);
        }
        override public function removeChild(_arg_1:IWindow):IWindow
        {
            var _local_2:int = _children.indexOf(_arg_1);
            if (_local_2 > -1){
                _children.splice(_local_2, 1);
                _arg_1.parent = null;
                return (_arg_1);
            };
            return (null);
        }
        override public function setChildIndex(_arg_1:IWindow, _arg_2:int):void
        {
            var _local_3:int = _children.indexOf(_arg_1);
            if ((((_local_3 > -1)) && (!((_arg_2 == _local_3))))){
                _children.splice(_local_3, 1);
                _children.splice(_arg_2, 0, _arg_1);
            };
        }
        override public function swapChildren(_arg_1:IWindow, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:IWindow;
            var _local_6:int;
            if (((((!((_arg_1 == null))) && (!((_arg_2 == null))))) && (!((_arg_1 == _arg_2))))){
                _local_3 = _children.indexOf(_arg_1);
                if (_local_3 < 0){
                    return;
                };
                _local_4 = _children.indexOf(_arg_2);
                if (_local_4 < 0){
                    return;
                };
                if (_local_4 < _local_3){
                    _local_5 = _arg_1;
                    _arg_1 = _arg_2;
                    _arg_2 = _local_5;
                    _local_6 = _local_3;
                    _local_3 = _local_4;
                    _local_4 = _local_6;
                };
                _children.splice(_local_4, 1);
                _children.splice(_local_3, 1);
                _children.splice(_local_3, 0, _arg_2);
                _children.splice(_local_4, 0, _arg_1);
            };
        }
        override public function swapChildrenAt(_arg_1:int, _arg_2:int):void
        {
            this.swapChildren(_children[_arg_1], _children[_arg_2]);
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// SubstituteParentController = "_-0kg" (String#4514, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_9161 = "_-2-n" (String#19004, DoABC#2)
// WindowController = "_-0r-" (String#16084, DoABC#2)
// childParamUpdated = "_-2pm" (String#21072, DoABC#2)
// IWindow = "_-1ml" (String#5794, DoABC#2)


