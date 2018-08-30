
package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.navigator.Util;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;

    public class ConfirmDialogView implements IDisposable 
    {

        private var _disposed:Boolean;
        private var _window:IFrameWindow;
        private var _SafeStr_6967:Function;
        private var _SafeStr_6968:Object;
        private var _messageArray:Array;

        public function ConfirmDialogView(_arg_1:IFrameWindow, _arg_2:Object, _arg_3:Function, _arg_4:Array)
        {
            this._window = _arg_1;
            this._SafeStr_6967 = _arg_3;
            this._SafeStr_6968 = _arg_2;
            this._messageArray = _arg_4;
            this._window.findChildByTag("close").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
            this._window.findChildByName("cancel").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
            this._window.findChildByName("ok").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOk);
        }
        private function onCancel(_arg_1:WindowMouseEvent):void
        {
            this.dispose();
        }
        private function onOk(_arg_1:WindowMouseEvent):void
        {
            this._SafeStr_6967.apply(this._SafeStr_6968, [_arg_1].concat(this._messageArray));
            this.dispose();
        }
        public function show():void
        {
            var _local_1:Rectangle = Util.getLocationRelativeTo(this._window.desktop, this._window.width, this._window.height);
            this._window.x = _local_1.x;
            this._window.y = _local_1.y;
            this._window.visible = true;
            this._window.activate();
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._window != null){
                this._window.destroy();
                this._window = null;
            };
            this._SafeStr_6968 = null;
            this._SafeStr_6967 = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set message(_arg_1:String):void
        {
            ITextWindow(this._window.findChildByName("message")).text = _arg_1;
        }

    }
}//package com.sulake.habbo.navigator.roomsettings

// Util = "_-1ve" (String#445, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// ConfirmDialogView = "_-2FS" (String#6352, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// getLocationRelativeTo = "_-2tz" (String#21236, DoABC#2)
// _SafeStr_6967 = "_-1Ff" (String#17102, DoABC#2)
// _SafeStr_6968 = "_-1Kg" (String#17301, DoABC#2)
// _messageArray = "_-0uz" (String#1576, DoABC#2)
// onCancel = "_-3JX" (String#633, DoABC#2)
// onOk = "_-39j" (String#457, DoABC#2)


