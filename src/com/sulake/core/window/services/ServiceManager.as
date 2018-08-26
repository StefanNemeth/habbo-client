
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
        private var _SafeStr_9638:IMouseDraggingService;
        private var _SafeStr_9639:IMouseScalingService;
        private var _SafeStr_9640:IMouseListenerService;
        private var _SafeStr_9641:IFocusManagerService;
        private var _SafeStr_9642:IToolTipAgentService;
        private var _SafeStr_9643:IGestureAgentService;

        public function ServiceManager(_arg_1:IWindowContext, _arg_2:DisplayObject)
        {
            this._SafeStr_9636 = 0;
            this._root = _arg_2;
            this._SafeStr_9637 = _arg_1;
            this._SafeStr_9638 = new WindowMouseDragger(_arg_2);
            this._SafeStr_9639 = new WindowMouseScaler(_arg_2);
            this._SafeStr_9640 = new WindowMouseListener(_arg_2);
            this._SafeStr_9641 = new FocusManager(_arg_2);
            this._SafeStr_9642 = new WindowToolTipAgent(_arg_2);
            this._SafeStr_9643 = new GestureAgentService();
        }
        public function dispose():void
        {
            if (this._SafeStr_9638 != null){
                this._SafeStr_9638.dispose();
                this._SafeStr_9638 = null;
            };
            if (this._SafeStr_9639 != null){
                this._SafeStr_9639.dispose();
                this._SafeStr_9639 = null;
            };
            if (this._SafeStr_9640 != null){
                this._SafeStr_9640.dispose();
                this._SafeStr_9640 = null;
            };
            if (this._SafeStr_9641 != null){
                this._SafeStr_9641.dispose();
                this._SafeStr_9641 = null;
            };
            if (this._SafeStr_9642 != null){
                this._SafeStr_9642.dispose();
                this._SafeStr_9642 = null;
            };
            if (this._SafeStr_9643 != null){
                this._SafeStr_9643.dispose();
                this._SafeStr_9643 = null;
            };
            this._root = null;
            this._SafeStr_9637 = null;
            this._disposed = true;
        }
        public function getMouseDraggingService():IMouseDraggingService
        {
            return (this._SafeStr_9638);
        }
        public function getMouseScalingService():IMouseScalingService
        {
            return (this._SafeStr_9639);
        }
        public function getMouseListenerService():IMouseListenerService
        {
            return (this._SafeStr_9640);
        }
        public function getFocusManagerService():IFocusManagerService
        {
            return (this._SafeStr_9641);
        }
        public function getToolTipAgentService():IToolTipAgentService
        {
            return (this._SafeStr_9642);
        }
        public function getGestureAgentService():IGestureAgentService
        {
            return (this._SafeStr_9643);
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
// _SafeStr_9638 = "_-29I" (String#19376, DoABC#2)
// _SafeStr_9639 = "_-2QN" (String#20061, DoABC#2)
// _SafeStr_9640 = "_-0hm" (String#15739, DoABC#2)
// _SafeStr_9641 = "_-1nD" (String#18433, DoABC#2)
// _SafeStr_9642 = "_-0VZ" (String#15262, DoABC#2)
// _SafeStr_9643 = "_-2xR" (String#21368, DoABC#2)


