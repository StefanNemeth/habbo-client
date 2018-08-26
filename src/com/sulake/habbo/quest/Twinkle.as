
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class Twinkle implements AnimationObject, IDisposable 
    {

        private static const _SafeStr_12188:int = 100;
        private static const _SafeStr_12189:Array = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1];
        private static const _SafeStr_12190:int = -1;
        private static const _SafeStr_12191:int = -2;
        private static const APPEAR_AREA:Point = new Point(44, 44);

        private var _twinkleImages:TwinkleImages;
        private var _SafeStr_12192:int;
        private var _position:Point;

        public function Twinkle(_arg_1:TwinkleImages, _arg_2:int)
        {
            this._twinkleImages = _arg_1;
            this._SafeStr_12192 = _arg_2;
        }
        public function dispose():void
        {
            this._twinkleImages = null;
            this._position = null;
        }
        public function get disposed():Boolean
        {
            return ((this._twinkleImages == null));
        }
        public function Twinkle():void
        {
            this._position = new Point(Math.round((Math.random() * APPEAR_AREA.x)), Math.round((Math.random() * APPEAR_AREA.y)));
        }
        public function Twinkle(_arg_1:int):Point
        {
            return (this._position);
        }
        public function isFinished(_arg_1:int):Boolean
        {
            return ((this.getFrame(_arg_1) == _SafeStr_12191));
        }
        public function getBitmap(_arg_1:int):BitmapData
        {
            var _local_2:int = this.getFrame(_arg_1);
            return (this._twinkleImages.TwinkleImages(_SafeStr_12189[_local_2]));
        }
        private function getFrame(_arg_1:int):int
        {
            var _local_2:int = (_arg_1 - this._SafeStr_12192);
            if (_local_2 < 0){
                return (_SafeStr_12190);
            };
            var _local_3:int = Math.floor((_local_2 / _SafeStr_12188));
            if (_local_3 >= _SafeStr_12189.length){
                return (_SafeStr_12191);
            };
            return (_local_3);
        }

    }
}//package com.sulake.habbo.quest

// Twinkle = "_-3Hw" (String#7665, DoABC#2)
// isFinished = "_-2pC" (String#7064, DoABC#2)
// getBitmap = "_-0zS" (String#4837, DoABC#2)
// _SafeStr_12188 = "_-1kr" (String#18325, DoABC#2)
// _SafeStr_12189 = "_-09N" (String#14424, DoABC#2)
// _SafeStr_12190 = "_-35i" (String#21719, DoABC#2)
// _SafeStr_12191 = "_-2qr" (String#21116, DoABC#2)
// _SafeStr_12192 = "_-0Wk" (String#15307, DoABC#2)
// AnimationObject = "_-0y7" (String#4813, DoABC#2)
// Twinkle = "_-i4" (String#23968, DoABC#2)
// TwinkleImages = "_-0vX" (String#4758, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _position = "_-0Pf" (String#433, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// Twinkle = "_-GB" (String#7997, DoABC#2)


