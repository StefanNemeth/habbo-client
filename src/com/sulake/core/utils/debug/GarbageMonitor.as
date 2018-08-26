
package com.sulake.core.utils.debug
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;

    public class GarbageMonitor implements IDisposable 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_8602:Dictionary;

        public function GarbageMonitor()
        {
            this._SafeStr_8602 = new Dictionary(true);
        }
        public function dispose():void
        {
            var _local_1:*;
            if (!this._disposed){
                for each (_local_1 in this._SafeStr_8602) {
                    delete this._SafeStr_8602[_local_1];
                };
                this._SafeStr_8602 = null;
                this._disposed = true;
            };
        }
        public function insert(_arg_1:Object, _arg_2:String=null):void
        {
            this._SafeStr_8602[_arg_1] = (((_arg_2 == null)) ? _arg_1.toString() : _arg_2);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get list():Array
        {
            var _local_2:*;
            var _local_1:Array = new Array();
            for each (_local_2 in this._SafeStr_8602) {
                _local_1.push(_local_2);
            };
            return (_local_1);
        }

    }
}//package com.sulake.core.utils.debug

// GarbageMonitor = "_-04w" (String#3664, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_8602 = "_-2ke" (String#20870, DoABC#2)


