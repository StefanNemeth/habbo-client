
package com.sulake.core.window.graphics
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.events.WindowDisposeEvent;
    import flash.display.BitmapData;

    public class WindowRenderer implements IWindowRenderer 
    {

        private var _debug:Boolean = false;
        private var _disposed:Boolean;
        private var _SafeStr_9625:Array;
        private var _SafeStr_9626:Point;
        private var _SafeStr_9627:Rectangle;
        private var _SafeStr_9628:Rectangle;
        private var _skinContainer:ISkinContainer;
        private var _SafeStr_9629:Dictionary;
        private var _drawBufferAllocator:DrawBufferAllocator;

        public function WindowRenderer(_arg_1:ISkinContainer)
        {
            this._disposed = false;
            this._SafeStr_9625 = new Array();
            this._SafeStr_9626 = new Point();
            this._SafeStr_9627 = new Rectangle();
            this._SafeStr_9628 = new Rectangle();
            this._SafeStr_9629 = new Dictionary(true);
            this._skinContainer = _arg_1;
            this._drawBufferAllocator = new DrawBufferAllocator();
        }
        private static function WindowRenderer(_arg_1:WindowController, _arg_2:Rectangle, _arg_3:Point, _arg_4:Rectangle):Boolean
        {
            var _local_7:int;
            var _local_5:Rectangle = _arg_1.rectangle.clone();
            var _local_6:Boolean = true;
            _arg_4.x = 0;
            _arg_4.y = 0;
            _arg_4.width = _local_5.width;
            _arg_4.height = _local_5.height;
            if (!_arg_1.IWindow(WindowParam._SafeStr_7443)){
                _arg_3.x = 0;
                _arg_3.y = 0;
                if (((_arg_1.parent) && (_arg_1.IWindow(WindowParam.WINDOW_PARAM_FORCE_CLIPPING)))){
                    return (WindowController(_arg_1.parent).WindowController(_local_5, _arg_4));
                };
            }
            else {
                if (_arg_1.parent){
                    _local_6 = WindowController(_arg_1.parent).WindowController(_local_5, _arg_4);
                    _arg_3.x = _local_5.x;
                    _arg_3.y = _local_5.y;
                }
                else {
                    _arg_3.x = 0;
                    _arg_3.y = 0;
                };
            };
            if (_arg_2.x > _arg_4.x){
                _local_7 = (_arg_2.x - _arg_4.x);
                _arg_3.x = (_arg_3.x + _local_7);
                _arg_4.x = (_arg_4.x + _local_7);
                _arg_4.width = (_arg_4.width - _local_7);
            };
            if (_arg_2.y > _arg_4.y){
                _local_7 = (_arg_2.y - _arg_4.y);
                _arg_3.y = (_arg_3.y + _local_7);
                _arg_4.y = (_arg_4.y + _local_7);
                _arg_4.height = (_arg_4.height - _local_7);
            };
            if (_arg_2.right < _arg_4.right){
                _local_7 = (_arg_4.right - _arg_2.right);
                _arg_4.width = (_arg_4.width - _local_7);
            };
            if (_arg_2.bottom < _arg_4.bottom){
                _local_7 = (_arg_4.bottom - _arg_2.bottom);
                _arg_4.height = (_arg_4.height - _local_7);
            };
            return (((((_local_6) && ((_arg_4.width > 0)))) && ((_arg_4.height > 0))));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get allocatedByteCount():uint
        {
            return (this._drawBufferAllocator.allocatedByteCount);
        }
        public function set debug(_arg_1:Boolean):void
        {
            this._debug = _arg_1;
        }
        public function get debug():Boolean
        {
            return (this._debug);
        }
        public function dispose():void
        {
            var _local_1:Object;
            if (!this._disposed){
                this._disposed = true;
                this._SafeStr_9625 = null;
                for (_local_1 in this._SafeStr_9629) {
                    delete this._SafeStr_9629[_local_1];
                };
                this._SafeStr_9629 = null;
                this._drawBufferAllocator.dispose();
                this._drawBufferAllocator = null;
            };
        }
        public function update(_arg_1:uint):void
        {
            this.render();
            this.WindowRenderer();
        }
        public function WindowRenderer(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):void
        {
            var _local_4:WindowController;
            var _local_5:IDesktopWindow;
            if (this.getWindowRendererItem(_arg_1).invalidate(_arg_1, _arg_2, _arg_3)){
                _local_5 = _arg_1.context.getDesktopWindow();
                this._SafeStr_9628.x = (_arg_2.x - _arg_1.x);
                this._SafeStr_9628.y = (_arg_2.y - _arg_1.y);
                this._SafeStr_9628.width = _arg_2.width;
                this._SafeStr_9628.height = _arg_2.height;
                if (_arg_1.IWindow(WindowParam._SafeStr_7443)){
                    while (true) {
                        if (!_arg_1.IWindow(WindowParam._SafeStr_7443)) break;
                        _local_4 = (_arg_1.parent as WindowController);
                        if (_local_4 == null){
                            return;
                        };
                        if (_local_4 == _local_5) break;
                        if (_local_4.visible == false){
                            return;
                        };
                        this._SafeStr_9628.offset(_arg_1.x, _arg_1.y);
                        _arg_1 = _local_4;
                    };
                };
                this.getWindowRendererItem(_arg_1).invalidate(_arg_1, this._SafeStr_9628, WindowRedrawFlag._SafeStr_9617);
                if (this._SafeStr_9625.indexOf(_arg_1) == -1){
                    this._SafeStr_9625.push(_arg_1);
                };
            };
        }
        public function WindowRenderer():void
        {
            do  {
            } while (this._SafeStr_9625.pop() != null);
        }
        public function invalidate(_arg_1:IWindowContext, _arg_2:Rectangle):void
        {
            var _local_5:WindowController;
            var _local_3:IDesktopWindow = _arg_1.getDesktopWindow();
            var _local_4:uint = _local_3.numChildren;
            while (_local_4-- > 0) {
                _local_5 = (_local_3.getChildAt(_local_4) as WindowController);
                this.WindowRenderer(_local_5, _local_5.rectangle, WindowRedrawFlag._SafeStr_9133);
            };
        }
        protected function getWindowRendererItem(_arg_1:IWindow):WindowRendererItem
        {
            var _local_2:WindowRendererItem = (this._SafeStr_9629[_arg_1] as WindowRendererItem);
            if (_local_2 == null){
                this.WindowRenderer(_arg_1);
                _local_2 = this._SafeStr_9629[_arg_1];
            };
            return (_local_2);
        }
        public function WindowRenderer(_arg_1:IWindow):void
        {
            var _local_2:WindowRendererItem = (this._SafeStr_9629[_arg_1] as WindowRendererItem);
            if (_local_2 == null){
                _local_2 = new WindowRendererItem(this, this._drawBufferAllocator, this._skinContainer);
                this._SafeStr_9629[_arg_1] = _local_2;
                _arg_1.addEventListener(WindowDisposeEvent.WINDOW_DISPOSE_EVENT, this.WindowRenderer);
            };
        }
        public function WindowRenderer(_arg_1:IWindow):void
        {
            _arg_1.removeEventListener(WindowDisposeEvent.WINDOW_DISPOSE_EVENT, this.WindowRenderer);
            var _local_2:WindowRendererItem = (this._SafeStr_9629[_arg_1] as WindowRendererItem);
            if (_local_2 != null){
                _local_2.dispose();
                delete this._SafeStr_9629[_arg_1];
            };
        }
        private function WindowRenderer(_arg_1:WindowDisposeEvent):void
        {
            this.WindowRenderer(_arg_1.window);
        }
        public function WindowRenderer(_arg_1:IWindow):BitmapData
        {
            var _local_2:WindowRendererItem = (this._SafeStr_9629[_arg_1] as WindowRendererItem);
            return ((((_local_2)!=null) ? _local_2.buffer : null));
        }
        public function render():void
        {
            var _local_1:WindowController;
            var _local_3:WindowRendererItem;
            var _local_4:uint;
            var _local_2:uint = this._SafeStr_9625.length;
            _local_4 = 0;
            while (_local_4 < _local_2) {
                _local_1 = (this._SafeStr_9625.pop() as WindowController);
                if (!_local_1.disposed){
                    _local_3 = this.getWindowRendererItem(_local_1);
                    this._SafeStr_9628.x = _local_3.dirty.x;
                    this._SafeStr_9628.y = _local_3.dirty.y;
                    this._SafeStr_9628.width = _local_3.dirty.width;
                    this._SafeStr_9628.height = _local_3.dirty.height;
                    this.WindowRenderer(_local_1, this._SafeStr_9628, _local_1.rectangle.clone());
                };
                _local_4++;
            };
        }
        private function WindowRenderer(_arg_1:WindowController, _arg_2:Rectangle, _arg_3:Rectangle):void
        {
            var _local_4:uint;
            var _local_5:WindowController;
            var _local_6:Rectangle;
            var _local_7:Rectangle;
            var _local_8:uint;
            if (_arg_1.visible){
                if (WindowRenderer(_arg_1, _arg_2, this._SafeStr_9626, this._SafeStr_9627)){
                    if (this.getWindowRendererItem(_arg_1).render(_arg_1, this._SafeStr_9626, this._SafeStr_9627)){
                        _local_4 = _arg_1.numChildren;
                        if (_arg_1.clipping){
                            _local_6 = new Rectangle(Math.max(_arg_2.x, 0), Math.max(_arg_2.y, 0), Math.min(_arg_2.width, _arg_1.width), Math.min(_arg_2.height, _arg_1.height));
                            _arg_3 = _arg_3.intersection(_arg_1.rectangle);
                        }
                        else {
                            _local_6 = _arg_2;
                        };
                        _arg_3.offset(-(_arg_1.x), -(_arg_1.y));
                        _local_8 = 0;
                        while (_local_8 < _local_4) {
                            _local_5 = (_arg_1.getChildAt(_local_8) as WindowController);
                            _local_7 = _local_5.rectangle;
                            if (_local_7.intersects(_local_6)){
                                if (_local_5.IWindow(WindowParam._SafeStr_7443)){
                                    _local_6.offset(-(_local_7.x), -(_local_7.y));
                                    this.WindowRenderer(_local_5, _local_6, _arg_3);
                                    _local_6.offset(_local_7.x, _local_7.y);
                                }
                                else {
                                    if (_local_5.IWindow(WindowParam.WINDOW_PARAM_FORCE_CLIPPING)){
                                        this.WindowRenderer(_local_5, _local_6, _arg_3);
                                    };
                                };
                            }
                            else {
                                if (!_local_7.intersects(_arg_3)){
                                    if (_local_5.WindowController()){
                                        _local_5.getGraphicContext(true).visible = false;
                                    };
                                };
                            };
                            _local_8++;
                        };
                    };
                }
                else {
                    if (!_arg_1.IWindow(WindowParam._SafeStr_7443)){
                        if (_arg_1.IWindow(WindowParam.WINDOW_PARAM_FORCE_CLIPPING)){
                            _arg_1.getGraphicContext(true).IGraphicContext(_arg_1.rectangle, false, this._SafeStr_9627);
                            _arg_1.getGraphicContext(true).visible = false;
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.core.window.graphics

// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IWindowRenderer = "_-2Oq" (String#6539, DoABC#2)
// ISkinContainer = "_-us" (String#8781, DoABC#2)
// WindowDisposeEvent = "_-1nb" (String#5812, DoABC#2)
// DrawBufferAllocator = "_-2jz" (String#6955, DoABC#2)
// WindowRendererItem = "_-34q" (String#7405, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_9133 = "_-2xy" (String#21391, DoABC#2)
// IWindow = "_-1ml" (String#5794, DoABC#2)
// WINDOW_DISPOSE_EVENT = "_-2qj" (String#21111, DoABC#2)
// WindowRenderer = "_-1zA" (String#6020, DoABC#2)
// WindowRenderer = "_-2wd" (String#7216, DoABC#2)
// WindowRenderer = "_-2bf" (String#6787, DoABC#2)
// WindowController = "_-2yM" (String#7247, DoABC#2)
// IGraphicContext = "_-340" (String#7389, DoABC#2)
// dirty = "_-2Qa" (String#20068, DoABC#2)
// _SafeStr_9617 = "_-2fd" (String#20676, DoABC#2)
// _SafeStr_9625 = "_-2Sd" (String#20141, DoABC#2)
// _SafeStr_9626 = "_-1cB" (String#17978, DoABC#2)
// _SafeStr_9627 = "_-DE" (String#22739, DoABC#2)
// _SafeStr_9628 = "_-ze" (String#24675, DoABC#2)
// _SafeStr_9629 = "_-oB" (String#24197, DoABC#2)
// WindowRenderer = "_-0fF" (String#15640, DoABC#2)
// WindowController = "_-1gm" (String#18166, DoABC#2)
// WindowRenderer = "_-34w" (String#21693, DoABC#2)
// WindowRenderer = "_-1yc" (String#18913, DoABC#2)
// WindowRenderer = "_-13y" (String#16615, DoABC#2)
// WindowRenderer = "_-2lu" (String#20912, DoABC#2)


