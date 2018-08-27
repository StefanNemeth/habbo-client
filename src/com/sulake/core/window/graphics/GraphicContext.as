
package com.sulake.core.window.graphics
{
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.display.Shape;
    import flash.text.TextField;
    import flash.display.Bitmap;
    import flash.text.TextFieldType;
    import flash.display.MorphShape;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.display.IBitmapDrawable;
    import flash.display.BitmapData;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;

    public class GraphicContext extends Sprite implements IGraphicContext 
    {

        public static const GC_TYPE_UNKNOWN:uint = 0;
        public static const GC_TYPE_BITMAP:uint = (1 << 0);
        public static const GC_TYPE_TEXTFIELD:uint = (1 << 1);
        public static const GC_TYPE_CONTAINER:uint = (1 << 2);
        public static const GC_TYPE_SHAPE:uint = (1 << 3);
        public static const GC_TYPE_MORPH_SHAPE:uint = (1 << 4);
        public static const _SafeStr_9590:uint = (1 << 6);
        public static const _SafeStr_9591:uint = (1 << 7);
        public static const GC_TYPE_DESKTOP:uint = (1 << 8);
        protected static var _SafeStr_4425:uint = 0;
        protected static var _SafeStr_9592:uint = 0;

        protected var _SafeStr_9593:DisplayObjectContainer;
        protected var _SafeStr_9594:Boolean;
        protected var _SafeStr_9595:Boolean;
        protected var _disposed:Boolean = false;
        protected var _rectangle:Rectangle;
        protected var _SafeStr_9596:Shape;

        public function GraphicContext(_arg_1:String, _arg_2:uint, _arg_3:Rectangle)
        {
            var _local_4:TextField;
            super();
            _SafeStr_4425++;
            if (_arg_3 == null){
                _arg_3 = new Rectangle(0, 0, 0, 0);
            };
            this.name = _arg_1;
            this.mouseEnabled = false;
            this.doubleClickEnabled = false;
            this.x = _arg_3.x;
            this.y = _arg_3.y;
            this._rectangle = _arg_3.clone();
            this._SafeStr_9594 = true;
            this._SafeStr_9595 = false;
            switch (_arg_2){
                case GraphicContext.GC_TYPE_BITMAP:
                    this._SafeStr_9595 = true;
                    this.setDisplayObject(new Bitmap());
                    this._SafeStr_9597(_arg_3.width, _arg_3.height);
                    return;
                case GraphicContext.GC_TYPE_TEXTFIELD:
                    _local_4 = new TextField();
                    _local_4.width = _arg_3.width;
                    _local_4.height = _arg_3.height;
                    _local_4.type = TextFieldType.INPUT;
                    this.setDisplayObject(_local_4);
                    return;
                case GraphicContext.GC_TYPE_SHAPE:
                    this.setDisplayObject(new Shape());
                    return;
                case GraphicContext.GC_TYPE_MORPH_SHAPE:
                    this.setDisplayObject(new MorphShape());
                    return;
                case GraphicContext.GC_TYPE_CONTAINER:
                    this.setDisplayObject(new Sprite());
                    return;
                case GraphicContext.GC_TYPE_DESKTOP:
                    return;
                case GraphicContext.GC_TYPE_UNKNOWN:
                    return;
                default:
                    throw (new Error((("Unsupported graphic context type: " + _arg_2) + "!")));
            };
        }
        public static function get numGraphicContexts():uint
        {
            return (_SafeStr_4425);
        }
        public static function get allocatedByteCount():uint
        {
            return (_SafeStr_9592);
        }

        public function set parent(_arg_1:DisplayObjectContainer):void
        {
            if (parent != null){
                parent.removeChild(this);
            };
            if (_arg_1 != null){
                _arg_1.addChild(this);
            };
        }
        override public function get filters():Array
        {
            return (this.getDisplayObject().filters);
        }
        override public function set filters(_arg_1:Array):void
        {
            this.getDisplayObject().filters = _arg_1;
        }
        public function get blend():Number
        {
            return (this.alpha);
        }
        public function set blend(_arg_1:Number):void
        {
            this.alpha = _arg_1;
        }
        public function get mouse():Boolean
        {
            return (super.mouseEnabled);
        }
        public function set mouse(_arg_1:Boolean):void
        {
            super.mouseEnabled = _arg_1;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (parent != null){
                    parent.removeChild(this);
                    this.parent = null;
                };
                while (this.numChildContexts > 0) {
                    this.removeChildContextAt(0);
                };
                if (this._SafeStr_9595){
                    this.releaseDrawBuffer();
                };
                if (this._SafeStr_9593 != null){
                    while (this._SafeStr_9593.numChildren > 0) {
                        this._SafeStr_9593.removeChildAt(0);
                    };
                };
                this._SafeStr_9593 = null;
                while (numChildren > 0) {
                    removeChildAt(0);
                };
                this._SafeStr_9596 = null;
                this._disposed = true;
                _SafeStr_4425--;
            };
        }
        override public function toString():String
        {
            return ((('[object GraphicContext name="' + name) + '"]'));
        }
        public function getDrawRegion():Rectangle
        {
            return (this._rectangle.clone());
        }
        public function setDrawRegion(_arg_1:Rectangle, _arg_2:Boolean, _arg_3:Rectangle):void
        {
            if (((this._SafeStr_9595) && (_arg_2))){
                this._SafeStr_9597(_arg_1.width, _arg_1.height);
            };
            x = _arg_1.x;
            y = _arg_1.y;
            this._rectangle.x = _arg_1.x;
            this._rectangle.y = _arg_1.y;
            this._rectangle.width = _arg_1.width;
            this._rectangle.height = _arg_1.height;
            if (_arg_3){
                if (!this._SafeStr_9596){
                    this._SafeStr_9596 = new Shape();
                    this._SafeStr_9596.visible = false;
                    this._SafeStr_9596.cacheAsBitmap = true;
                    super.addChild(this._SafeStr_9596);
                };
                this._SafeStr_9596.graphics.clear();
                this._SafeStr_9596.graphics.beginFill(0xFF);
                this._SafeStr_9596.graphics.drawRect(_arg_3.x, _arg_3.y, _arg_3.width, _arg_3.height);
                this._SafeStr_9596.graphics.endFill();
                this.getDisplayObject().mask = this._SafeStr_9596;
            }
            else {
                if (this._SafeStr_9596){
                    super.removeChild(this._SafeStr_9596);
                    this._SafeStr_9596.graphics.clear();
                    this._SafeStr_9596 = null;
                    this.getDisplayObject().mask = null;
                };
            };
        }
        public function getDisplayObject():DisplayObject
        {
            return (getChildAt(0));
        }
        public function setDisplayObject(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:DisplayObject;
            if (numChildren > 0){
                _local_2 = removeChildAt(0);
            };
            addChildAt(_arg_1, 0);
            _arg_1.cacheAsBitmap = true;
            _arg_1.mask = this._SafeStr_9596;
            return (_local_2);
        }
        public function getAbsoluteMousePosition(_arg_1:Point):void
        {
            _arg_1.x = stage.mouseX;
            _arg_1.y = stage.mouseY;
        }
        public function getRelativeMousePosition(_arg_1:Point):void
        {
            var _local_2:DisplayObject = this.getDisplayObject();
            _arg_1.x = _local_2.mouseX;
            _arg_1.y = _local_2.mouseY;
        }
        public function fetchDrawBuffer():IBitmapDrawable
        {
            var _local_1:DisplayObject;
            if (this._SafeStr_9595){
                _local_1 = this.getDisplayObject();
                if (_local_1 != null){
                    return (Bitmap(_local_1).bitmapData);
                };
            };
            return (null);
        }
        protected function _SafeStr_9597(width:int, height:int):BitmapData
        {
            var displayObject:DisplayObject;
            var bitmap:BitmapData;
            if (this._SafeStr_9595){
                displayObject = this.getDisplayObject();
                if ((displayObject is Bitmap)){
                    bitmap = Bitmap(displayObject).bitmapData;
                    if (bitmap != null){
                        if (((!((bitmap.width == width))) || (!((bitmap.height == height))))){
                            _SafeStr_9592 = (_SafeStr_9592 - ((bitmap.width * bitmap.height) * 4));
                            bitmap.dispose();
                            bitmap = null;
                        };
                    };
                    if ((((((bitmap == null)) && ((width > 0)))) && ((height > 0)))){
                        try {
                            bitmap = new TrackedBitmapData(this, width, height, this._SafeStr_9594, 0xFFFFFF);
                        }
                        catch(e:Error) {
                            bitmap = new TrackedBitmapData(this, 1, 1, _SafeStr_9594, 0xFFFFFF);
                        };
                        _SafeStr_9592 = (_SafeStr_9592 + ((bitmap.width * bitmap.height) * 4));
                    };
                    Bitmap(displayObject).bitmapData = bitmap;
                    return (bitmap);
                };
            };
            return (null);
        }
        protected function releaseDrawBuffer():void
        {
            var _local_1:DisplayObject;
            var _local_2:BitmapData;
            if (this._SafeStr_9595){
                _local_1 = this.getDisplayObject();
                if ((_local_1 is Bitmap)){
                    _local_2 = Bitmap(_local_1).bitmapData;
                    if (_local_2 != null){
                        _SafeStr_9592 = (_SafeStr_9592 - ((_local_2.width * _local_2.height) * 4));
                        _local_2.dispose();
                    };
                };
            };
        }
        public function showRedrawRegion(_arg_1:Rectangle):void
        {
            graphics.clear();
            graphics.lineStyle(1, 0xFF00FF00);
            graphics.drawRect(0, 0, width, height);
            if (_arg_1 != null){
                graphics.lineStyle(1, 0xFF0000FF);
                graphics.drawRect(_arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
            };
        }
        protected function setupChildContainer():DisplayObjectContainer
        {
            if (this._SafeStr_9593 == null){
                this._SafeStr_9593 = new Sprite();
                this._SafeStr_9593.name = (this.name + " - Child Container");
                this._SafeStr_9593.mouseEnabled = false;
                addChild(this._SafeStr_9593);
            };
            return (this._SafeStr_9593);
        }
        protected function removeChildContainer():void
        {
            if (this._SafeStr_9593 != null){
                removeChild(this._SafeStr_9593);
                this._SafeStr_9593 = null;
            };
        }
        public function get numChildContexts():int
        {
            return ((((this._SafeStr_9593)!=null) ? this._SafeStr_9593.numChildren : 0));
        }
        public function addChildContext(_arg_1:IGraphicContext):IGraphicContext
        {
            return ((this.setupChildContainer().addChild((_arg_1 as DisplayObject)) as IGraphicContext));
        }
        public function addChildContextAt(_arg_1:IGraphicContext, _arg_2:int):IGraphicContext
        {
            return ((this.setupChildContainer().addChildAt((_arg_1 as DisplayObject), _arg_2) as IGraphicContext));
        }
        public function getChildContextAt(_arg_1:int):IGraphicContext
        {
            return ((this.setupChildContainer().getChildAt(_arg_1) as IGraphicContext));
        }
        public function getChildContextByName(_arg_1:String):IGraphicContext
        {
            return ((this.setupChildContainer().getChildByName(_arg_1) as IGraphicContext));
        }
        public function getChildContextIndex(_arg_1:IGraphicContext):int
        {
            return (this.setupChildContainer().getChildIndex(DisplayObject(_arg_1)));
        }
        public function removeChildContext(_arg_1:IGraphicContext):IGraphicContext
        {
            return ((this.setupChildContainer().removeChild(DisplayObject(_arg_1)) as IGraphicContext));
        }
        public function removeChildContextAt(_arg_1:int):IGraphicContext
        {
            var _local_2:IGraphicContext = (this.setupChildContainer().getChildAt(_arg_1) as IGraphicContext);
            return ((((_local_2 == null)) ? null : this.removeChildContext(_local_2)));
        }
        public function setChildContextIndex(child:IGraphicContext, index:int):void
        {
            var current:int;
            var temp:Array;
            var i:uint;
            var dispObj:DisplayObject = (child as DisplayObject);
            if (dispObj != null){
                try {
                    current = this.setupChildContainer().getChildIndex(dispObj);
                }
                catch(error:ArgumentError) {
                    temp = new Array();
                    i = 0;
                    while (i < numChildContexts) {
                        temp.push(getChildContextAt(i));
                        i++;
                    };
                    throw (new Error("Provided display object is not a child of this!"));
                };
                if (index != current){
                    this.setupChildContainer().setChildIndex(dispObj, index);
                };
            }
            else {
                throw (new Error("Provided child must implement IGraphicContext!"));
            };
        }
        public function swapChildContexts(_arg_1:IGraphicContext, _arg_2:IGraphicContext):void
        {
            this.setupChildContainer().swapChildren((_arg_1 as DisplayObject), (_arg_2 as DisplayObject));
        }
        public function swapChildContextsAt(_arg_1:int, _arg_2:int):void
        {
            this.setupChildContainer().swapChildrenAt(_arg_1, _arg_2);
        }

    }
}//package com.sulake.core.window.graphics

// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// GraphicContext = "_-03R" (String#14179, DoABC#2)
// TrackedBitmapData = "_-1gF" (String#5666, DoABC#2)
// _SafeStr_4425 = "_-vA" (String#643, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// mouse = "_-2qv" (String#7094, DoABC#2)
// getRelativeMousePosition = "_-1wW" (String#1785, DoABC#2)
// getDrawRegion = "_-0xH" (String#1582, DoABC#2)
// fetchDrawBuffer = "_-0oc" (String#1553, DoABC#2)
// setDrawRegion = "_-340" (String#7389, DoABC#2)
// getAbsoluteMousePosition = "_-313" (String#1987, DoABC#2)
// showRedrawRegion = "_-2Qs" (String#6574, DoABC#2)
// numChildContexts = "_-1cY" (String#5611, DoABC#2)
// addChildContext = "_-1ax" (String#5575, DoABC#2)
// addChildContextAt = "_-2dP" (String#6819, DoABC#2)
// getChildContextAt = "_-105" (String#4870, DoABC#2)
// getChildContextIndex = "_-2bO" (String#6780, DoABC#2)
// removeChildContext = "_-28x" (String#6224, DoABC#2)
// removeChildContextAt = "_-2rG" (String#7107, DoABC#2)
// setChildContextIndex = "_-je" (String#8591, DoABC#2)
// swapChildContexts = "_-0Zm" (String#4292, DoABC#2)
// swapChildContextsAt = "_-2yp" (String#7257, DoABC#2)
// _SafeStr_9590 = "_-0Qj" (String#15091, DoABC#2)
// _SafeStr_9591 = "_-0z6" (String#16397, DoABC#2)
// _SafeStr_9592 = "_-2Ko" (String#19837, DoABC#2)
// _SafeStr_9593 = "_-2ok" (String#21034, DoABC#2)
// _SafeStr_9594 = "_-ph" (String#24261, DoABC#2)
// _SafeStr_9595 = "_-31l" (String#21569, DoABC#2)
// _SafeStr_9596 = "_-3DV" (String#22015, DoABC#2)
// _SafeStr_9597 = "use" (String#2631, DoABC#2)
// numGraphicContexts = "_-2D3" (String#19525, DoABC#2)
// setupChildContainer = "_-0Nz" (String#14987, DoABC#2)
// removeChildContainer = "_-1uI" (String#18729, DoABC#2)
// getChildContextByName = "_-14s" (String#16649, DoABC#2)


