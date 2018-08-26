
package com.sulake.habbo.avatar.pets
{
    import flash.geom.ColorTransform;

    public class PetColor extends PetEditorInfo implements IPetColor 
    {

        private var _id:int;
        private var _rgb:uint;
        private var _r:uint;
        private var _g:uint;
        private var _b:uint;
        private var _colorTransform:ColorTransform;
        private var _redMultiplier:Number;
        private var _greenMultiplier:Number;
        private var _blueMultiplier:Number;
        private var _figurePartPaletteColorId:int;

        public function PetColor(_arg_1:XML)
        {
            super(_arg_1);
            this._id = parseInt(_arg_1.@id);
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
        public function get id():int
        {
            return (this._id);
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
        public function get colorTransform():ColorTransform
        {
            return (this._colorTransform);
        }
        public function get figurePartPaletteColorId():int
        {
            return (this._figurePartPaletteColorId);
        }
        public function set figurePartPaletteColorId(_arg_1:int):void
        {
            this._figurePartPaletteColorId = _arg_1;
        }

    }
}//package com.sulake.habbo.avatar.pets

// figurePartPaletteColorId = "_-1K6" (String#17277, DoABC#2)
// _figurePartPaletteColorId = "_-05x" (String#14280, DoABC#2)
// IPetColor = "_-2Cb" (String#6294, DoABC#2)
// PetEditorInfo = "_-13t" (String#4952, DoABC#2)
// PetColor = "_-2Cu" (String#6304, DoABC#2)
// _colorTransform = "_-0yf" (String#300, DoABC#2)
// rgb = "_-1zC" (String#1788, DoABC#2)
// _r = "_-y" (String#2225, DoABC#2)
// _g = "_-0yi" (String#1589, DoABC#2)
// _redMultiplier = "_-0vB" (String#1577, DoABC#2)
// _greenMultiplier = "_-Wn" (String#2123, DoABC#2)
// _blueMultiplier = "_-Ay" (String#2067, DoABC#2)


