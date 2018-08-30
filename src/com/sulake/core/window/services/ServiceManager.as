
package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObject;
    import com.sulake.core.window.IWindowContext;

    public class ServiceManager implements IInternalWindowServices, IDisposable 
    {

        private var _SafeStr_9636:uint;
        private var _root:DisplayObject;
        private var _disposed:Boolean = false;
        private var _SafeStr_9637:IWindowContext;
        private var _mouseDraggingService:IMouseDraggingService;
        private var _mouseScalingService:IMouseScalingService;
        private var _mouseListenerService:IMouseListenerService;
        private var _focusManagerService:IFocusManagerService;
        private var _toolTipAgentService:IToolTipAgentService;
        private var _gestureAgentService:IGestureAgentService;

        public function ServiceManager(_arg_1:IWindowContext, _arg_2:DisplayObject)
        {
            this._SafeStr_9636 = 0;
            this._root = _arg_2;
            this._SafeStr_9637 = _arg_1;
            this._mouseDraggingService = new WindowMouseDragger(_arg_2);
            this._mouseScalingService = new WindowMouseScaler(_arg_2);
            this._mouseListenerService = new WindowMouseListener(_arg_2);
            this._focusManagerService = new FocusManager(_arg_2);
            this._toolTipAgentService = new WindowToolTipAgent(_arg_2);
            this._gestureAgentService = new GestureAgentService();
        }
        public function dispose():void
        {
            if (this._mouseDraggingService != null){
                this._mouseDraggingService.dispose();
                this._mouseDraggingService = null;
            };
            if (this._mouseScalingService != null){
                this._mouseScalingService.dispose();
                this._mouseScalingService = null;
            };
            if (this._mouseListenerService != null){
                this._mouseListenerService.dispose();
                this._mouseListenerService = null;
            };
            if (this._focusManagerService != null){
                this._focusManagerService.dispose();
                this._focusManagerService = null;
            };
            if (this._toolTipAgentService != null){
                this._toolTipAgentService.dispose();
                this._toolTipAgentService = null;
            };
            if (this._gestureAgentService != null){
                this._gestureAgentService.dispose();
                this._gestureAgentService = null;
            };
            this._root = null;
            this._SafeStr_9637 = null;
            this._disposed = true;
        }
        public function getMouseDraggingService():IMouseDraggingService
        {
            return (this._mouseDraggingService);
        }
        public function getMouseScalingService():IMouseScalingService
        {
            return (this._mouseScalingService);
        }
        public function getMouseListenerService():IMouseListenerService
        {
            return (this._mouseListenerService);
        }
        public function getFocusManagerService():IFocusManagerService
        {
            return (this._focusManagerService);
        }
        public function getToolTipAgentService():IToolTipAgentService
        {
            return (this._toolTipAgentService);
        }
        public function getGestureAgentService():IGestureAgentService
        {
            return (this._gestureAgentService);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }

    }
}//package com.sulake.core.window.services

// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IInternalWindowServices = "_-2Ry" (String#6605, DoABC#2)
// ServiceManager = "_-21o" (String#6081, DoABC#2)
// IMouseListenerService = "_-0s7" (String#4688, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IToolTipAgentService = "_-0Sl" (String#4154, DoABC#2)
// IGestureAgentService = "_-F9" (String#7973, DoABC#2)
// IMouseScalingService = "_-Mf" (String#8135, DoABC#2)
// IMouseDraggingService = "_-6c" (String#7797, DoABC#2)
// IFocusManagerService = "_-0Jl" (String#3946, DoABC#2)
// WindowMouseScaler = "_-CB" (String#7917, DoABC#2)
// FocusManager = "_-2tk" (String#7153, DoABC#2)
// WindowToolTipAgent = "_-3Gu" (String#7645, DoABC#2)
// GestureAgentService = "_-Nq" (String#8162, DoABC#2)
// WindowMouseListener = "_-2tW" (String#7147, DoABC#2)
// WindowMouseDragger = "_-AB" (String#7870, DoABC#2)
// _SafeStr_9636 = "_-1Rz" (String#17581, DoABC#2)
// _SafeStr_9637 = "_-2Xg" (String#1895, DoABC#2)
// _mouseDraggingService = "_-29I" (String#19376, DoABC#2)
// _mouseScalingService = "_-2QN" (String#20061, DoABC#2)
// _mouseListenerService = "_-0hm" (String#15739, DoABC#2)
// _focusManagerService = "_-1nD" (String#18433, DoABC#2)
// _toolTipAgentService = "_-0VZ" (String#15262, DoABC#2)
// _gestureAgentService = "_-2xR" (String#21368, DoABC#2)


