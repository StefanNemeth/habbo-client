
package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.IWindowContainer;

    public class ScrollbarController extends InteractiveController implements IScrollbarWindow, ITouchAwareWindow 
    {

        private static const _SafeStr_9372:String = "increment";
        private static const _SafeStr_9373:String = "decrement";
        private static const _SafeStr_9374:String = "slider_track";
        private static const _SafeStr_9375:String = "slider_bar";

        protected var _offset:Number = 0;
        protected var _SafeStr_9376:Number = 0.1;
        protected var _scrollable:IScrollableWindow;
        private var _horizontal:Boolean;
        private var _SafeStr_9378:String;
        private var _SafeStr_9379:Boolean = false;

        public function ScrollbarController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0, _arg_12:IScrollableWindow=null)
        {
            var _local_14:IWindow;
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_9161 = false;
            this._scrollable = _arg_12;
            this._horizontal = (_arg_2 == WindowType._SafeStr_7526);
            var _local_13:Array = new Array();
            groupChildrenWithTag(TAG_INTERNAL, _local_13, true);
            for each (_local_14 in _local_13) {
                _local_14.procedure = this.scrollButtonEventProc;
            };
            this.updateLiftSizeAndPosition();
        }
        public function get scrollH():Number
        {
            return (((this._horizontal) ? this._offset : 0));
        }
        public function get scrollV():Number
        {
            return (((this._horizontal) ? 0 : this._offset));
        }
        public function get scrollable():IScrollableWindow
        {
            return (this._scrollable);
        }
        public function set scrollH(_arg_1:Number):void
        {
            if (this._horizontal){
                if (this.setScrollPosition(_arg_1)){
                    this.updateLiftSizeAndPosition();
                };
            };
        }
        public function set scrollV(_arg_1:Number):void
        {
            if (!this._horizontal){
                if (this.setScrollPosition(_arg_1)){
                    this.updateLiftSizeAndPosition();
                };
            };
        }
        public function set scrollable(_arg_1:IScrollableWindow):void
        {
            if (((!((this._scrollable == null))) && (!(this._scrollable.disposed)))){
                this._scrollable.removeEventListener(WindowEvent.WE_RESIZED, this.onScrollableResized);
                this._scrollable.removeEventListener(WindowEvent.WE_SCROLL, this.onScrollableScrolled);
            };
            this._scrollable = _arg_1;
            if (((!((this._scrollable == null))) && (!(this._scrollable.disposed)))){
                this._scrollable.addEventListener(WindowEvent.WE_RESIZED, this.onScrollableResized);
                this._scrollable.addEventListener(WindowEvent.WE_SCROLL, this.onScrollableScrolled);
                this.updateLiftSizeAndPosition();
            };
        }
        public function get horizontal():Boolean
        {
            return (this._horizontal);
        }
        public function get vertical():Boolean
        {
            return (!(this._horizontal));
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            var _local_2:String = "";
            if ((this._scrollable is IWindow)){
                _local_2 = IWindow(this._scrollable).name;
            }
            else {
                if (this._SafeStr_9378 != null){
                    _local_2 = this._SafeStr_9378;
                };
            };
            _local_1.push(new PropertyStruct("scrollable", _local_2, "String", !((_local_2 == ""))));
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_3:PropertyStruct;
            var _local_2:int = _arg_1.length;
            var _local_4:int;
            while (_local_4 < _local_2) {
                _local_3 = (_arg_1[_local_4] as PropertyStruct);
                if (_local_3.key == "scrollable"){
                    this._SafeStr_9378 = (_local_3.value as String);
                    this._scrollable = null;
                };
                _local_4++;
            };
            super.properties = _arg_1;
        }
        protected function get track():WindowController
        {
            return ((findChildByName(_SafeStr_9374) as WindowController));
        }
        protected function get lift():WindowController
        {
            return ((this.track.findChildByName(_SafeStr_9375) as WindowController));
        }
        override public function dispose():void
        {
            this.scrollable = null;
            super.dispose();
        }
        override public function enable():Boolean
        {
            var _local_1:Array;
            var _local_2:uint;
            if (super.enable()){
                _local_1 = new Array();
                groupChildrenWithTag(TAG_INTERNAL, _local_1, true);
                _local_2 = 0;
                while (_local_2 < _local_1.length) {
                    IWindow(_local_1[_local_2]).enable();
                    _local_2++;
                };
                return (true);
            };
            return (false);
        }
        override public function disable():Boolean
        {
            var _local_1:Array;
            var _local_2:uint;
            if (super.disable()){
                _local_1 = new Array();
                groupChildrenWithTag(TAG_INTERNAL, _local_1, true);
                _local_2 = 0;
                while (_local_2 < _local_1.length) {
                    IWindow(_local_1[_local_2]).disable();
                    _local_2++;
                };
                return (true);
            };
            return (false);
        }
        protected function setScrollPosition(_arg_1:Number):Boolean
        {
            var _local_2:Boolean;
            if ((((this._scrollable == null)) || (this._scrollable.disposed))){
                if (!this.resolveScrollTarget()){
                    return (false);
                };
            };
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_1 > 1){
                _arg_1 = 1;
            };
            this._offset = _arg_1;
            if (this._horizontal){
                _local_2 = !((this._scrollable.scrollH == this._offset));
                if (_local_2){
                    this._scrollable.scrollH = this._offset;
                };
            }
            else {
                _local_2 = !((this._scrollable.scrollV == this._offset));
                if (_local_2){
                    this._scrollable.scrollV = this._offset;
                };
            };
            return (_local_2);
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            switch (_arg_1.name){
                case ScrollbarController._SafeStr_9375:
                    if (_arg_2.type == WindowEvent.WE_CHILD_RELOCATED){
                        if (!this._SafeStr_9379){
                            if (this._horizontal){
                                this.setScrollPosition(ScrollbarLiftController(_arg_1).offsetX);
                            }
                            else {
                                this.setScrollPosition(ScrollbarLiftController(_arg_1).offsetY);
                            };
                        };
                    };
                    break;
            };
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            if (_arg_2.type == WindowEvent.WE_PARENT_ADDED){
                if (this._scrollable == null){
                    this.resolveScrollTarget();
                };
            };
            if (_arg_1 == this){
                if (_arg_2.type == WindowEvent.WE_RESIZED){
                    this.updateLiftSizeAndPosition();
                }
                else {
                    if (_arg_2.type == WindowMouseEvent.WME_WHEEL){
                        if (WindowMouseEvent(_arg_2).delta > 0){
                            if (this._horizontal){
                                this.scrollH = (this.scrollH - this._SafeStr_9376);
                            }
                            else {
                                this.scrollV = (this.scrollV - this._SafeStr_9376);
                            };
                        }
                        else {
                            if (this._horizontal){
                                this.scrollH = (this.scrollH + this._SafeStr_9376);
                            }
                            else {
                                this.scrollV = (this.scrollV + this._SafeStr_9376);
                            };
                        };
                        _local_3 = true;
                    };
                };
            };
            return (_local_3);
        }
        private function updateLiftSizeAndPosition():void
        {
            var _local_1:Number;
            var _local_4:int;
            if ((((this._scrollable == null)) || (this._scrollable.disposed))){
                if (((_disposed) || (!(this.resolveScrollTarget())))){
                    return;
                };
            };
            var _local_2:WindowController = this.track;
            var _local_3:WindowController = this.lift;
            if (_local_3 != null){
                if (this._horizontal){
                    _local_1 = (this._scrollable.visibleRegion.width / this._scrollable.scrollableRegion.width);
                    if (_local_1 > 1){
                        _local_1 = 1;
                    };
                    _local_4 = (_local_1 * _local_2.width);
                    _local_3.width = _local_4;
                    _local_3.x = (this._scrollable.scrollH * (_local_2.width - _local_4));
                }
                else {
                    _local_1 = (this._scrollable.visibleRegion.height / this._scrollable.scrollableRegion.height);
                    if (_local_1 > 1){
                        _local_1 = 1;
                    };
                    _local_4 = (_local_1 * _local_2.height);
                    _local_3.height = _local_4;
                    _local_3.y = (this._scrollable.scrollV * (_local_2.height - _local_3.height));
                };
            };
            if (_local_1 == 1){
                this.disable();
            }
            else {
                this.enable();
            };
        }
        private function nullEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }
        private function scrollButtonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Rectangle;
            var _local_3:Boolean;
            if ((((_arg_1.type == WindowMouseEvent.WME_DOWN)) || ((_arg_1.type == WindowTouchEvent.WTE_TAP)))){
                if (_arg_2.name == _SafeStr_9372){
                    if (this._scrollable){
                        this._SafeStr_9379 = true;
                        if (this._horizontal){
                            this.scrollH = (this.scrollH + (this._scrollable.scrollStepH / this._scrollable.maxScrollH));
                        }
                        else {
                            this.scrollV = (this.scrollV + (this._scrollable.scrollStepV / this._scrollable.maxScrollV));
                        };
                        this._SafeStr_9379 = false;
                    };
                }
                else {
                    if (_arg_2.name == _SafeStr_9373){
                        if (this._scrollable){
                            this._SafeStr_9379 = true;
                            if (this._horizontal){
                                this.scrollH = (this.scrollH - (this._scrollable.scrollStepH / this._scrollable.maxScrollH));
                            }
                            else {
                                this.scrollV = (this.scrollV - (this._scrollable.scrollStepV / this._scrollable.maxScrollV));
                            };
                            this._SafeStr_9379 = false;
                        };
                    }
                    else {
                        if (_arg_2.name == _SafeStr_9374){
                            if ((_arg_1 is WindowMouseEvent)){
                                _local_4 = WindowMouseEvent(_arg_1).localX;
                                _local_5 = WindowMouseEvent(_arg_1).localY;
                            }
                            else {
                                if ((_arg_1 is WindowTouchEvent)){
                                    _local_4 = WindowTouchEvent(_arg_1).localX;
                                    _local_5 = WindowTouchEvent(_arg_1).localY;
                                };
                            };
                            _local_6 = WindowController(_arg_2).getChildByName(ScrollbarController._SafeStr_9375).rectangle;
                            if (this._horizontal){
                                if (_local_4 < _local_6.x){
                                    this.scrollH = (this.scrollH - ((this._scrollable.visibleRegion.width - this._scrollable.scrollStepH) / this._scrollable.maxScrollH));
                                }
                                else {
                                    if (_local_4 > _local_6.right){
                                        this.scrollH = (this.scrollH + ((this._scrollable.visibleRegion.width - this._scrollable.scrollStepH) / this._scrollable.maxScrollH));
                                    };
                                };
                            }
                            else {
                                if (_local_5 < _local_6.y){
                                    this.scrollV = (this.scrollV - ((this._scrollable.visibleRegion.height - this._scrollable.scrollStepV) / this._scrollable.maxScrollV));
                                }
                                else {
                                    if (_local_5 > _local_6.bottom){
                                        this.scrollV = (this.scrollV + ((this._scrollable.visibleRegion.height - this._scrollable.scrollStepV) / this._scrollable.maxScrollV));
                                    };
                                };
                            };
                            _local_3 = true;
                        };
                    };
                };
            };
            if (_arg_1.type == WindowMouseEvent.WME_WHEEL){
                if (WindowMouseEvent(_arg_1).delta > 0){
                    if (this._horizontal){
                        this.scrollH = (this.scrollH - this._SafeStr_9376);
                    }
                    else {
                        this.scrollV = (this.scrollV - this._SafeStr_9376);
                    };
                }
                else {
                    if (this._horizontal){
                        this.scrollH = (this.scrollH + this._SafeStr_9376);
                    }
                    else {
                        this.scrollV = (this.scrollV + this._SafeStr_9376);
                    };
                };
                _local_3 = true;
            };
            if (_local_3){
                this.updateLiftSizeAndPosition();
            };
        }
        private function resolveScrollTarget():Boolean
        {
            var _local_1:IScrollableWindow;
            var _local_2:uint;
            var _local_3:IScrollableWindow;
            var _local_4:uint;
            if (this._scrollable != null){
                if (!this._scrollable.disposed){
                    return (true);
                };
            };
            if (this._SafeStr_9378 != null){
                _local_1 = (findParentByName(this._SafeStr_9378) as IScrollableWindow);
                if ((((_local_1 == null)) && ((_parent is IWindowContainer)))){
                    _local_1 = (IWindowContainer(_parent).findChildByName(this._SafeStr_9378) as IScrollableWindow);
                    if (_local_1){
                        this.scrollable = _local_1;
                        return (true);
                    };
                };
            };
            if ((_parent is IScrollableWindow)){
                this.scrollable = IScrollableWindow(_parent);
                return (true);
            };
            if ((((_parent is IWindowContainer)) && (!((_parent is IDesktopWindow))))){
                _local_2 = IWindowContainer(_parent).numChildren;
                _local_4 = 0;
                while (_local_4 < _local_2) {
                    _local_3 = (IWindowContainer(_parent).getChildAt(_local_4) as IScrollableWindow);
                    if (_local_3){
                        this.scrollable = _local_3;
                        return (true);
                    };
                    _local_4++;
                };
            };
            return (false);
        }
        private function onScrollableResized(_arg_1:WindowEvent):void
        {
            this.updateLiftSizeAndPosition();
            this.setScrollPosition(this._offset);
        }
        private function onScrollableScrolled(_arg_1:WindowEvent):void
        {
            this.updateLiftSizeAndPosition();
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// ITouchAwareWindow = "_-QS" (String#8212, DoABC#2)
// ScrollbarController = "_-1Mk" (String#5287, DoABC#2)
// ScrollbarLiftController = "_-1WE" (String#5477, DoABC#2)
// WindowTouchEvent = "_-0lW" (String#4536, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WE_PARENT_ADDED = "_-0D7" (String#14572, DoABC#2)
// _SafeStr_7526 = "_-17o" (String#16766, DoABC#2)
// scrollStepH = "_-1Qu" (String#5371, DoABC#2)
// scrollStepV = "_-2Ee" (String#6333, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)
// _SafeStr_9161 = "_-2-n" (String#19004, DoABC#2)
// WTE_TAP = "_-2Ox" (String#19999, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)
// WE_CHILD_RELOCATED = "_-30I" (String#21512, DoABC#2)
// WE_SCROLL = "_-DZ" (String#22752, DoABC#2)
// WME_WHEEL = "_-1Ot" (String#17464, DoABC#2)
// _SafeStr_9372 = "_-5q" (String#22457, DoABC#2)
// _SafeStr_9373 = "_-he" (String#23953, DoABC#2)
// _SafeStr_9374 = "_-0mM" (String#15910, DoABC#2)
// _SafeStr_9375 = "_-GH" (String#22863, DoABC#2)
// _SafeStr_9376 = "_-2MX" (String#19908, DoABC#2)
// _scrollable = "_-3Jv" (String#22281, DoABC#2)
// _SafeStr_9378 = "_-0gU" (String#15692, DoABC#2)
// _SafeStr_9379 = "_-bJ" (String#23683, DoABC#2)
// scrollButtonEventProc = "_-2mB" (String#20925, DoABC#2)
// updateLiftSizeAndPosition = "_-q8" (String#24278, DoABC#2)
// setScrollPosition = "_-2BK" (String#19457, DoABC#2)
// onScrollableResized = "_-2ll" (String#20909, DoABC#2)
// onScrollableScrolled = "_-17a" (String#16758, DoABC#2)
// track = "_-0H4" (String#3897, DoABC#2)
// lift = "_-wy" (String#24568, DoABC#2)
// resolveScrollTarget = "_-Co" (String#22718, DoABC#2)
// nullEventProc = "_-s6" (String#8737, DoABC#2)
// findParentByName = "_-0iw" (String#4478, DoABC#2)


