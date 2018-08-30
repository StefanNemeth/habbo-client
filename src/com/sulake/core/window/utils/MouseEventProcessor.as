
package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContextStateListener;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.events.MouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IInteractiveWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.*;

    public class MouseEventProcessor implements IEventProcessor, IDisposable 
    {

        protected static var _SafeStr_9719:Array;
        protected static var _SafeStr_9720:Array;
        protected static var _SafeStr_9721:Point = new Point();

        protected var _SafeStr_9722:Point;
        protected var _SafeStr_8620:WindowController;
        protected var _SafeStr_8618:WindowController;
        protected var _renderer:IWindowRenderer;
        protected var _desktopWindow:IDesktopWindow;
        protected var _SafeStr_8623:Vector.<IWindowContextStateListener>;
        private var _disposed:Boolean = false;

        public function MouseEventProcessor()
        {
            this._SafeStr_9722 = new Point();
            if (_SafeStr_9719 == null){
                _SafeStr_9719 = new Array();
                _SafeStr_9719[0] = MouseCursorType._SafeStr_9484;
                _SafeStr_9719[1] = MouseCursorType._SafeStr_3729;
                _SafeStr_9719[2] = MouseCursorType._SafeStr_9484;
                _SafeStr_9719[3] = MouseCursorType._SafeStr_9484;
                _SafeStr_9719[4] = MouseCursorType._SafeStr_9484;
                _SafeStr_9719[5] = MouseCursorType._SafeStr_3729;
                _SafeStr_9719[6] = MouseCursorType._SafeStr_9484;
            };
            if (_SafeStr_9720 == null){
                _SafeStr_9720 = new Array();
                _SafeStr_9720[0] = WindowState._SafeStr_4586;
                _SafeStr_9720[1] = WindowState._SafeStr_9170;
                _SafeStr_9720[2] = WindowState._SafeStr_5004;
                _SafeStr_9720[3] = WindowState._SafeStr_9479;
                _SafeStr_9720[4] = WindowState._SafeStr_9258;
                _SafeStr_9720[5] = WindowState._SafeStr_6248;
                _SafeStr_9720[6] = WindowState._SafeStr_9399;
            };
        }
        public static function setMouseCursorByState(_arg_1:uint, _arg_2:uint):void
        {
            var _local_3:int = _SafeStr_9720.indexOf(_arg_1);
            if (_local_3 > -1){
                _SafeStr_9719[_local_3] = _arg_2;
            };
        }
        public static function getMouseCursorByState(_arg_1:uint):uint
        {
            var _local_2:uint = _SafeStr_9720.length;
            while (_local_2-- > 0) {
                if ((_arg_1 & _SafeStr_9720[_local_2]) > 0){
                    return (_SafeStr_9719[_local_2]);
                };
            };
            return (MouseCursorType._SafeStr_3729);
        }
        protected static function convertMouseEventType(_arg_1:MouseEvent, _arg_2:IWindow, _arg_3:IWindow):WindowMouseEvent
        {
            var _local_4:String;
            var _local_5:Point;
            var _local_6:Boolean;
            _local_5 = new Point(_arg_1.stageX, _arg_1.stageY);
            _arg_2.convertPointFromGlobalToLocalSpace(_local_5);
            switch (_arg_1.type){
                case MouseEvent.MOUSE_MOVE:
                    _local_4 = WindowMouseEvent.WME_MOVE;
                    break;
                case MouseEvent.MOUSE_OVER:
                    _local_4 = WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER;
                    break;
                case MouseEvent.MOUSE_OUT:
                    _local_4 = WindowMouseEvent.WME_OUT;
                    break;
                case MouseEvent.ROLL_OUT:
                    _local_4 = WindowMouseEvent.WME_ROLL_OUT;
                    break;
                case MouseEvent.ROLL_OVER:
                    _local_4 = WindowMouseEvent.WME_ROLL_OVER;
                    break;
                case MouseEvent.CLICK:
                    _local_4 = WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK;
                    break;
                case MouseEvent.DOUBLE_CLICK:
                    _local_4 = WindowMouseEvent.WME_DOUBLE_CLICK;
                    break;
                case MouseEvent.MOUSE_DOWN:
                    _local_4 = WindowMouseEvent.WME_DOWN;
                    break;
                case MouseEvent.MOUSE_UP:
                    _local_6 = (((((((_local_5.x > -1)) && ((_local_5.y > -1)))) && ((_local_5.x < _arg_2.width)))) && ((_local_5.y < _arg_2.height)));
                    _local_4 = ((_local_6) ? WindowMouseEvent.WME_UP : WindowMouseEvent.WME_UP_OUTSIDE);
                    break;
                case MouseEvent.MOUSE_WHEEL:
                    _local_4 = WindowMouseEvent.WME_WHEEL;
                    break;
                default:
                    _local_4 = WindowEvent.POLL_OFFER_STATE_UNKNOWN;
            };
            return (WindowMouseEvent.allocate(_local_4, _arg_2, _arg_3, _local_5.x, _local_5.y, _arg_1.stageX, _arg_1.stageY, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown, _arg_1.delta));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
            };
        }
        public function process(state:EventProcessorState, eventQueue:IEventQueue):void
        {
            var event:MouseEvent;
            var index:int;
            var child:WindowController;
            var array:Array;
            var tempWindowEvent:WindowEvent;
            var window:IWindow;
            var temp:IWindow;
            var tracker:IWindowContextStateListener;
            if (eventQueue.length == 0){
                return;
            };
            this._desktopWindow = state.desktop;
            this._SafeStr_8618 = (state._SafeStr_8619 as WindowController);
            this._SafeStr_8620 = (state._SafeStr_8621 as WindowController);
            this._renderer = state.renderer;
            this._SafeStr_8623 = state._SafeStr_8624;
            eventQueue.begin();
            this._SafeStr_9722.x = -1;
            this._SafeStr_9722.y = -1;
            var mouseCursorType:int = MouseCursorType._SafeStr_3729;
            while (true) {
                event = (eventQueue.next() as MouseEvent);
                if (event == null) break;
                if (((!((event.stageX == this._SafeStr_9722.x))) || (!((event.stageY == this._SafeStr_9722.y))))){
                    this._SafeStr_9722.x = event.stageX;
                    this._SafeStr_9722.y = event.stageY;
                    array = new Array();
                    this._desktopWindow.groupParameterFilteredChildrenUnderPoint(this._SafeStr_9722, array, WindowParam._SafeStr_7434);
                };
                index = (((array)!=null) ? array.length : 0);
                if (index == 0){
                    switch (event.type){
                        case MouseEvent.MOUSE_MOVE:
                            if (((!((this._SafeStr_8618 == this._desktopWindow))) && (!(this._SafeStr_8618.disposed)))){
                                this._SafeStr_8618.getGlobalPosition(_SafeStr_9721);
                                tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.WME_OUT, this._SafeStr_8618, null, (event.stageX - _SafeStr_9721.x), (event.stageY - _SafeStr_9721.y), event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                this._SafeStr_8618.update(this._SafeStr_8618, tempWindowEvent);
                                this._SafeStr_8618 = WindowController(this._desktopWindow);
                                tempWindowEvent.recycle();
                            };
                            break;
                        case MouseEvent.MOUSE_DOWN:
                            window = this._desktopWindow.getActiveWindow();
                            if (window){
                                window.deactivate();
                            };
                            break;
                        case MouseEvent.MOUSE_UP:
                            if (this._SafeStr_8620){
                                array.push(this._SafeStr_8620);
                                index = (index + 1);
                            };
                            break;
                    };
                };
                while (--index > -1) {
                    child = this.passMouseEvent(WindowController(array[index]), event);
                    if (((!((child == null))) && (child.visible))){
                        if (event.type == MouseEvent.MOUSE_MOVE){
                            if (child != this._SafeStr_8618){
                                if (!this._SafeStr_8618.disposed){
                                    this._SafeStr_8618.getGlobalPosition(_SafeStr_9721);
                                    tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.WME_OUT, this._SafeStr_8618, child, (event.stageX - _SafeStr_9721.x), (event.stageY - _SafeStr_9721.y), event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                    this._SafeStr_8618.update(this._SafeStr_8618, tempWindowEvent);
                                    tempWindowEvent.recycle();
                                };
                                if (!child.disposed){
                                    child.getGlobalPosition(_SafeStr_9721);
                                    tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, child, null, (event.stageX - _SafeStr_9721.x), (event.stageY - _SafeStr_9721.y), event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                    child.update(child, tempWindowEvent);
                                    tempWindowEvent.recycle();
                                };
                                if (!child.disposed){
                                    this._SafeStr_8618 = child;
                                };
                            };
                        }
                        else {
                            if ((((((event.type == MouseEvent.MOUSE_UP)) || ((event.type == MouseEvent.CLICK)))) || ((event.type == MouseEvent.MOUSE_DOWN)))){
                                if (((this._SafeStr_8618) && (!(this._SafeStr_8618.disposed)))){
                                    if (this._SafeStr_8623 != null){
                                        for each (tracker in this._SafeStr_8623) {
                                            tracker.mouseEventReceived(event.type, this._SafeStr_8618);
                                        };
                                    };
                                };
                            };
                        };
                        temp = child.parent;
                        while (((temp) && (!(temp.disposed)))) {
                            if ((temp is IInputProcessorRoot)){
                                tempWindowEvent = convertMouseEventType(event, temp, child);
                                IInputProcessorRoot(temp).process(tempWindowEvent);
                                tempWindowEvent.recycle();
                                break;
                            };
                            temp = temp.parent;
                        };
                        if (event.altKey){
                            if (this._SafeStr_8618){
                                Logger.log(("HOVER: " + this._SafeStr_8618.name));
                            };
                        };
                        if ((this._SafeStr_8618 is IInteractiveWindow)){
                            try {
                                mouseCursorType = IInteractiveWindow(this._SafeStr_8618).getMouseCursorByState(this._SafeStr_8618.state);
                                if (mouseCursorType == MouseCursorType._SafeStr_3729){
                                    mouseCursorType = getMouseCursorByState(this._SafeStr_8618.state);
                                };
                            }
                            catch(e:Error) {
                                mouseCursorType = MouseCursorType._SafeStr_3729;
                            };
                        };
                        if (child != this._desktopWindow){
                            event.stopPropagation();
                            eventQueue.remove();
                        };
                        break;
                    };
                };
            };
            eventQueue.end();
            MouseCursorControl.type = mouseCursorType;
            state.desktop = this._desktopWindow;
            state._SafeStr_8619 = this._SafeStr_8618;
            state._SafeStr_8621 = this._SafeStr_8620;
            state.renderer = this._renderer;
            state._SafeStr_8624 = this._SafeStr_8623;
        }
        private function passMouseEvent(_arg_1:WindowController, _arg_2:MouseEvent, _arg_3:Boolean=false):WindowController
        {
            var _local_9:BitmapData;
            if (_arg_1.disposed){
                return (null);
            };
            if (_arg_1.testStateFlag(WindowState._SafeStr_9399)){
                return (null);
            };
            var _local_4:Boolean;
            var _local_5:Point = new Point(_arg_2.stageX, _arg_2.stageY);
            _arg_1.convertPointFromGlobalToLocalSpace(_local_5);
            if (_arg_2.type == MouseEvent.MOUSE_UP){
                if (_arg_1 != this._SafeStr_8620){
                    if (((this._SafeStr_8620) && (!(this._SafeStr_8620.disposed)))){
                        this._SafeStr_8620.update(this._SafeStr_8620, convertMouseEventType(new MouseEvent(MouseEvent.MOUSE_UP, false, true, _arg_2.localX, _arg_2.localY, null, _arg_2.ctrlKey, _arg_2.altKey, _arg_2.shiftKey, _arg_2.buttonDown, _arg_2.delta), this._SafeStr_8620, _arg_1));
                        this._SafeStr_8620 = null;
                        if (_arg_1.disposed){
                            return (null);
                        };
                    };
                }
                else {
                    _local_4 = !(_arg_1.hitTestLocalPoint(_local_5));
                };
            };
            if (!_local_4){
                _local_9 = this._renderer.getDrawBufferForRenderable(_arg_1);
                if (!_arg_1.validateLocalPointIntersection(_local_5, _local_9)){
                    return (null);
                };
            };
            if (_arg_1.testParamFlag(WindowParam._SafeStr_7438)){
                if (_arg_1.parent != null){
                    return (this.passMouseEvent(WindowController(_arg_1.parent), _arg_2));
                };
            };
            if (!_arg_3){
                switch (_arg_2.type){
                    case MouseEvent.MOUSE_DOWN:
                        this._SafeStr_8620 = _arg_1;
                        break;
                    case MouseEvent.CLICK:
                        if (this._SafeStr_8620 != _arg_1){
                            return (null);
                        };
                        this._SafeStr_8620 = null;
                        break;
                    case MouseEvent.DOUBLE_CLICK:
                        if (this._SafeStr_8620 != _arg_1){
                            return (null);
                        };
                        this._SafeStr_8620 = null;
                        break;
                };
            };
            var _local_6:IWindow;
            var _local_7:WindowMouseEvent = convertMouseEventType(_arg_2, _arg_1, _local_6);
            var _local_8:Boolean = _arg_1.update(_arg_1, _local_7);
            _local_7.recycle();
            if (((!(_local_8)) && (!(_arg_3)))){
                if (_arg_1.parent){
                    return (this.passMouseEvent(WindowController(_arg_1.parent), _arg_2));
                };
            };
            return (_arg_1);
        }

    }
}//package com.sulake.core.window.utils

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IWindowRenderer = "_-2Oq" (String#6539, DoABC#2)
// MouseCursorControl = "_-eM" (String#23816, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// EventProcessorState = "_-Ct" (String#7930, DoABC#2)
// IEventQueue = "_-cw" (String#8470, DoABC#2)
// IEventProcessor = "_-1A-" (String#5077, DoABC#2)
// MouseEventProcessor = "_-1zl" (String#6028, DoABC#2)
// MouseCursorType = "_-031" (String#14164, DoABC#2)
// IInputProcessorRoot = "_-0Qw" (String#4109, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP_OUTSIDE = "_-2qi" (String#21110, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)
// _SafeStr_5004 = "_-0Yv" (String#15399, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// _SafeStr_6248 = "_-3J9" (String#22246, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7438 = "_-2pe" (String#21065, DoABC#2)
// process = "_-3Fw" (String#2032, DoABC#2)
// _desktopWindow = "_-1WY" (String#5483, DoABC#2)
// _SafeStr_8618 = "_-3JL" (String#22257, DoABC#2)
// _SafeStr_8619 = "_-0fY" (String#15653, DoABC#2)
// _SafeStr_8620 = "_-1pW" (String#18526, DoABC#2)
// _SafeStr_8621 = "_-1ek" (String#18088, DoABC#2)
// _renderer = "_-32W" (String#628, DoABC#2)
// _SafeStr_8623 = "_-20v" (String#19048, DoABC#2)
// _SafeStr_8624 = "_-3ED" (String#22044, DoABC#2)
// getMouseCursorByState = "_-0Bd" (String#3788, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _SafeStr_9170 = "_-2FR" (String#19621, DoABC#2)
// testParamFlag = "_-1ml" (String#5794, DoABC#2)
// getActiveWindow = "_-1h8" (String#1744, DoABC#2)
// POLL_OFFER_STATE_UNKNOWN = "_-2VV" (String#20262, DoABC#2)
// testStateFlag = "_-35A" (String#7410, DoABC#2)
// _SafeStr_9258 = "const" (String#44694, DoABC#2)
// WME_WHEEL = "_-1Ot" (String#17464, DoABC#2)
// _SafeStr_9399 = "_-1WJ" (String#17754, DoABC#2)
// groupParameterFilteredChildrenUnderPoint = "_-ZD" (String#8399, DoABC#2)
// _SafeStr_9479 = "_-H4" (String#22893, DoABC#2)
// _SafeStr_9484 = "_-3GB" (String#22126, DoABC#2)
// WME_ROLL_OUT = "_-0ZG" (String#15413, DoABC#2)
// WME_ROLL_OVER = "_-2Fi" (String#19631, DoABC#2)
// getDrawBufferForRenderable = "_-2bf" (String#6787, DoABC#2)
// _SafeStr_9719 = "_-0Cl" (String#14560, DoABC#2)
// _SafeStr_9720 = "_-1Ss" (String#17618, DoABC#2)
// _SafeStr_9721 = "_-2aV" (String#20464, DoABC#2)
// _SafeStr_9722 = "_-0cb" (String#15539, DoABC#2)
// setMouseCursorByState = "_-2OP" (String#19982, DoABC#2)
// convertMouseEventType = "_-192" (String#16819, DoABC#2)
// convertPointFromGlobalToLocalSpace = "_-0Vq" (String#4224, DoABC#2)
// passMouseEvent = "_-HO" (String#22908, DoABC#2)
// mouseEventReceived = "_-3K3" (String#7704, DoABC#2)
// hitTestLocalPoint = "_-E9" (String#7955, DoABC#2)
// validateLocalPointIntersection = "_-1vM" (String#18771, DoABC#2)


