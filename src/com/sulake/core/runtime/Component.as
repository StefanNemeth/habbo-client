
package com.sulake.core.runtime
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.core.runtime.exceptions.InvalidComponentException;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.exceptions.ComponentDisposedException;
    import flash.utils.getQualifiedClassName;
    import flash.events.Event;
    import com.sulake.core.runtime.events.LockEvent;

    public class Component implements IUnknown 
    {

        public static const COMPONENT_EVENT_RUNNING:String = "COMPONENT_EVENT_RUNNING";
        public static const COMPONENT_EVENT_DISPOSING:String = "COMPONENT_EVENT_DISPOSING";
        public static const COMPONENT_EVENT_WARNING:String = "COMPONENT_EVENT_WARNING";
        public static const COMPONENT_EVENT_ERROR:String = "COMPONENT_EVENT_ERROR";
        public static const COMPONENT_EVENT_DEBUG:String = "COMPONENT_EVENT_DEBUG";
        protected static const _INTERNAL_EVENT_UNLOCKED:String = "_INTERNAL_EVENT_UNLOCKED";
        public static const COMPONENT_FLAG_NULL:uint = 0;
        public static const _SafeStr_8978:uint = 1;
        public static const COMPONENT_FLAG_CONTEXT:uint = 2;
        public static const _SafeStr_8979:uint = 4;

        protected var _references:uint = 0;
        protected var _lastError:String = "";
        protected var _SafeStr_8955:String = "";
        protected var _lastWarning:String = "";
        private var _assets:IAssetLibrary;
        private var _events:EventDispatcher;
        private var _SafeStr_8916:uint;
        private var _SafeStr_8981:InterfaceStructList;
        private var _context:IContext = null;
        private var _disposed:Boolean = false;
        private var _locked:Boolean = false;

        public function Component(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._SafeStr_8916 = _arg_2;
            this._SafeStr_8981 = new InterfaceStructList();
            this._events = new EventDispatcher();
            this._context = _arg_1;
            this._assets = (((_arg_3)!=null) ? _arg_3 : new AssetLibrary("_internal_asset_library"));
            if (this._context == null){
                throw (new InvalidComponentException("IContext not provided to Component's constructor!"));
            };
        }
        public static function getInterfaceStructList(_arg_1:Component):InterfaceStructList
        {
            return (_arg_1._SafeStr_8981);
        }

        public function get locked():Boolean
        {
            return (this._locked);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get context():IContext
        {
            return (this._context);
        }
        public function get events():IEventDispatcher
        {
            return (this._events);
        }
        public function get assets():IAssetLibrary
        {
            return (this._assets);
        }
        public function queueInterface(_arg_1:IID, _arg_2:Function=null):IUnknown
        {
            var _local_3:InterfaceStruct = this._SafeStr_8981.getStructByInterface(_arg_1);
            if (_local_3 == null){
                return (this._context.queueInterface(_arg_1, _arg_2));
            };
            if (this._disposed){
                throw (new ComponentDisposedException((('Failed to queue interface trough disposed Component "' + getQualifiedClassName(this)) + '"!')));
            };
            if (this._locked){
                return (null);
            };
            _local_3.reserve();
            var _local_4:IUnknown = (_local_3.unknown as IUnknown);
            if (_arg_2 != null){
                (_arg_2(_arg_1, _local_4));
            };
            return (_local_4);
        }
        public function release(_arg_1:IID):uint
        {
            if (this._disposed){
                return (0);
            };
            var _local_2:InterfaceStruct = this._SafeStr_8981.getStructByInterface(_arg_1);
            if (_local_2 == null){
                this._lastError = (("Attempting to release unknown interface:" + _arg_1) + "!");
                throw (new Error(this._lastError));
            };
            var _local_3:uint = _local_2.release();
            if ((this._SafeStr_8916 & _SafeStr_8979)){
                if (_local_3 == 0){
                    if (this._SafeStr_8981.getTotalReferenceCount() == 0){
                        this._context.detachComponent(this);
                        this.dispose();
                    };
                };
            };
            return (_local_3);
        }
        public function dispose():void
        {
            if (!this._disposed){
                Logger.log(("Disposing component " + getQualifiedClassName(this)));
                this._events.dispatchEvent(new Event(Component.COMPONENT_EVENT_DISPOSING));
                this._events = null;
                this._SafeStr_8981.dispose();
                this._SafeStr_8981 = null;
                this._assets.dispose();
                this._assets = null;
                this._context = null;
                this._references = 0;
                this._disposed = true;
            };
        }
        final protected function lock():void
        {
            if (!this._locked){
                this._locked = true;
            };
        }
        final protected function unlock():void
        {
            if (this._locked){
                this._locked = false;
                this._events.dispatchEvent(new LockEvent(_INTERNAL_EVENT_UNLOCKED, this));
            };
        }
        public function toString():String
        {
            return ((((("[component " + getQualifiedClassName(this)) + " refs: ") + this._references) + "]"));
        }
        public function toXMLString(_arg_1:uint=0):String
        {
            var _local_6:InterfaceStruct;
            var _local_2:String = "";
            var _local_3:uint;
            while (_local_3 < _arg_1) {
                _local_2 = (_local_2 + "\t");
                _local_3++;
            };
            var _local_4:String = getQualifiedClassName(this);
            var _local_5:String = "";
            _local_5 = (_local_5 + (((_local_2 + '<component class="') + _local_4) + '">\n'));
            var _local_7:uint = this._SafeStr_8981.length;
            var _local_8:uint;
            while (_local_8 < _local_7) {
                _local_6 = this._SafeStr_8981.getStructByIndex(_local_8);
                _local_5 = (_local_5 + (((((_local_2 + '\t<interface iid="') + _local_6.iis) + '" refs="') + _local_6.references) + '"/>\n'));
                _local_8++;
            };
            return ((_local_5 + (_local_2 + "</component>\n")));
        }
        public function registerUpdateReceiver(_arg_1:IUpdateReceiver, _arg_2:uint):void
        {
            if (!this._disposed){
                this._context.registerUpdateReceiver(_arg_1, _arg_2);
            };
        }
        public function removeUpdateReceiver(_arg_1:IUpdateReceiver):void
        {
            if (!this._disposed){
                this._context.removeUpdateReceiver(_arg_1);
            };
        }

    }
}//package com.sulake.core.runtime

