
package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.events.TimerEvent;

    public class Icon implements IDisposable 
    {

        protected static const _SafeStr_5289:int = 0;
        protected static const _SafeStr_5290:int = 1;
        protected static const _SafeStr_5291:int = 2;
        protected static const _SafeStr_5292:int = 3;
        protected static const _SafeStr_4863:int = 4;
        protected static const _SafeStr_5293:int = 8;
        protected static const _SafeStr_4862:int = 18;
        protected static const _SafeStr_5294:int = 18;

        private var _disposed:Boolean = false;
        private var _disabled:Boolean = false;
        protected var _image:BitmapDataAsset;
        protected var _canvas:IBitmapWrapperWindow;
        private var _alignment:uint;
        protected var _SafeStr_5297:Timer;
        protected var _frame:int = 0;
        private var _SafeStr_5298:Point;
        protected var _SafeStr_5299:Boolean = false;
        protected var _hover:Boolean = false;

        public function Icon()
        {
            this._alignment = (_SafeStr_5290 | _SafeStr_5293);
            this._SafeStr_5298 = new Point();
            super();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get disabled():Boolean
        {
            return (this._disabled);
        }
        protected function set image(_arg_1:BitmapDataAsset):void
        {
            this._image = _arg_1;
            this.redraw();
        }
        protected function get image():BitmapDataAsset
        {
            return (this._image);
        }
        protected function set canvas(_arg_1:IBitmapWrapperWindow):void
        {
            this._canvas = _arg_1;
            this.redraw();
        }
        protected function get canvas():IBitmapWrapperWindow
        {
            return (this._canvas);
        }
        protected function set alignment(_arg_1:uint):void
        {
            this._alignment = _arg_1;
            this.redraw();
        }
        protected function get alignment():uint
        {
            return (this._alignment);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this.toggleTimer(false, 0);
                this.image = null;
                this.canvas = null;
                this._disposed = true;
            };
        }
        public function notify(_arg_1:Boolean):void
        {
            this._SafeStr_5299 = _arg_1;
            if (((this._SafeStr_5299) && (this._disabled))){
                this.enable(true);
            };
        }
        public function hover(_arg_1:Boolean):void
        {
            this._hover = _arg_1;
        }
        public function enable(_arg_1:Boolean):void
        {
            this._disabled = !(_arg_1);
        }
        protected function redraw():void
        {
            var _local_1:BitmapData;
            if (((this._canvas) && (!(this._canvas.disposed)))){
                if (!this._canvas.bitmap){
                    this._canvas.bitmap = new BitmapData(this._canvas.width, this._canvas.height, true, 0);
                }
                else {
                    this._canvas.bitmap.fillRect(this._canvas.bitmap.rect, 0);
                };
                if (((this._image) && (!(this._image.disposed)))){
                    this._SafeStr_5298.x = (this._SafeStr_5298.y = 0);
                    _local_1 = (this._image.content as BitmapData);
                    switch ((this._alignment & _SafeStr_5292)){
                        case _SafeStr_5290:
                            this._SafeStr_5298.x = ((this._canvas.bitmap.width / 2) - (_local_1.width / 2));
                            break;
                        case _SafeStr_5291:
                            this._SafeStr_5298.x = (this._canvas.bitmap.width - _local_1.width);
                            break;
                    };
                    switch ((this._alignment & _SafeStr_5294)){
                        case _SafeStr_5293:
                            this._SafeStr_5298.y = ((this._canvas.bitmap.height / 2) - (_local_1.height / 2));
                            break;
                        case _SafeStr_4862:
                            this._SafeStr_5298.y = (this._canvas.bitmap.height - _local_1.height);
                            break;
                    };
                    this._canvas.bitmap.copyPixels(_local_1, _local_1.rect, this._SafeStr_5298);
                    this._canvas.invalidate();
                };
            };
        }
        protected function toggleTimer(_arg_1:Boolean, _arg_2:int):void
        {
            if (_arg_1){
                if (!this._SafeStr_5297){
                    this._SafeStr_5297 = new Timer(_arg_2, 0);
                    this._SafeStr_5297.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
                    this._SafeStr_5297.start();
                    this.onTimerEvent(null);
                };
                this._SafeStr_5297.delay = _arg_2;
            }
            else {
                this._frame = 0;
                if (this._SafeStr_5297){
                    this._SafeStr_5297.reset();
                    this._SafeStr_5297.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
                    this._SafeStr_5297 = null;
                };
            };
        }
        protected function onTimerEvent(_arg_1:TimerEvent):void
        {
        }

    }
}//package com.sulake.habbo.friendbar.view.utils

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Icon = "_-2AV" (String#6254, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _canvas = "_-0Xp" (String#588, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _SafeStr_4862 = "_-3BX" (String#7541, DoABC#2)
// _SafeStr_4863 = "_-0Ny" (String#4045, DoABC#2)
// _SafeStr_5289 = "_-bf" (String#23699, DoABC#2)
// _SafeStr_5290 = "_-1mA" (String#18386, DoABC#2)
// _SafeStr_5291 = "_-1OH" (String#17444, DoABC#2)
// _SafeStr_5292 = "_-X1" (String#23523, DoABC#2)
// _SafeStr_5293 = "_-275" (String#19295, DoABC#2)
// _SafeStr_5294 = "_-0Jn" (String#14834, DoABC#2)
// _disabled = "_-2lG" (String#1933, DoABC#2)
// _alignment = "_-1UN" (String#17680, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// _SafeStr_5298 = "_-180" (String#16776, DoABC#2)
// _SafeStr_5299 = "_-mi" (String#24137, DoABC#2)
// redraw = "_-0dk" (String#15573, DoABC#2)
// alignment = "_-2Dg" (String#19553, DoABC#2)
// toggleTimer = "_-0Lc" (String#14898, DoABC#2)
// hover = "_-27m" (String#19322, DoABC#2)


