
package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.enum.WindowStyle;

    public class WindowRendererItem implements IDisposable 
    {

        private static const _SafeStr_9603:uint = 0;
        private static const _SafeStr_9604:uint = 1;
        private static const _SafeStr_9605:uint = 2;

        private var _buffer:BitmapData;
        private var _RoomInstance:WindowRenderer;
        private var _skinContainer:ISkinContainer;
        private var _drawBufferAllocator:DrawBufferAllocator;
        private var _disposed:Boolean;
        private var _SafeStr_9607:Boolean;
        private var _dirty:Rectangle;
        private var _SafeStr_4063:Matrix;
        private var _colorTransform:ColorTransform;
        private var _SafeStr_9609:uint;
        private var _SafeStr_9610:uint;

        public function WindowRendererItem(_arg_1:WindowRenderer, _arg_2:DrawBufferAllocator, _arg_3:ISkinContainer)
        {
            this._disposed = false;
            this._RoomInstance = _arg_1;
            this._skinContainer = _arg_3;
            this._drawBufferAllocator = _arg_2;
            this._SafeStr_9609 = 0xFFFFFFFF;
            this._SafeStr_9610 = 0;
            this._colorTransform = new ColorTransform();
            this._SafeStr_4063 = new Matrix();
            this._dirty = new Rectangle();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get buffer():BitmapData
        {
            return (this._buffer);
        }
        public function get dirty():Rectangle
        {
            return (this._dirty);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
                this._RoomInstance = null;
                this._skinContainer = null;
                if (this._buffer != null){
                    this._drawBufferAllocator.free(this._buffer);
                    this._buffer = null;
                };
            };
        }
        public function render(_arg_1:IWindow, _arg_2:Point, _arg_3:Rectangle):Boolean
        {
            var _local_4:BitmapData;
            var _local_12:Boolean;
            var _local_5:uint = ((_arg_1.background) ? _SafeStr_9605 : _SafeStr_9603);
            var _local_6:Boolean = (((this._dirty.width > 0)) && ((this._dirty.height > 0)));
            var _local_7:ISkinRenderer = this.resolveSkinRenderer(_arg_1);
            if (_local_7 != null){
                if (_local_7.isStateDrawable(this._SafeStr_9610)){
                    _local_5 = _SafeStr_9604;
                };
            };
            var _local_8:int = Math.max(_arg_1.width, 1);
            var _local_9:int = Math.max(_arg_1.height, 1);
            var _local_10:Boolean = true;
            if (_local_5 != _SafeStr_9603){
                if (this._buffer == null){
                    this._buffer = this._drawBufferAllocator.allocate(_local_8, _local_9, true, _arg_1.color);
                    this._SafeStr_9607 = true;
                    _local_6 = true;
                    _local_10 = false;
                }
                else {
                    if (((!((this._buffer.width == _local_8))) || (!((this._buffer.height == _local_9))))){
                        this._drawBufferAllocator.free(this._buffer);
                        this._buffer = this._drawBufferAllocator.allocate(_local_8, _local_9, true, _arg_1.color);
                        this._SafeStr_9607 = true;
                        _local_6 = true;
                        _local_10 = false;
                    };
                };
            };
            var _local_11:IGraphicContext = IGraphicContextHost(_arg_1).getGraphicContext(false);
            if (_local_11){
                if (!_local_11.visible){
                    _local_11.visible = true;
                };
                _local_12 = _arg_1.IWindow(WindowParam.WINDOW_PARAM_FORCE_CLIPPING);
                _local_11.IGraphicContext(_arg_1.rectangle, !(_arg_1.IWindow(WindowParam._SafeStr_7443)), ((_local_12) ? _arg_3 : null));
                if (_local_12){
                    _arg_3 = new Rectangle(0, 0, _local_8, _local_9);
                };
            };
            if (_local_5 != _SafeStr_9603){
                this._SafeStr_9609 = this._SafeStr_9610;
                _local_4 = (_arg_1.WindowController() as BitmapData);
                if (_local_4 != null){
                    _local_4.lock();
                    if (_local_5 == _SafeStr_9604){
                        _local_6 = true;
                        if (!_arg_1.IWindow(WindowParam._SafeStr_7443)){
                            _local_4.fillRect(_arg_3, 0);
                        };
                        if (this._SafeStr_9607){
                            this._SafeStr_9607 = false;
                            if (_local_10){
                                this._buffer.fillRect(this._buffer.rect, _arg_1.color);
                            };
                            _local_7.draw(_arg_1, this._buffer, this._buffer.rect, this._SafeStr_9610, false);
                        };
                        if ((((_arg_1.blend < 1)) && (_arg_1.IWindow(WindowParam._SafeStr_7443)))){
                            this._SafeStr_4063.tx = _arg_2.x;
                            this._SafeStr_4063.ty = _arg_2.y;
                            this._colorTransform.alphaMultiplier = _arg_1.blend;
                            _arg_3.offset(_arg_2.x, _arg_2.y);
                            _local_4.draw(this._buffer, this._SafeStr_4063, this._colorTransform, null, _arg_3, false);
                            _arg_3.offset(-(_arg_2.x), -(_arg_2.y));
                        }
                        else {
                            _local_4.copyPixels(this._buffer, _arg_3, _arg_2, null, null, true);
                        };
                    }
                    else {
                        if (_local_5 == _SafeStr_9605){
                            _local_6 = true;
                            if (_arg_1.IWindow(WindowParam._SafeStr_7443)){
                                this._buffer.fillRect(this._buffer.rect, _arg_1.color);
                                _local_4.copyPixels(this._buffer, _arg_3, _arg_2, null, null, true);
                            }
                            else {
                                _local_4.fillRect(new Rectangle(_arg_2.x, _arg_2.y, _arg_3.width, _arg_3.height), _arg_1.color);
                                _local_11.blend = _arg_1.blend;
                            };
                        };
                    };
                    _local_4.unlock();
                };
                this._dirty.left = int.MAX_VALUE;
                this._dirty.top = int.MAX_VALUE;
                this._dirty.right = int.MIN_VALUE;
                this._dirty.bottom = int.MIN_VALUE;
            };
            return (true);
        }
        private function resolveSkinRenderer(_arg_1:IWindow):ISkinRenderer
        {
            var _local_2:ISkinRenderer = this._skinContainer.getSkinRendererByTypeAndStyle(_arg_1.type, _arg_1.style);
            if (_local_2 == null){
                if (_arg_1.style != WindowStyle._SafeStr_9310){
                    _local_2 = this._skinContainer.getSkinRendererByTypeAndStyle(_arg_1.type, WindowStyle._SafeStr_9310);
                };
            };
            return (_local_2);
        }
        public function testForStateChange(_arg_1:IWindow):Boolean
        {
            return (!((this._skinContainer.getTheActualState(_arg_1.type, _arg_1.style, _arg_1.state) == this._SafeStr_9609)));
        }
        public function invalidate(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):Boolean
        {
            var _local_5:IGraphicContext;
            var _local_4:Boolean;
            switch (_arg_3){
                case WindowRedrawFlag._SafeStr_9133:
                    this._SafeStr_9607 = true;
                    _local_4 = true;
                    break;
                case WindowRedrawFlag.RESIZE:
                    this._SafeStr_9607 = true;
                    _local_4 = true;
                    break;
                case WindowRedrawFlag._SafeStr_9614:
                    if (_arg_1.IWindow(WindowParam._SafeStr_7443)){
                        _local_4 = true;
                    }
                    else {
                        _local_5 = IGraphicContextHost(_arg_1).getGraphicContext(true);
                        _local_5.IGraphicContext(_arg_1.rectangle, false, null);
                        if (!_local_5.visible){
                            _local_4 = true;
                        };
                    };
                    break;
                case WindowRedrawFlag._SafeStr_9615:
                    this._SafeStr_9610 = this._skinContainer.getTheActualState(_arg_1.type, _arg_1.style, _arg_1.state);
                    if (this._SafeStr_9610 != this._SafeStr_9609){
                        this._SafeStr_9607 = true;
                        _local_4 = true;
                    };
                    break;
                case WindowRedrawFlag._SafeStr_9616:
                    if (_arg_1.IWindow(WindowParam._SafeStr_7443)){
                        this._SafeStr_9607 = true;
                        _local_4 = true;
                    }
                    else {
                        IGraphicContextHost(_arg_1).getGraphicContext(true).blend = _arg_1.blend;
                    };
                    break;
                case WindowRedrawFlag._SafeStr_9617:
                    _local_4 = true;
                    break;
            };
            if (_local_4){
                this._dirty.left = Math.min(this._dirty.left, _arg_2.left);
                this._dirty.top = Math.min(this._dirty.top, _arg_2.top);
                this._dirty.right = Math.max(this._dirty.right, _arg_2.right);
                this._dirty.bottom = Math.max(this._dirty.bottom, _arg_2.bottom);
            };
            return (_local_4);
        }
        private function drawRect(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:uint):void
        {
            var _local_4:int;
            _local_4 = _arg_2.left;
            while (_local_4 < _arg_2.right) {
                _arg_1.setPixel32(_local_4, _arg_2.top, _arg_3);
                _arg_1.setPixel32(_local_4, (_arg_2.bottom - 1), _arg_3);
                _local_4++;
            };
            _local_4 = _arg_2.top;
            while (_local_4 < _arg_2.bottom) {
                _arg_1.setPixel32(_arg_2.left, _local_4, _arg_3);
                _arg_1.setPixel32((_arg_2.right - 1), _local_4, _arg_3);
                _local_4++;
            };
        }

    }
}//package com.sulake.core.window.graphics

