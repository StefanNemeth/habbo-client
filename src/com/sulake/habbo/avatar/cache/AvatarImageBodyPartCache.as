
package com.sulake.habbo.avatar.cache
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.actions.IActiveActionData;

    public class AvatarImageBodyPartCache 
    {

        private var _cache:Map;
        private var _action:IActiveActionData;
        private var _direction:int;
        private var _disposed:Boolean;

        public function AvatarImageBodyPartCache()
        {
            this._cache = new Map();
        }
        public function setAction(_arg_1:IActiveActionData, _arg_2:int):void
        {
            if (this._action == null){
                this._action = _arg_1;
            };
            var _local_3:AvatarImageActionCache = this.getActionCache(this._action);
            if (_local_3 != null){
                _local_3.setLastAccessTime(_arg_2);
            };
            this._action = _arg_1;
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._cache == null){
                    return;
                };
                Logger.log("[dispose]");
                if (this._cache){
                    this.disposeActions(0, int.MAX_VALUE);
                    this._cache.dispose();
                    this._cache = null;
                };
                this._disposed = true;
            };
        }
        public function disposeActions(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:AvatarImageActionCache;
            var _local_6:String;
            if ((((this._cache == null)) || (this._disposed))){
                return;
            };
            var _local_5:Array = this._cache.getKeys();
            for each (_local_6 in _local_5) {
                _local_4 = (this._cache.getValue(_local_6) as AvatarImageActionCache);
                if (_local_4 != null){
                    _local_3 = _local_4.getLastAccessTime();
                    if ((_arg_2 - _local_3) >= _arg_1){
                        Logger.log((("[Disposing inactive: " + _local_6) + "]"));
                        _local_4.dispose();
                        this._cache.remove(_local_6);
                    };
                };
            };
        }
        public function getAction():IActiveActionData
        {
            return (this._action);
        }
        public function setDirection(_arg_1:int):void
        {
            this._direction = _arg_1;
        }
        public function getDirection():int
        {
            return (this._direction);
        }
        public function getActionCache(_arg_1:IActiveActionData=null):AvatarImageActionCache
        {
            if (!this._action){
                return (null);
            };
            if (_arg_1 == null){
                _arg_1 = this._action;
            };
            return ((this._cache.getValue(_arg_1.id) as AvatarImageActionCache));
        }
        public function updateActionCache(_arg_1:IActiveActionData, _arg_2:AvatarImageActionCache):void
        {
            this._cache.add(_arg_1.id, _arg_2);
        }
        private function debugInfo(_arg_1:String):void
        {
        }

    }
}//package com.sulake.habbo.avatar.cache

// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// AvatarImageBodyPartCache = "_-2Jz" (String#6441, DoABC#2)
// AvatarImageActionCache = "_-wn" (String#8822, DoABC#2)
// _cache = "_-Fe" (String#636, DoABC#2)
// disposeActions = "_-04s" (String#14236, DoABC#2)
// setAction = "_-1lS" (String#18350, DoABC#2)
// getAction = "_-e3" (String#23805, DoABC#2)
// getActionCache = "_-1EO" (String#17042, DoABC#2)
// updateActionCache = "_-1rM" (String#18598, DoABC#2)
// debugInfo = "_-3g" (String#924, DoABC#2)
// _action = "_-ch" (String#23741, DoABC#2)
// _direction = "_-22E" (String#19100, DoABC#2)
// setLastAccessTime = "_-0lF" (String#15874, DoABC#2)
// getLastAccessTime = "_-0Vn" (String#15270, DoABC#2)


