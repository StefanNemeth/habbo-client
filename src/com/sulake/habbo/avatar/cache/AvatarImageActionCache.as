
package com.sulake.habbo.avatar.cache
{
    import com.sulake.core.utils.Map;
    import flash.utils.getTimer;

    public class AvatarImageActionCache 
    {

        private var _cache:Map;
        private var _lastAccessTime:int;

        public function AvatarImageActionCache()
        {
            this._cache = new Map();
            this.setLastAccessTime(getTimer());
        }
        public function dispose():void
        {
            var _local_1:AvatarImageDirectionCache;
            this.debugInfo("[dispose]");
            if (this._cache == null){
                return;
            };
            for each (_local_1 in this._cache) {
                _local_1.dispose();
            };
            this._cache.dispose();
        }
        public function getDirectionCache(_arg_1:int):AvatarImageDirectionCache
        {
            var _local_2:String = _arg_1.toString();
            return ((this._cache.getValue(_local_2) as AvatarImageDirectionCache));
        }
        public function updateDirectionCache(_arg_1:int, _arg_2:AvatarImageDirectionCache):void
        {
            var _local_3:String = _arg_1.toString();
            this._cache.add(_local_3, _arg_2);
        }
        public function setLastAccessTime(_arg_1:int):void
        {
            this._lastAccessTime = _arg_1;
        }
        public function getLastAccessTime():int
        {
            return (this._lastAccessTime);
        }
        private function debugInfo(_arg_1:String):void
        {
        }

    }
}//package com.sulake.habbo.avatar.cache

// AvatarImageDirectionCache = "_-Qp" (String#8223, DoABC#2)
// AvatarImageActionCache = "_-wn" (String#8822, DoABC#2)
// _cache = "_-Fe" (String#636, DoABC#2)
// getDirectionCache = "_-K0" (String#23006, DoABC#2)
// updateDirectionCache = "_-0ew" (String#15624, DoABC#2)
// debugInfo = "_-3g" (String#924, DoABC#2)
// setLastAccessTime = "_-0lF" (String#15874, DoABC#2)
// getLastAccessTime = "_-0Vn" (String#15270, DoABC#2)
// _lastAccessTime = "_-2NG" (String#19934, DoABC#2)


