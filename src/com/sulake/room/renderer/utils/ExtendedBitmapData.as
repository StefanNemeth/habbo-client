
package com.sulake.room.renderer.utils
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class ExtendedBitmapData extends BitmapData 
    {

        private static const _SafeStr_12969:Point = new Point(0, 0);

        private var _referenceCount:int = 0;
        private var _disposed:Boolean = false;

        public function ExtendedBitmapData(_arg_1:int, _arg_2:int, _arg_3:Boolean=true, _arg_4:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        public function get referenceCount():int
        {
            return (this._referenceCount);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function ExtendedBitmapData():void
        {
            this._referenceCount++;
        }
        override public function dispose():void
        {
            if (this._disposed){
                return;
            };
            if (--this._referenceCount <= 0){
                super.dispose();
                this._disposed = true;
            };
        }
        override public function clone():BitmapData
        {
            var data:ExtendedBitmapData;
            try {
                data = new ExtendedBitmapData(width, height, true, 0xFFFFFF);
                data.copyPixels(this, rect, _SafeStr_12969, null, null, true);
            }
            catch(e:Error) {
                data = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
            };
            return (data);
        }

    }
}//package com.sulake.room.renderer.utils

// _SafeStr_12969 = "_-0Bv" (String#1423, DoABC#2)
// _referenceCount = "_-195" (String#5057, DoABC#2)
// referenceCount = "_-0qp" (String#16079, DoABC#2)
// ExtendedBitmapData = "_-11w" (String#4915, DoABC#2)
// ExtendedBitmapData = "_-2F" (String#6343, DoABC#2)


