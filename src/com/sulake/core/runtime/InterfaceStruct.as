
package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.getQualifiedClassName;

    final class InterfaceStruct implements IDisposable 
    {

        private var _iid:IID;
        private var _iis:String;
        private var _unknown:IUnknown;
        private var _references:uint;

        public function InterfaceStruct(_arg_1:IID, _arg_2:IUnknown)
        {
            this._iid = _arg_1;
            this._iis = getQualifiedClassName(this._iid);
            this._unknown = _arg_2;
            this._references = 0;
        }
        public function get iid():IID
        {
            return (this._iid);
        }
        public function get iis():String
        {
            return (this._iis);
        }
        public function get unknown():IUnknown
        {
            return (this._unknown);
        }
        public function get references():uint
        {
            return (this._references);
        }
        public function get disposed():Boolean
        {
            return ((this._unknown == null));
        }
        public function dispose():void
        {
            this._iid = null;
            this._iis = null;
            this._unknown = null;
            this._references = 0;
        }
        public function reserve():uint
        {
            return (++this._references);
        }
        public function release():uint
        {
            return ((((this.references)>0) ? --this._references : 0));
        }

    }
}//package com.sulake.core.runtime

// IID = "_-3KV" (String#7712, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// InterfaceStruct = "_-2vc" (String#7189, DoABC#2)
// _unknown = "_-14" (String#4956, DoABC#2)
// iis = "_-2RW" (String#20099, DoABC#2)
// references = "_-1yb" (String#18912, DoABC#2)
// _references = "_-02V" (String#3617, DoABC#2)
// reserve = "_-k-" (String#24033, DoABC#2)
// _iid = "_-xo" (String#24605, DoABC#2)
// _iis = "_-jA" (String#24005, DoABC#2)


