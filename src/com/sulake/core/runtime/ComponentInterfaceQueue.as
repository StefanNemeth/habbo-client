
package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;

    class ComponentInterfaceQueue implements IDisposable 
    {

        private var _identifier:IID;
        private var _disposed:Boolean;
        private var _receivers:Array;

        public function ComponentInterfaceQueue(_arg_1:IID)
        {
            this._identifier = _arg_1;
            this._receivers = new Array();
            this._disposed = false;
        }
        public function get identifier():IID
        {
            return (this._identifier);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get receivers():Array
        {
            return (this._receivers);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
                this._identifier = null;
                while (this._receivers.length > 0) {
                    this._receivers.pop();
                };
                this._receivers = null;
            };
        }

    }
}//package com.sulake.core.runtime

// IID = "_-3KV" (String#7712, DoABC#2)
// ComponentInterfaceQueue = "_-Ou" (String#8183, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _identifier = "_-1Ax" (String#1628, DoABC#2)
// _receivers = "_-2Az" (String#19442, DoABC#2)