// IID = "_-3KV" (String#7712, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// LockEvent = "_-4a" (String#22400, DoABC#2)
// InvalidComponentException = "_-QL" (String#8208, DoABC#2)
// InterfaceStructList = "_-0ur" (String#16233, DoABC#2)
// InterfaceStruct = "_-2vc" (String#7189, DoABC#2)
// ComponentDisposedException = "_-CC" (String#7918, DoABC#2)
// _SafeStr_8916 = "_-27n" (String#877, DoABC#2)
// detachComponent = "_-28T" (String#6212, DoABC#2)
// _SafeStr_8955 = "_-0qy" (String#16083, DoABC#2)
// _lastError = "_-0NR" (String#4029, DoABC#2)
// getInterfaceStructList = "_-1xl" (String#18879, DoABC#2)
// _INTERNAL_EVENT_UNLOCKED = "_-1Ik" (String#17224, DoABC#2)
// iis = "_-2RW" (String#20099, DoABC#2)
// references = "_-1yb" (String#18912, DoABC#2)
// _SafeStr_8978 = "_-1GA" (String#17122, DoABC#2)
// _SafeStr_8979 = "_-0-o" (String#14046, DoABC#2)
// _references = "_-02V" (String#3617, DoABC#2)
// _SafeStr_8981 = "_-3EA" (String#22041, DoABC#2)
// _locked = "_-2vv" (String#902, DoABC#2)
// reserve = "_-k-" (String#24033, DoABC#2)
// getTotalReferenceCount = "_-2A5" (String#19408, DoABC#2)
// getStructByIndex = "_-1BO" (String#16913, DoABC#2)


