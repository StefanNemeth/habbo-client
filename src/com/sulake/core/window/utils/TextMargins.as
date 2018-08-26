
package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public class TextMargins implements IMargins, IDisposable 
    {

        private var _left:int;
        private var _right:int;
        private var _top:int;
        private var _bottom:int;
        private var _callback:Function;
        private var _disposed:Boolean = false;

        public function TextMargins(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function)
        {
            this._left = _arg_1;
            this._top = _arg_2;
            this._right = _arg_3;
            this._bottom = _arg_4;
            this._callback = (((_arg_5)!=null) ? _arg_5 : this.TextMargins);
        }
        public function get left():int
        {
            return (this._left);
        }
        public function get right():int
        {
            return (this._right);
        }
        public function get top():int
        {
            return (this._top);
        }
        public function get bottom():int
        {
            return (this._bottom);
        }
        public function set left(_arg_1:int):void
        {
            this._left = _arg_1;
            this._callback(this);
        }
        public function set right(_arg_1:int):void
        {
            this._right = _arg_1;
            this._callback(this);
        }
        public function set top(_arg_1:int):void
        {
            this._top = _arg_1;
            this._callback(this);
        }
        public function set bottom(_arg_1:int):void
        {
            this._bottom = _arg_1;
            this._callback(this);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get isZeroes():Boolean
        {
            return ((((((((this._left == 0)) && ((this._right == 0)))) && ((this._top == 0)))) && ((this._bottom == 0))));
        }
        public function assign(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function):void
        {
            this._left = _arg_1;
            this._top = _arg_2;
            this._right = _arg_3;
            this._bottom = _arg_4;
            this._callback = (((_arg_5)!=null) ? _arg_5 : this.TextMargins);
        }
        public function clone(_arg_1:Function):TextMargins
        {
            return (new TextMargins(this._left, this._top, this._right, this._bottom, _arg_1));
        }
        public function dispose():void
        {
            this._callback = null;
            this._disposed = true;
        }
        private function TextMargins(_arg_1:IMargins):void
        {
        }

    }
}//package com.sulake.core.window.utils

// IMargins = "_-1mu" (String#1757, DoABC#2)
// TextMargins = "_-2Jl" (String#19801, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _callback = "_-0t2" (String#593, DoABC#2)
// _left = "_-iR" (String#8567, DoABC#2)
// _bottom = "_-0nY" (String#4581, DoABC#2)
// TextMargins = "_-f5" (String#23849, DoABC#2)
// isZeroes = "_-2Yv" (String#20392, DoABC#2)


