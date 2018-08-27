
package com.sulake.room.renderer.utils
{
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class ExtendedSprite extends Bitmap 
    {

        private var _alphaTolerance:int = 128;
        private var _alphaActive:Boolean = false;
        private var _SafeStr_14441:Point;
        private var _tag:String = "";
        private var _identifier:String = "";
        private var _clickHandling:Boolean = false;
        private var _varyingDepth:Boolean = false;
        private var _bitmapData:ExtendedBitmapData = null;
        private var _width:int = 0;
        private var _height:int = 0;
        private var _SafeStr_14442:int = -1;
        private var _SafeStr_14443:int = -1;

        public function ExtendedSprite():void
        {
            this._SafeStr_14441 = new Point();
            cacheAsBitmap = false;
            this.enableAlpha();
        }
        public function get alphaActive():Boolean
        {
            return (this._alphaActive);
        }
        public function get alphaTolerance():int
        {
            return (this._alphaTolerance);
        }
        public function set alphaTolerance(_arg_1:int):void
        {
            this._alphaTolerance = _arg_1;
        }
        public function get tag():String
        {
            return (this._tag);
        }
        public function set tag(_arg_1:String):void
        {
            this._tag = _arg_1;
        }
        public function get identifier():String
        {
            return (this._identifier);
        }
        public function set identifier(_arg_1:String):void
        {
            this._identifier = _arg_1;
        }
        public function get varyingDepth():Boolean
        {
            return (this._varyingDepth);
        }
        public function set varyingDepth(_arg_1:Boolean):void
        {
            this._varyingDepth = _arg_1;
        }
        public function get clickHandling():Boolean
        {
            return (this._clickHandling);
        }
        public function set clickHandling(_arg_1:Boolean):void
        {
            this._clickHandling = _arg_1;
        }
        public function dispose():void
        {
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }
        override public function set bitmapData(_arg_1:BitmapData):void
        {
            var _local_2:ExtendedBitmapData;
            if (_arg_1 == bitmapData){
                return;
            };
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            if (_arg_1 != null){
                this._width = _arg_1.width;
                this._height = _arg_1.height;
                _local_2 = (_arg_1 as ExtendedBitmapData);
                if (_local_2 != null){
                    _local_2.addReference();
                    this._bitmapData = _local_2;
                };
            }
            else {
                this._width = 0;
                this._height = 0;
                this._SafeStr_14442 = -1;
                this._SafeStr_14443 = -1;
            };
            super.bitmapData = _arg_1;
        }
        public function needsUpdate(_arg_1:int, _arg_2:int):Boolean
        {
            if (((!((_arg_1 == this._SafeStr_14442))) || (!((_arg_2 == this._SafeStr_14443))))){
                this._SafeStr_14442 = _arg_1;
                this._SafeStr_14443 = _arg_2;
                return (true);
            };
            if (((!((this._bitmapData == null))) && (this._bitmapData.disposed))){
                return (true);
            };
            return (false);
        }
        public function disableAlpha():void
        {
            this._alphaActive = false;
        }
        public function enableAlpha():void
        {
            this.disableAlpha();
            this._alphaActive = true;
        }
        override public function hitTestPoint(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=false):Boolean
        {
            return (this.hitTest(_arg_1, _arg_2));
        }
        public function hitTest(_arg_1:int, _arg_2:int):Boolean
        {
            if ((((this._alphaTolerance > 0xFF)) || ((bitmapData == null)))){
                return (false);
            };
            if ((((((((_arg_1 < 0)) || ((_arg_2 < 0)))) || ((_arg_1 >= this._width)))) || ((_arg_2 >= this._height)))){
                return (false);
            };
            return (this.hitTestBitmapData(_arg_1, _arg_2));
        }
        private function hitTestBitmapData(x:int, y:int):Boolean
        {
            var pixel:uint;
            var retVal:Boolean;
            try {
                if (((!(this._alphaActive)) || (!(bitmapData.transparent)))){
                    retVal = true;
                }
                else {
                    pixel = bitmapData.getPixel32(x, y);
                    pixel = (pixel >> 24);
                    retVal = (pixel > this._alphaTolerance);
                };
            }
            catch(e:Error) {
            };
            return (retVal);
        }

    }
}//package com.sulake.room.renderer.utils

// needsUpdate = "_-2cQ" (String#20541, DoABC#2)
// _alphaTolerance = "_-u" (String#24449, DoABC#2)
// _alphaActive = "_-5t" (String#22459, DoABC#2)
// _SafeStr_14441 = "_-2dr" (String#20595, DoABC#2)
// _SafeStr_14442 = "_-0iD" (String#15759, DoABC#2)
// _SafeStr_14443 = "_-M0" (String#23083, DoABC#2)
// enableAlpha = "_-01h" (String#14118, DoABC#2)
// alphaActive = "_-jM" (String#24013, DoABC#2)
// alphaTolerance = "_-2KR" (String#19819, DoABC#2)
// disableAlpha = "_-2B0" (String#19445, DoABC#2)
// hitTestBitmapData = "_-0Dm" (String#14599, DoABC#2)
// ExtendedSprite = "_-1mI" (String#5785, DoABC#2)
// ExtendedBitmapData = "_-11w" (String#4915, DoABC#2)
// _tag = "_-1Gy" (String#601, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// addReference = "_-2F" (String#6343, DoABC#2)
// varyingDepth = "_-11d" (String#4909, DoABC#2)
// clickHandling = "_-2fU" (String#6858, DoABC#2)
// _varyingDepth = "_-1g2" (String#5664, DoABC#2)
// _clickHandling = "_-13Y" (String#1613, DoABC#2)
// _identifier = "_-1Ax" (String#1628, DoABC#2)


