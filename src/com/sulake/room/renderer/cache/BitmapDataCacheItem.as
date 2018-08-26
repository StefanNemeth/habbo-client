
package com.sulake.room.renderer.cache
{
    import com.sulake.room.renderer.utils.ExtendedBitmapData;

    public class BitmapDataCacheItem 
    {

        private var _bitmapData:ExtendedBitmapData = null;
        private var _name:String = "";
        private var _memUsage:int = 0;

        public function BitmapDataCacheItem(_arg_1:ExtendedBitmapData, _arg_2:String)
        {
            this._bitmapData = _arg_1;
            this._name = _arg_2;
            if (_arg_1 != null){
                _arg_1.ExtendedBitmapData();
                this._memUsage = ((this._bitmapData.width * this._bitmapData.height) * 4);
            };
        }
        public function get bitmapData():ExtendedBitmapData
        {
            return (this._bitmapData);
        }
        public function get memUsage():int
        {
            return (this._memUsage);
        }
        public function get useCount():int
        {
            if (this._bitmapData == null){
                return (0);
            };
            return (this._bitmapData.referenceCount);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function set bitmapData(_arg_1:ExtendedBitmapData):void
        {
            if (this._bitmapData != null){
                this._bitmapData.dispose();
            };
            this._bitmapData = _arg_1;
            if (this._bitmapData != null){
                this._bitmapData.ExtendedBitmapData();
                this._memUsage = ((this._bitmapData.width * this._bitmapData.height) * 4);
            }
            else {
                this._memUsage = 0;
            };
        }
        public function dispose():void
        {
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            this._memUsage = 0;
        }

    }
}//package com.sulake.room.renderer.cache

// _memUsage = "_-2xu" (String#7237, DoABC#2)
// memUsage = "_-1kZ" (String#18310, DoABC#2)
// referenceCount = "_-0qp" (String#16079, DoABC#2)
// ExtendedBitmapData = "_-11w" (String#4915, DoABC#2)
// BitmapDataCacheItem = "_-KT" (String#8091, DoABC#2)
// ExtendedBitmapData = "_-2F" (String#6343, DoABC#2)


