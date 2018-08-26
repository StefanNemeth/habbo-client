
package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import flash.events.TimerEvent;

    public class DropAnimation implements IDisposable 
    {

        private var _SafeStr_5297:Timer;
        private var _window:IWindow;
        private var _duration:int;
        private var _height:int;
        private var _offset:int;
        private var _SafeStr_5307:int;
        private var _SafeStr_5308:int;

        public function DropAnimation(_arg_1:IWindow, _arg_2:int, _arg_3:int)
        {
            this._window = _arg_1;
            this._duration = _arg_2;
            this._height = _arg_3;
            this._offset = this._window.y;
            this._window.y = (this._offset - _arg_3);
            this._SafeStr_5307 = getTimer();
            this._SafeStr_5308 = this._SafeStr_5307;
            this._SafeStr_5297 = new Timer((1000 / 24), 0);
            this._SafeStr_5297.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this._SafeStr_5297.start();
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_5297 == null));
        }
        public function dispose():void
        {
            if (this._SafeStr_5297){
                this._SafeStr_5297.stop();
                this._SafeStr_5297.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
                this._SafeStr_5297 = null;
            };
            if (((this._window) && (!(this._window.disposed)))){
                this._window.y = this._offset;
                this._window = null;
            };
        }
        private function onTimerEvent(_arg_1:TimerEvent):void
        {
            if (((!(this._window)) || (this._window.disposed))){
                this.dispose();
                return;
            };
            this._SafeStr_5307 = getTimer();
            var _local_2:Number = (Number((this._SafeStr_5307 - this._SafeStr_5308)) / Number(this._duration));
            this._window.y = ((this._offset - this._height) + (this.DropAnimation(_local_2) * this._height));
            if (_local_2 >= 1){
                this.dispose();
            };
        }
        protected function DropAnimation(_arg_1:Number):Number
        {
            if (_arg_1 < (1 / 2.75)){
                return (((7.5625 * _arg_1) * _arg_1));
            };
            if (_arg_1 < (2 / 2.75)){
                _arg_1 = (_arg_1 - (1.5 / 2.75));
                return ((((7.5625 * _arg_1) * _arg_1) + 0.75));
            };
            if (_arg_1 < (2.5 / 2.75)){
                _arg_1 = (_arg_1 - (2.25 / 2.75));
                return ((((7.5625 * _arg_1) * _arg_1) + 0.9375));
            };
            _arg_1 = (_arg_1 - (2.625 / 2.75));
            return ((((7.5625 * _arg_1) * _arg_1) + 0.984375));
        }

    }
}//package com.sulake.habbo.friendbar.view.utils

// IDisposable = "_-0dY" (String#4382, DoABC#2)
// DropAnimation = "_-2du" (String#20598, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// _duration = "_-1OY" (String#606, DoABC#2)
// _SafeStr_5307 = "_-280" (String#19331, DoABC#2)
// _SafeStr_5308 = "_-2zi" (String#21448, DoABC#2)
// DropAnimation = "_-0yA" (String#16358, DoABC#2)


