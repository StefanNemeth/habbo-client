
package com.sulake.core.assets.loaders
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.events.HTTPStatusEvent;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;

    class AssetLoaderEventBroker extends EventDispatcher implements IDisposable 
    {

        public static const NONE:uint = 0;
        public static const IO_ERROR:uint = 1;
        public static const SECURITY_ERROR:uint = 2;

        protected var _status:int = 0;
        protected var _SafeStr_7404:int = 0;
        protected var _SafeStr_7405:int = 2;
        protected var _errorCode:uint = 0;

        public function get errorCode():uint
        {
            return (this._errorCode);
        }
        protected function loadEventHandler(_arg_1:Event):void
        {
            switch (_arg_1.type){
                case HTTPStatusEvent.HTTP_STATUS:
                    this._status = HTTPStatusEvent(_arg_1).status;
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent._SafeStr_7406, this._status));
                    return;
                case Event.COMPLETE:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this._status));
                    return;
                case Event.UNLOAD:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent._SafeStr_7407, this._status));
                    return;
                case Event.OPEN:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent._SafeStr_7408, this._status));
                    return;
                case ProgressEvent.PROGRESS:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent._SafeStr_7409, this._status));
                    return;
                case IOErrorEvent.IO_ERROR:
                    this._errorCode = IO_ERROR;
                    if (!this.LibraryLoader()){
                        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent._SafeStr_4221, this._status));
                    };
                    return;
                case SecurityErrorEvent.SECURITY_ERROR:
                    this._errorCode = SECURITY_ERROR;
                    if (!this.LibraryLoader()){
                        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent._SafeStr_4221, this._status));
                    };
                    return;
                default:
                    Logger.log((("Unknown asset loader event! AssetLoaderEventBroker::loadEventHandler(" + _arg_1) + ")"));
            };
        }
        protected function LibraryLoader():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.core.assets.loaders

// AssetLoaderEventBroker = "_-1Da" (String#5137, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// _SafeStr_7404 = "_-291" (String#19368, DoABC#2)
// _SafeStr_7405 = "_-Wu" (String#23519, DoABC#2)
// _SafeStr_7406 = "_-2p3" (String#21044, DoABC#2)
// _SafeStr_7407 = "_-2Dr" (String#19562, DoABC#2)
// _SafeStr_7408 = "_-3F-" (String#22076, DoABC#2)
// _SafeStr_7409 = "_-2JT" (String#19788, DoABC#2)
// LibraryLoader = "_-0Ol" (String#816, DoABC#2)


