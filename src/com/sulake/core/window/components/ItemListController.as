
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IInputProcessorRoot;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.enum.WindowStyle;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.utils.PropertyStruct;

    public class ItemListController extends WindowController implements IItemListWindow, IInputProcessorRoot 
    {

        protected var _scrollH:Number;
        protected var _scrollV:Number;
        protected var _SafeStr_9296:Number;
        protected var _SafeStr_9297:Number;
        protected var _container:IWindowContainer;
        protected var _SafeStr_9298:Boolean = false;
        protected var _SafeStr_9299:Boolean = false;
        protected var _spacing:int = 0;
        protected var _horizontal:Boolean = false;
        protected var _scrollStepH:Number = -1;
        protected var _scrollStepV:Number = -1;
        protected var _autoArrangeItems:Boolean = true;
        protected var _scaleToFitItems:Boolean = false;
        protected var _resizeOnItemUpdate:Boolean = false;
        protected var _SafeStr_9305:int = 0;
        protected var _SafeStr_9306:int = 0;
        protected var _SafeStr_9307:Number;
        protected var _SafeStr_9308:Number;
        protected var _SafeStr_9309:Boolean = false;

        public function ItemListController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            this._scrollH = 0;
            this._scrollV = 0;
            this._SafeStr_9296 = 0;
            this._SafeStr_9297 = 0;
            this._horizontal = (_arg_2 == WindowType._SafeStr_7518);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_9161 = ((_background) || (!(IWindow(WindowParam._SafeStr_7443))));
            this._container = (_context.create("_CONTAINER", "", WindowType._SafeStr_7544, WindowStyle._SafeStr_9310, ((WindowParam._SafeStr_7443 | WindowParam._SafeStr_7466) | WindowParam._SafeStr_7433), new Rectangle(0, 0, width, height), null, this, 0, null, [TAG_INTERNAL, TAG_EXCLUDE]) as IWindowContainer);
            this._container.addEventListener(WindowEvent.WE_RESIZED, this.ItemListController);
            this._container.addEventListener(WindowEvent.WE_CHILD_REMOVED, this.ItemListController);
            this._container.addEventListener(WindowEvent.WE_CHILD_RESIZED, this.ItemListController);
            this._container.addEventListener(WindowEvent.WE_CHILD_RELOCATED, this.ItemListController);
            this._container.clipping = clipping;
            this.resizeOnItemUpdate = this._resizeOnItemUpdate;
        }
        public function get spacing():int
        {
            return (this._spacing);
        }
        public function set spacing(_arg_1:int):void
        {
            if (_arg_1 != this._spacing){
                this._spacing = _arg_1;
                this.ItemListController();
            };
        }
        public function get scrollH():Number
        {
            return (this._scrollH);
        }
        public function get scrollV():Number
        {
            return (this._scrollV);
        }
        public function get maxScrollH():int
        {
            return (Math.max(0, (this._SafeStr_9296 - width)));
        }
        public function get maxScrollV():int
        {
            return (Math.max(0, (this._SafeStr_9297 - height)));
        }
        public function get visibleRegion():Rectangle
        {
            return (new Rectangle((this._scrollH * this.maxScrollH), (this._scrollV * this.maxScrollV), width, height));
        }
        public function get scrollableRegion():Rectangle
        {
            return (this._container.rectangle.clone());
        }
        public function set scrollH(_arg_1:Number):void
        {
            var _local_2:WindowEvent;
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_1 > 1){
                _arg_1 = 1;
            };
            if (_arg_1 != this._scrollH){
                this._scrollH = _arg_1;
                this._container.x = (-(this._scrollH) * this.maxScrollH);
                _context.invalidate(this._container, this.visibleRegion, WindowRedrawFlag._SafeStr_9133);
                if (_events){
                    _local_2 = WindowEvent.allocate(WindowEvent.WE_SCROLL, this, null);
                    _events.dispatchEvent(_local_2);
                    _local_2.recycle();
                };
            };
        }
        public function set scrollV(_arg_1:Number):void
        {
            var _local_2:WindowEvent;
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_1 > 1){
                _arg_1 = 1;
            };
            if (_arg_1 != this._scrollV){
                this._scrollV = _arg_1;
                this._container.y = (-(this._scrollV) * this.maxScrollV);
                if (_events){
                    _local_2 = WindowEvent.allocate(WindowEvent.WE_SCROLL, this, null);
                    _events.dispatchEvent(_local_2);
                    _local_2.recycle();
                };
            };
        }
        public function get scrollStepH():Number
        {
            if (this._scrollStepH >= 0){
                return (this._scrollStepH);
            };
            return (((this._horizontal) ? (this._container.width / this.numListItems) : (0.1 * this._container.width)));
        }
        public function get scrollStepV():Number
        {
            if (this._scrollStepV >= 0){
                return (this._scrollStepV);
            };
            return (((this._horizontal) ? (0.1 * this._container.height) : (this._container.height / this.numListItems)));
        }
        public function set scrollStepH(_arg_1:Number):void
        {
            this._scrollStepH = _arg_1;
        }
        public function set scrollStepV(_arg_1:Number):void
        {
            this._scrollStepV = _arg_1;
        }
        public function set scaleToFitItems(_arg_1:Boolean):void
        {
            if (this._scaleToFitItems != _arg_1){
                this._scaleToFitItems = _arg_1;
                this.ItemListController();
            };
        }
        public function get scaleToFitItems():Boolean
        {
            return (this._scaleToFitItems);
        }
        public function set autoArrangeItems(_arg_1:Boolean):void
        {
            this._autoArrangeItems = _arg_1;
            this.ItemListController();
        }
        public function get autoArrangeItems():Boolean
        {
            return (this._autoArrangeItems);
        }
        public function set resizeOnItemUpdate(_arg_1:Boolean):void
        {
            this._resizeOnItemUpdate = _arg_1;
            if (this._container){
                if (this._horizontal){
                    this._container.setParamFlag(WindowParam._SafeStr_9318, _arg_1);
                }
                else {
                    this._container.setParamFlag(WindowParam._SafeStr_9319, _arg_1);
                };
            };
        }
        public function get resizeOnItemUpdate():Boolean
        {
            return (this._resizeOnItemUpdate);
        }
        public function get iterator():IIterator
        {
            return (new Iterator(this));
        }
        public function get firstListItem():IWindow
        {
            return ((((this.numListItems)>0) ? this.getListItemAt(0) : null));
        }
        public function get lastListItem():IWindow
        {
            return ((((this.numListItems)>0) ? this.getListItemAt((this.numListItems - 1)) : null));
        }
        override public function set clipping(_arg_1:Boolean):void
        {
            super.clipping = _arg_1;
            if (this._container){
                this._container.clipping = _arg_1;
            };
        }
        override public function dispose():void
        {
            if (!_disposed){
                if (this._SafeStr_9309){
                    try {
                        _context.getWindowServices().getGestureAgentService().end(this);
                    }
                    catch(e:Error) {
                    };
                };
                this._container.removeEventListener(WindowEvent.WE_RESIZED, this.ItemListController);
                this._container.removeEventListener(WindowEvent.WE_CHILD_REMOVED, this.ItemListController);
                this._container.removeEventListener(WindowEvent.WE_CHILD_RESIZED, this.ItemListController);
                this._container.removeEventListener(WindowEvent.WE_CHILD_RELOCATED, this.ItemListController);
                super.dispose();
            };
        }
        override protected function WindowController(_arg_1:WindowController):void
        {
            var _local_2:int;
            while (_local_2 < this.numListItems) {
                IItemListWindow(_arg_1).addListItem(this.getListItemAt(_local_2).clone());
                _local_2++;
            };
        }
        public function get numListItems():int
        {
            return ((((this._container)!=null) ? this._container.numChildren : 0));
        }
        public function addListItem(_arg_1:IWindow):IWindow
        {
            this._SafeStr_9299 = true;
            if (this._horizontal){
                _arg_1.x = (this._SafeStr_9296 + (((this.numListItems)>0) ? this._spacing : 0));
                this._SafeStr_9296 = _arg_1.rectangle.right;
                this._container.width = this._SafeStr_9296;
            }
            else {
                if (this.autoArrangeItems){
                    _arg_1.y = (this._SafeStr_9297 + (((this.numListItems)>0) ? this._spacing : 0));
                    this._SafeStr_9297 = _arg_1.rectangle.bottom;
                }
                else {
                    this._SafeStr_9297 = Math.max(this._SafeStr_9297, _arg_1.rectangle.bottom);
                };
                this._container.height = this._SafeStr_9297;
            };
            _arg_1 = this._container.addChild(_arg_1);
            this._SafeStr_9299 = false;
            return (_arg_1);
        }
        public function IItemListWindow(_arg_1:IWindow, _arg_2:uint):IWindow
        {
            _arg_1 = this._container.addChildAt(_arg_1, _arg_2);
            this.ItemListController();
            return (_arg_1);
        }
        public function getListItemAt(_arg_1:uint):IWindow
        {
            return (this._container.getChildAt(_arg_1));
        }
        public function IItemListWindow(_arg_1:uint):IWindow
        {
            return (this._container.WindowController(_arg_1));
        }
        public function getListItemByName(_arg_1:String):IWindow
        {
            return (this._container.getChildByName(_arg_1));
        }
        public function IItemListWindow(_arg_1:String):IWindow
        {
            return (this._container.WindowController(_arg_1));
        }
        public function IItemListWindow(_arg_1:IWindow):int
        {
            return (this._container.getChildIndex(_arg_1));
        }
        public function removeListItem(_arg_1:IWindow):IWindow
        {
            _arg_1 = this._container.removeChild(_arg_1);
            if (_arg_1){
                this.ItemListController();
            };
            return (_arg_1);
        }
        public function IItemListWindow(_arg_1:int):IWindow
        {
            return (this._container.removeChildAt(_arg_1));
        }
        public function IItemListWindow(_arg_1:IWindow, _arg_2:int):void
        {
            this._container.setChildIndex(_arg_1, _arg_2);
        }
        public function IItemListWindow(_arg_1:IWindow, _arg_2:IWindow):void
        {
            this._container.swapChildren(_arg_1, _arg_2);
            this.ItemListController();
        }
        public function IItemListWindow(_arg_1:int, _arg_2:int):void
        {
            this._container.swapChildrenAt(_arg_1, _arg_2);
            this.ItemListController();
        }
        public function IItemListWindow(_arg_1:uint, _arg_2:Array, _arg_3:Boolean=false):uint
        {
            return (this._container.WindowController(_arg_1, _arg_2, _arg_3));
        }
        public function IItemListWindow(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):uint
        {
            return (this._container.WindowController(_arg_1, _arg_2, _arg_3));
        }
        public function IItemListWindow():void
        {
            this._SafeStr_9299 = true;
            while (this.numListItems > 0) {
                this._container.removeChildAt(0);
            };
            this._SafeStr_9299 = false;
            this.ItemListController();
        }
        public function IItemListWindow():void
        {
            this._SafeStr_9299 = true;
            while (this.numListItems > 0) {
                this._container.removeChildAt(0).destroy();
            };
            this._SafeStr_9299 = false;
            this.ItemListController();
        }
        public function IItemListWindow():void
        {
            this.ItemListController();
        }
        override public function populate(_arg_1:Array):void
        {
            WindowController(this._container).populate(_arg_1);
            this.ItemListController();
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            switch (_arg_2.type){
                case WindowEvent.WE_RESIZE:
                    this._SafeStr_9298 = true;
                    break;
                case WindowEvent.WE_RESIZED:
                    if (!this._scaleToFitItems){
                        if (this._horizontal){
                            this._container.height = _rectangle.height;
                        }
                        else {
                            this._container.width = _rectangle.width;
                        };
                    };
                    this.ItemListController();
                    this._SafeStr_9298 = false;
                    break;
                default:
                    if ((_arg_2 is WindowEvent)){
                        _local_3 = this.MouseEventProcessor((_arg_2 as WindowEvent));
                    };
            };
            return (_local_3);
        }
        public function MouseEventProcessor(_arg_1:WindowEvent):Boolean
        {
            var _local_2:Boolean;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if ((_arg_1 is WindowMouseEvent)){
                _local_3 = WindowMouseEvent(_arg_1).localX;
                _local_4 = WindowMouseEvent(_arg_1).localY;
                _local_5 = WindowMouseEvent(_arg_1).delta;
            };
            switch (_arg_1.type){
                case WindowMouseEvent.WME_WHEEL:
                    if (this._horizontal){
                        this.scrollH = (this.scrollH - (_local_5 * 0.01));
                    }
                    else {
                        this.scrollV = (this.scrollV - (_local_5 * 0.01));
                    };
                    _local_2 = true;
                    break;
                case WindowMouseEvent.WME_DOWN:
                    this._SafeStr_9305 = _local_3;
                    this._SafeStr_9306 = _local_4;
                    this._SafeStr_9307 = 0;
                    this._SafeStr_9308 = 0;
                    this._SafeStr_9309 = true;
                    _local_2 = true;
                    break;
                case WindowMouseEvent.WME_MOVE:
                    if (this._SafeStr_9309){
                        this._SafeStr_9307 = (this._SafeStr_9305 - _local_3);
                        this._SafeStr_9308 = (this._SafeStr_9306 - _local_4);
                        if (this._horizontal){
                            if (((!((this._SafeStr_9307 == 0))) && (!((this._SafeStr_9296 == 0))))){
                                this.scrollH = (this.scrollH + (this._SafeStr_9307 / this._SafeStr_9296));
                            };
                        }
                        else {
                            if (((!((this._SafeStr_9308 == 0))) && (!((this._SafeStr_9297 == 0))))){
                                this.scrollV = (this.scrollV + (this._SafeStr_9308 / this._SafeStr_9297));
                            };
                        };
                        this._SafeStr_9305 = _local_3;
                        this._SafeStr_9306 = _local_4;
                        _local_2 = true;
                    };
                    break;
                case WindowMouseEvent.WME_UP:
                case WindowMouseEvent.WME_UP_OUTSIDE:
                    if (this._SafeStr_9309){
                        if (this._horizontal){
                            _context.getWindowServices().getGestureAgentService().begin(this, this.ItemListController, 0, -(this._SafeStr_9307), 0);
                        }
                        else {
                            _context.getWindowServices().getGestureAgentService().begin(this, this.ItemListController, 0, 0, -(this._SafeStr_9308));
                        };
                        this._SafeStr_9309 = false;
                        _local_2 = true;
                    };
                    break;
            };
            return (_local_2);
        }
        private function ItemListController(_arg_1:int, _arg_2:int):void
        {
            if (!disposed){
                this.scrollH = (this.scrollH - (_arg_1 / this._SafeStr_9296));
                this.scrollV = (this.scrollV - (_arg_2 / this._SafeStr_9297));
            };
        }
        private function ItemListController(_arg_1:WindowEvent):void
        {
            var _local_2:WindowEvent;
            switch (_arg_1.type){
                case WindowEvent.WE_CHILD_REMOVED:
                    this.ItemListController();
                    return;
                case WindowEvent.WE_CHILD_RESIZED:
                    if (!this._SafeStr_9298){
                        this.ItemListController();
                    };
                    return;
                case WindowEvent.WE_CHILD_RELOCATED:
                    this.ItemListController();
                    return;
                case WindowEvent.WE_RESIZED:
                    if (_events){
                        _local_2 = WindowEvent.allocate(WindowEvent.WE_RESIZED, this, null);
                        _events.dispatchEvent(_local_2);
                        _local_2.recycle();
                    };
                    return;
                default:
                    Logger.log((("ItemListController::containerEventHandler(" + _arg_1.type) + ")"));
            };
        }
        protected function ItemListController():void
        {
            var _local_1:uint;
            var _local_2:IWindow;
            var _local_3:int;
            var _local_4:uint;
            if (((((this._autoArrangeItems) && (!(this._SafeStr_9299)))) && (this._container))){
                this._SafeStr_9299 = true;
                _local_1 = this._container.numChildren;
                if (this._horizontal){
                    this._SafeStr_9296 = 0;
                    this._SafeStr_9297 = _rectangle.height;
                    _local_4 = 0;
                    while (_local_4 < _local_1) {
                        _local_2 = this._container.getChildAt(_local_4);
                        if (_local_2.visible){
                            _local_2.x = this._SafeStr_9296;
                            this._SafeStr_9296 = (this._SafeStr_9296 + (_local_2.width + this._spacing));
                            if (this._scaleToFitItems){
                                _local_3 = (_local_2.height + _local_2.y);
                                this._SafeStr_9297 = (((_local_3)>this._SafeStr_9297) ? _local_3 : this._SafeStr_9297);
                            };
                        };
                        _local_4++;
                    };
                    if (_local_1 > 0){
                        this._SafeStr_9296 = (this._SafeStr_9296 - this._spacing);
                    };
                }
                else {
                    this._SafeStr_9296 = _rectangle.width;
                    this._SafeStr_9297 = 0;
                    _local_4 = 0;
                    while (_local_4 < _local_1) {
                        _local_2 = this._container.getChildAt(_local_4);
                        if (_local_2.visible){
                            _local_2.y = this._SafeStr_9297;
                            this._SafeStr_9297 = (this._SafeStr_9297 + (_local_2.height + this._spacing));
                            if (this._scaleToFitItems){
                                _local_3 = (_local_2.width + _local_2.x);
                                this._SafeStr_9296 = (((_local_3)>this._SafeStr_9296) ? _local_3 : this._SafeStr_9296);
                            };
                        };
                        _local_4++;
                    };
                    if (_local_1 > 0){
                        this._SafeStr_9297 = (this._SafeStr_9297 - this._spacing);
                    };
                };
                if (this._scrollH > 0){
                    if (this._SafeStr_9296 <= _rectangle.width){
                        this.scrollH = 0;
                    }
                    else {
                        this._container.x = -((this._scrollH * this.maxScrollH));
                    };
                };
                if (this._scrollV > 0){
                    if (this._SafeStr_9297 <= _rectangle.height){
                        this.scrollV = 0;
                    }
                    else {
                        this._container.y = -((this._scrollV * this.maxScrollV));
                    };
                };
                this._container.height = this._SafeStr_9297;
                this._container.width = this._SafeStr_9296;
                this._SafeStr_9299 = false;
            };
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            if (this._spacing != PropertyDefaults._SafeStr_9336){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9337, this._spacing, PropertyStruct._SafeStr_8992, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9338);
            };
            if (this._autoArrangeItems != PropertyDefaults._SafeStr_9339){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9340, this._autoArrangeItems, PropertyStruct._SafeStr_8996, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9341);
            };
            if (this._scaleToFitItems != PropertyDefaults._SafeStr_9342){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9343, this._scaleToFitItems, PropertyStruct._SafeStr_8996, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9344);
            };
            if (this._resizeOnItemUpdate != PropertyDefaults._SafeStr_9345){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9346, this._resizeOnItemUpdate, PropertyStruct._SafeStr_8996, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9347);
            };
            if (this._scrollStepH != PropertyDefaults._SafeStr_9348){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9349, this._scrollStepH, PropertyStruct._SafeStr_8994, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9350);
            };
            if (this._scrollStepV != PropertyDefaults._SafeStr_9351){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9352, this._scrollStepV, PropertyStruct._SafeStr_8994, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9353);
            };
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            for each (_local_2 in _arg_1) {
                switch (_local_2.key){
                    case PropertyDefaults._SafeStr_9337:
                        this.spacing = (_local_2.value as int);
                        break;
                    case PropertyDefaults._SafeStr_9343:
                        this.scaleToFitItems = (_local_2.value as Boolean);
                        break;
                    case PropertyDefaults._SafeStr_9346:
                        this.resizeOnItemUpdate = (_local_2.value as Boolean);
                        break;
                    case PropertyDefaults._SafeStr_9340:
                        this._autoArrangeItems = (_local_2.value as Boolean);
                        break;
                    case PropertyDefaults._SafeStr_9349:
                        this._scrollStepH = (_local_2.value as Number);
                        break;
                    case PropertyDefaults._SafeStr_9352:
                        this._scrollStepV = (_local_2.value as Number);
                        break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// IInputProcessorRoot = "_-0Qw" (String#4109, DoABC#2)
// ItemListController = "_-06j" (String#3696, DoABC#2)
// Iterator = "_-G2" (String#7994, DoABC#2)
// IItemListWindow = "_-2CT" (String#6293, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP_OUTSIDE = "_-2qi" (String#21110, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// IItemListWindow = "_-aG" (String#8425, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// IItemListWindow = "_-0gQ" (String#4432, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// _SafeStr_7433 = "_-222" (String#19092, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_7466 = "_-20p" (String#19045, DoABC#2)
// _SafeStr_7518 = "_-9I" (String#22590, DoABC#2)
// _SafeStr_7544 = "_-0c" (String#15512, DoABC#2)
// MouseEventProcessor = "_-3Fw" (String#2032, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// _SafeStr_8994 = "_-0yp" (String#16384, DoABC#2)
// _SafeStr_8996 = "_-0gH" (String#15685, DoABC#2)
// scrollStepH = "_-1Qu" (String#5371, DoABC#2)
// scrollStepV = "_-2Ee" (String#6333, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _SafeStr_9133 = "_-2xy" (String#21391, DoABC#2)
// _SafeStr_9161 = "_-2-n" (String#19004, DoABC#2)
// _background = "_-35x" (String#21726, DoABC#2)
// IWindow = "_-1ml" (String#5794, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)
// WindowController = "_-cU" (String#2141, DoABC#2)
// _scrollH = "_-0-H" (String#14023, DoABC#2)
// _scrollV = "_-1xk" (String#18878, DoABC#2)
// _SafeStr_9296 = "_-1TP" (String#17642, DoABC#2)
// _SafeStr_9297 = "_-Bn" (String#22679, DoABC#2)
// _SafeStr_9298 = "_-0yE" (String#16362, DoABC#2)
// _SafeStr_9299 = "_-2FT" (String#6353, DoABC#2)
// _scrollStepH = "_-1Xl" (String#17806, DoABC#2)
// _scrollStepV = "_-3BL" (String#21937, DoABC#2)
// _autoArrangeItems = "_-2lM" (String#20896, DoABC#2)
// _scaleToFitItems = "_-1LF" (String#17324, DoABC#2)
// _resizeOnItemUpdate = "_-3FF" (String#22086, DoABC#2)
// _SafeStr_9305 = "_-0ih" (String#15780, DoABC#2)
// _SafeStr_9306 = "_-1Na" (String#17420, DoABC#2)
// _SafeStr_9307 = "_-Cs" (String#22722, DoABC#2)
// _SafeStr_9308 = "_-0zw" (String#16424, DoABC#2)
// _SafeStr_9309 = "_-3Ih" (String#22226, DoABC#2)
// _SafeStr_9310 = "_-2-h" (String#19000, DoABC#2)
// ItemListController = "_-03L" (String#14176, DoABC#2)
// WE_CHILD_REMOVED = "_-r3" (String#24318, DoABC#2)
// WE_CHILD_RELOCATED = "_-30I" (String#21512, DoABC#2)
// resizeOnItemUpdate = "_-2es" (String#6849, DoABC#2)
// ItemListController = "_-2gV" (String#20710, DoABC#2)
// WE_SCROLL = "_-DZ" (String#22752, DoABC#2)
// scaleToFitItems = "_-Xo" (String#8364, DoABC#2)
// _SafeStr_9318 = "_-2PC" (String#20010, DoABC#2)
// _SafeStr_9319 = "_-1jm" (String#18275, DoABC#2)
// firstListItem = "_-1Sz" (String#17623, DoABC#2)
// lastListItem = "_-15C" (String#16662, DoABC#2)
// WindowController = "_-1ic" (String#5724, DoABC#2)
// IItemListWindow = "_-29k" (String#6245, DoABC#2)
// WindowController = "_-y3" (String#2226, DoABC#2)
// IItemListWindow = "_-Ml" (String#8136, DoABC#2)
// WindowController = "_-tP" (String#2212, DoABC#2)
// IItemListWindow = "_-2ZB" (String#6748, DoABC#2)
// IItemListWindow = "_-1We" (String#5485, DoABC#2)
// IItemListWindow = "_-2JU" (String#6429, DoABC#2)
// IItemListWindow = "_-CS" (String#7927, DoABC#2)
// WindowController = "_-2KM" (String#1856, DoABC#2)
// IItemListWindow = "_-0fG" (String#4411, DoABC#2)
// WE_RESIZE = "_-2Gi" (String#19669, DoABC#2)
// WME_WHEEL = "_-1Ot" (String#17464, DoABC#2)
// ItemListController = "_-J1" (String#22968, DoABC#2)
// _SafeStr_9336 = "_-1IE" (String#17202, DoABC#2)
// _SafeStr_9337 = "_-2tT" (String#21220, DoABC#2)
// _SafeStr_9338 = "_-9p" (String#22611, DoABC#2)
// _SafeStr_9339 = "_-2s-" (String#21158, DoABC#2)
// _SafeStr_9340 = "_-bq" (String#23707, DoABC#2)
// _SafeStr_9341 = "_-2Qj" (String#20075, DoABC#2)
// _SafeStr_9342 = "_-0S4" (String#15139, DoABC#2)
// _SafeStr_9343 = "_-gI" (String#23906, DoABC#2)
// _SafeStr_9344 = "_-22I" (String#19104, DoABC#2)
// _SafeStr_9345 = "_-1XV" (String#17795, DoABC#2)
// _SafeStr_9346 = "_-08c" (String#14391, DoABC#2)
// _SafeStr_9347 = "_-0oI" (String#15988, DoABC#2)
// _SafeStr_9348 = "_-1Zh" (String#17878, DoABC#2)
// _SafeStr_9349 = "_-0mm" (String#15929, DoABC#2)
// _SafeStr_9350 = "_-1DD" (String#16991, DoABC#2)
// _SafeStr_9351 = "_-2nS" (String#20976, DoABC#2)
// _SafeStr_9352 = "_-21U" (String#19073, DoABC#2)
// _SafeStr_9353 = "_-34r" (String#21690, DoABC#2)


