
package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowState;
    import flash.geom.Point;

    public class WindowModel implements IDisposable 
    {

        protected var _rectangle:Rectangle;
        protected var _SafeStr_9800:Rectangle;
        protected var _SafeStr_9801:Rectangle;
        protected var _SafeStr_9802:Rectangle;
        protected var _SafeStr_9803:Rectangle;
        protected var _context:WindowContext;
        protected var _background:Boolean = false;
        protected var _background:uint = 0xFFFFFF;
        protected var _SafeStr_9165:uint;
        protected var _mouseThreshold:uint = 10;
        protected var _clipping:Boolean = true;
        protected var _visible:Boolean = true;
        protected var _blend:Number = 1;
        protected var _param:uint;
        protected var _state:uint;
        protected var _style:uint;
        protected var _type:uint;
        protected var _caption:String = "";
        protected var _name:String;
        protected var _id:uint;
        protected var _tags:Array;
        protected var _disposed:Boolean = false;

        public function WindowModel(_arg_1:uint, _arg_2:String, _arg_3:uint, _arg_4:uint, _arg_5:uint, _arg_6:WindowContext, _arg_7:Rectangle, _arg_8:Array=null)
        {
            this._id = _arg_1;
            this._name = _arg_2;
            this._type = _arg_3;
            this._param = _arg_5;
            this._state = WindowState._SafeStr_4075;
            this._style = _arg_4;
            this._tags = (((_arg_8 == null)) ? [] : _arg_8);
            this._context = _arg_6;
            this._rectangle = _arg_7.clone();
            this._SafeStr_9800 = _arg_7.clone();
            this._SafeStr_9801 = _arg_7.clone();
            this._SafeStr_9802 = new Rectangle();
            this._SafeStr_9803 = null;
        }
        public function get x():int
        {
            return (this._rectangle.x);
        }
        public function get y():int
        {
            return (this._rectangle.y);
        }
        public function get width():int
        {
            return (this._rectangle.width);
        }
        public function get height():int
        {
            return (this._rectangle.height);
        }
        public function get position():Point
        {
            return (this._rectangle.topLeft);
        }
        public function get rectangle():Rectangle
        {
            return (this._rectangle);
        }
        public function get context():IWindowContext
        {
            return (this._context);
        }
        public function get mouseThreshold():uint
        {
            return (this._mouseThreshold);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get background():Boolean
        {
            return (this._background);
        }
        public function get clipping():Boolean
        {
            return (this._clipping);
        }
        public function get visible():Boolean
        {
            return (this._visible);
        }
        public function get color():uint
        {
            return (this._background);
        }
        public function get alpha():uint
        {
            return ((this._SafeStr_9165 >>> 24));
        }
        public function get blend():Number
        {
            return (this._blend);
        }
        public function get param():uint
        {
            return (this._param);
        }
        public function get state():uint
        {
            return (this._state);
        }
        public function get style():uint
        {
            return (this._style);
        }
        public function get type():uint
        {
            return (this._type);
        }
        public function get caption():String
        {
            return (this._caption);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get id():uint
        {
            return (this._id);
        }
        public function get tags():Array
        {
            return (this._tags);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
                this._rectangle = null;
                this._context = null;
                this._state = WindowState._SafeStr_9480;
                this._tags = null;
            };
        }
        public function invalidate(_arg_1:Rectangle=null):void
        {
        }
        public function getInitialWidth():int
        {
            return (this._SafeStr_9800.width);
        }
        public function getInitialHeight():int
        {
            return (this._SafeStr_9800.height);
        }
        public function getPreviousWidth():int
        {
            return (this._SafeStr_9801.width);
        }
        public function getPreviousHeight():int
        {
            return (this._SafeStr_9801.height);
        }
        public function getMinimizedWidth():int
        {
            return (this._SafeStr_9802.width);
        }
        public function getMinimizedHeight():int
        {
            return (this._SafeStr_9802.height);
        }
        public function getMaximizedWidth():int
        {
            return (this._SafeStr_9803.width);
        }
        public function getMaximizedHeight():int
        {
            return (this._SafeStr_9803.height);
        }
        public function testTypeFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0){
                return ((((this._type & _arg_2) ^ _arg_1) == 0));
            };
            return (((this._type & _arg_1) == _arg_1));
        }
        public function testStateFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0){
                return ((((this._state & _arg_2) ^ _arg_1) == 0));
            };
            return (((this._state & _arg_1) == _arg_1));
        }
        public function testStyleFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0){
                return ((((this._style & _arg_2) ^ _arg_1) == 0));
            };
            return (((this._style & _arg_1) == _arg_1));
        }
        public function testParamFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0){
                return ((((this._param & _arg_2) ^ _arg_1) == 0));
            };
            return (((this._param & _arg_1) == _arg_1));
        }

    }
}//package com.sulake.core.window

// IWindowContext = "_-8b" (String#2061, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// WindowModel = "_-2WP" (String#1891, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)
// _SafeStr_4075 = "_-0DX" (String#14589, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// _param = "_-2d3" (String#306, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// _blend = "_-2A2" (String#616, DoABC#2)
// _caption = "_-p" (String#8690, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// _background = "_-35x" (String#21726, DoABC#2)
// _background = "_-zD" (String#24660, DoABC#2)
// _SafeStr_9165 = "_-2Yy" (String#20394, DoABC#2)
// testParamFlag = "_-1ml" (String#5794, DoABC#2)
// testStateFlag = "_-35A" (String#7410, DoABC#2)
// _SafeStr_9480 = "_-2cN" (String#20539, DoABC#2)
// _SafeStr_9800 = "_-2AJ" (String#19417, DoABC#2)
// _SafeStr_9801 = "_-QG" (String#23260, DoABC#2)
// _SafeStr_9802 = "_-1OR" (String#17450, DoABC#2)
// _SafeStr_9803 = "_-0bN" (String#15491, DoABC#2)
// _mouseThreshold = "_-95" (String#22584, DoABC#2)
// _clipping = "_-38F" (String#21812, DoABC#2)
// getInitialWidth = "_-0V9" (String#15249, DoABC#2)
// getInitialHeight = "_-Kc" (String#23028, DoABC#2)
// getPreviousWidth = "_-1f5" (String#18102, DoABC#2)
// getPreviousHeight = "_-1pB" (String#18508, DoABC#2)
// getMinimizedWidth = "_-gm" (String#23922, DoABC#2)
// getMinimizedHeight = "_-1ix" (String#18242, DoABC#2)
// getMaximizedWidth = "_-2WQ" (String#20301, DoABC#2)
// getMaximizedHeight = "_-2Rx" (String#20117, DoABC#2)
// testTypeFlag = "_-Mj" (String#23115, DoABC#2)
// testStyleFlag = "_-3C2" (String#7553, DoABC#2)


