
package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import com.sulake.core.window.events.WindowEvent;
    import flash.events.TimerEvent;

    public class GestureAgentService implements IGestureAgentService, IDisposable 
    {

        private var _disposed:Boolean = false;
        protected var _working:Boolean;
        protected var _window:IWindow;
        protected var _SafeStr_5297:Timer;
        protected var _SafeStr_8916:uint = 0;
        protected var _callback:Function;
        protected var _SafeStr_9656:int;
        protected var _SafeStr_9657:int;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            this.end(this._window);
            this._disposed = true;
        }
        public function begin(_arg_1:IWindow, _arg_2:Function, _arg_3:uint, _arg_4:int, _arg_5:int):IWindow
        {
            this._SafeStr_8916 = _arg_3;
            var _local_6:IWindow = this._window;
            if (this._window != null){
                this.end(this._window);
            };
            if (((_arg_1) && (!(_arg_1.disposed)))){
                this._window = _arg_1;
                this._window.addEventListener(WindowEvent.WE_DESTROYED, this.GestureAgentService);
                this._callback = _arg_2;
                this._working = true;
                this._SafeStr_9656 = _arg_4;
                this._SafeStr_9657 = _arg_5;
                this._SafeStr_5297 = new Timer(40, 0);
                this._SafeStr_5297.addEventListener(TimerEvent.TIMER, this.GestureAgentService);
                this._SafeStr_5297.start();
            };
            return (_local_6);
        }
        protected function GestureAgentService(_arg_1:TimerEvent):void
        {
            this._SafeStr_9656 = (this._SafeStr_9656 * 0.75);
            this._SafeStr_9657 = (this._SafeStr_9657 * 0.75);
            if ((((Math.abs(this._SafeStr_9656) <= 1)) && ((Math.abs(this._SafeStr_9657) <= 1)))){
                this.end(this._window);
            }
            else {
                if (this._callback != null){
                    this._callback(this._SafeStr_9656, this._SafeStr_9657);
                };
            };
        }
        public function end(_arg_1:IWindow):IWindow
        {
            var _local_2:IWindow = this._window;
            if (this._SafeStr_5297){
                this._SafeStr_5297.stop();
                this._SafeStr_5297.removeEventListener(TimerEvent.TIMER, this.GestureAgentService);
                this._SafeStr_5297 = null;
            };
            if (this._working){
                if (this._window == _arg_1){
                    if (!this._window.disposed){
                        this._window.removeEventListener(WindowEvent.WE_DESTROYED, this.GestureAgentService);
                    };
                    this._window = null;
                    this._working = false;
                };
            };
            return (_local_2);
        }
        private function GestureAgentService(_arg_1:WindowEvent):void
        {
            this.end(this._window);
        }

    }
}//package com.sulake.core.window.services

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IGestureAgentService = "_-F9" (String#7973, DoABC#2)
// GestureAgentService = "_-Nq" (String#8162, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// _callback = "_-0t2" (String#593, DoABC#2)
// _SafeStr_8916 = "_-27n" (String#877, DoABC#2)
// WE_DESTROYED = "_-2PT" (String#20021, DoABC#2)
// GestureAgentService = "_-1b2" (String#5578, DoABC#2)
// GestureAgentService = "_-0n2" (String#4567, DoABC#2)
// _SafeStr_9656 = "_-vJ" (String#24502, DoABC#2)
// _SafeStr_9657 = "_-214" (String#19053, DoABC#2)


