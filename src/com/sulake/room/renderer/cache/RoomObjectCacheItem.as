
package com.sulake.room.renderer.cache
{
    public class RoomObjectCacheItem 
    {

        private var _location:RoomObjectLocationCacheItem = null;
        private var _sprites:RoomObjectSortableSpriteCacheItem = null;

        public function RoomObjectCacheItem(_arg_1:String)
        {
            this._location = new RoomObjectLocationCacheItem(_arg_1);
            this._sprites = new RoomObjectSortableSpriteCacheItem();
        }
        public function get location():RoomObjectLocationCacheItem
        {
            return (this._location);
        }
        public function get sprites():RoomObjectSortableSpriteCacheItem
        {
            return (this._sprites);
        }
        public function dispose():void
        {
            if (this._location != null){
                this._location.dispose();
                this._location = null;
            };
            if (this._sprites != null){
                this._sprites.dispose();
                this._sprites = null;
            };
        }

    }
}//package com.sulake.room.renderer.cache

// sprites = "_-hQ" (String#23946, DoABC#2)
// RoomObjectCacheItem = "_-1Au" (String#5091, DoABC#2)
// RoomObjectLocationCacheItem = "_-2gl" (String#6886, DoABC#2)
// RoomObjectSortableSpriteCacheItem = "_-Sj" (String#8261, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)
// _sprites = "_-2vJ" (String#455, DoABC#2)


