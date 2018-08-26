
package com.sulake.habbo.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowState;

    public class WindowToggle implements IDisposable 
    {

        public static const RESULT_SHOW:int = 0;
        public static const _SafeStr_4579:int = 1;
        public static const _SafeStr_4580:int = 2;

        private var _window:IWindow;
        private var _SafeStr_4581:IDesktopWindow;
        private var _disposed:Boolean;
        private var _SafeStr_4582:Function;
        private var _SafeStr_4583:Function;

        public function WindowToggle(_arg_1:IWindow, _arg_2:IDesktopWindow, _arg_3:Function=null, _arg_4:Function=null)
        {
            this._window = _arg_1;
            this._SafeStr_4581 = _arg_2;
            this._SafeStr_4582 = _arg_3;
            this._SafeStr_4583 = _arg_4;
        }
        public static function WindowToggle(_arg_1:IWindow):Boolean
        {
            var _local_7:IWindow;
            var _local_2:IDesktopWindow = _arg_1.desktop;
            var _local_3:int = _local_2.numChildren;
            var _local_4:int = _local_2.getChildIndex(_arg_1);
            if (_local_4 < 0){
                throw (new Error("Window must be contained by the desktop!"));
            };
            var _local_5:Rectangle = new Rectangle();
            _arg_1.WindowController(_local_5);
            var _local_6:Rectangle = new Rectangle();
            var _local_8:int = (_local_4 + 1);
            while (_local_8 < _local_3) {
                _local_7 = _local_2.getChildAt(_local_8);
                if (_local_7.visible){
                    _local_7.WindowController(_local_6);
                    if (_local_5.intersects(_local_6)){
                        return (true);
                    };
                };
                _local_8++;
            };
            return (false);
        }

        public function get window():IWindow
        {
            return (this._window);
        }
        public function get visible():Boolean
        {
            return (((((this._window) && (this._window.visible))) && (this._window.parent)));
        }
        public function get active():Boolean
        {
            return (((this.visible) && (this._window.WindowController(WindowState._SafeStr_4586))));
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._window){
                    this._window.dispose();
                    this._window = null;
                };
                this._SafeStr_4581 = null;
                this._disposed = true;
                this._SafeStr_4582 = null;
                this._SafeStr_4583 = null;
            };
        }
        public function show():void
        {
            if (!this._window.disposed){
                if (this._window.parent != this._SafeStr_4581){
                    this._SafeStr_4581.addChild(this._window);
                };
                if (!this._window.visible){
                    this._window.visible = true;
                };
                this._window.activate();
            };
        }
        public function hide():void
        {
            if (!this._window.disposed){
                if (this._window.parent == this._SafeStr_4581){
                    this._SafeStr_4581.removeChild(this._window);
                };
                if (this._window.visible){
                    this._window.visible = false;
                };
                this._window.deactivate();
            };
        }
        public function toggle():int
        {
            if (this.visible){
                if (this.active){
                    if ((this._SafeStr_4583 == null)){
                        this.hide();
                    }
                    else {
                        this._SafeStr_4583.call();
                    };
                    return (_SafeStr_4580);
                };
                if (WindowToggle(this._window)){
                    this._window.activate();
                    return (_SafeStr_4579);
                };
                if ((this._SafeStr_4583 == null)){
                    this.hide();
                }
                else {
                    this._SafeStr_4583.call();
                };
                return (_SafeStr_4580);
            };
            if ((this._SafeStr_4582 == null)){
                this.show();
            }
            else {
                this._SafeStr_4582.call();
            };
            return (RESULT_SHOW);
        }

    }
}//package com.sulake.habbo.utils

// WindowToggle = "_-1Ud" (String#17689, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// WindowToggle = "_-1OQ" (String#17449, DoABC#2)
// toggle = "_-2MR" (String#19903, DoABC#2)
// _SafeStr_4579 = "_-sm" (String#24392, DoABC#2)
// _SafeStr_4580 = "_-0Ex" (String#14643, DoABC#2)
// _SafeStr_4581 = "_-3--" (String#7285, DoABC#2)
// _SafeStr_4582 = "_-PQ" (String#23223, DoABC#2)
// _SafeStr_4583 = "_-2mT" (String#20939, DoABC#2)
// WindowController = "_-05T" (String#3675, DoABC#2)
// WindowController = "_-1nM" (String#5804, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)


