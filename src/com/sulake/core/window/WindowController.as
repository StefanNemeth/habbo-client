
package com.sulake.core.window
{
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowEventDispatcher;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.utils.WindowRectLimits;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.window.utils.IRectLimiter;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.graphics.GraphicContext;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.window.events.WindowDisposeEvent;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import flash.display.IBitmapDrawable;
    import com.sulake.core.window.services.IMouseListenerService;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.enum.MouseListenerType;
    import flash.display.BitmapData;

    public class WindowController extends WindowModel implements IWindow, IGraphicContextHost 
    {

        private static var _SafeStr_9833:uint = 0;
        protected static const TAG_EXCLUDE:String = "_EXCLUDE";
        protected static const TAG_INTERNAL:String = "_INTERNAL";
        protected static const _COLORIZE:String = "_COLORIZE";
        protected static const _IGNORE_INHERITED_STYLE:String = "_IGNORE_INHERITED_STYLE";
        private static const _SafeStr_9835:Point = new Point();

        protected var _events:WindowEventDispatcher;
        protected var _graphicContext:IGraphicContext;
        protected var _procedure:Function;
        protected var _SafeStr_9161:Boolean = true;
        protected var _parent:WindowController;
        protected var _children:Array;
        protected var _debug:Boolean = false;
        protected var _limits:WindowRectLimits;
        private var _SafeStr_9837:Boolean = false;
        private var _SafeStr_9838:Rectangle;
        private var _SafeStr_9839:uint;

        public function WindowController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            var _local_14:uint;
            this._SafeStr_9839 = _SafeStr_9833++;
            var _local_12:XML = _arg_5.getWindowFactory().getLayoutByTypeAndStyle(_arg_2, _arg_3);
            if (_arg_6 == null){
                _arg_6 = new Rectangle(0, 0, ((_local_12) ? int(_local_12.attribute("width")) : 10), ((_local_12) ? int(_local_12.attribute("height")) : 10));
            };
            super(_arg_11, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_10);
            if (!this._graphicContext){
                this._graphicContext = this.getGraphicContext(!(testParamFlag(WindowParam._SafeStr_7443)));
            };
            this._children = new Array();
            this._SafeStr_9838 = new Rectangle();
            if (_local_12 != null){
                _SafeStr_9800 = new Rectangle(0, 0, int(_local_12.attribute("width")), int(_local_12.attribute("height")));
                _SafeStr_9801 = _SafeStr_9800.clone();
                _rectangle = _SafeStr_9800.clone();
                _arg_5.getWindowParser().parseAndConstruct(_local_12, this, null);
                _local_14 = _param;
                _param = (_param & ~(WindowParam._SafeStr_9362));
                this.setRectangle(_arg_6.x, _arg_6.y, _arg_6.width, _arg_6.height);
                _param = _local_14;
                _SafeStr_9801.x = _arg_6.x;
                _SafeStr_9801.y = _arg_6.y;
                _SafeStr_9801.width = _arg_6.width;
                _SafeStr_9801.height = _arg_6.height;
            };
            var _local_13:DefaultAttStruct = _arg_5.getWindowFactory().getDefaultsByTypeAndStyle(_arg_2, _arg_3);
            if (_local_13){
                _blend = _local_13.blend;
                _mouseThreshold = _local_13._SafeStr_9574;
                if (_background != _local_13.background){
                    this.background = _local_13.background;
                };
                if (_background != _local_13.color){
                    this.color = _local_13.color;
                };
                if (_local_13.hasRectLimits()){
                    WindowRectLimits(this.limits).assign(_local_13.width_min, _local_13.width_max, _local_13.height_min, _local_13.height_max);
                };
            };
            if (_arg_9){
                this.properties = _arg_9;
            };
            this._procedure = _arg_8;
            if (_arg_7 != null){
                this._parent = (_arg_7 as WindowController);
                WindowController(_arg_7).addChild(this);
                if (this._graphicContext){
                    _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
                };
            };
        }
        private static function calculateMouseRegion(_arg_1:WindowController, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle = new Rectangle();
            _arg_1.getGlobalRectangle(_local_3);
            var _local_4:int = _arg_1.numChildren;
            var _local_5:int = _local_3.x;
            var _local_6:int = _local_3.y;
            _arg_2.left = (((_local_5)<_arg_2.left) ? _local_5 : _arg_2.left);
            _arg_2.top = (((_local_6)<_arg_2.top) ? _local_6 : _arg_2.top);
            _arg_2.right = (((_local_3.right)>_arg_2.right) ? _local_3.right : _arg_2.right);
            _arg_2.bottom = (((_local_3.bottom)>_arg_2.bottom) ? _local_3.bottom : _arg_2.bottom);
            var _local_7:int;
            while (_local_7 < _local_4) {
                WindowController.calculateMouseRegion((_arg_1.getChildAt(_local_7) as WindowController), _arg_2);
                _local_7++;
            };
        }
        public static function expandToAccommodateChild(_arg_1:WindowController, _arg_2:IWindow):void
        {
            var _local_9:uint;
            var _local_10:uint;
            var _local_11:uint;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int = _arg_1.width;
            var _local_6:int = _arg_1.height;
            var _local_7:Rectangle = _arg_2.rectangle.clone();
            var _local_8:Boolean;
            if (_local_7.x < 0){
                _local_3 = _local_7.x;
                _local_5 = (_local_5 - _local_3);
                _local_7.x = 0;
                _local_8 = true;
            };
            if (_local_7.right > _local_5){
                _local_5 = (_local_7.x + _local_7.width);
                _local_8 = true;
            };
            if (_local_7.y < 0){
                _local_4 = _local_7.y;
                _local_6 = (_local_6 - _local_4);
                _local_7.y = 0;
                _local_8 = true;
            };
            if (_local_7.bottom > _local_6){
                _local_6 = (_local_7.y + _local_7.height);
                _local_8 = true;
            };
            if (_local_8){
                _local_9 = (_arg_1.param & (WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN | WindowParam._SafeStr_7436));
                if (_local_9){
                    _arg_1.setParamFlag(_local_9, false);
                };
                _arg_1.setRectangle((_arg_1.x + _local_3), (_arg_1.y + _local_4), _local_5, _local_6);
                if (((!((_local_4 == 0))) || (!((_local_3 == 0))))){
                    _local_11 = _arg_1.numChildren;
                    _local_10 = 0;
                    while (_local_10 < _local_11) {
                        IWindow(_arg_1.getChildAt(_local_10)).offset(-(_local_3), -(_local_4));
                        _local_10++;
                    };
                };
                if (_local_9){
                    _arg_1.setParamFlag(_local_9, true);
                };
            };
        }
        public static function resizeToAccommodateChildren(_arg_1:WindowController):void
        {
            var _local_2:uint;
            var _local_7:Rectangle;
            var _local_10:uint;
            var _local_11:IWindow;
            var _local_12:Boolean;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int = int.MIN_VALUE;
            var _local_6:int = int.MIN_VALUE;
            var _local_8:Boolean;
            var _local_9:uint = _arg_1.numChildren;
            _local_2 = 0;
            while (_local_2 < _local_9) {
                _local_7 = _arg_1.getChildAt(_local_2).rectangle;
                if (_local_7.right > _local_5){
                    _local_5 = _local_7.right;
                    _local_8 = true;
                };
                if (_local_7.bottom > _local_6){
                    _local_6 = _local_7.bottom;
                    _local_8 = true;
                };
                _local_2++;
            };
            if (_local_8){
                _local_10 = (_arg_1.param & (WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN | WindowParam._SafeStr_7436));
                if (_local_10){
                    _arg_1.setParamFlag(_local_10, false);
                };
                if (((!((_local_3 == 0))) || (!((_local_4 == 0))))){
                    _local_2 = 0;
                    while (_local_2 < _local_9) {
                        _local_11 = _arg_1.getChildAt(_local_2);
                        _local_12 = _local_11.testParamFlag(WindowParam._SafeStr_7445);
                        if (_local_12){
                            _local_11.setParamFlag(WindowParam._SafeStr_7445, false);
                        };
                        _local_11.offset(-(_local_3), -(_local_4));
                        if (_local_12){
                            _local_11.setParamFlag(WindowParam._SafeStr_7445, true);
                        };
                        _local_2++;
                    };
                };
                _arg_1.width = _local_5;
                _arg_1.height = _local_6;
                if (_local_10){
                    _arg_1.setParamFlag(_local_10, true);
                };
            };
        }

        public function get properties():Array
        {
            return (new Array());
        }
        public function get procedure():Function
        {
            return ((((this._procedure)!=null) ? this._procedure : (((this._parent)!=null) ? this._parent.procedure : this.nullEventProc)));
        }
        public function get filters():Array
        {
            return (((this.hasGraphicsContext()) ? this.getGraphicContext(true).filters : []));
        }
        public function get parent():IWindow
        {
            return (this._parent);
        }
        public function get debug():Boolean
        {
            return (this._debug);
        }
        public function get limits():IRectLimiter
        {
            if (!this._limits){
                this._limits = new WindowRectLimits(this);
            };
            return (this._limits);
        }
        public function set x(_arg_1:int):void
        {
            if (_arg_1 != _rectangle.x){
                this.setRectangle(_arg_1, _rectangle.y, _rectangle.width, _rectangle.height);
            };
        }
        public function set y(_arg_1:int):void
        {
            if (_arg_1 != _rectangle.y){
                this.setRectangle(_rectangle.x, _arg_1, _rectangle.width, _rectangle.height);
            };
        }
        public function set id(_arg_1:uint):void
        {
            _id = _arg_1;
        }
        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }
        public function set width(_arg_1:int):void
        {
            if (_arg_1 != _rectangle.width){
                this.setRectangle(_rectangle.x, _rectangle.y, _arg_1, _rectangle.height);
            };
        }
        public function set height(_arg_1:int):void
        {
            if (_arg_1 != _rectangle.height){
                this.setRectangle(_rectangle.x, _rectangle.y, _rectangle.width, _arg_1);
            };
        }
        public function set position(_arg_1:Point):void
        {
            this.setRectangle(_arg_1.x, _arg_1.y, _rectangle.width, _rectangle.height);
        }
        public function set rectangle(_arg_1:Rectangle):void
        {
            this.setRectangle(_arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
        }
        public function set background(_arg_1:Boolean):void
        {
            _background = _arg_1;
            _background = ((_background) ? (_background | _SafeStr_9165) : (_background & 0xFFFFFF));
            this._SafeStr_9161 = ((this._SafeStr_9161) || (_arg_1));
            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
        }
        public function set color(_arg_1:uint):void
        {
            _SafeStr_9165 = (_arg_1 & 0xFF000000);
            _background = ((_background) ? _arg_1 : (_arg_1 & 0xFFFFFF));
            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
        }
        public function set alpha(_arg_1:uint):void
        {
            _SafeStr_9165 = (_arg_1 << 24);
            _background = ((_background) ? (_SafeStr_9165 | _background) : (0xFFFFFF & _background));
            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
        }
        public function set blend(_arg_1:Number):void
        {
            _blend = (((_arg_1 > 1)) ? 1 : (((_arg_1 < 0)) ? 0 : _arg_1));
            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9616);
        }
        public function set visible(_arg_1:Boolean):void
        {
            if (_arg_1 != _visible){
                _visible = _arg_1;
                if (this._graphicContext){
                    this._graphicContext.visible = _arg_1;
                };
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            };
        }
        public function set type(_arg_1:uint):void
        {
            if (_arg_1 != _type){
                _type = _arg_1;
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            };
        }
        public function set caption(_arg_1:String):void
        {
            _arg_1 = ((_arg_1) ? _arg_1 : "");
            if (_arg_1 != caption){
                _caption = _arg_1;
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            };
        }
        public function set tags(_arg_1:Array):void
        {
            if (_arg_1 != null){
                _tags = _arg_1;
            };
        }
        public function set mouseThreshold(_arg_1:uint):void
        {
            _mouseThreshold = (((_arg_1 > 0xFF)) ? 0xFF : _arg_1);
        }
        public function set procedure(_arg_1:Function):void
        {
            this._procedure = _arg_1;
        }
        public function set filters(_arg_1:Array):void
        {
            if (this.hasGraphicsContext()){
                this.getGraphicContext(true).filters = _arg_1;
            };
        }
        public function set debug(_arg_1:Boolean):void
        {
            this._debug = _arg_1;
        }
        public function set properties(_arg_1:Array):void
        {
        }
        public function set state(_arg_1:uint):void
        {
            if (_arg_1 != _state){
                _state = _arg_1;
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9615);
            };
        }
        public function set style(_arg_1:uint):void
        {
            var _local_2:Array;
            var _local_3:uint;
            var _local_4:WindowController;
            if (_arg_1 != _style){
                _style = _arg_1;
                _local_2 = new Array();
                this.groupChildrenWithTag(WindowController.TAG_INTERNAL, _local_2);
                _local_3 = _local_2.length;
                while (--_local_3 > -1) {
                    _local_4 = (_local_2[_local_3] as WindowController);
                    if (_local_4.tags.indexOf(_IGNORE_INHERITED_STYLE) == -1){
                        _local_4.style = _style;
                    };
                };
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            };
        }
        public function set clipping(_arg_1:Boolean):void
        {
            if (_arg_1 != _clipping){
                _clipping = _arg_1;
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            };
        }
        public function get host():IWindow
        {
            return ((((this._parent)==this.desktop) ? this : this._parent.host));
        }
        public function get desktop():IDesktopWindow
        {
            return (_context.getDesktopWindow());
        }
        public function set parent(_arg_1:IWindow):void
        {
            var _local_3:WindowController;
            var _local_4:WindowEvent;
            if (_arg_1 == this){
                throw (new Error("Attempted to assign self as parent!"));
            };
            if (((!((_arg_1 == null))) && (!((_arg_1.context == _context))))){
                _context = WindowContext(_arg_1.context);
                for each (_local_3 in this._children) {
                    _local_3.parent = this;
                };
            };
            var _local_2:IWindow = this._parent;
            if (this._parent != _arg_1){
                if (this._parent != null){
                    this._parent.removeChild(this);
                };
                this._parent = WindowController(_arg_1);
                if (this._parent != null){
                    this._SafeStr_9838 = this._parent.rectangle.clone();
                    _SafeStr_9801.x = _rectangle.x;
                    _SafeStr_9801.y = _rectangle.y;
                    _SafeStr_9801.width = _rectangle.width;
                    _SafeStr_9801.height = _rectangle.height;
                    _local_4 = WindowEvent.allocate(WindowEvent.WE_PARENT_ADDED, this, this._parent);
                    this.update(this, _local_4);
                }
                else {
                    this._SafeStr_9838.x = 0;
                    this._SafeStr_9838.y = 0;
                    this._SafeStr_9838.width = 0;
                    this._SafeStr_9838.height = 0;
                    _local_4 = WindowEvent.allocate(WindowEvent.WE_PARENT_REMOVED, this, _local_2);
                    this.update(this, _local_4);
                };
                _local_4.recycle();
            };
        }
        public function hasGraphicsContext():Boolean
        {
            return (((!((this._graphicContext == null))) || (!(testParamFlag(WindowParam._SafeStr_7443)))));
        }
        public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(this._graphicContext)))){
                this._graphicContext = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_BITMAP, _rectangle);
                this._graphicContext.visible = _visible;
            };
            return (this._graphicContext);
        }
        public function setupGraphicsContext():IGraphicContext
        {
            var _local_1:int;
            var _local_2:WindowController;
            this._graphicContext = this.getGraphicContext(true);
            if (this._parent){
                this._parent.setupGraphicsContext();
            };
            if (this._children.length > 0){
                if (this._graphicContext.numChildContexts != this.numChildren){
                    _local_1 = 0;
                    for each (_local_2 in this._children) {
                        this._graphicContext.addChildContextAt(_local_2.getGraphicContext(true), _local_1++);
                    };
                };
            };
            this._SafeStr_9837 = true;
            return (this._graphicContext);
        }
        public function releaseGraphicsContext():void
        {
            this._SafeStr_9837 = false;
            if (this._graphicContext){
            };
        }
        public function clone():IWindow
        {
            var _local_1:Class = (getDefinitionByName(getQualifiedClassName(this)) as Class);
            var _local_2:WindowController = (new (_local_1)(_name, _type, _style, _param, _context, _rectangle, null, this._procedure, this.properties, _tags.concat(), _id) as WindowController);
            _local_2._mouseThreshold = _mouseThreshold;
            _local_2._SafeStr_9161 = this._SafeStr_9161;
            _local_2._debug = this._debug;
            _local_2._SafeStr_9838 = this._SafeStr_9838.clone();
            _local_2._rectangle = _rectangle.clone();
            _local_2._SafeStr_9800 = _SafeStr_9800.clone();
            _local_2._SafeStr_9801 = _SafeStr_9801.clone();
            _local_2._SafeStr_9802 = ((_SafeStr_9802) ? _SafeStr_9802.clone() : null);
            _local_2._SafeStr_9803 = ((_SafeStr_9803) ? _SafeStr_9803.clone() : null);
            _local_2._limits = ((this._limits) ? this._limits.clone(_local_2) : null);
            _local_2._context = _context;
            _local_2._background = _background;
            _local_2._SafeStr_9165 = _SafeStr_9165;
            _local_2._clipping = _clipping;
            _local_2._visible = _visible;
            _local_2._blend = _blend;
            _local_2._param = _param;
            _local_2._state = _state;
            _local_2._name = _name;
            _local_2._id = _id;
            _local_2.caption = _caption;
            _local_2.background = _background;
            this.cloneChildWindows(_local_2);
            return (_local_2);
        }
        protected function cloneChildWindows(_arg_1:WindowController):void
        {
            var _local_2:WindowController;
            for each (_local_2 in this._children) {
                if (_local_2.tags.indexOf(WindowController.TAG_EXCLUDE) == -1){
                    _arg_1.addChild(_local_2.clone());
                };
            };
        }
        override public function dispose():void
        {
            var _local_1:WindowDisposeEvent;
            if (!_disposed){
                this._procedure = null;
                if (!_context.disposed){
                    if (!this.isChildWindow()){
                        if (this.getStateFlag(WindowState._SafeStr_4586)){
                            this.deactivate();
                        };
                    };
                };
                while (this._children.length > 0) {
                    IDisposable(this._children.pop()).dispose();
                };
                this._children = null;
                if (this.parent){
                    this.parent = null;
                };
                if (this._events){
                    _local_1 = WindowDisposeEvent.allocate(this);
                    this._events.dispatchEvent(_local_1);
                    _local_1.recycle();
                    if ((this._events is IDisposable)){
                        IDisposable(this._events).dispose();
                        this._events = null;
                    };
                };
                if (this._graphicContext != null){
                    this._graphicContext.dispose();
                    this._graphicContext = null;
                };
                super.dispose();
            };
        }
        public function toString():String
        {
            return (((((((("[" + "Window ") + getQualifiedClassName(this)) + " ") + _name) + " ") + this._SafeStr_9839) + "]"));
        }
        override public function invalidate(_arg_1:Rectangle=null):void
        {
            if (_arg_1 == null){
                _arg_1 = _rectangle;
            };
            _context.invalidate(this, _arg_1, WindowRedrawFlag._SafeStr_9133);
        }
        public function resolve():uint
        {
            return (0);
        }
        public function center():void
        {
            if (this._parent != null){
                this.x = ((this._parent.width / 2) - (_rectangle.width / 2));
                this.y = ((this._parent.height / 2) - (_rectangle.height / 2));
            };
        }
        public function setRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_7:uint;
            var _local_8:Rectangle;
            var _local_9:WindowEvent;
            if (this._limits){
                _arg_4 = Math.max(this._limits.minHeight, _arg_4);
                _arg_4 = Math.min(this._limits.maxHeight, _arg_4);
                _arg_3 = Math.max(this._limits.minWidth, _arg_3);
                _arg_3 = Math.min(this._limits.maxWidth, _arg_3);
            };
            var _local_5:Boolean = ((!((_arg_1 == _rectangle.x))) || (!((_arg_2 == _rectangle.y))));
            var _local_6:Boolean = ((!((_arg_3 == _rectangle.width))) || (!((_arg_4 == _rectangle.height))));
            if (((_local_6) && (!(_local_5)))){
                _local_7 = (_param & WindowParam._SafeStr_9506);
                if (_local_7 == WindowParam._SafeStr_7476){
                    _arg_1 = (_arg_1 - ((_arg_3 - _rectangle.width) / 2));
                    _local_5 = true;
                }
                else {
                    if (_local_7 == WindowParam._SafeStr_7478){
                        _arg_1 = (_arg_1 - (_arg_3 - _rectangle.width));
                        _local_5 = true;
                    };
                };
                _local_7 = (_param & WindowParam._SafeStr_9507);
                if (_local_7 == WindowParam._SafeStr_7482){
                    _arg_2 = (_arg_2 - ((_arg_4 - _rectangle.height) / 2));
                    _local_5 = true;
                }
                else {
                    if (_local_7 == WindowParam._SafeStr_7484){
                        _arg_2 = (_arg_2 - (_arg_4 - _rectangle.height));
                        _local_5 = true;
                    };
                };
            };
            if (testParamFlag(WindowParam._SafeStr_7445)){
                if (this._parent != null){
                    _local_8 = this._parent.rectangle;
                    _arg_1 = (((_arg_1)<0) ? 0 : _arg_1);
                    _arg_2 = (((_arg_2)<0) ? 0 : _arg_2);
                    if (_local_5){
                        _arg_1 = (_arg_1 - ((((_arg_1 + _arg_3))>_local_8.width) ? ((_arg_1 + _arg_3) - _local_8.width) : 0));
                        _arg_2 = (_arg_2 - ((((_arg_2 + _arg_4))>_local_8.height) ? ((_arg_2 + _arg_4) - _local_8.height) : 0));
                        _local_5 = ((!((_arg_1 == _rectangle.x))) || (!((_arg_2 == _rectangle.y))));
                    }
                    else {
                        _arg_3 = (_arg_3 - ((((_arg_1 + _arg_3))>_local_8.width) ? ((_arg_1 + _arg_3) - _local_8.width) : 0));
                        _arg_4 = (_arg_4 - ((((_arg_2 + _arg_4))>_local_8.height) ? ((_arg_2 + _arg_4) - _local_8.height) : 0));
                        _local_6 = ((!((_arg_3 == _rectangle.width))) || (!((_arg_4 == _rectangle.height))));
                    };
                };
            };
            if (((_local_5) || (_local_6))){
                if (_local_5){
                    _local_9 = WindowEvent.allocate(WindowEvent.WINDOW_EVENT_RELOCATE, this, null, true);
                    this.update(this, _local_9);
                    if (_local_9.isWindowOperationPrevented()){
                        _local_5 = false;
                    };
                    _local_9.recycle();
                };
                if (_local_6){
                    _local_9 = WindowEvent.allocate(WindowEvent.WE_RESIZE, this, null, true);
                    this.update(this, _local_9);
                    if (_local_9.isWindowOperationPrevented()){
                        _local_6 = false;
                    };
                    _local_9.recycle();
                };
                if (_local_5){
                    _SafeStr_9801.x = _rectangle.x;
                    _SafeStr_9801.y = _rectangle.y;
                    _SafeStr_9801.width = _rectangle.width;
                    _SafeStr_9801.height = _rectangle.height;
                    _rectangle.x = _arg_1;
                    _rectangle.y = _arg_2;
                };
                if (_local_6){
                    _SafeStr_9801.width = _rectangle.width;
                    _SafeStr_9801.height = _rectangle.height;
                    _rectangle.width = _arg_3;
                    _rectangle.height = _arg_4;
                };
                if (_local_5){
                    _local_9 = WindowEvent.allocate(WindowEvent.WE_RELOCATED, this, null);
                    this.update(this, _local_9);
                    _local_9.recycle();
                };
                if (_local_6){
                    _local_9 = WindowEvent.allocate(WindowEvent.WE_RESIZED, this, null);
                    this.update(this, _local_9);
                    _local_9.recycle();
                };
            };
        }
        public function getRegionProperties(_arg_1:Rectangle=null, _arg_2:Rectangle=null, _arg_3:Rectangle=null, _arg_4:Rectangle=null):void
        {
            if (_arg_1 != null){
                _arg_1.x = _rectangle.x;
                _arg_1.y = _rectangle.y;
                _arg_1.width = _rectangle.width;
                _arg_1.height = _rectangle.height;
            };
            if (_arg_2 != null){
                _arg_2.x = _SafeStr_9801.x;
                _arg_2.y = _SafeStr_9801.y;
                _arg_2.width = _SafeStr_9801.width;
                _arg_2.height = _SafeStr_9801.height;
            };
            if (((!((_arg_3 == null))) && (!((_SafeStr_9802 == null))))){
                _arg_3.x = _SafeStr_9802.x;
                _arg_3.y = _SafeStr_9802.y;
                _arg_3.width = _SafeStr_9802.width;
                _arg_3.height = _SafeStr_9802.height;
            };
            if (((!((_arg_4 == null))) && (!((_SafeStr_9803 == null))))){
                _arg_4.x = _SafeStr_9803.x;
                _arg_4.y = _SafeStr_9803.y;
                _arg_4.width = _SafeStr_9803.width;
                _arg_4.height = _SafeStr_9803.height;
            };
        }
        public function setRegionProperties(_arg_1:Rectangle=null, _arg_2:Rectangle=null, _arg_3:Rectangle=null):void
        {
            if (_arg_3 != null){
                if ((((_arg_3.width < 0)) || ((_arg_3.height < 0)))){
                    throw (new Error("Invalid rectangle; maximized size can't be less than zero!"));
                };
                if (_SafeStr_9803 == null){
                    _SafeStr_9803 = new Rectangle();
                };
                _SafeStr_9803.x = _arg_3.x;
                _SafeStr_9803.y = _arg_3.y;
                _SafeStr_9803.width = _arg_3.width;
                _SafeStr_9803.height = _arg_3.height;
            };
            if (_arg_2 != null){
                if ((((_arg_2.width < 0)) || ((_arg_2.height < 0)))){
                    throw (new Error("Invalid rectangle; minimized size can't be less than zero!"));
                };
                if (_SafeStr_9802 == null){
                    _SafeStr_9802 = new Rectangle();
                };
                _SafeStr_9802.x = _arg_2.x;
                _SafeStr_9802.y = _arg_2.y;
                _SafeStr_9802.width = _arg_2.width;
                _SafeStr_9802.height = _arg_2.height;
            };
            if ((((_arg_3.width < _arg_2.width)) || ((_arg_3.height < _arg_2.height)))){
                _arg_3.width = _arg_2.width;
                _arg_3.height = _arg_2.height;
                throw (new Error("Maximized rectangle can't be smaller than minimized rectangle!"));
            };
            if (_arg_1 != null){
                this.setRectangle(_arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
            };
        }
        public function buildFromXML(_arg_1:XML, _arg_2:Map=null):Boolean
        {
            return (!((_context.getWindowParser().parseAndConstruct(_arg_1, this, _arg_2) == null)));
        }
        public function fetchDrawBuffer():IBitmapDrawable
        {
            return (((testParamFlag(WindowParam._SafeStr_7443)) ? (((this._parent)!=null) ? this._parent.fetchDrawBuffer() : null) : this.getGraphicContext(true).fetchDrawBuffer()));
        }
        public function getDrawRegion(_arg_1:Rectangle):void
        {
            if (!testParamFlag(WindowParam._SafeStr_7443)){
                _arg_1.x = 0;
                _arg_1.y = 0;
                _arg_1.width = _rectangle.width;
                _arg_1.height = _rectangle.height;
            }
            else {
                if (this._parent != null){
                    this._parent.getDrawRegion(_arg_1);
                    _arg_1.x = (_arg_1.x + _rectangle.x);
                    _arg_1.y = (_arg_1.y + _rectangle.y);
                    _arg_1.width = _rectangle.width;
                    _arg_1.height = _rectangle.height;
                }
                else {
                    _arg_1.x = 0;
                    _arg_1.y = 0;
                    _arg_1.width = 0;
                    _arg_1.height = 0;
                };
            };
        }
        public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:IWindow;
            var _local_4:IMouseListenerService;
            var _local_5:WindowEvent;
            var _local_6:Rectangle;
            var _local_7:uint;
            if (!testParamFlag(WindowParam._SafeStr_7442)){
                this.procedure(_arg_2, this);
                if (_disposed){
                    return (true);
                };
                if (!_arg_2.isWindowOperationPrevented()){
                    if (this.hasEventListener(_arg_2.type)){
                        this._events.dispatchEvent(_arg_2);
                        if (_disposed){
                            return (true);
                        };
                    };
                };
                if (_arg_2.cancelable){
                    if (_arg_2.isWindowOperationPrevented()){
                        return (true);
                    };
                };
            };
            if ((_arg_2 is WindowMouseEvent)){
                switch (_arg_2.type){
                    case WindowMouseEvent.WME_DOWN:
                        if (this.activate()){
                            if (_arg_2.cancelable){
                                _arg_2.preventDefault();
                            };
                        };
                        if (disposed){
                            return (true);
                        };
                        this.setStateFlag(WindowState._SafeStr_6248, true);
                        _local_4 = _context.getWindowServices().getMouseListenerService();
                        _local_4.begin(this);
                        _local_4.eventTypes.push(WindowMouseEvent.WME_UP);
                        _local_4.areaLimit = MouseListenerType._SafeStr_9483;
                        if (testParamFlag(WindowParam._SafeStr_7488)){
                            _local_3 = this;
                            while (_local_3 != null) {
                                if (_local_3.testParamFlag(WindowParam._SafeStr_7486)){
                                    _context.getWindowServices().getMouseDraggingService().begin(_local_3);
                                    break;
                                };
                                _local_3 = _local_3.parent;
                            };
                        };
                        if ((_param & WindowParam._SafeStr_7498) > 0){
                            _local_3 = this;
                            while (_local_3 != null) {
                                if (_local_3.testParamFlag(WindowParam._SafeStr_7492)){
                                    _context.getWindowServices().getMouseScalingService().begin(_local_3, (_param & WindowParam._SafeStr_7498));
                                    break;
                                };
                                _local_3 = _local_3.parent;
                            };
                        };
                        break;
                    case WindowMouseEvent.WME_UP:
                        if (testStateFlag(WindowState._SafeStr_6248)){
                            this.setStateFlag(WindowState._SafeStr_6248, false);
                        };
                        _context.getWindowServices().getMouseListenerService().end(this);
                        if (testParamFlag(WindowParam._SafeStr_7486)){
                            _context.getWindowServices().getMouseDraggingService().end(this);
                        };
                        if (testParamFlag(WindowParam._SafeStr_7492)){
                            _context.getWindowServices().getMouseScalingService().end(this);
                        };
                        break;
                    case WindowMouseEvent.WME_OUT:
                        if (testStateFlag(WindowState._SafeStr_5004)){
                            this.setStateFlag(WindowState._SafeStr_5004, false);
                        };
                        if (testStateFlag(WindowState._SafeStr_6248)){
                            this.setStateFlag(WindowState._SafeStr_6248, false);
                        };
                        break;
                    case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                        if (!testStateFlag(WindowState._SafeStr_5004)){
                            this.setStateFlag(WindowState._SafeStr_5004, true);
                        };
                        break;
                    case WindowMouseEvent.WME_WHEEL:
                        return (false);
                };
            }
            else {
                if ((_arg_2 is WindowEvent)){
                    switch (_arg_2.type){
                        case WindowEvent.WE_RESIZED:
                            _context.invalidate(this, _rectangle.union(_SafeStr_9801), WindowRedrawFlag.RESIZE);
                            if (_arg_1 == this){
                                _local_5 = WindowEvent.allocate(WindowEvent.WE_PARENT_RESIZED, this, null);
                                this.notifyChildren(_local_5);
                                _local_5.recycle();
                                if (testParamFlag(WindowParam._SafeStr_7452, WindowParam._SafeStr_7454)){
                                    this.updateScaleRelativeToParent();
                                }
                                else {
                                    if (testParamFlag(WindowParam._SafeStr_7462, WindowParam._SafeStr_7464)){
                                        this.updateScaleRelativeToParent();
                                    };
                                };
                                if (this._parent != null){
                                    _local_7 = _param;
                                    _param = (_param & ~((WindowParam._SafeStr_7454 | WindowParam._SafeStr_7464)));
                                    if (testParamFlag(WindowParam._SafeStr_9318)){
                                        this._parent.width = (this._parent.width + (_rectangle.width - _SafeStr_9801.width));
                                    };
                                    if (testParamFlag(WindowParam._SafeStr_9319)){
                                        this._parent.height = (this._parent.height + (_rectangle.height - _SafeStr_9801.height));
                                    };
                                    _param = _local_7;
                                    _local_5 = WindowEvent.allocate(WindowEvent.WE_CHILD_RESIZED, this._parent, this);
                                    this._parent.update(this, _local_5);
                                    _local_5.recycle();
                                };
                            };
                            break;
                        case WindowEvent.WE_RELOCATED:
                            _local_6 = _rectangle.union(_SafeStr_9801);
                            if (this._parent){
                                if (this._parent.clipping){
                                    _local_6.offset(this._parent.x, this._parent.y);
                                    _local_6 = _local_6.intersection(this._parent.rectangle);
                                    _local_6.offset(-(this._parent.x), -(this._parent.y));
                                };
                            };
                            _context.invalidate(this, _local_6, WindowRedrawFlag._SafeStr_9614);
                            if (_arg_1 == this){
                                _local_5 = WindowEvent.allocate(WindowEvent.WE_PARENT_RELOCATED, this, null);
                                this.notifyChildren(_local_5);
                                _local_5.recycle();
                                if (this._parent != null){
                                    _local_5 = WindowEvent.allocate(WindowEvent.WE_CHILD_RELOCATED, this._parent, this);
                                    this._parent.update(this, _local_5);
                                    _local_5.recycle();
                                };
                            };
                            break;
                        case WindowEvent.WE_ACTIVATED:
                            if (_arg_1 == this){
                                _local_5 = WindowEvent.allocate(WindowEvent.WE_PARENT_ACTIVATED, this, null);
                                this.notifyChildren(_local_5);
                                _local_5.recycle();
                                if (this._parent != null){
                                    _local_5 = WindowEvent.allocate(WindowEvent.WE_CHILD_ACTIVATED, this._parent, this);
                                    this._parent.update(this, _local_5);
                                    _local_5.recycle();
                                };
                            };
                            break;
                        case WindowEvent.WE_PARENT_ADDED:
                            if (testParamFlag(WindowParam._SafeStr_7452, WindowParam._SafeStr_7454)){
                                this.updateScaleRelativeToParent();
                            }
                            else {
                                if (testParamFlag(WindowParam._SafeStr_7462, WindowParam._SafeStr_7464)){
                                    this.updateScaleRelativeToParent();
                                };
                            };
                            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
                            break;
                        case WindowEvent.WE_PARENT_RESIZED:
                            this._parent.getRegionProperties(null, this._SafeStr_9838);
                            this.updateScaleRelativeToParent();
                            break;
                        case WindowEvent.WE_CHILD_ADDED:
                            if (testParamFlag(WindowParam._SafeStr_7436)){
                                this.scaleToAccommodateChildren();
                            }
                            else {
                                if (testParamFlag(WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN)){
                                    expandToAccommodateChild(this, _arg_2.related);
                                };
                            };
                            break;
                        case WindowEvent.WE_CHILD_REMOVED:
                            if (testParamFlag(WindowParam._SafeStr_7436)){
                                this.scaleToAccommodateChildren();
                            };
                            break;
                        case WindowEvent.WE_CHILD_ACTIVATED:
                            this.activate();
                            break;
                        case WindowEvent.WE_CHILD_RESIZED:
                            if (testParamFlag(WindowParam._SafeStr_7436)){
                                this.scaleToAccommodateChildren();
                            }
                            else {
                                if (testParamFlag(WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN)){
                                    expandToAccommodateChild(this, _arg_2.related);
                                };
                            };
                            break;
                        case WindowEvent.WE_CHILD_RELOCATED:
                            if (testParamFlag(WindowParam._SafeStr_7436)){
                                this.scaleToAccommodateChildren();
                            }
                            else {
                                if (testParamFlag(WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN)){
                                    expandToAccommodateChild(this, _arg_2.related);
                                };
                            };
                            break;
                    };
                };
            };
            return (true);
        }
        protected function notifyEventListeners(_arg_1:WindowEvent):void
        {
            this.procedure(_arg_1, this);
            if (!_arg_1.isWindowOperationPrevented()){
                if (this.hasEventListener(_arg_1.type)){
                    this._events.dispatchEvent(_arg_1);
                };
            };
        }
        private function nullEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }
        private function notifyChildren(_arg_1:WindowEvent):void
        {
            var _local_2:WindowController;
            for each (_local_2 in this._children) {
                _local_2.update(this, _arg_1);
            };
        }
        public function childRectToClippedDrawRegion(_arg_1:Rectangle, _arg_2:Rectangle):Boolean
        {
            var _local_4:Rectangle;
            var _local_3:Boolean;
            if (testParamFlag(WindowParam._SafeStr_7443)){
                _arg_1.offset(_rectangle.x, _rectangle.y);
                if (clipping){
                    _local_4 = _arg_1.intersection(_rectangle);
                    if (_arg_1.x < _rectangle.x){
                        _arg_2.x = (_arg_2.x - (_arg_1.x - _rectangle.x));
                        _arg_1.x = _rectangle.x;
                        _local_3 = true;
                    };
                    if (_arg_1.y < _rectangle.y){
                        _arg_2.y = (_arg_2.y - (_arg_1.y - _rectangle.y));
                        _arg_1.y = _rectangle.y;
                        _local_3 = true;
                    };
                    if (_arg_1.width != _local_4.width){
                        _arg_1.width = _local_4.width;
                        _local_3 = true;
                    };
                    if (_arg_1.height != _local_4.height){
                        _arg_1.height = _local_4.height;
                        _local_3 = true;
                    };
                    _arg_2.width = _local_4.width;
                    _arg_2.height = _local_4.height;
                };
                if (this._parent != null){
                    _local_3 = ((WindowController(this._parent).childRectToClippedDrawRegion(_arg_1, _arg_2)) || (_local_3));
                };
            }
            else {
                if (clipping){
                    if (_arg_1.x < 0){
                        _arg_2.x = (_arg_2.x - _arg_1.x);
                        _arg_1.x = 0;
                        _local_3 = true;
                    };
                    if (_arg_1.y < 0){
                        _arg_2.y = (_arg_2.y - _arg_1.y);
                        _arg_1.y = 0;
                        _local_3 = true;
                    };
                    if (_rectangle.width < _arg_1.right){
                        _arg_2.right = (_arg_2.right - (_arg_1.right - _rectangle.width));
                        _arg_1.right = _arg_1.width;
                        _local_3 = true;
                    };
                    if (_rectangle.height < _arg_1.bottom){
                        _arg_2.bottom = (_arg_2.bottom - (_arg_1.bottom - _rectangle.height));
                        _arg_1.bottom = _rectangle.height;
                        _local_3 = true;
                    };
                };
            };
            return (((_local_3) ? (((_arg_2.width > 0)) && ((_arg_2.height > 0))) : true));
        }
        public function convertPointFromGlobalToLocalSpace(_arg_1:Point):void
        {
            var _local_2:Number = _arg_1.x;
            var _local_3:Number = _arg_1.y;
            if (this._parent == null){
                _arg_1.x = _rectangle.x;
                _arg_1.y = _rectangle.y;
            }
            else {
                this._parent.getGlobalPosition(_arg_1);
                _arg_1.x = (_arg_1.x + _rectangle.x);
                _arg_1.y = (_arg_1.y + _rectangle.y);
            };
            _arg_1.x = (_local_2 - _arg_1.x);
            _arg_1.y = (_local_3 - _arg_1.y);
        }
        public function convertPointFromLocalToGlobalSpace(_arg_1:Point):void
        {
            var _local_2:Number = _arg_1.x;
            var _local_3:Number = _arg_1.y;
            if (this._parent == null){
                _arg_1.x = _rectangle.x;
                _arg_1.y = _rectangle.y;
            }
            else {
                this._parent.getGlobalPosition(_arg_1);
                _arg_1.x = (_arg_1.x + _rectangle.x);
                _arg_1.y = (_arg_1.y + _rectangle.y);
            };
            _arg_1.x = (_arg_1.x + _local_2);
            _arg_1.y = (_arg_1.y + _local_3);
        }
        public function getRelativeMousePosition(_arg_1:Point):void
        {
            this.getGlobalPosition(_arg_1);
            _arg_1.x = (_context.getDesktopWindow().mouseX - _arg_1.x);
            _arg_1.y = (_context.getDesktopWindow().mouseY - _arg_1.y);
        }
        public function getAbsoluteMousePosition(_arg_1:Point):void
        {
            _arg_1.x = _context.getDesktopWindow().mouseX;
            _arg_1.y = _context.getDesktopWindow().mouseY;
        }
        public function getLocalPosition(_arg_1:Point):void
        {
            _arg_1.x = _rectangle.x;
            _arg_1.y = _rectangle.y;
        }
        public function getLocalRectangle(_arg_1:Rectangle):void
        {
            _arg_1.x = _rectangle.x;
            _arg_1.y = _rectangle.y;
            _arg_1.width = _rectangle.width;
            _arg_1.height = _rectangle.height;
        }
        public function hitTestLocalPoint(_arg_1:Point):Boolean
        {
            return (_rectangle.containsPoint(_arg_1));
        }
        public function hitTestLocalRectangle(_arg_1:Rectangle):Boolean
        {
            return (_rectangle.intersects(_arg_1));
        }
        public function validateLocalPointIntersection(_arg_1:Point, _arg_2:BitmapData):Boolean
        {
            return (this.testLocalPointHitAgainstAlpha(_arg_1, _arg_2, _mouseThreshold));
        }
        public function getGlobalPosition(_arg_1:Point):void
        {
            if (this._parent != null){
                this._parent.getGlobalPosition(_arg_1);
                _arg_1.x = (_arg_1.x + _rectangle.x);
                _arg_1.y = (_arg_1.y + _rectangle.y);
            }
            else {
                _arg_1.x = _rectangle.x;
                _arg_1.y = _rectangle.y;
            };
        }
        public function setGlobalPosition(_arg_1:Point):void
        {
            var _local_2:Point = new Point();
            if (this._parent != null){
                this._parent.getGlobalPosition(_local_2);
                _local_2.x = (_local_2.x + _rectangle.x);
                _local_2.y = (_local_2.y + _rectangle.y);
            }
            else {
                _local_2.x = _rectangle.x;
                _local_2.y = _rectangle.y;
            };
            this.x = (x + (_arg_1.x - _local_2.x));
            this.y = (y + (_arg_1.y - _local_2.y));
        }
        public function getGlobalRectangle(_arg_1:Rectangle):void
        {
            var _local_2:Rectangle = _rectangle;
            if (this._parent != null){
                this._parent.getGlobalRectangle(_arg_1);
                _arg_1.x = (_arg_1.x + _local_2.x);
                _arg_1.y = (_arg_1.y + _local_2.y);
            }
            else {
                _arg_1.x = _local_2.x;
                _arg_1.y = _local_2.y;
            };
            _arg_1.width = _local_2.width;
            _arg_1.height = _local_2.height;
        }
        public function setGlobalRectangle(_arg_1:Rectangle):void
        {
            var _local_2:Point = new Point();
            if (this._parent != null){
                this._parent.getGlobalPosition(_local_2);
                _local_2.x = (_local_2.x + _rectangle.x);
                _local_2.y = (_local_2.y + _rectangle.y);
            }
            else {
                _local_2.x = _rectangle.x;
                _local_2.y = _rectangle.y;
            };
            this.setRectangle((x + (_arg_1.x - _local_2.x)), (y + (_arg_1.y - _local_2.y)), _arg_1.width, _arg_1.height);
        }
        public function hitTestGlobalPoint(_arg_1:Point):Boolean
        {
            var _local_2:Rectangle = new Rectangle();
            this.getGlobalRectangle(_local_2);
            return (_local_2.containsPoint(_arg_1));
        }
        public function hitTestGlobalRectangle(_arg_1:Rectangle):Boolean
        {
            var _local_2:Rectangle = new Rectangle();
            this.getGlobalRectangle(_local_2);
            return (_local_2.intersects(_arg_1));
        }
        public function validateGlobalPointIntersection(_arg_1:Point, _arg_2:BitmapData):Boolean
        {
            var _local_3:Point = new Point();
            this.getGlobalPosition(_local_3);
            _local_3.x = (_arg_1.x - _local_3.x);
            _local_3.y = (_arg_1.y - _local_3.y);
            return (this.testLocalPointHitAgainstAlpha(_local_3, _arg_2, _mouseThreshold));
        }
        public function getMouseRegion(_arg_1:Rectangle):void
        {
            var _local_2:Rectangle;
            this.getGlobalRectangle(_arg_1);
            if (_arg_1.width < 0){
                _arg_1.width = 0;
            };
            if (_arg_1.height < 0){
                _arg_1.height = 0;
            };
            if (testParamFlag(WindowParam._SafeStr_7443)){
                _local_2 = new Rectangle();
                IWindow(this._parent).getMouseRegion(_local_2);
                if (_arg_1.left < _local_2.left){
                    _arg_1.left = _local_2.left;
                };
                if (_arg_1.top < _local_2.top){
                    _arg_1.top = _local_2.top;
                };
                if (_arg_1.right > _local_2.right){
                    _arg_1.right = _local_2.right;
                };
                if (_arg_1.bottom > _local_2.bottom){
                    _arg_1.bottom = _local_2.bottom;
                };
            };
        }
        protected function testLocalPointHitAgainstAlpha(_arg_1:Point, _arg_2:BitmapData, _arg_3:uint):Boolean
        {
            var _local_5:BitmapData;
            var _local_4:Boolean;
            if ((((_rectangle.width < 1)) || ((_rectangle.height < 1)))){
                return (false);
            };
            if (((this._SafeStr_9161) && ((_mouseThreshold > 0)))){
                if (!testParamFlag(WindowParam._SafeStr_7443)){
                    if ((((_arg_1.x <= _rectangle.width)) && ((_arg_1.y <= _rectangle.height)))){
                        _local_5 = (this.getGraphicContext(true).fetchDrawBuffer() as BitmapData);
                        if (_local_5 != null){
                            _local_4 = _local_5.hitTest(_SafeStr_9835, _arg_3, _arg_1);
                        };
                    };
                }
                else {
                    _local_4 = (((_arg_2)!=null) ? _arg_2.hitTest(_SafeStr_9835, _arg_3, _arg_1) : false);
                };
            }
            else {
                if ((((_arg_1.x >= 0)) && ((_arg_1.x < _rectangle.width)))){
                    if ((((_arg_1.y >= 0)) && ((_arg_1.y < _rectangle.height)))){
                        _local_4 = true;
                    };
                };
            };
            return (_local_4);
        }
        public function isCapableOfUsingSharedGraphicContext():Boolean
        {
            return (true);
        }
        public function resolveVerticalScale():Number
        {
            return ((_rectangle.height / _SafeStr_9800.height));
        }
        public function resolveHorizontalScale():Number
        {
            return ((_rectangle.width / _SafeStr_9800.width));
        }
        public function offset(_arg_1:Number, _arg_2:Number):void
        {
            this.setRectangle((_rectangle.x + _arg_1), (_rectangle.y + _arg_2), _rectangle.width, _rectangle.height);
        }
        public function scale(_arg_1:Number, _arg_2:Number):void
        {
            this.setRectangle(_rectangle.x, _rectangle.y, (_rectangle.width + _arg_1), (_rectangle.height + _arg_2));
        }
        public function scaleToAccommodateChildren():void
        {
            var _local_1:IWindow;
            var _local_6:Rectangle;
            var _local_9:Array;
            var _local_10:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_7:Boolean;
            var _local_8:uint = (param & (WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN | WindowParam._SafeStr_7436));
            for each (_local_1 in this._children) {
                _local_6 = _local_1.rectangle;
                if (_local_6.x < _local_2){
                    _local_4 = (_local_4 - (_local_6.x - _local_2));
                    _local_2 = _local_6.x;
                    _local_7 = true;
                };
                if (_local_6.right > _local_4){
                    _local_4 = (_local_6.x + _local_6.width);
                    _local_7 = true;
                };
                if (_local_6.y < _local_3){
                    _local_5 = (_local_5 - (_local_6.y - _local_3));
                    _local_3 = _local_6.y;
                    _local_7 = true;
                };
                if (_local_6.bottom > _local_5){
                    _local_5 = (_local_6.y + _local_6.height);
                    _local_7 = true;
                };
            };
            if (_local_7){
                _local_9 = [];
                for each (_local_1 in this._children) {
                    _local_10 = (_local_1.param & (WindowParam._SafeStr_7454 | WindowParam._SafeStr_7464));
                    _local_1.setParamFlag(_local_10, false);
                    _local_9.push(_local_10);
                };
                if (_local_8){
                    this.setParamFlag(_local_8, false);
                };
                this.setRectangle((_rectangle.x + _local_2), (_rectangle.y + _local_3), _local_4, _local_5);
                for each (_local_1 in this._children) {
                    _local_1.offset(-(_local_2), -(_local_3));
                    _local_1.setParamFlag(_local_9.shift(), true);
                };
                if (_local_8){
                    this.setParamFlag(_local_8, true);
                };
            };
        }
        public function getStateFlag(_arg_1:uint):Boolean
        {
            return (!(((_state & _arg_1) == 0)));
        }
        public function setStateFlag(_arg_1:uint, _arg_2:Boolean=true):void
        {
            var _local_3:uint = _state;
            _state = ((_arg_2) ? _state = (_state | _arg_1) : _state = (_state & ~(_arg_1)));
            if (_state != _local_3){
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9615);
            };
        }
        public function getStyleFlag(_arg_1:uint):Boolean
        {
            return (!(((_style & _arg_1) == 0)));
        }
        public function setStyleFlag(_arg_1:uint, _arg_2:Boolean=true):void
        {
            var _local_4:Array;
            var _local_5:uint;
            var _local_6:WindowController;
            var _local_3:uint = _style;
            _style = ((_arg_2) ? _style = (_style | _arg_1) : _style = (_style & ~(_arg_1)));
            if (_style != _local_3){
                _local_4 = new Array();
                this.groupChildrenWithTag(WindowController.TAG_INTERNAL, _local_4);
                _local_5 = _local_4.length;
                while (--_local_5 > -1) {
                    _local_6 = (_local_4[_local_5] as WindowController);
                    if (_local_6.tags.indexOf(_IGNORE_INHERITED_STYLE) == -1){
                        _local_6.style = _style;
                    };
                };
                _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            };
        }
        public function getParamFlag(_arg_1:uint):Boolean
        {
            return (!(((_param & _arg_1) == 0)));
        }
        public function setParamFlag(_arg_1:uint, _arg_2:Boolean=true):void
        {
            var _local_3:uint = _param;
            _param = ((_arg_2) ? _param = (_param | _arg_1) : _param = (_param & ~(_arg_1)));
            if (_param != _local_3){
                if (!(_param & WindowParam._SafeStr_7443)){
                    if (!this._graphicContext){
                        this.setupGraphicsContext();
                        _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
                    };
                }
                else {
                    if ((_param & WindowParam._SafeStr_7443)){
                        if (this._graphicContext){
                            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
                        };
                    };
                };
            };
        }
        protected function updateScaleRelativeToParent():void
        {
            var _local_3:Rectangle;
            var _local_4:int;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:Rectangle;
            if (this._parent == null){
                return;
            };
            var _local_1 = !(testParamFlag(WindowParam._SafeStr_7447, WindowParam._SafeStr_7454));
            var _local_2 = !(testParamFlag(WindowParam._SafeStr_7456, WindowParam._SafeStr_7464));
            if (((_local_1) || (_local_2))){
                _local_3 = _rectangle.clone();
                if (_local_1){
                    _local_4 = (this._parent.width - this._SafeStr_9838.width);
                    _local_5 = (_param & WindowParam._SafeStr_7454);
                    if (_local_5 == WindowParam._SafeStr_7450){
                        _local_3.width = (_local_3.width + _local_4);
                    }
                    else {
                        if (_local_5 == WindowParam._SafeStr_7449){
                            _local_3.x = (_local_3.x + _local_4);
                        }
                        else {
                            if (_local_5 == WindowParam._SafeStr_7452){
                                if ((((this._parent.width < _local_3.width)) && (this.getParamFlag(WindowParam._SafeStr_7443)))){
                                    _local_3.x = 0;
                                }
                                else {
                                    _local_3.x = (Math.floor((this._parent.width / 2)) - Math.floor((_local_3.width / 2)));
                                };
                            };
                        };
                    };
                };
                if (_local_2){
                    _local_4 = (this._parent.height - this._SafeStr_9838.height);
                    _local_5 = (_param & WindowParam._SafeStr_7464);
                    if (_local_5 == WindowParam._SafeStr_7460){
                        _local_3.height = (_local_3.height + _local_4);
                    }
                    else {
                        if (_local_5 == WindowParam._SafeStr_7458){
                            _local_3.y = (_local_3.y + _local_4);
                        }
                        else {
                            if (_local_5 == WindowParam._SafeStr_7462){
                                if ((((this._parent.height < _local_3.height)) && (this.getParamFlag(WindowParam._SafeStr_7443)))){
                                    _local_3.y = 0;
                                }
                                else {
                                    _local_3.y = (Math.floor((this._parent.height / 2)) - Math.floor((_local_3.height / 2)));
                                };
                            };
                        };
                    };
                };
                _local_6 = _param;
                _param = (_param & ~(((WindowParam._SafeStr_9362 | WindowParam._SafeStr_7454) | WindowParam._SafeStr_7464)));
                this.setRectangle(_local_3.x, _local_3.y, _local_3.width, _local_3.height);
                _param = _local_6;
            }
            else {
                if (testParamFlag(WindowParam._SafeStr_7445)){
                    _local_3 = _rectangle.clone();
                    if (this._parent != null){
                        _local_7 = this._parent.rectangle;
                        _local_3.x = (((_local_3.x)<0) ? 0 : _local_3.x);
                        _local_3.y = (((_local_3.y)<0) ? 0 : _local_3.y);
                        _local_3.x = (_local_3.x - ((((_local_3.x + _local_3.width))>_local_7.width) ? ((_local_3.x + _local_3.width) - _local_7.width) : 0));
                        _local_3.y = (_local_3.y - ((((_local_3.y + _local_3.height))>_local_7.height) ? ((_local_3.y + _local_3.height) - _local_7.height) : 0));
                        _local_3.width = (_local_3.width - ((((_local_3.x + _local_3.width))>_local_7.width) ? ((_local_3.x + _local_3.width) - _local_7.width) : 0));
                        _local_3.height = (_local_3.height - ((((_local_3.y + _local_3.height))>_local_7.height) ? ((_local_3.y + _local_3.height) - _local_7.height) : 0));
                        if (((((((!((_local_3.x == _rectangle.x))) || (!((_local_3.y == _rectangle.y))))) || (!((_local_3.width == _rectangle.width))))) || (!((_local_3.height == _rectangle.height))))){
                            _local_6 = _param;
                            _param = (_param & ~(((WindowParam._SafeStr_9362 | WindowParam._SafeStr_7454) | WindowParam._SafeStr_7464)));
                            this.setRectangle(_local_3.x, _local_3.y, _local_3.width, _local_3.height);
                            _param = _local_6;
                        };
                    };
                };
            };
        }
        protected function isChildWindow():Boolean
        {
            return (!((this._parent == context.getDesktopWindow())));
        }
        public function destroy():Boolean
        {
            if (_state == WindowState._SafeStr_9480){
                return (true);
            };
            _state = WindowState._SafeStr_9480;
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_DESTROY, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            _local_1 = WindowEvent.allocate(WindowEvent.WE_DESTROYED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            this.dispose();
            return (true);
        }
        public function minimize():Boolean
        {
            if ((_state & WindowState._SafeStr_9479)){
                return (false);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_MINIMIZE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9479, true);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_MINIMIZED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function maximize():Boolean
        {
            if ((_state & WindowState._SafeStr_9479)){
                return (false);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_MAXIMIZE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9479, true);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_MAXIMIZED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function restore():Boolean
        {
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_RESTORE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9479, false);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_RESTORED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function activate():Boolean
        {
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_ACTIVATE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_4586, true);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_ACTIVATED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function deactivate():Boolean
        {
            if (!this.getStateFlag(WindowState._SafeStr_4586)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_DEACTIVATE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_4586, false);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_DEACTIVATED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function lock():Boolean
        {
            if (this.getStateFlag(WindowState._SafeStr_9479)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_LOCK, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9479, true);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_LOCKED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function unlock():Boolean
        {
            if (!this.getStateFlag(WindowState._SafeStr_9479)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_UNLOCK, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9479, false);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_UNLOCKED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function enable():Boolean
        {
            if (!this.getStateFlag(WindowState._SafeStr_9399)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_ENABLE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9399, false);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_ENABLED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function disable():Boolean
        {
            if (this.getStateFlag(WindowState._SafeStr_9399)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_DISABLE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9399, true);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_DISABLED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function focus():Boolean
        {
            if (this.getStateFlag(WindowState._SafeStr_9170)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_FOCUS, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9170, true);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_FOCUSED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function unfocus():Boolean
        {
            if (!this.getStateFlag(WindowState._SafeStr_9170)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_UNFOCUS, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            this.setStateFlag(WindowState._SafeStr_9170, false);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_UNFOCUSED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function getChildUnderPoint(_arg_1:Point):IWindow
        {
            var _local_2:Rectangle;
            var _local_3:Boolean;
            var _local_4:IWindow;
            var _local_5:uint;
            if (_visible){
                _local_2 = new Rectangle();
                this.getMouseRegion(_local_2);
                _local_3 = _local_2.containsPoint(_arg_1);
                _local_5 = this.numChildren;
                if (_local_3){
                    while (_local_5 > 0) {
                        _local_4 = WindowController(this._children[(_local_5 - 1)]).getChildUnderPoint(_arg_1);
                        if (_local_4 != null){
                            return (_local_4);
                        };
                        _local_5--;
                    };
                };
                if (this.validateGlobalPointIntersection(_arg_1, null)){
                    return (this);
                };
            };
            return (null);
        }
        public function groupChildrenUnderPoint(_arg_1:Point, _arg_2:Array):void
        {
            var _local_3:WindowController;
            if (_visible){
                if (_rectangle.containsPoint(_arg_1)){
                    _arg_2.push(this);
                    _arg_1.offset(-(_rectangle.x), -(_rectangle.y));
                    for each (_local_3 in this._children) {
                        _local_3.groupChildrenUnderPoint(_arg_1, _arg_2);
                    };
                    _arg_1.offset(_rectangle.x, _rectangle.y);
                }
                else {
                    if (!_clipping){
                        _arg_1.offset(-(_rectangle.x), -(_rectangle.y));
                        for each (_local_3 in this._children) {
                            _local_3.groupChildrenUnderPoint(_arg_1, _arg_2);
                        };
                        _arg_1.offset(_rectangle.x, _rectangle.y);
                    };
                };
            };
        }
        public function groupParameterFilteredChildrenUnderPoint(_arg_1:Point, _arg_2:Array, _arg_3:uint=0):void
        {
            var _local_4:WindowController;
            if (_visible){
                if (_rectangle.containsPoint(_arg_1)){
                    if ((_param & _arg_3) == _arg_3){
                        _arg_2.push(this);
                    };
                    _arg_1.offset(-(_rectangle.x), -(_rectangle.y));
                    for each (_local_4 in this._children) {
                        _local_4.groupParameterFilteredChildrenUnderPoint(_arg_1, _arg_2, _arg_3);
                    };
                    _arg_1.offset(_rectangle.x, _rectangle.y);
                }
                else {
                    if (!_clipping){
                        _arg_1.offset(-(_rectangle.x), -(_rectangle.y));
                        for each (_local_4 in this._children) {
                            _local_4.groupParameterFilteredChildrenUnderPoint(_arg_1, _arg_2, _arg_3);
                        };
                        _arg_1.offset(_rectangle.x, _rectangle.y);
                    };
                };
            };
        }
        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:int=0):void
        {
            if (!_disposed){
                if (!this._events){
                    this._events = new WindowEventDispatcher(this);
                };
                this._events.addEventListener(_arg_1, _arg_2, _arg_3);
            };
        }
        public function hasEventListener(_arg_1:String):Boolean
        {
            return (((((_disposed) || (!(this._events)))) ? false : this._events.hasEventListener(_arg_1)));
        }
        public function removeEventListener(_arg_1:String, _arg_2:Function):void
        {
            if (((!(_disposed)) && (this._events))){
                this._events.removeEventListener(_arg_1, _arg_2);
            };
        }
        public function get numChildren():int
        {
            return (this._children.length);
        }
        public function populate(_arg_1:Array):void
        {
            var _local_3:WindowController;
            var _local_2:Boolean;
            for each (_local_3 in _arg_1) {
                if (((_local_3) && (!((_local_3.parent == this))))){
                    this._children.push(_local_3);
                    _local_3.parent = this;
                    _local_2 = ((_local_2) || (_local_3.hasGraphicsContext()));
                };
            };
            if (((this._SafeStr_9837) || (_local_2))){
                this.setupGraphicsContext();
            };
        }
        public function addChild(_arg_1:IWindow):IWindow
        {
            var _local_2:WindowController = WindowController(_arg_1);
            if (_local_2.parent != null){
                WindowController(_local_2.parent).removeChild(_local_2);
            };
            this._children.push(_local_2);
            _local_2.parent = this;
            if (((this._SafeStr_9837) || (_local_2.hasGraphicsContext()))){
                this.setupGraphicsContext();
                if (_local_2.getGraphicContext(true).parent != this._graphicContext){
                    this._graphicContext.addChildContext(_local_2.getGraphicContext(true));
                };
            };
            var _local_3:WindowEvent = WindowEvent.allocate(WindowEvent.WE_CHILD_ADDED, this, _arg_1);
            this.update(this, _local_3);
            _local_3.recycle();
            return (_arg_1);
        }
        public function addChildAt(_arg_1:IWindow, _arg_2:int):IWindow
        {
            var _local_3:WindowController = WindowController(_arg_1);
            if (_local_3.parent != null){
                WindowController(_local_3.parent).removeChild(_local_3);
            };
            this._children.splice(_arg_2, 0, _local_3);
            _local_3.parent = this;
            if (((this._SafeStr_9837) || (_local_3.hasGraphicsContext()))){
                this.setupGraphicsContext();
                if (_local_3.getGraphicContext(true).parent != this._graphicContext){
                    this._graphicContext.addChildContextAt(_local_3.getGraphicContext(true), _arg_2);
                };
            };
            var _local_4:WindowEvent = WindowEvent.allocate(WindowEvent.WE_CHILD_ADDED, this, _arg_1);
            this.update(this, _local_4);
            _local_4.recycle();
            return (_arg_1);
        }
        public function getChildAt(_arg_1:int):IWindow
        {
            return ((this._children[_arg_1] as IWindow));
        }
        public function getChildByID(_arg_1:uint):IWindow
        {
            var _local_2:IWindow;
            for each (_local_2 in this._children) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getChildByName(_arg_1:String):IWindow
        {
            var _local_2:IWindow;
            for each (_local_2 in this._children) {
                if (_local_2.name == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function findChildByName(_arg_1:String):IWindow
        {
            var _local_2:WindowController;
            for each (_local_2 in this._children) {
                if (_local_2.name == _arg_1){
                    return (_local_2);
                };
            };
            for each (_local_2 in this._children) {
                _local_2 = (_local_2.findChildByName(_arg_1) as WindowController);
                if (_local_2){
                    return ((_local_2 as IWindow));
                };
            };
            return (null);
        }
        public function getChildByTag(_arg_1:String):IWindow
        {
            var _local_2:IWindow;
            for each (_local_2 in this._children) {
                if (_local_2.tags.indexOf(_arg_1) > -1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function findChildByTag(_arg_1:String):IWindow
        {
            if (_tags.indexOf(_arg_1) > -1){
                return (this);
            };
            var _local_2:WindowController = WindowController(this.getChildByTag(_arg_1));
            if (_local_2 == null){
                for each (_local_2 in this._children) {
                    _local_2 = (_local_2.findChildByTag(_arg_1) as WindowController);
                    if (_local_2 != null) break;
                };
            };
            return ((_local_2 as IWindow));
        }
        public function getChildIndex(_arg_1:IWindow):int
        {
            return (this._children.indexOf(_arg_1));
        }
        public function removeChild(_arg_1:IWindow):IWindow
        {
            var _local_2:int = this._children.indexOf(_arg_1);
            if (_local_2 < 0){
                return (null);
            };
            this._children.splice(_local_2, 1);
            var _local_3:WindowController = WindowController(_arg_1);
            _local_3.parent = null;
            if (_local_3.hasGraphicsContext()){
                this._graphicContext.removeChildContext(_local_3.getGraphicContext(true));
            };
            var _local_4:WindowEvent = WindowEvent.allocate(WindowEvent.WE_CHILD_REMOVED, this, _arg_1);
            this.update(this, _local_4);
            _local_4.recycle();
            return (_arg_1);
        }
        public function removeChildAt(_arg_1:int):IWindow
        {
            return (this.removeChild(this.getChildAt(_arg_1)));
        }
        public function setChildIndex(_arg_1:IWindow, _arg_2:int):void
        {
            var _local_4:WindowController;
            var _local_3:int = this._children.indexOf(_arg_1);
            if ((((_local_3 > -1)) && (!((_arg_2 == _local_3))))){
                this._children.splice(_local_3, 1);
                this._children.splice(_arg_2, 0, _arg_1);
                _local_4 = WindowController(_arg_1);
                if (_local_4.hasGraphicsContext()){
                    this._graphicContext.setChildContextIndex(_local_4.getGraphicContext(true), this.getChildIndex(_local_4));
                };
            };
        }
        public function swapChildren(_arg_1:IWindow, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:IWindow;
            var _local_6:int;
            if (((((!((_arg_1 == null))) && (!((_arg_2 == null))))) && (!((_arg_1 == _arg_2))))){
                _local_3 = this._children.indexOf(_arg_1);
                if (_local_3 < 0){
                    return;
                };
                _local_4 = this._children.indexOf(_arg_2);
                if (_local_4 < 0){
                    return;
                };
                if (_local_4 < _local_3){
                    _local_5 = _arg_1;
                    _arg_1 = _arg_2;
                    _arg_2 = _local_5;
                    _local_6 = _local_3;
                    _local_3 = _local_4;
                    _local_4 = _local_6;
                };
                this._children.splice(_local_4, 1);
                this._children.splice(_local_3, 1);
                this._children.splice(_local_3, 0, _arg_2);
                this._children.splice(_local_4, 0, _arg_1);
                if (((WindowController(_arg_1).hasGraphicsContext()) || (WindowController(_arg_2).hasGraphicsContext()))){
                    this._graphicContext.swapChildContexts(WindowController(_arg_1).getGraphicContext(true), WindowController(_arg_2).getGraphicContext(true));
                };
            };
        }
        public function swapChildrenAt(_arg_1:int, _arg_2:int):void
        {
            this.swapChildren(this._children[_arg_1], this._children[_arg_2]);
            this._graphicContext.swapChildContextsAt(_arg_1, _arg_2);
        }
        public function groupChildrenWithID(_arg_1:uint, _arg_2:Array, _arg_3:Boolean=false):uint
        {
            var _local_4:WindowController;
            var _local_5:uint;
            for each (_local_4 in this._children) {
                if (_local_4.id == _arg_1){
                    _arg_2.push(_local_4);
                    _local_5++;
                };
                if (_arg_3){
                    _local_5 = (_local_5 + _local_4.groupChildrenWithID(_arg_1, _arg_2, _arg_3));
                };
            };
            return (_local_5);
        }
        public function groupChildrenWithTag(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):uint
        {
            var _local_4:WindowController;
            var _local_5:uint;
            for each (_local_4 in this._children) {
                if (_local_4.tags.indexOf(_arg_1) > -1){
                    _arg_2.push(_local_4);
                    _local_5++;
                };
                if (_arg_3){
                    _local_5 = (_local_5 + _local_4.groupChildrenWithTag(_arg_1, _arg_2, _arg_3));
                };
            };
            return (_local_5);
        }
        public function findParentByName(_arg_1:String):IWindow
        {
            if (_name == _arg_1){
                return (this);
            };
            if (this._parent != null){
                if (this._parent.name == _arg_1){
                    return (this._parent);
                };
                return (this._parent.findParentByName(_arg_1));
            };
            return (null);
        }
        protected function requiresOwnGraphicContext():Boolean
        {
            var _local_1:WindowController;
            if (testParamFlag(WindowParam._SafeStr_7443)){
                for each (_local_1 in this._children) {
                    if (_local_1.requiresOwnGraphicContext()){
                        return (true);
                    };
                };
                return (false);
            };
            return (true);
        }

    }
}//package com.sulake.core.window

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// DefaultAttStruct = "_-2e0" (String#20604, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// WindowModel = "_-2WP" (String#1891, DoABC#2)
// IGraphicContextHost = "_-2on" (String#1945, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// MouseListenerType = "_-0a" (String#4300, DoABC#2)
// IRectLimiter = "_-1O2" (String#5311, DoABC#2)
// GraphicContext = "_-03R" (String#14179, DoABC#2)
// WindowDisposeEvent = "_-1nb" (String#5812, DoABC#2)
// IMouseListenerService = "_-0s7" (String#4688, DoABC#2)
// WindowRectLimits = "_-2hy" (String#6906, DoABC#2)
// WindowEventDispatcher = "_-2VY" (String#6674, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WE_RELOCATED = "_-13s" (String#16612, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _param = "_-2d3" (String#306, DoABC#2)
// getGlobalRectangle = "_-05T" (String#3675, DoABC#2)
// getStateFlag = "_-1nM" (String#5804, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)
// _SafeStr_5004 = "_-0Yv" (String#15399, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// WE_FOCUSED = "_-1ay" (String#17932, DoABC#2)
// WE_DEACTIVATED = "_-1oi" (String#18485, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// WE_PARENT_RESIZED = "_-0GO" (String#14697, DoABC#2)
// WE_PARENT_ADDED = "_-0D7" (String#14572, DoABC#2)
// setStateFlag = "_-1jq" (String#5750, DoABC#2)
// _SafeStr_6248 = "_-3J9" (String#22246, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// _blend = "_-2A2" (String#616, DoABC#2)
// _SafeStr_7436 = "_-0zN" (String#16403, DoABC#2)
// _SafeStr_7442 = "_-2kb" (String#20869, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_7445 = "_-3Kg" (String#22311, DoABC#2)
// _SafeStr_7447 = "_-2dV" (String#20584, DoABC#2)
// _SafeStr_7449 = "_-01-" (String#14095, DoABC#2)
// _SafeStr_7450 = "_-9f" (String#22606, DoABC#2)
// _SafeStr_7452 = "_-2Hm" (String#19717, DoABC#2)
// _SafeStr_7454 = "_-sy" (String#24403, DoABC#2)
// _SafeStr_7456 = "_-2vm" (String#21305, DoABC#2)
// _SafeStr_7458 = "_-cq" (String#23748, DoABC#2)
// _SafeStr_7460 = "_-ZZ" (String#23619, DoABC#2)
// _SafeStr_7462 = "_-15I" (String#16664, DoABC#2)
// _SafeStr_7464 = "_-1u-" (String#18716, DoABC#2)
// _SafeStr_7476 = "_-2eb" (String#20630, DoABC#2)
// _SafeStr_7478 = "_-09q" (String#14440, DoABC#2)
// _SafeStr_7482 = "_-22c" (String#19116, DoABC#2)
// _SafeStr_7484 = "_-28R" (String#19349, DoABC#2)
// _SafeStr_7486 = "_-2NN" (String#19938, DoABC#2)
// _SafeStr_7488 = "_-1ib" (String#18232, DoABC#2)
// _SafeStr_7492 = "_-0tz" (String#16201, DoABC#2)
// _SafeStr_7498 = "_-09o" (String#14438, DoABC#2)
// _caption = "_-p" (String#8690, DoABC#2)
// unfocus = "_-Rh" (String#8242, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// getParamFlag = "_-38B" (String#7475, DoABC#2)
// getRelativeMousePosition = "_-1wW" (String#1785, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// isWindowOperationPrevented = "_-27I" (String#19304, DoABC#2)
// setRectangle = "_-Vb" (String#23476, DoABC#2)
// _SafeStr_9133 = "_-2xy" (String#21391, DoABC#2)
// _SafeStr_9161 = "_-2-n" (String#19004, DoABC#2)
// _background = "_-35x" (String#21726, DoABC#2)
// _background = "_-zD" (String#24660, DoABC#2)
// _SafeStr_9165 = "_-2Yy" (String#20394, DoABC#2)
// _graphicContext = "_-1or" (String#18492, DoABC#2)
// WE_ACTIVATE = "_-3Ek" (String#22065, DoABC#2)
// _SafeStr_9170 = "_-2FR" (String#19621, DoABC#2)
// setupGraphicsContext = "_-0r-" (String#16084, DoABC#2)
// testParamFlag = "_-1ml" (String#5794, DoABC#2)
// WE_CHILD_ACTIVATED = "_-f-" (String#23845, DoABC#2)
// WE_PARENT_ACTIVATED = "_-1o3" (String#18465, DoABC#2)
// _procedure = "_-1SV" (String#17600, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)
// WE_ENABLED = "_-2J1" (String#19767, DoABC#2)
// WE_DISABLED = "_-xm" (String#24603, DoABC#2)
// related = "_-2Pu" (String#20039, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)
// _COLORIZE = "_-EQ" (String#22789, DoABC#2)
// testStateFlag = "_-35A" (String#7410, DoABC#2)
// WE_ACTIVATED = "_-0ud" (String#16226, DoABC#2)
// setGlobalRectangle = "_-1XU" (String#5508, DoABC#2)
// getDrawRegion = "_-0xH" (String#1582, DoABC#2)
// fetchDrawBuffer = "_-0oc" (String#1553, DoABC#2)
// WE_CHILD_REMOVED = "_-r3" (String#24318, DoABC#2)
// WE_CHILD_RELOCATED = "_-30I" (String#21512, DoABC#2)
// _SafeStr_9318 = "_-2PC" (String#20010, DoABC#2)
// _SafeStr_9319 = "_-1jm" (String#18275, DoABC#2)
// cloneChildWindows = "_-1ic" (String#5724, DoABC#2)
// getChildByID = "_-y3" (String#2226, DoABC#2)
// getChildByTag = "_-tP" (String#2212, DoABC#2)
// groupChildrenWithID = "_-2KM" (String#1856, DoABC#2)
// WE_RESIZE = "_-2Gi" (String#19669, DoABC#2)
// WME_WHEEL = "_-1Ot" (String#17464, DoABC#2)
// _SafeStr_9362 = "_-199" (String#16823, DoABC#2)
// nullEventProc = "_-s6" (String#8737, DoABC#2)
// findParentByName = "_-0iw" (String#4478, DoABC#2)
// limits = "_-2BM" (String#6274, DoABC#2)
// _SafeStr_9399 = "_-1WJ" (String#17754, DoABC#2)
// WE_DESTROYED = "_-2PT" (String#20021, DoABC#2)
// WE_CHILD_ADDED = "_-32L" (String#21593, DoABC#2)
// groupParameterFilteredChildrenUnderPoint = "_-ZD" (String#8399, DoABC#2)
// notifyEventListeners = "_-03d" (String#14188, DoABC#2)
// _SafeStr_9479 = "_-H4" (String#22893, DoABC#2)
// _SafeStr_9480 = "_-2cN" (String#20539, DoABC#2)
// _SafeStr_9483 = "_-1ot" (String#18494, DoABC#2)
// _SafeStr_9506 = "_-dY" (String#23783, DoABC#2)
// _SafeStr_9507 = "_-2gX" (String#20712, DoABC#2)
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
// preventDefault = "_-0ee" (String#15611, DoABC#2)
// _SafeStr_9574 = "_-2pO" (String#21053, DoABC#2)
// hasGraphicsContext = "_-2yM" (String#7247, DoABC#2)
// getAbsoluteMousePosition = "_-313" (String#1987, DoABC#2)
// numChildContexts = "_-1cY" (String#5611, DoABC#2)
// addChildContext = "_-1ax" (String#5575, DoABC#2)
// addChildContextAt = "_-2dP" (String#6819, DoABC#2)
// removeChildContext = "_-28x" (String#6224, DoABC#2)
// setChildContextIndex = "_-je" (String#8591, DoABC#2)
// swapChildContexts = "_-0Zm" (String#4292, DoABC#2)
// swapChildContextsAt = "_-2yp" (String#7257, DoABC#2)
// _SafeStr_9614 = "_-u3" (String#24452, DoABC#2)
// _SafeStr_9615 = "_-2xY" (String#21375, DoABC#2)
// _SafeStr_9616 = "_-1DN" (String#5132, DoABC#2)
// childRectToClippedDrawRegion = "_-1gm" (String#18166, DoABC#2)
// eventTypes = "_-iE" (String#8559, DoABC#2)
// areaLimit = "_-1I0" (String#5207, DoABC#2)
// hasRectLimits = "_-2Rg" (String#20108, DoABC#2)
// convertPointFromGlobalToLocalSpace = "_-0Vq" (String#4224, DoABC#2)
// hitTestLocalPoint = "_-E9" (String#7955, DoABC#2)
// validateLocalPointIntersection = "_-1vM" (String#18771, DoABC#2)
// getWindowFactory = "_-0-h" (String#14041, DoABC#2)
// _SafeStr_9800 = "_-2AJ" (String#19417, DoABC#2)
// _SafeStr_9801 = "_-QG" (String#23260, DoABC#2)
// _SafeStr_9802 = "_-1OR" (String#17450, DoABC#2)
// _SafeStr_9803 = "_-0bN" (String#15491, DoABC#2)
// _mouseThreshold = "_-95" (String#22584, DoABC#2)
// _clipping = "_-38F" (String#21812, DoABC#2)
// getLayoutByTypeAndStyle = "_-9S" (String#7853, DoABC#2)
// getDefaultsByTypeAndStyle = "_-2ch" (String#6806, DoABC#2)
// resolve = "_-0fS" (String#4413, DoABC#2)
// getLocalPosition = "_-35W" (String#7418, DoABC#2)
// getLocalRectangle = "_-2j" (String#6932, DoABC#2)
// hitTestLocalRectangle = "_-1sE" (String#5889, DoABC#2)
// setGlobalPosition = "_-0OJ" (String#4052, DoABC#2)
// hitTestGlobalRectangle = "_-Bj" (String#7906, DoABC#2)
// resolveVerticalScale = "_-02I" (String#3611, DoABC#2)
// resolveHorizontalScale = "_-2pw" (String#7076, DoABC#2)
// convertPointFromLocalToGlobalSpace = "_-21w" (String#6085, DoABC#2)
// setStyleFlag = "_-2Dz" (String#6320, DoABC#2)
// getStyleFlag = "_-2x8" (String#7224, DoABC#2)
// maximize = "_-18B" (String#5040, DoABC#2)
// restore = "_-18X" (String#5049, DoABC#2)
// getChildUnderPoint = "_-2TR" (String#6633, DoABC#2)
// _SafeStr_9833 = "_-nZ" (String#24174, DoABC#2)
// _IGNORE_INHERITED_STYLE = "_-UP" (String#23427, DoABC#2)
// _SafeStr_9835 = "_-29J" (String#19377, DoABC#2)
// _limits = "_-1ft" (String#18133, DoABC#2)
// _SafeStr_9837 = "_-UD" (String#23416, DoABC#2)
// _SafeStr_9838 = "_-2Dh" (String#19554, DoABC#2)
// _SafeStr_9839 = "_-0sU" (String#16142, DoABC#2)
// expandToAccommodateChild = "_-2qO" (String#21097, DoABC#2)
// releaseGraphicsContext = "_-3Gk" (String#22153, DoABC#2)
// isChildWindow = "_-1Yi" (String#17837, DoABC#2)
// getRegionProperties = "_-1Wc" (String#17763, DoABC#2)
// setRegionProperties = "_-1Ld" (String#17341, DoABC#2)
// notifyChildren = "_-1sC" (String#18640, DoABC#2)
// updateScaleRelativeToParent = "_-1RJ" (String#17558, DoABC#2)
// scaleToAccommodateChildren = "_-0kG" (String#15841, DoABC#2)
// testLocalPointHitAgainstAlpha = "_-Ah" (String#22644, DoABC#2)
// validateGlobalPointIntersection = "_-23c" (String#19159, DoABC#2)
// isCapableOfUsingSharedGraphicContext = "_-1vG" (String#18767, DoABC#2)
// requiresOwnGraphicContext = "_-1XF" (String#17786, DoABC#2)


