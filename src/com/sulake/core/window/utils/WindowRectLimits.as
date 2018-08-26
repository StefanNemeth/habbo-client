
package com.sulake.core.window.utils
{
    import com.sulake.core.window.IWindow;

    public class WindowRectLimits implements IRectLimiter 
    {

        private var _minWidth:int = -2147483648;
        private var _maxWidth:int = 2147483647;
        private var _minHeight:int = -2147483648;
        private var _maxHeight:int = 2147483647;
        private var _target:IWindow;

        public function WindowRectLimits(_arg_1:IWindow)
        {
            this._target = _arg_1;
        }
        public function get minWidth():int
        {
            return (this._minWidth);
        }
        public function get maxWidth():int
        {
            return (this._maxWidth);
        }
        public function get minHeight():int
        {
            return (this._minHeight);
        }
        public function get maxHeight():int
        {
            return (this._maxHeight);
        }
        public function set minWidth(_arg_1:int):void
        {
            this._minWidth = _arg_1;
            if ((((((this._minWidth > int.MIN_VALUE)) && (!(this._target.disposed)))) && ((this._target.width < this._minWidth)))){
                this._target.width = this._minWidth;
            };
        }
        public function set maxWidth(_arg_1:int):void
        {
            this._maxWidth = _arg_1;
            if ((((((this._maxWidth < int.MAX_VALUE)) && (!(this._target.disposed)))) && ((this._target.width > this._maxWidth)))){
                this._target.width = this._maxWidth;
            };
        }
        public function set minHeight(_arg_1:int):void
        {
            this._minHeight = _arg_1;
            if ((((((this._minHeight > int.MIN_VALUE)) && (!(this._target.disposed)))) && ((this._target.height < this._minHeight)))){
                this._target.height = this._minHeight;
            };
        }
        public function set maxHeight(_arg_1:int):void
        {
            this._maxHeight = _arg_1;
            if ((((((this._maxHeight < int.MAX_VALUE)) && (!(this._target.disposed)))) && ((this._target.height > this._maxHeight)))){
                this._target.height = this._maxHeight;
            };
        }
        public function get isEmpty():Boolean
        {
            return ((((((((this._minWidth == int.MIN_VALUE)) && ((this._maxWidth == int.MAX_VALUE)))) && ((this._minHeight == int.MIN_VALUE)))) && ((this._maxHeight == int.MAX_VALUE))));
        }
        public function WindowRectLimits():void
        {
            this._minWidth = int.MIN_VALUE;
            this._maxWidth = int.MAX_VALUE;
            this._minHeight = int.MIN_VALUE;
            this._maxHeight = int.MAX_VALUE;
        }
        public function limit():void
        {
            if (((!(this.isEmpty)) && (this._target))){
                if (this._target.width < this._minWidth){
                    this._target.width = this._minWidth;
                }
                else {
                    if (this._target.width > this._maxWidth){
                        this._target.width = this._maxWidth;
                    };
                };
                if (this._target.height < this._minHeight){
                    this._target.height = this._minHeight;
                }
                else {
                    if (this._target.height > this._maxHeight){
                        this._target.height = this._maxHeight;
                    };
                };
            };
        }
        public function assign(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            this._minWidth = _arg_1;
            this._maxWidth = _arg_2;
            this._minHeight = _arg_3;
            this._maxHeight = _arg_4;
            this.limit();
        }
        public function clone(_arg_1:IWindow):WindowRectLimits
        {
            var _local_2:WindowRectLimits = new WindowRectLimits(_arg_1);
            _local_2._minWidth = this._minWidth;
            _local_2._maxWidth = this._maxWidth;
            _local_2._minHeight = this._minHeight;
            _local_2._maxHeight = this._maxHeight;
            return (_local_2);
        }

    }
}//package com.sulake.core.window.utils

// IRectLimiter = "_-1O2" (String#5311, DoABC#2)
// WindowRectLimits = "_-2hy" (String#6906, DoABC#2)
// _maxWidth = "_-0vf" (String#1578, DoABC#2)
// isEmpty = "_-01T" (String#3592, DoABC#2)
// WindowRectLimits = "_-YG" (String#8377, DoABC#2)
// _minWidth = "_-1El" (String#17058, DoABC#2)
// _minHeight = "_-0qU" (String#16069, DoABC#2)
// _maxHeight = "_-0YM" (String#4270, DoABC#2)


