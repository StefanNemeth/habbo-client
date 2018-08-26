
package com.sulake.habbo.avatar.cache
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.actions.IActiveActionData;

    public class AvatarImageBodyPartCache 
    {

        private var _SafeStr_7920:Map;
        private var _SafeStr_7984:IActiveActionData;
        private var _SafeStr_7985:int;
        private var _disposed:Boolean;

        public function AvatarImageBodyPartCache()
        {
            this._SafeStr_7920 = new Map();
        }
        public function setAction(_arg_1:IActiveActionData, _arg_2:int):void
        {
            if (this._SafeStr_7984 == null){
                this._SafeStr_7984 = _arg_1;
            };
            var _local_3:AvatarImageActionCache = this.getActionCache(this._SafeStr_7984);
            if (_local_3 != null){
                _local_3.setLastAccessTime(_arg_2);
            };
            this._SafeStr_7984 = _arg_1;
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._SafeStr_7920 == null){
                    return;
                };
                Logger.log("[dispose]");
                if (this._SafeStr_7920){
                    this.disposeActions(0, int.MAX_VALUE);
                    this._SafeStr_7920.dispose();
                    this._SafeStr_7920 = null;
                };
                this._disposed = true;
            };
        }
        public function disposeActions(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:AvatarImageActionCache;
            var _local_6:String;
            if ((((this._SafeStr_7920 == null)) || (this._disposed))){
                return;
            };
            var _local_5:Array = this._SafeStr_7920.getKeys();
            for each (_local_6 in _local_5) {
                _local_4 = (this._SafeStr_7920.getValue(_local_6) as AvatarImageActionCache);
                if (_local_4 != null){
                    _local_3 = _local_4.getLastAccessTime();
                    if ((_arg_2 - _local_3) >= _arg_1){
                        Logger.log((("[Disposing inactive: " + _local_6) + "]"));
                        _local_4.dispose();
                        this._SafeStr_7920.remove(_local_6);
                    };
                };
            };
        }
        public function getAction():IActiveActionData
        {
            return (this._SafeStr_7984);
        }
        public function setDirection(_arg_1:int):void
        {
            this._SafeStr_7985 = _arg_1;
        }
        public function getDirection():int
        {
            return (this._SafeStr_7985);
        }
        public function getActionCache(_arg_1:IActiveActionData=null):AvatarImageActionCache
        {
            if (!this._SafeStr_7984){
                return (null);
            };
            if (_arg_1 == null){
                _arg_1 = this._SafeStr_7984;
            };
            return ((this._SafeStr_7920.getValue(_arg_1.id) as AvatarImageActionCache));
        }
        public function updateActionCache(_arg_1:IActiveActionData, _arg_2:AvatarImageActionCache):void
        {
            this._SafeStr_7920.add(_arg_1.id, _arg_2);
        }
        private function debugInfo(_arg_1:String):void
        {
        }

    }
}//package com.sulake.habbo.avatar.cache

// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// AvatarImageBodyPartCache = "_-2Jz" (String#6441, DoABC#2)
// AvatarImageActionCache = "_-wn" (String#8822, DoABC#2)
// _SafeStr_7920 = "_-Fe" (String#636, DoABC#2)
// disposeActions = "_-04s" (String#14236, DoABC#2)
// setAction = "_-1lS" (String#18350, DoABC#2)
// getAction = "_-e3" (String#23805, DoABC#2)
// getActionCache = "_-1EO" (String#17042, DoABC#2)
// updateActionCache = "_-1rM" (String#18598, DoABC#2)
// debugInfo = "_-3g" (String#924, DoABC#2)
// _SafeStr_7984 = "_-ch" (String#23741, DoABC#2)
// _SafeStr_7985 = "_-22E" (String#19100, DoABC#2)
// setLastAccessTime = "_-0lF" (String#15874, DoABC#2)
// getLastAccessTime = "_-0Vn" (String#15270, DoABC#2)


