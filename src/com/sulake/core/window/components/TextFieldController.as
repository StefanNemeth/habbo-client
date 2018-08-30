
package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import flash.text.TextField;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.text.TextFieldType;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;
    import flash.geom.Point;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class TextFieldController extends TextController implements ITextFieldWindow 
    {

        protected var _toolTipDelay:uint = 500;
        protected var _toolTipCaption:String = "";
        protected var _SafeStr_9156:Boolean = false;
        protected var _initialized:Boolean = false;

        public function TextFieldController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 & ~(WindowParam._SafeStr_7443));
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            _rectangle = _arg_6;
            _field = TextField(this.getGraphicContext(true).getDisplayObject());
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _field.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownEvent);
            _field.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpEvent);
            _field.addEventListener(Event.CHANGE, this.onChangeEvent);
            _field.addEventListener(FocusEvent.FOCUS_IN, this.onFocusEvent);
            _field.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
            _field.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedEvent);
            _SafeStr_9161 = false;
            this._initialized = true;
        }
        public function get focused():Boolean
        {
            if (_field){
                if (_field.stage){
                    return ((_field.stage.focus == _field));
                };
            };
            return (false);
        }
        override public function enable():Boolean
        {
            if (super.enable()){
                _field.type = TextFieldType.INPUT;
                return (true);
            };
            _field.type = TextFieldType.DYNAMIC;
            return (false);
        }
        override public function disable():Boolean
        {
            if (super.disable()){
                _field.type = TextFieldType.DYNAMIC;
                return (true);
            };
            _field.type = TextFieldType.INPUT;
            return (false);
        }
        public function get editable():Boolean
        {
            return ((_field.type == TextFieldType.INPUT));
        }
        public function set editable(_arg_1:Boolean):void
        {
            _field.type = ((_arg_1) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
        }
        public function get selectable():Boolean
        {
            return (_field.selectable);
        }
        public function set selectable(_arg_1:Boolean):void
        {
            _field.selectable = _arg_1;
        }
        public function set displayAsPassword(_arg_1:Boolean):void
        {
            _field.displayAsPassword = _arg_1;
        }
        public function get displayAsPassword():Boolean
        {
            return (_field.displayAsPassword);
        }
        public function set mouseCursorType(_arg_1:uint):void
        {
        }
        public function get mouseCursorType():uint
        {
            return (0);
        }
        public function set toolTipCaption(_arg_1:String):void
        {
            this._toolTipCaption = (((_arg_1 == null)) ? "" : _arg_1);
        }
        public function get toolTipCaption():String
        {
            return (this._toolTipCaption);
        }
        public function set toolTipDelay(_arg_1:uint):void
        {
            this._toolTipDelay = _arg_1;
        }
        public function get toolTipDelay():uint
        {
            return (this._toolTipDelay);
        }
        public function setMouseCursorForState(_arg_1:uint, _arg_2:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }
        public function getMouseCursorByState(_arg_1:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }
        public function showToolTip(_arg_1:IToolTipWindow):void
        {
            throw (new Error("Unimplemented method!"));
        }
        public function hideToolTip():void
        {
            throw (new Error("Unimplemented method!"));
        }
        override public function set autoSize(_arg_1:String):void
        {
            super.autoSize = _arg_1;
            this.refreshAutoSize();
        }
        override public function set background(_arg_1:Boolean):void
        {
            _field.background = _arg_1;
            _background = _arg_1;
            _background = ((_background) ? (_background | _SafeStr_9165) : (_background & 0xFFFFFF));
        }
        public function setSelection(_arg_1:int, _arg_2:int):void
        {
            _field.setSelection(_arg_1, _arg_2);
        }
        public function get selectionBeginIndex():int
        {
            return (_field.selectionBeginIndex);
        }
        public function get selectionEndIndex():int
        {
            return (_field.selectionEndIndex);
        }
        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_graphicContext)))){
                _graphicContext = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_TEXTFIELD, _rectangle);
            };
            return (_graphicContext);
        }
        override public function dispose():void
        {
            _context.getWindowServices().getFocusManagerService().removeFocusWindow(this);
            this._SafeStr_9156 = false;
            if (_field){
                if (this.focused){
                    this.unfocus();
                };
                _field.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownEvent);
                _field.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUpEvent);
                _field.removeEventListener(Event.CHANGE, this.onChangeEvent);
                _field.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusEvent);
                _field.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
                _field.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedEvent);
            };
            super.dispose();
        }
        override public function set text(_arg_1:String):void
        {
            super.text = _arg_1;
            this.refreshAutoSize();
        }
        override public function focus():Boolean
        {
            var _local_1:Boolean = super.focus();
            if (_local_1){
                if (_field){
                    if (_field.stage){
                        if (_field.stage.focus != _field){
                            _field.stage.focus = _field;
                        };
                    };
                };
            };
            return (_local_1);
        }
        override public function unfocus():Boolean
        {
            if (_field){
                if (_field.stage){
                    if (_field.stage.focus == _field){
                        _field.stage.focus = null;
                    };
                };
            };
            return (super.unfocus());
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            switch (_arg_2.type){
                case WindowEvent.WE_ACTIVATE:
                case WindowMouseEvent.WME_DOWN:
                    this.focus();
                    break;
                case WindowEvent.WE_RESIZED:
                    if (_arg_1 == this){
                        _field.width = this.width;
                        _field.height = this.height;
                    };
                    break;
            };
            if (_arg_1 == this){
                InteractiveController.processInteractiveWindowEvents(this, _arg_2);
            };
            return (_local_3);
        }
        protected function refreshAutoSize():void
        {
            var _local_1:Point;
            var _local_2:Point;
            var _local_3:Point;
            if (((this._initialized) && (!((autoSize == TextFieldAutoSize.NONE))))){
                if (((!((_rectangle.width == _field.width))) || (!((_rectangle.height == _field.height))))){
                    _local_1 = _field.localToGlobal(new Point(_field.x, _field.y));
                    _local_2 = new Point();
                    getGlobalPosition(_local_2);
                    _local_3 = new Point((_local_1.x - _local_2.x), (_local_1.y - _local_2.y));
                    setRectangle((_rectangle.x + _local_3.x), (_rectangle.y + _local_3.y), _field.width, _field.height);
                };
            };
        }
        override protected function refreshTextImage(_arg_1:Boolean=false):void
        {
            var _local_3:WindowEvent;
            var _local_2:Boolean;
            if (_rectangle.width != _field.width){
                if (autoSize != TextFieldAutoSize.NONE){
                    width = _field.width;
                    _local_2 = true;
                }
                else {
                    _field.width = width;
                };
            };
            if (_rectangle.height != _field.height){
                if (autoSize != TextFieldAutoSize.NONE){
                    height = _field.height;
                    _local_2 = true;
                }
                else {
                    _field.height = height;
                };
            };
            if (((((!(_local_2)) && (!(_arg_1)))) && (_events))){
                _local_3 = WindowEvent.allocate(WindowEvent.WE_RESIZED, this, null);
                _events.dispatchEvent(_local_3);
                _local_3.recycle();
            };
        }
        private function onKeyDownEvent(event:KeyboardEvent):void
        {
            var windowEvent:WindowKeyboardEvent;
            try {
                windowEvent = WindowKeyboardEvent.allocate(WindowKeyboardEvent.WKE_KEY_DOWN, event, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error) {
                _context.handleError(WindowContext._SafeStr_9169, e);
            };
        }
        private function onKeyUpEvent(event:KeyboardEvent):void
        {
            var windowEvent:WindowKeyboardEvent;
            try {
                _caption = _field.text;
                windowEvent = WindowKeyboardEvent.allocate(WindowKeyboardEvent.WKE_KEY_UP, event, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error) {
                _context.handleError(WindowContext._SafeStr_9169, e);
            };
        }
        private function onChangeEvent(event:Event):void
        {
            var windowEvent:WindowEvent;
            try {
                this.refreshAutoSize();
                windowEvent = WindowEvent.allocate(WindowEvent.WE_CHANGE, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error) {
                _context.handleError(WindowContext._SafeStr_9169, e);
            };
        }
        private function onFocusEvent(event:FocusEvent):void
        {
            try {
                if (event.type == FocusEvent.FOCUS_IN){
                    if (!getStateFlag(WindowState._SafeStr_9170)){
                        this.focus();
                    };
                }
                else {
                    if (event.type == FocusEvent.FOCUS_OUT){
                        if (getStateFlag(WindowState._SafeStr_9170)){
                            this.unfocus();
                        };
                    };
                };
            }
            catch(e:Error) {
                _context.handleError(WindowContext._SafeStr_9169, e);
            };
        }
        private function onRemovedEvent(event:Event):void
        {
            try {
                if (getStateFlag(WindowState._SafeStr_9170)){
                    this.unfocus();
                };
            }
            catch(e:Error) {
                _context.handleError(WindowContext._SafeStr_9169, e);
            };
        }
        override public function get properties():Array
        {
            var _local_1:Array = InteractiveController.writeInteractiveWindowProperties(this, super.properties);
            _local_1.push((((_field.type == TextFieldType.DYNAMIC)) ? new PropertyStruct(PropertyDefaults._SafeStr_9172, false, PropertyStruct._SafeStr_8996, true) : PropertyDefaults._SafeStr_9173));
            _local_1.push((((this._SafeStr_9156)!=PropertyDefaults._SafeStr_9174) ? new PropertyStruct(PropertyDefaults._SafeStr_9175, this._SafeStr_9156, PropertyStruct._SafeStr_8996, true) : PropertyDefaults._SafeStr_9176));
            _local_1.push((((_field.selectable)!=PropertyDefaults._SafeStr_9177) ? new PropertyStruct(PropertyDefaults._SafeStr_9178, _field.selectable, PropertyStruct._SafeStr_8996, true) : PropertyDefaults._SafeStr_9179));
            _local_1.push((((_field.displayAsPassword)!=PropertyDefaults._SafeStr_9180) ? new PropertyStruct("display_as_password", _field.displayAsPassword, PropertyStruct._SafeStr_8996, true) : PropertyDefaults._SafeStr_9181));
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            InteractiveController.readInteractiveWindowProperties(this, _arg_1);
            for each (_local_2 in _arg_1) {
                switch (_local_2.key){
                    case PropertyDefaults._SafeStr_9175:
                        this._SafeStr_9156 = (_local_2.value as Boolean);
                        if (this._SafeStr_9156){
                            _context.getWindowServices().getFocusManagerService().registerFocusWindow(this);
                        };
                        break;
                    case PropertyDefaults._SafeStr_9178:
                        _field.selectable = (_local_2.value as Boolean);
                        break;
                    case PropertyDefaults._SafeStr_9172:
                        _field.type = ((_local_2.value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
                        break;
                    case PropertyDefaults._SafeStr_9182:
                        _field.displayAsPassword = (_local_2.value as Boolean);
                        break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// TextController = "_-2vO" (String#7184, DoABC#2)
// TextFieldController = "_-2rC" (String#7105, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// GraphicContext = "_-03R" (String#14179, DoABC#2)
// IToolTipWindow = "_-0GV" (String#3884, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// getStateFlag = "_-1nM" (String#5804, DoABC#2)
// setMouseCursorForState = "_-1lf" (String#5777, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// WKE_KEY_UP = "_-0aL" (String#15451, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _caption = "_-p" (String#8690, DoABC#2)
// _SafeStr_8996 = "_-0gH" (String#15685, DoABC#2)
// unfocus = "_-Rh" (String#8242, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)
// hideToolTip = "_-2VZ" (String#1889, DoABC#2)
// getMouseCursorByState = "_-0Bd" (String#3788, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// refreshTextImage = "_-0hP" (String#4454, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// setRectangle = "_-Vb" (String#23476, DoABC#2)
// _toolTipDelay = "_-0Bo" (String#810, DoABC#2)
// _toolTipCaption = "_-03Q" (String#806, DoABC#2)
// _SafeStr_9156 = "_-1pR" (String#18521, DoABC#2)
// onKeyDownEvent = "_-MV" (String#23105, DoABC#2)
// onKeyUpEvent = "_-iX" (String#23978, DoABC#2)
// onChangeEvent = "_-1sn" (String#18668, DoABC#2)
// onRemovedEvent = "_-1yV" (String#18909, DoABC#2)
// _SafeStr_9161 = "_-2-n" (String#19004, DoABC#2)
// refreshAutoSize = "_-1FT" (String#17093, DoABC#2)
// _background = "_-35x" (String#21726, DoABC#2)
// _background = "_-zD" (String#24660, DoABC#2)
// _SafeStr_9165 = "_-2Yy" (String#20394, DoABC#2)
// _graphicContext = "_-1or" (String#18492, DoABC#2)
// WE_ACTIVATE = "_-3Ek" (String#22065, DoABC#2)
// processInteractiveWindowEvents = "_-10V" (String#16483, DoABC#2)
// _SafeStr_9169 = "_-2Nz" (String#19963, DoABC#2)
// _SafeStr_9170 = "_-2FR" (String#19621, DoABC#2)
// writeInteractiveWindowProperties = "_-3LB" (String#22332, DoABC#2)
// _SafeStr_9172 = "_-1D9" (String#16987, DoABC#2)
// _SafeStr_9173 = "_-16x" (String#16733, DoABC#2)
// _SafeStr_9174 = "_-1cF" (String#17981, DoABC#2)
// _SafeStr_9175 = "_-0IM" (String#14773, DoABC#2)
// _SafeStr_9176 = "_-2ZA" (String#20405, DoABC#2)
// _SafeStr_9177 = "_-2vW" (String#21297, DoABC#2)
// _SafeStr_9178 = "_-2Ax" (String#19440, DoABC#2)
// _SafeStr_9179 = "_-348" (String#21665, DoABC#2)
// _SafeStr_9180 = "_-0sG" (String#16134, DoABC#2)
// _SafeStr_9181 = "_-33M" (String#21636, DoABC#2)
// _SafeStr_9182 = "_-wU" (String#24552, DoABC#2)


