
package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowEvent 
    {

        public static const WE_DESTROY:String = "WE_DESTROY";
        public static const WE_DESTROYED:String = "WE_DESTROYED";
        public static const WE_OPEN:String = "WE_OPEN";
        public static const WE_OPENED:String = "WE_OPENED";
        public static const WE_CLOSE:String = "WE_CLOSE";
        public static const WE_CLOSED:String = "WE_CLOSED";
        public static const WE_FOCUS:String = "WE_FOCUS";
        public static const WE_FOCUSED:String = "WE_FOCUSED";
        public static const WE_UNFOCUS:String = "WE_UNFOCUS";
        public static const WE_UNFOCUSED:String = "WE_UNFOCUSED";
        public static const WE_ACTIVATE:String = "WE_ACTIVATE";
        public static const WE_ACTIVATED:String = "WE_ACTIVATED";
        public static const WE_DEACTIVATE:String = "WE_DEACTIVATE";
        public static const WE_DEACTIVATED:String = "WE_DEACTIVATED";
        public static const WE_SELECT:String = "WE_SELECT";
        public static const WE_SELECTED:String = "WE_SELECTED";
        public static const WE_UNSELECT:String = "WE_UNSELECT";
        public static const WE_UNSELECTED:String = "WE_UNSELECTED";
        public static const WE_LOCK:String = "WE_LOCK";
        public static const WE_LOCKED:String = "WE_LOCKED";
        public static const WE_UNLOCK:String = "WE_UNLOCK";
        public static const WE_UNLOCKED:String = "WE_UNLOCKED";
        public static const WE_ENABLE:String = "WE_ENABLE";
        public static const WE_ENABLED:String = "WE_ENABLED";
        public static const WE_DISABLE:String = "WE_DISABLE";
        public static const WE_DISABLED:String = "WE_DISABLED";
        public static const WINDOW_EVENT_RELOCATE:String = "WE_RELOCATE";
        public static const WE_RELOCATED:String = "WE_RELOCATED";
        public static const WE_RESIZE:String = "WE_RESIZE";
        public static const WE_RESIZED:String = "WE_RESIZED";
        public static const WE_MINIMIZE:String = "WE_MINIMIZE";
        public static const WE_MINIMIZED:String = "WE_MINIMIZED";
        public static const WE_MAXIMIZE:String = "WE_MAXIMIZE";
        public static const WE_MAXIMIZED:String = "WE_MAXIMIZED";
        public static const WE_RESTORE:String = "WE_RESTORE";
        public static const WE_RESTORED:String = "WE_RESTORED";
        public static const WE_CHILD_ADDED:String = "WE_CHILD_ADDED";
        public static const WE_CHILD_REMOVED:String = "WE_CHILD_REMOVED";
        public static const WE_CHILD_RELOCATED:String = "WE_CHILD_RELOCATED";
        public static const WE_CHILD_RESIZED:String = "WE_CHILD_RESIZED";
        public static const WE_CHILD_ACTIVATED:String = "WE_CHILD_ACTIVATED";
        public static const WE_PARENT_ADDED:String = "WE_PARENT_ADDED";
        public static const WE_PARENT_REMOVED:String = "WE_PARENT_REMOVED";
        public static const WE_PARENT_RELOCATED:String = "WE_PARENT_RELOCATED";
        public static const WE_PARENT_RESIZED:String = "WE_PARENT_RESIZED";
        public static const WE_PARENT_ACTIVATED:String = "WE_PARENT_ACTIVATED";
        public static const WE_OK:String = "WE_OK";
        public static const WE_CANCEL:String = "WE_CANCEL";
        public static const WE_CHANGE:String = "WE_CHANGE";
        public static const WE_SCROLL:String = "WE_SCROLL";
        public static const POLL_OFFER_STATE_UNKNOWN:String = "";
        private static const POOL:Array = [];

        protected var _type:String;
        protected var _window:IWindow;
        protected var _related:IWindow;
        protected var _SafeStr_9530:Boolean;
        protected var set:Boolean;
        protected var _recycled:Boolean;
        protected var _SafeStr_9532:Array;

        public static function allocate(_arg_1:String, _arg_2:IWindow, _arg_3:IWindow, _arg_4:Boolean=false):WindowEvent
        {
            var _local_5:WindowEvent = (((POOL.length)>0) ? POOL.pop() : new (WindowEvent)());
            _local_5._type = _arg_1;
            _local_5._window = _arg_2;
            _local_5._related = _arg_3;
            _local_5.set = _arg_4;
            _local_5._recycled = false;
            _local_5._SafeStr_9532 = POOL;
            return (_local_5);
        }

        public function get type():String
        {
            return (this._type);
        }
        public function get target():IWindow
        {
            return (this._window);
        }
        public function get window():IWindow
        {
            return (this._window);
        }
        public function get related():IWindow
        {
            return (this._related);
        }
        public function get cancelable():Boolean
        {
            return (this.set);
        }
        public function recycle():void
        {
            if (this._recycled){
                throw (new Error("Event already recycled!"));
            };
            this._window = (this._related = null);
            this._recycled = true;
            this._SafeStr_9530 = false;
            this._SafeStr_9532.push(this);
        }
        public function clone():WindowEvent
        {
            return (allocate(this._type, this.window, this.related, this.cancelable));
        }
        public function preventDefault():void
        {
            this.preventWindowOperation();
        }
        public function isDefaultPrevented():Boolean
        {
            return (this._SafeStr_9530);
        }
        public function preventWindowOperation():void
        {
            if (this.cancelable){
                this._SafeStr_9530 = true;
            }
            else {
                throw (new Error("Attempted to prevent window operation that is not cancelable!"));
            };
        }
        public function isWindowOperationPrevented():Boolean
        {
            return (this._SafeStr_9530);
        }
        public function stopPropagation():void
        {
            this._SafeStr_9530 = true;
        }
        public function stopImmediatePropagation():void
        {
            this._SafeStr_9530 = true;
        }
        public function toString():String
        {
            return ((((((("WindowEvent { type: " + this._type) + " cancelable: ") + this.set) + " window: ") + this._window) + " }"));
        }

    }
}//package com.sulake.core.window.events

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WE_RELOCATED = "_-13s" (String#16612, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// WE_FOCUSED = "_-1ay" (String#17932, DoABC#2)
// WE_SELECT = "_-335" (String#21624, DoABC#2)
// WE_UNSELECTED = "_-1D" (String#16982, DoABC#2)
// WE_DEACTIVATED = "_-1oi" (String#18485, DoABC#2)
// WE_PARENT_RESIZED = "_-0GO" (String#14697, DoABC#2)
// WE_PARENT_ADDED = "_-0D7" (String#14572, DoABC#2)
// WE_UNSELECT = "_-sx" (String#24402, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// isWindowOperationPrevented = "_-27I" (String#19304, DoABC#2)
// WE_ACTIVATE = "_-3Ek" (String#22065, DoABC#2)
// WE_CHILD_ACTIVATED = "_-f-" (String#23845, DoABC#2)
// WE_PARENT_ACTIVATED = "_-1o3" (String#18465, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)
// WE_ENABLED = "_-2J1" (String#19767, DoABC#2)
// WE_DISABLED = "_-xm" (String#24603, DoABC#2)
// POLL_OFFER_STATE_UNKNOWN = "_-2VV" (String#20262, DoABC#2)
// related = "_-2Pu" (String#20039, DoABC#2)
// WE_ACTIVATED = "_-0ud" (String#16226, DoABC#2)
// WE_OPEN = "_-0hq" (String#15741, DoABC#2)
// WE_OPENED = "_-2AP" (String#19423, DoABC#2)
// WE_CLOSE = "_-1dD" (String#18023, DoABC#2)
// WE_CLOSED = "_-1da" (String#18038, DoABC#2)
// WE_CHILD_REMOVED = "_-r3" (String#24318, DoABC#2)
// WE_CHILD_RELOCATED = "_-30I" (String#21512, DoABC#2)
// WE_SCROLL = "_-DZ" (String#22752, DoABC#2)
// WE_RESIZE = "_-2Gi" (String#19669, DoABC#2)
// WE_DESTROYED = "_-2PT" (String#20021, DoABC#2)
// WE_CHILD_ADDED = "_-32L" (String#21593, DoABC#2)
// WE_DESTROY = "_-3Gv" (String#22159, DoABC#2)
// WE_FOCUS = "_-LB" (String#23053, DoABC#2)
// WE_UNFOCUS = "_-1n" (String#18420, DoABC#2)
// WE_UNFOCUSED = "_-1qe" (String#18569, DoABC#2)
// WE_DEACTIVATE = "_-2V8" (String#20244, DoABC#2)
// WE_LOCK = "_-1L3" (String#17316, DoABC#2)
// WE_LOCKED = "_-1M5" (String#17362, DoABC#2)
// WE_UNLOCK = "_-19f" (String#16844, DoABC#2)
// WE_UNLOCKED = "_-oZ" (String#24217, DoABC#2)
// WE_ENABLE = "_-0b-" (String#15474, DoABC#2)
// WE_DISABLE = "_-37c" (String#21791, DoABC#2)
// WE_MINIMIZE = "_-0tg" (String#16189, DoABC#2)
// WE_MINIMIZED = "_-0MR" (String#14932, DoABC#2)
// WE_MAXIMIZE = "_-Oy" (String#23205, DoABC#2)
// WE_MAXIMIZED = "_-0ar" (String#15468, DoABC#2)
// WE_RESTORE = "_-6J" (String#22478, DoABC#2)
// WE_RESTORED = "_-1WN" (String#17757, DoABC#2)
// WE_PARENT_REMOVED = "_-2NW" (String#19945, DoABC#2)
// WE_PARENT_RELOCATED = "_-1ei" (String#18086, DoABC#2)
// WE_CANCEL = "_-0gf" (String#15696, DoABC#2)
// _related = "_-2q8" (String#21086, DoABC#2)
// _SafeStr_9530 = "_-12O" (String#16554, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)
// _SafeStr_9532 = "_-Tf" (String#23392, DoABC#2)
// preventDefault = "_-0ee" (String#15611, DoABC#2)
// preventWindowOperation = "_-t2" (String#24408, DoABC#2)


