
package com.sulake.core.window.utils
{
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContextStateListener;

    public class EventProcessorState 
    {

        public var renderer:IWindowRenderer;
        public var desktop:IDesktopWindow;
        public var _SafeStr_8619:IWindow;
        public var _SafeStr_8621:IWindow;
        public var _SafeStr_8624:Vector.<IWindowContextStateListener>;

        public function EventProcessorState(_arg_1:IWindowRenderer, _arg_2:IDesktopWindow, _arg_3:IWindow, _arg_4:IWindow, _arg_5:Vector.<IWindowContextStateListener>)
        {
            this.renderer = _arg_1;
            this.desktop = _arg_2;
            this._SafeStr_8619 = _arg_3;
            this._SafeStr_8621 = _arg_4;
            this._SafeStr_8624 = _arg_5;
        }
    }
}//package com.sulake.core.window.utils

// IWindowRenderer = "_-2Oq" (String#6539, DoABC#2)
// EventProcessorState = "_-Ct" (String#7930, DoABC#2)
// _SafeStr_8619 = "_-0fY" (String#15653, DoABC#2)
// _SafeStr_8621 = "_-1ek" (String#18088, DoABC#2)
// _SafeStr_8624 = "_-3ED" (String#22044, DoABC#2)


