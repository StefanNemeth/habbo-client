
package com.sulake.core.assets
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.Core;

    public class LazyAssetProcessor implements IUpdateReceiver 
    {

        private var _SafeStr_8771:Array;
        private var _running:Boolean = false;
        private var _disposed:Boolean = false;

        public function LazyAssetProcessor()
        {
            this._SafeStr_8771 = new Array();
            super();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                Core.instance.removeUpdateReceiver(this);
                this._SafeStr_8771 = null;
                this._running = false;
                this._disposed = true;
            };
        }
        public function push(_arg_1:ILazyAsset):void
        {
            if (_arg_1){
                this._SafeStr_8771.push(_arg_1);
                if (!this._running){
                    Core.instance.registerUpdateReceiver(this, 2);
                    this._running = true;
                };
            };
        }
        public function flush():void
        {
            var _local_1:ILazyAsset;
            for each (_local_1 in this._SafeStr_8771) {
                if (!_local_1.disposed){
                    _local_1.prepareLazyContent();
                };
            };
            this._SafeStr_8771 = new Array();
            if (this._running){
                Core.instance.removeUpdateReceiver(this);
                this._running = false;
            };
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:ILazyAsset = this._SafeStr_8771.shift();
            if (!_local_2){
                if (this._running){
                    Core.instance.removeUpdateReceiver(this);
                    this._running = false;
                };
            }
            else {
                if (!_local_2.disposed){
                    _local_2.prepareLazyContent();
                };
            };
        }

    }
}//package com.sulake.core.assets

// ILazyAsset = "_-0Yb" (String#4275, DoABC#2)
// LazyAssetProcessor = "_-K2" (String#23007, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// _running = "_-00c" (String#353, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// prepareLazyContent = "_-2p2" (String#7059, DoABC#2)
// _SafeStr_8771 = "_-13w" (String#4953, DoABC#2)
// instance = "_-1iT" (String#18226, DoABC#2)


