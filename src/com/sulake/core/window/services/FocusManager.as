
package com.sulake.core.window.services
{
    import com.sulake.core.window.utils.ChildEntityArrayReader;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.display.DisplayObject;
    import com.sulake.core.window.components.IFocusWindow;
    import com.sulake.core.window.utils.*;

    public class FocusManager extends ChildEntityArrayReader implements IFocusManagerService 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_9650:Stage;

        public function FocusManager(_arg_1:DisplayObject)
        {
            this._SafeStr_9650 = _arg_1.stage;
            this._SafeStr_9650.addEventListener(Event.ACTIVATE, this.onActivateEvent);
            this._SafeStr_9650.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
            this._SafeStr_9650.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onFocusEvent);
            this._SafeStr_9650.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onFocusEvent);
            super();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._SafeStr_9650.removeEventListener(Event.ACTIVATE, this.onActivateEvent);
                this._SafeStr_9650.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
                this._SafeStr_9650.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onFocusEvent);
                this._SafeStr_9650.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onFocusEvent);
                this._SafeStr_9650 = null;
                this._disposed = true;
                _messageArray = null;
            };
        }
        public function registerFocusWindow(_arg_1:IFocusWindow):void
        {
            if (_arg_1 != null){
                if (_messageArray.indexOf(_arg_1) == -1){
                    _messageArray.push(_arg_1);
                    if (this._SafeStr_9650.focus == null){
                        _arg_1.focus();
                    };
                };
            };
        }
        public function removeFocusWindow(_arg_1:IFocusWindow):void
        {
            var _local_2:int;
            if (_arg_1 != null){
                _local_2 = _messageArray.indexOf(_arg_1);
                if (_local_2 > -1){
                    _messageArray.splice(_local_2, 1);
                };
            };
            if (this._SafeStr_9650.focus == null){
                this.resolveNextFocusTarget();
            };
        }
        private function resolveNextFocusTarget():IFocusWindow
        {
            var _local_2:IFocusWindow;
            var _local_1:uint = _messageArray.length;
            while (_local_1-- != 0) {
                _local_2 = (_messageArray[_local_1] as IFocusWindow);
                if (_local_2.disposed){
                    _messageArray.splice(_local_1, 1);
                }
                else {
                    _local_2.focus();
                    break;
                };
            };
            return (_local_2);
        }
        private function onActivateEvent(_arg_1:Event):void
        {
            if (this._SafeStr_9650.focus == null){
                this.resolveNextFocusTarget();
            };
        }
        private function onFocusEvent(_arg_1:FocusEvent):void
        {
            if (this._SafeStr_9650.focus == null){
                this.resolveNextFocusTarget();
            };
        }

    }
}//package com.sulake.core.window.services

// IFocusWindow = "_-1Ty" (String#5431, DoABC#2)
// IFocusManagerService = "_-0Jl" (String#3946, DoABC#2)
// ChildEntityArrayReader = "_-1e2" (String#5629, DoABC#2)
// FocusManager = "_-2tk" (String#7153, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// _SafeStr_9650 = "_-0MX" (String#4012, DoABC#2)
// onActivateEvent = "_-0Ry" (String#15134, DoABC#2)
// resolveNextFocusTarget = "_-fD" (String#23856, DoABC#2)


