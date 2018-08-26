
package com.sulake.core.assets.loaders
{
    import flash.events.Event;

    public class AssetLoaderEvent extends Event 
    {

        public static const ASSET_LOADER_EVENT_COMPLETE:String = "AssetLoaderEventComplete";
        public static const _SafeStr_7409:String = "AssetLoaderEventProgress";
        public static const _SafeStr_7407:String = "AssetLoaderEventUnload";
        public static const _SafeStr_7406:String = "AssetLoaderEventStatus";
        public static const _SafeStr_4221:String = "AssetLoaderEventError";
        public static const _SafeStr_7408:String = "AssetLoaderEventOpen";

        private var _status:int;

        public function AssetLoaderEvent(_arg_1:String, _arg_2:int)
        {
            this._status = _arg_2;
            super(_arg_1, false, false);
        }
        public function get status():int
        {
            return (this._status);
        }
        override public function clone():Event
        {
            return (new AssetLoaderEvent(type, this._status));
        }
        override public function toString():String
        {
            return (formatToString("AssetLoaderEvent", "type", "status"));
        }

    }
}//package com.sulake.core.assets.loaders

// _status = "_-0kS" (String#126, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// _SafeStr_7406 = "_-2p3" (String#21044, DoABC#2)
// _SafeStr_7407 = "_-2Dr" (String#19562, DoABC#2)
// _SafeStr_7408 = "_-3F-" (String#22076, DoABC#2)
// _SafeStr_7409 = "_-2JT" (String#19788, DoABC#2)


