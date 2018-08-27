
package com.sulake.core.utils
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;

    public class LibraryLoaderQueue extends EventDispatcher implements IDisposable 
    {

        protected static const _SafeStr_9017:int = 4;

        private var _debug:Boolean = false;
        private var _SafeStr_8771:Array;
        private var _SafeStr_8954:Array;

        public function LibraryLoaderQueue(_arg_1:Boolean=false)
        {
            this._SafeStr_8771 = new Array();
            this._SafeStr_8954 = new Array();
            this._debug = _arg_1;
            super();
        }
        public function get length():int
        {
            return ((this._SafeStr_8771.length + this._SafeStr_8954.length));
        }
        override public function dispose():void
        {
            var _local_1:LibraryLoader;
            if (!disposed){
                for each (_local_1 in this._SafeStr_8954) {
                    _local_1.dispose();
                };
                for each (_local_1 in this._SafeStr_8771) {
                    _local_1.dispose();
                };
                this._SafeStr_8954 = null;
                this._SafeStr_8771 = null;
                super.dispose();
            };
        }
        public function push(_arg_1:LibraryLoader):void
        {
            if (((((!(disposed)) && (!(this.isUrlInQueue(_arg_1.url))))) && (!(this.findLibraryLoaderByURL(_arg_1.url))))){
                if (_arg_1.paused){
                    this._SafeStr_8771.push(_arg_1);
                }
                else {
                    this._SafeStr_8954.push(_arg_1);
                };
                _arg_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                _arg_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadProgressHandler);
                _arg_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DISPOSE, this.loaderDisposeHandler);
                _arg_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                this.next();
            };
        }
        private function next():void
        {
            var _local_1:LibraryLoader;
            if (!disposed){
                while ((((this._SafeStr_8954.length < _SafeStr_9017)) && ((this._SafeStr_8771.length > 0)))) {
                    _local_1 = this._SafeStr_8771.shift();
                    this._SafeStr_8954.push(_local_1);
                    _local_1.final();
                };
            };
        }
        private function libraryLoadedHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            if (_local_2){
                this.removeLoader(_local_2);
            };
            this.next();
        }
        private function loadProgressHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
        }
        private function loaderDisposeHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            this.removeLoader(_local_2);
            this.next();
        }
        private function loadErrorHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            if (_local_2){
                Logger.log(("Failed to download  specified file: " + _local_2.url));
                this.removeLoader(_local_2);
            };
            this.next();
        }
        private function removeLoader(loader:LibraryLoader):void
        {
            var index:int;
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadProgressHandler);
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DISPOSE, this.loaderDisposeHandler);
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
            try {
                index = this._SafeStr_8771.indexOf(loader);
                if (index > -1){
                    this._SafeStr_8771.splice(index, 1);
                };
                index = this._SafeStr_8954.indexOf(loader);
                if (index > -1){
                    this._SafeStr_8954.splice(index, 1);
                };
            }
            catch(e:Error) {
                Logger.log("LibraryLoaderQueue was propably disposed!");
            };
        }
        private function isUrlInQueue(_arg_1:String, _arg_2:Boolean=true):Boolean
        {
            var _local_3:LibraryLoader;
            if (!disposed){
                if (((_arg_2) && ((_arg_1.indexOf("?") > -1)))){
                    _arg_1 = _arg_1.slice(0, _arg_1.indexOf("?"));
                };
                for each (_local_3 in this._SafeStr_8771) {
                    if (_arg_2){
                        if (_local_3.url.indexOf(_arg_1) == 0){
                            return (true);
                        };
                    }
                    else {
                        if (_local_3.url == _arg_1){
                            return (true);
                        };
                    };
                };
            };
            return (false);
        }
        public function findLibraryLoaderByURL(_arg_1:String, _arg_2:Boolean=true):LibraryLoader
        {
            var _local_3:LibraryLoader;
            if (!disposed){
                if (((_arg_2) && ((_arg_1.indexOf("?") > -1)))){
                    _arg_1 = _arg_1.slice(0, _arg_1.indexOf("?"));
                };
                for each (_local_3 in this._SafeStr_8954) {
                    if (_arg_2){
                        if (_local_3.url.indexOf(_arg_1) == 0){
                            return (_local_3);
                        };
                    }
                    else {
                        if (_local_3.url == _arg_1){
                            return (_local_3);
                        };
                    };
                };
            };
            return (null);
        }

    }
}//package com.sulake.core.utils

// LibraryLoaderQueue = "_-00R" (String#14071, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// _SafeStr_8771 = "_-13w" (String#4953, DoABC#2)
// libraryLoadedHandler = "_-0GL" (String#3878, DoABC#2)
// loadErrorHandler = "_-0IT" (String#1448, DoABC#2)
// _SafeStr_8954 = "_-3CG" (String#2020, DoABC#2)
// _SafeStr_9017 = "_-aZ" (String#2134, DoABC#2)
// findLibraryLoaderByURL = "_-08i" (String#14394, DoABC#2)
// isUrlInQueue = "_-0Ss" (String#15165, DoABC#2)
// paused = "_-1WA" (String#17749, DoABC#2)
// loadProgressHandler = "_-2Fz" (String#19642, DoABC#2)
// loaderDisposeHandler = "_-0Z3" (String#15405, DoABC#2)
// removeLoader = "_-1II" (String#17206, DoABC#2)


