
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.Core;
    import flash.events.Event;

    public class AvatarAssetDownloadLibrary extends EventDispatcher 
    {

        private static var _SafeStr_10168:int = 0;
        private static var _SafeStr_10169:int = 1;
        private static var _SafeStr_5891:int = 2;

        private var _state:int;
        private var _libraryName:String;
        private var _revision:String;
        private var _SafeStr_10171:String;
        private var _assets:IAssetLibrary;

        public function AvatarAssetDownloadLibrary(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:IAssetLibrary)
        {
            this._state = _SafeStr_10168;
            this._assets = _arg_4;
            this._libraryName = String(_arg_1);
            this._revision = String(_arg_2);
            this._SafeStr_10171 = ((_arg_3 + this._libraryName) + ".swf");
            this._SafeStr_10171 = this._SafeStr_10171.replace("%revision%", this._revision);
            var _local_5:AssetLibraryCollection = (this._assets as AssetLibraryCollection);
            var _local_6:IAssetLibrary = _local_5.getAssetLibraryByUrl((this._libraryName + ".swf"));
            if (_local_6 != null){
                Logger.log(("[AvatarAssetDownloadLibrary] Already Downloaded by Core: " + this._libraryName));
                this._state = _SafeStr_5891;
            };
        }
        override public function dispose():void
        {
            super.dispose();
        }
        public function startDownloading():void
        {
            this._state = _SafeStr_10169;
            var _local_1:URLRequest = new URLRequest(this._SafeStr_10171);
            var _local_2:LibraryLoader = new LibraryLoader();
            this._assets.loadFromFile(_local_2, true);
            _local_2.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _local_2.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onLoaderError);
            _local_2.load(_local_1);
        }
        private function onLoaderError(_arg_1:Event):void
        {
            Core.error(((("Could not load avatar asset library " + this._libraryName) + " from URL ") + this._SafeStr_10171), false, Core._SafeStr_8936);
        }
        private function onLoaderComplete(_arg_1:Event):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onLoaderError);
            this._state = _SafeStr_5891;
            dispatchEvent(new Event(Event.COMPLETE));
        }
        public function get libraryName():String
        {
            return (this._libraryName);
        }
        public function get isReady():Boolean
        {
            return ((this._state == _SafeStr_5891));
        }
        public function toString():String
        {
            var _local_1:String = this._libraryName;
            return ((_local_1 + ((this.isReady) ? "[x]" : "[ ]")));
        }

    }
}//package com.sulake.habbo.avatar

// onLoaderComplete = "_-1gp" (String#5681, DoABC#2)
// libraryName = "_-3DA" (String#22002, DoABC#2)
// startDownloading = "_-vP" (String#24506, DoABC#2)
// _SafeStr_10168 = "_-32Y" (String#7359, DoABC#2)
// _SafeStr_10169 = "_-1Yr" (String#17845, DoABC#2)
// _libraryName = "_-2hF" (String#20739, DoABC#2)
// _SafeStr_10171 = "_-0QI" (String#15075, DoABC#2)
// onLoaderError = "_-bd" (String#23697, DoABC#2)
// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// AvatarAssetDownloadLibrary = "_-1wv" (String#5970, DoABC#2)
// _SafeStr_5891 = "_-1Ny" (String#852, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// isReady = "_-2Wr" (String#6698, DoABC#2)
// getAssetLibraryByUrl = "_-2Cf" (String#19511, DoABC#2)
// _SafeStr_8936 = "_-Y9" (String#23568, DoABC#2)


