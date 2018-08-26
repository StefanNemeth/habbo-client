
package com.sulake.room.renderer.cache
{
    import com.sulake.room.renderer.utils.SortableSprite;

    public class RoomObjectSortableSpriteCacheItem 
    {

        private var _sprites:Array;
        private var _SafeStr_14432:int = -1;
        private var _SafeStr_14433:int = -1;
        private var _isEmpty:Boolean = false;

        public function RoomObjectSortableSpriteCacheItem()
        {
            this._sprites = [];
            super();
        }
        public function get spriteCount():int
        {
            return (this._sprites.length);
        }
        public function get isEmpty():Boolean
        {
            return (this._isEmpty);
        }
        public function dispose():void
        {
            this.setSpriteCount(0);
        }
        public function addSprite(_arg_1:SortableSprite):void
        {
            this._sprites.push(_arg_1);
        }
        public function getSprite(_arg_1:int):SortableSprite
        {
            return (this._sprites[_arg_1]);
        }
        public function ExtendedSprite(_arg_1:int, _arg_2:int):Boolean
        {
            if (((!((_arg_1 == this._SafeStr_14432))) || (!((_arg_2 == this._SafeStr_14433))))){
                this._SafeStr_14432 = _arg_1;
                this._SafeStr_14433 = _arg_2;
                return (true);
            };
            return (false);
        }
        public function setSpriteCount(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:SortableSprite;
            if (_arg_1 < this._sprites.length){
                _local_2 = _arg_1;
                while (_local_2 < this._sprites.length) {
                    _local_3 = this.getSprite(_local_2);
                    if (_local_3){
                        _local_3.dispose();
                    };
                    _local_2++;
                };
                this._sprites.splice(_arg_1, (this._sprites.length - _arg_1));
            };
            if (this._sprites.length == 0){
                this._isEmpty = true;
            }
            else {
                this._isEmpty = false;
            };
        }

    }
}//package com.sulake.room.renderer.cache

// _SafeStr_14432 = "_-36l" (String#21756, DoABC#2)
// _SafeStr_14433 = "_-00B" (String#14061, DoABC#2)
// _isEmpty = "_-1sY" (String#18656, DoABC#2)
// setSpriteCount = "_-2V2" (String#20240, DoABC#2)
// addSprite = "_-1FI" (String#17085, DoABC#2)
// ExtendedSprite = "_-2cQ" (String#20541, DoABC#2)
// SortableSprite = "_-0J3" (String#3936, DoABC#2)
// RoomObjectSortableSpriteCacheItem = "_-Sj" (String#8261, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// _sprites = "_-2vJ" (String#455, DoABC#2)
// isEmpty = "_-01T" (String#3592, DoABC#2)


