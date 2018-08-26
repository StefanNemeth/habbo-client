
package com.sulake.room.renderer.cache
{
    import com.sulake.core.utils.Map;

    public class RoomObjectCache 
    {

        private var _data:Map = null;
        private var _roomObjectVariableAccurateZ:String = "";

        public function RoomObjectCache(_arg_1:String)
        {
            this._roomObjectVariableAccurateZ = _arg_1;
            this._data = new Map();
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:RoomObjectCacheItem;
            if (this._data != null){
                _local_1 = 0;
                while (_local_1 < this._data.length) {
                    _local_2 = (this._data.getWithIndex(_local_1) as RoomObjectCacheItem);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._data.dispose();
                this._data = null;
            };
        }
        public function getObjectCache(_arg_1:String):RoomObjectCacheItem
        {
            var _local_2:RoomObjectCacheItem = (this._data.getValue(_arg_1) as RoomObjectCacheItem);
            if (_local_2 == null){
                _local_2 = new RoomObjectCacheItem(this._roomObjectVariableAccurateZ);
                this._data.add(_arg_1, _local_2);
            };
            return (_local_2);
        }
        public function removeObjectCache(_arg_1:String):void
        {
            var _local_2:RoomObjectCacheItem = (this._data.remove(_arg_1) as RoomObjectCacheItem);
            if (_local_2 != null){
                _local_2.dispose();
            };
        }

    }
}//package com.sulake.room.renderer.cache

// getObjectCache = "_-36e" (String#21752, DoABC#2)
// removeObjectCache = "_-xS" (String#24588, DoABC#2)
// RoomObjectCacheItem = "_-1Au" (String#5091, DoABC#2)
// RoomObjectCache = "_-0fT" (String#4414, DoABC#2)


