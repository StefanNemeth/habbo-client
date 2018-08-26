
package com.sulake.habbo.avatar.structure.figure
{
    import flash.geom.ColorTransform;

    public class PartColor implements IPartColor 
    {

        private var _id:int;
        private var _index:int;
        private var _clubLevel:int;
        private var _isSelectable:Boolean = false;
        private var _rgb:uint;
        private var _r:uint;
        private var _g:uint;
        private var _b:uint;
        private var _redMultiplier:Number;
        private var _greenMultiplier:Number;
        private var _blueMultiplier:Number;
        private var _colorTransform:ColorTransform;

        public function PartColor(_arg_1:XML)
        {
            this._id = parseInt(_arg_1.@id);
            this._index = parseInt(_arg_1.@index);
            this._clubLevel = parseInt(_arg_1.@club);
            this._isSelectable = Boolean(parseInt(_arg_1.@selectable));
            var _local_2:String = _arg_1.text();
            this._rgb = parseInt(_local_2, 16);
            this._r = ((this._rgb >> 16) & 0xFF);
            this._g = ((this._rgb >> 8) & 0xFF);
            this._b = ((this._rgb >> 0) & 0xFF);
            this._redMultiplier = ((this._r / 0xFF) * 1);
            this._greenMultiplier = ((this._g / 0xFF) * 1);
            this._blueMultiplier = ((this._b / 0xFF) * 1);
            this._colorTransform = new ColorTransform(this._redMultiplier, this._greenMultiplier, this._blueMultiplier);
        }
        public function get colorTransform():ColorTransform
        {
            return (this._colorTransform);
        }
        public function get redMultiplier():Number
        {
            return (this._redMultiplier);
        }
        public function get greenMultiplier():Number
        {
            return (this._greenMultiplier);
        }
        public function get blueMultiplier():Number
        {
            return (this._blueMultiplier);
        }
        public function get rgb():uint
        {
            return (this._rgb);
        }
        public function get r():uint
        {
            return (this._r);
        }
        public function get g():uint
        {
            return (this._g);
        }
        public function get b():uint
        {
            return (this._b);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get index():int
        {
            return (this._index);
        }
        public function get clubLevel():int
        {
            return (this._clubLevel);
        }
        public function get isSelectable():Boolean
        {
            return (this._isSelectable);
        }

    }
}//package com.sulake.habbo.avatar.structure.figure

// IPartColor = "_-1dO" (String#5620, DoABC#2)
// PartColor = "_-1py" (String#5856, DoABC#2)
// _colorTransform = "_-0yf" (String#300, DoABC#2)
// _isSelectable = "_-t7" (String#947, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)
// rgb = "_-1zC" (String#1788, DoABC#2)
// _r = "_-y" (String#2225, DoABC#2)
// _g = "_-0yi" (String#1589, DoABC#2)
// _redMultiplier = "_-0vB" (String#1577, DoABC#2)
// _greenMultiplier = "_-Wn" (String#2123, DoABC#2)
// _blueMultiplier = "_-Ay" (String#2067, DoABC#2)