// ISkinContainer = "_-us" (String#8781, DoABC#2)
// IGraphicContextHost = "_-2on" (String#1945, DoABC#2)
// ISkinRenderer = "_-1uJ" (String#1780, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// DrawBufferAllocator = "_-2jz" (String#6955, DoABC#2)
// WindowRendererItem = "_-34q" (String#7405, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// _SafeStr_4063 = "_-09E" (String#808, DoABC#2)
// _colorTransform = "_-0yf" (String#300, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _RoomInstance = "_-32W" (String#628, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _SafeStr_9133 = "_-2xy" (String#21391, DoABC#2)
// IWindow = "_-1ml" (String#5794, DoABC#2)
// WindowController = "_-0oc" (String#1553, DoABC#2)
// _SafeStr_9310 = "_-2-h" (String#19000, DoABC#2)
// getSkinRendererByTypeAndStyle = "_-0j" (String#4480, DoABC#2)
// getTheActualState = "_-0Or" (String#4067, DoABC#2)
// IGraphicContext = "_-340" (String#7389, DoABC#2)
// _SafeStr_9603 = "_-1fQ" (String#18114, DoABC#2)
// _SafeStr_9604 = "_-2RY" (String#20100, DoABC#2)
// _SafeStr_9605 = "_-1yJ" (String#18900, DoABC#2)
// _buffer = "_-2PU" (String#20022, DoABC#2)
// _SafeStr_9607 = "_-0Dq" (String#14600, DoABC#2)
// _dirty = "_-2eo" (String#20638, DoABC#2)
// _SafeStr_9609 = "_-lv" (String#24106, DoABC#2)
// _SafeStr_9610 = "_-0pR" (String#16033, DoABC#2)
// dirty = "_-2Qa" (String#20068, DoABC#2)
// resolveSkinRenderer = "_-2F6" (String#19609, DoABC#2)
// testForStateChange = "_-2Fl" (String#19633, DoABC#2)
// _SafeStr_9614 = "_-u3" (String#24452, DoABC#2)
// _SafeStr_9615 = "_-2xY" (String#21375, DoABC#2)
// _SafeStr_9616 = "_-1DN" (String#5132, DoABC#2)
// _SafeStr_9617 = "_-2fd" (String#20676, DoABC#2)


