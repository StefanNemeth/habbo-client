
package com.sulake.room.renderer.cache
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.renderer.utils.ExtendedBitmapData;
    import flash.display.BitmapData;

    public class BitmapDataCache 
    {

        private var _dataMap:Map;
        private var _memUsage:int = 0;
        private var _memLimit:int = 0;
        private var _SafeStr_14416:int = 0;
        private var _SafeStr_14417:int = 0;

        public function BitmapDataCache(_arg_1:int, _arg_2:int, _arg_3:int=1)
        {
            this._dataMap = new Map();
            this._memLimit = ((_arg_1 * 0x0400) * 0x0400);
            this._SafeStr_14416 = ((_arg_2 * 0x0400) * 0x0400);
            this._SafeStr_14417 = ((_arg_3 * 0x0400) * 0x0400);
            if (this._SafeStr_14417 < 0){
                this._SafeStr_14417 = 0;
            };
        }
        public function get memUsage():int
        {
            return (this._memUsage);
        }
        public function get memLimit():int
        {
            return (this._memLimit);
        }
        public function dispose():void
        {
            var _local_1:Array;
            var _local_2:String;
            if (this._dataMap != null){
                _local_1 = this._dataMap.getKeys();
                for each (_local_2 in _local_1) {
                    if (!this.removeItem(_local_2)){
                        Logger.log((("Failed to remove item " + _local_2) + " from room canvas bitmap cache!"));
                    };
                };
                this._dataMap.dispose();
                this._dataMap = null;
            };
        }
        public function compress():void
        {
            var _local_3:Array;
            var _local_1:BitmapDataCacheItem;
            var _local_2:int;
            if (this.memUsage > this.memLimit){
                _local_3 = this._dataMap.getValues();
                _local_3.sortOn("useCount", (Array.DESCENDING | Array.NUMERIC));
                _local_2 = (_local_3.length - 1);
                while (_local_2 >= 0) {
                    _local_1 = (_local_3[_local_2] as BitmapDataCacheItem);
                    if (_local_1.useCount <= 1){
                        this.removeItem(_local_1.name);
                    }
                    else {
                        break;
                    };
                    _local_2--;
                };
                this.increaseMemoryLimit();
            };
        }
        private function increaseMemoryLimit():void
        {
            this._memLimit = (this._memLimit + this._SafeStr_14417);
            if (this._memLimit > this._SafeStr_14416){
                this._memLimit = this._SafeStr_14416;
            };
        }
        private function removeItem(_arg_1:String):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:BitmapDataCacheItem = (this._dataMap.getValue(_arg_1) as BitmapDataCacheItem);
            if (_local_2 != null){
                if (_local_2.useCount <= 1){
                    this._dataMap.remove(_local_2.name);
                    this._memUsage = (this._memUsage - _local_2.memUsage);
                    _local_2.dispose();
                    return (true);
                };
                return (false);
            };
            return (false);
        }
        public function getBitmapData(_arg_1:String):ExtendedBitmapData
        {
            var _local_2:BitmapDataCacheItem = (this._dataMap.getValue(_arg_1) as BitmapDataCacheItem);
            if (_local_2 == null){
                return (null);
            };
            return (_local_2.bitmapData);
        }
        public function addBitmapData(_arg_1:String, _arg_2:ExtendedBitmapData):void
        {
            var _local_4:BitmapData;
            if (_arg_2 == null){
                return;
            };
            var _local_3:BitmapDataCacheItem = (this._dataMap.getValue(_arg_1) as BitmapDataCacheItem);
            if (_local_3 != null){
                _local_4 = _local_3.bitmapData;
                if (_local_4 != null){
                    this._memUsage = (this._memUsage - ((_local_4.width * _local_4.height) * 4));
                };
                _local_3.bitmapData = _arg_2;
            }
            else {
                _local_3 = new BitmapDataCacheItem(_arg_2, _arg_1);
                this._dataMap.add(_arg_1, _local_3);
            };
            this._memUsage = (this._memUsage + ((_arg_2.width * _arg_2.height) * 4));
        }

    }
}//package com.sulake.room.renderer.cache

// _memUsage = "_-2xu" (String#7237, DoABC#2)
// _memLimit = "_-0ql" (String#16076, DoABC#2)
// _SafeStr_14416 = "_-3-E" (String#21471, DoABC#2)
// _SafeStr_14417 = "_-0SK" (String#15147, DoABC#2)
// memUsage = "_-1kZ" (String#18310, DoABC#2)
// memLimit = "_-si" (String#24388, DoABC#2)
// compress = "_-1hE" (String#18183, DoABC#2)
// increaseMemoryLimit = "_-0I3" (String#14760, DoABC#2)
// getBitmapData = "_-oI" (String#8681, DoABC#2)
// addBitmapData = "_-0B3" (String#14490, DoABC#2)
// BitmapDataCache = "_-zk" (String#8876, DoABC#2)
// ExtendedBitmapData = "_-11w" (String#4915, DoABC#2)
// BitmapDataCacheItem = "_-KT" (String#8091, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// removeItem = "_-2gu" (String#6888, DoABC#2)


