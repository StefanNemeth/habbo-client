
package com.sulake.core.window.utils
{
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.IEventDispatcher;

    public class MouseEventQueue extends GenericEventQueue 
    {

        protected var _mousePosition:Point;

        public function MouseEventQueue(_arg_1:IEventDispatcher)
        {
            super(_arg_1);
            this._mousePosition = new Point();
            _eventDispatcher.addEventListener(MouseEvent.CLICK, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.DOUBLE_CLICK, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_UP, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_WHEEL, this.mouseEventListener, false);
        }
        public function get mousePosition():Point
        {
            return (this._mousePosition);
        }
        override public function dispose():void
        {
            if (!_disposed){
                _eventDispatcher.removeEventListener(MouseEvent.CLICK, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.DOUBLE_CLICK, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_UP, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_WHEEL, this.mouseEventListener, false);
                super.dispose();
            };
        }
        private function mouseEventListener(_arg_1:MouseEvent):void
        {
            this._mousePosition.x = _arg_1.stageX;
            this._mousePosition.y = _arg_1.stageY;
            _SafeStr_9714.push(_arg_1);
        }

    }
}//package com.sulake.core.window.utils

// GenericEventQueue = "_-0Tz" (String#4181, DoABC#2)
// MouseEventQueue = "_-3Du" (String#22030, DoABC#2)
// _SafeStr_9714 = "_-0an" (String#15466, DoABC#2)
// _mousePosition = "_-1fo" (String#18129, DoABC#2)
// mouseEventListener = "_-2kl" (String#20874, DoABC#2)
// mousePosition = "_-05g" (String#14268, DoABC#2)


