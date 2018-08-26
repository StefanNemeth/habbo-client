
package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObject;
    import com.sulake.core.window.WindowController;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.sulake.core.window.events.WindowEvent;

    public class WindowMouseOperator implements IDisposable 
    {

        protected var _root:DisplayObject;
        protected var _window:WindowController;
        protected var _working:Boolean;
        protected var _offset:Point;
        protected var _mouse:Point;
        protected var _SafeStr_9646:Point;
        protected var _SafeStr_8916:uint;
        private var _disposed:Boolean = false;

        public function WindowMouseOperator(_arg_1:DisplayObject)
        {
            this._root = _arg_1;
            this._SafeStr_9646 = new Point();
            this._mouse = new Point();
            this._offset = new Point();
            this._working = false;
            this._SafeStr_8916 = 0;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            this.end(this._window);
            this._offset = null;
            this._mouse = null;
            this._SafeStr_9646 = null;
            this._root = null;
            this._disposed = true;
        }
        public function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow
        {
            this._SafeStr_8916 = _arg_2;
            var _local_3:IWindow = this._window;
            if (this._window != null){
                this.end(this._window);
            };
            if (((_arg_1) && (!(_arg_1.disposed)))){
                this._root.addEventListener(MouseEvent.MOUSE_DOWN, this.handler, false);
                this._root.addEventListener(MouseEvent.MOUSE_UP, this.handler, false);
                this._root.addEventListener(Event.ENTER_FRAME, this.handler);
                this._mouse.x = this._root.mouseX;
                this._mouse.y = this._root.mouseY;
                this._window = WindowController(_arg_1);
                this.WindowMouseOperator(_arg_1, this._mouse, this._offset);
                this._window.addEventListener(WindowEvent.WE_DESTROYED, this.GestureAgentService);
                this._working = true;
            };
            return (_local_3);
        }
        public function end(_arg_1:IWindow):IWindow
        {
            var _local_2:IWindow = this._window;
            if (this._working){
                if (this._window == _arg_1){
                    this._root.removeEventListener(MouseEvent.MOUSE_DOWN, this.handler, false);
                    this._root.removeEventListener(MouseEvent.MOUSE_UP, this.handler, false);
                    this._root.removeEventListener(Event.ENTER_FRAME, this.handler);
                    if (!this._window.disposed){
                        this._window.removeEventListener(WindowEvent.WE_DESTROYED, this.GestureAgentService);
                    };
                    this._window = null;
                    this._working = false;
                };
            };
            return (_local_2);
        }
        protected function handler(_arg_1:Event):void
        {
            var _local_2:MouseEvent;
            if (this._working){
                if (_arg_1.type == Event.ENTER_FRAME){
                    if (this._window.disposed){
                        this.end(this._window);
                    }
                    else {
                        if (((!((this._mouse.x == this._root.mouseX))) || (!((this._mouse.y == this._root.mouseY))))){
                            this.GestureAgentService(this._root.mouseX, this._root.mouseY);
                            this._mouse.x = this._root.mouseX;
                            this._mouse.y = this._root.mouseY;
                        };
                    };
                    return;
                };
                _local_2 = (_arg_1 as MouseEvent);
                if (_local_2 != null){
                    switch (_local_2.type){
                        case MouseEvent.MOUSE_UP:
                            this.end(this._window);
                            return;
                    };
                };
            };
        }
        public function GestureAgentService(_arg_1:int, _arg_2:int):void
        {
            this._mouse.x = _arg_1;
            this._mouse.y = _arg_2;
            this.WindowMouseOperator(this._window, this._mouse, this._SafeStr_9646);
            this._window.offset((this._SafeStr_9646.x - this._offset.x), (this._SafeStr_9646.y - this._offset.y));
        }
        private function GestureAgentService(_arg_1:WindowEvent):void
        {
            this.end(this._window);
        }
        protected function WindowMouseOperator(_arg_1:IWindow, _arg_2:Point, _arg_3:Point):void
        {
            _arg_1.getGlobalPosition(_arg_3);
            _arg_3.x = (_arg_2.x - _arg_3.x);
            _arg_3.y = (_arg_2.y - _arg_3.y);
        }

    }
}//package com.sulake.core.window.services

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// WindowMouseOperator = "_-1Tv" (String#5430, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _SafeStr_8916 = "_-27n" (String#877, DoABC#2)
// WE_DESTROYED = "_-2PT" (String#20021, DoABC#2)
// _SafeStr_9646 = "_-SB" (String#23332, DoABC#2)
// WindowMouseOperator = "_-1xh" (String#18875, DoABC#2)
// GestureAgentService = "_-1b2" (String#5578, DoABC#2)
// GestureAgentService = "_-0n2" (String#4567, DoABC#2)


