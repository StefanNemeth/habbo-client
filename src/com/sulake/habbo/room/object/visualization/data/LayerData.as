
package com.sulake.habbo.room.object.visualization.data
{
    public class LayerData 
    {

        public static const :String = "";
        public static const _SafeStr_12548:int = 0;
        public static const _SafeStr_12550:int = 0xFF;
        public static const _SafeStr_12552:Boolean = false;
        public static const _SafeStr_12554:int = 0;
        public static const _SafeStr_12556:int = 0;
        public static const _SafeStr_4401:int = 0;
        public static const _SafeStr_12537:int = 1;
        public static const _SafeStr_12538:int = 2;
        public static const INK_DARKEN:int = 3;

        private var _tag:String = "";
        private var _ink:int = 0;
        private var _alpha:int = 0xFF;
        private var _ignoreMouse:Boolean = false;
        private var _xOffset:int = 0;
        private var _yOffset:int = 0;
        private var _zOffset:Number = 0;

        public function set tag(_arg_1:String):void
        {
            this._tag = _arg_1;
        }
        public function get tag():String
        {
            return (this._tag);
        }
        public function set ink(_arg_1:int):void
        {
            this._ink = _arg_1;
        }
        public function get ink():int
        {
            return (this._ink);
        }
        public function set alpha(_arg_1:int):void
        {
            this._alpha = _arg_1;
        }
        public function get alpha():int
        {
            return (this._alpha);
        }
        public function set ignoreMouse(_arg_1:Boolean):void
        {
            this._ignoreMouse = _arg_1;
        }
        public function get ignoreMouse():Boolean
        {
            return (this._ignoreMouse);
        }
        public function set xOffset(_arg_1:int):void
        {
            this._xOffset = _arg_1;
        }
        public function get xOffset():int
        {
            return (this._xOffset);
        }
        public function set yOffset(_arg_1:int):void
        {
            this._yOffset = _arg_1;
        }
        public function get yOffset():int
        {
            return (this._yOffset);
        }
        public function set zOffset(_arg_1:Number):void
        {
            this._zOffset = _arg_1;
        }
        public function get zOffset():Number
        {
            return (this._zOffset);
        }
        public function copyValues(_arg_1:LayerData):void
        {
            if (_arg_1 != null){
                this.tag = _arg_1.tag;
                this.ink = _arg_1.ink;
                this.alpha = _arg_1.alpha;
                this.ignoreMouse = _arg_1.ignoreMouse;
                this.xOffset = _arg_1.xOffset;
                this.yOffset = _arg_1.yOffset;
                this.zOffset = _arg_1.zOffset;
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// _SafeStr_12537 = "_-ZY" (String#23618, DoABC#2)
// _SafeStr_12538 = "_-1dV" (String#18034, DoABC#2)
//  = "_-1S-" (String#17583, DoABC#2)
// _SafeStr_12548 = "_-1jC" (String#18252, DoABC#2)
// _SafeStr_12550 = "_-1Y" (String#17814, DoABC#2)
// _SafeStr_12552 = "_-1Vm" (String#17733, DoABC#2)
// _SafeStr_12554 = "_-2ZS" (String#20416, DoABC#2)
// _SafeStr_12556 = "_-35D" (String#21702, DoABC#2)
// xOffset = "_-2uo" (String#21269, DoABC#2)
// yOffset = "_-23e" (String#19160, DoABC#2)
// zOffset = "_-2bJ" (String#20500, DoABC#2)
// _ignoreMouse = "_-1H5" (String#17156, DoABC#2)
// _xOffset = "_-JW" (String#22984, DoABC#2)
// _yOffset = "_-1ey" (String#18095, DoABC#2)
// _zOffset = "_-3DG" (String#22006, DoABC#2)
// _tag = "_-1Gy" (String#601, DoABC#2)
// _SafeStr_4401 = "_-1Tp" (String#17658, DoABC#2)
// _alpha = "_-0SY" (String#1474, DoABC#2)
// _ink = "_-23x" (String#874, DoABC#2)


