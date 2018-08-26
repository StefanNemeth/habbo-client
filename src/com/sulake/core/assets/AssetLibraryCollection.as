
package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.utils.LibraryLoader;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class AssetLibraryCollection extends EventDispatcher implements IAssetLibrary 
    {

        protected var _SafeStr_8752:Array;
        protected var _SafeStr_8753:Array;
        protected var _loaderContext:LoaderContext;
        protected var _SafeStr_8754:AssetLibrary;
        protected var _manifest:XML;
        protected var _name:String;
        private var _SafeStr_4425:uint = 0;

        public function AssetLibraryCollection(_arg_1:String)
        {
            this._name = _arg_1;
            this._manifest = new XML();
            this._SafeStr_8752 = new Array();
            this._SafeStr_8753 = new Array();
            this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            this._SafeStr_8754 = new AssetLibrary(("lib-" + this._SafeStr_4425++));
            this._SafeStr_8752.push(this._SafeStr_8754);
        }
        public function get url():String
        {
            return ("");
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get isReady():Boolean
        {
            return ((this._SafeStr_8753.length == 0));
        }
        public function get numAssets():uint
        {
            return (this.getNumAssets());
        }
        public function get nameArray():Array
        {
            return (this.getAssetNameArray());
        }
        public function get manifest():XML
        {
            return (this._manifest);
        }
        public function get loaderContext():LoaderContext
        {
            return (this._loaderContext);
        }
        public function set loaderContext(_arg_1:LoaderContext):void
        {
            this._loaderContext = _arg_1;
        }
        public function loadFromFile(_arg_1:LibraryLoader, _arg_2:Boolean=false):void
        {
            if (this.loaderContext == null){
                this.loaderContext = this._loaderContext;
            };
            var _local_3:IAssetLibrary = new AssetLibrary(("lib-" + this._SafeStr_4425++));
            this._SafeStr_8753.push(_local_3);
            _local_3.loadFromFile(_arg_1, _arg_2);
            _arg_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadEventHandler);
            _arg_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadEventHandler);
            _arg_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadEventHandler);
        }
        public function loadFromResource(_arg_1:XML, _arg_2:Class):Boolean
        {
            return (this._SafeStr_8754.loadFromResource(_arg_1, _arg_2));
        }
        public function unload():void
        {
            while (this._SafeStr_8753.length > 0) {
                (this._SafeStr_8753.pop() as IAssetLibrary).dispose();
            };
            while (this._SafeStr_8752.length > 0) {
                (this._SafeStr_8752.pop() as IAssetLibrary).dispose();
            };
        }
        override public function dispose():void
        {
            var _local_1:uint;
            var _local_2:IAssetLibrary;
            var _local_3:uint;
            if (!disposed){
                super.dispose();
                _local_1 = this._SafeStr_8752.length;
                _local_3 = 0;
                while (_local_3 < _local_1) {
                    _local_2 = this._SafeStr_8752.pop();
                    _local_2.dispose();
                    _local_3++;
                };
            };
        }
        private function loadEventHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader;
            var _local_3:IAssetLibrary;
            var _local_4:uint;
            if (_arg_1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE){
                _local_2 = (_arg_1.target as LibraryLoader);
                _local_4 = 0;
                while (_local_4 < this._SafeStr_8753.length) {
                    _local_3 = (this._SafeStr_8753[_local_4] as IAssetLibrary);
                    if (_local_3.url == _local_2.url){
                        this._SafeStr_8753.splice(_local_4, 1);
                        break;
                    };
                    _local_4++;
                };
                this._SafeStr_8752.push(_local_3);
                _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadEventHandler);
                _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadEventHandler);
                _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadEventHandler);
                if (this._SafeStr_8753.length == 0){
                    dispatchEvent(new Event(AssetLibrary._SafeStr_8758));
                };
            };
        }
        public function hasAssetLibrary(_arg_1:String):Boolean
        {
            var _local_3:IAssetLibrary;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_4];
                if (_local_3.name == _arg_1){
                    return (true);
                };
                _local_4++;
            };
            return (false);
        }
        public function getAssetLibraryByName(_arg_1:String):IAssetLibrary
        {
            var _local_3:IAssetLibrary;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_4];
                if (_local_3.name == _arg_1){
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }
        public function getAssetLibraryByUrl(_arg_1:String):IAssetLibrary
        {
            var _local_3:IAssetLibrary;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_4];
                if (_local_3.url == _arg_1){
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }
        public function addAssetLibrary(_arg_1:IAssetLibrary):void
        {
            if (this._SafeStr_8752.indexOf(_arg_1) == -1){
                this._SafeStr_8752.push(_arg_1);
            };
        }
        public function loadAssetFromFile(_arg_1:String, _arg_2:URLRequest, _arg_3:String=null):AssetLoaderStruct
        {
            return (this._SafeStr_8754.loadAssetFromFile(_arg_1, _arg_2, _arg_3));
        }
        public function getAssetByName(_arg_1:String):IAsset
        {
            var _local_3:IAssetLibrary;
            var _local_4:IAsset;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_5:uint;
            while (_local_5 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_5];
                _local_4 = _local_3.getAssetByName(_arg_1);
                if (_local_4 != null){
                    return (_local_4);
                };
                _local_5++;
            };
            return (null);
        }
        public function getAssetsByName(_arg_1:String):Array
        {
            var _local_3:IAsset;
            var _local_4:IAssetLibrary;
            var _local_2:Array = [];
            for each (_local_4 in this._SafeStr_8752) {
                _local_3 = _local_4.getAssetByName(_arg_1);
                if (_local_3 != null){
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }
        public function IAssetLibrary(_arg_1:Object):IAsset
        {
            var _local_3:IAssetLibrary;
            var _local_4:IAsset;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_5:uint;
            while (_local_5 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_5];
                _local_4 = _local_3.IAssetLibrary(_arg_1);
                if (_local_4 != null){
                    return (_local_4);
                };
                _local_5++;
            };
            return (null);
        }
        public function getAssetByIndex(_arg_1:uint):IAsset
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint = this._SafeStr_8752.length;
            var _local_5:uint;
            while (_local_5 < _local_4) {
                _local_2 = (_local_2 + IAssetLibrary(this._SafeStr_8752[_local_5]).numAssets);
                if (_local_2 <= _arg_1){
                    return (IAssetLibrary(this._SafeStr_8752[_local_5]).getAssetByIndex((_arg_1 - _local_3)));
                };
                _local_3 = _local_2;
                _local_5++;
            };
            return (null);
        }
        public function IAssetLibrary(_arg_1:IAsset):int
        {
            var _local_3:IAssetLibrary;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_4:int;
            var _local_5:int;
            var _local_6:uint;
            while (_local_6 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_6];
                _local_5 = _local_3.IAssetLibrary(_arg_1);
                if (_local_5 != -1){
                    return ((_local_4 + _local_5));
                };
                _local_4 = (_local_4 + _local_3.numAssets);
                _local_6++;
            };
            return (-1);
        }
        public function hasAsset(_arg_1:String):Boolean
        {
            var _local_3:IAssetLibrary;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_4];
                if (_local_3.hasAsset(_arg_1)){
                    return (true);
                };
                _local_4++;
            };
            return (false);
        }
        public function IAssetLibrary(_arg_1:String, _arg_2:IAsset, _arg_3:Boolean=true):Boolean
        {
            return (this._SafeStr_8754.IAssetLibrary(_arg_1, _arg_2, _arg_3));
        }
        public function createAsset(_arg_1:String, _arg_2:AssetTypeDeclaration):IAsset
        {
            return (this._SafeStr_8754.createAsset(_arg_1, _arg_2));
        }
        public function removeAsset(_arg_1:IAsset):IAsset
        {
            var _local_3:IAssetLibrary;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_4:uint;
            while (_local_4 < _local_2) {
                _local_3 = this._SafeStr_8752[_local_4];
                if (_local_3.removeAsset(_arg_1) == _arg_1){
                    return (_arg_1);
                };
                _local_4++;
            };
            return (null);
        }
        public function IAssetLibrary(_arg_1:AssetTypeDeclaration, _arg_2:Boolean=true):Boolean
        {
            return (this._SafeStr_8754.IAssetLibrary(_arg_1, _arg_2));
        }
        public function IAssetLibrary(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:uint;
            var _local_4:IAssetLibrary;
            var _local_5:AssetTypeDeclaration;
            var _local_6:uint;
            if (_arg_2){
                return (this._SafeStr_8754.IAssetLibrary(_arg_1, true));
            };
            _local_3 = this._SafeStr_8752.length;
            _local_6 = 0;
            while (_local_6 < _local_3) {
                _local_4 = this._SafeStr_8752[_local_6];
                _local_5 = _local_4.IAssetLibrary(_arg_1, false);
                if (_local_5 != null){
                    return (_local_5);
                };
                _local_6++;
            };
            return (null);
        }
        public function IAssetLibrary(_arg_1:Class, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:uint;
            var _local_4:IAssetLibrary;
            var _local_5:AssetTypeDeclaration;
            var _local_6:uint;
            if (_arg_2){
                return (this._SafeStr_8754.IAssetLibrary(_arg_1, true));
            };
            _local_3 = this._SafeStr_8752.length;
            _local_6 = 0;
            while (_local_6 < _local_3) {
                _local_4 = this._SafeStr_8752[_local_6];
                _local_5 = _local_4.IAssetLibrary(_arg_1, false);
                if (_local_5 != null){
                    return (_local_5);
                };
                _local_6++;
            };
            return (null);
        }
        public function IAssetLibrary(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:uint;
            var _local_4:IAssetLibrary;
            var _local_5:AssetTypeDeclaration;
            var _local_6:uint;
            if (_arg_2){
                return (this._SafeStr_8754.IAssetLibrary(_arg_1, true));
            };
            _local_3 = this._SafeStr_8752.length;
            _local_6 = 0;
            while (_local_6 < _local_3) {
                _local_4 = this._SafeStr_8752[_local_6];
                _local_5 = _local_4.IAssetLibrary(_arg_1, false);
                if (_local_5 != null){
                    return (_local_5);
                };
                _local_6++;
            };
            return (null);
        }
        private function getNumAssets():uint
        {
            var _local_1:uint;
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_3:uint;
            while (_local_3 < _local_2) {
                _local_1 = (_local_1 + IAssetLibrary(this._SafeStr_8752[_local_3]).numAssets);
                _local_3++;
            };
            return (_local_1);
        }
        private function getAssetNameArray():Array
        {
            var _local_1:Array = new Array();
            var _local_2:uint = this._SafeStr_8752.length;
            var _local_3:uint;
            while (_local_3 < _local_2) {
                _local_1 = _local_1.concat(IAssetLibrary(this._SafeStr_8752[_local_3]).nameArray);
                _local_3++;
            };
            return (_local_1);
        }
        public function getManifests():Array
        {
            var _local_1:Array = new Array();
            var _local_2:int = this._SafeStr_8752.length;
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_1.push(IAssetLibrary(this._SafeStr_8752[_local_3]).manifest);
                _local_3++;
            };
            return (_local_1);
        }

    }
}//package com.sulake.core.assets

// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// _SafeStr_4425 = "_-vA" (String#643, DoABC#2)
// getManifests = "_-0hi" (String#15736, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// _loaderContext = "_-0PU" (String#4082, DoABC#2)
// loaderContext = "_-27g" (String#19318, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// _SafeStr_8752 = "_-2D-" (String#19522, DoABC#2)
// _SafeStr_8753 = "_-0Vm" (String#15269, DoABC#2)
// _SafeStr_8754 = "_-2oF" (String#21012, DoABC#2)
// isReady = "_-2Wr" (String#6698, DoABC#2)
// getNumAssets = "_-3E6" (String#22038, DoABC#2)
// getAssetNameArray = "_-0vK" (String#16250, DoABC#2)
// _SafeStr_8758 = "_-2H5" (String#19688, DoABC#2)
// hasAssetLibrary = "_-1EM" (String#17040, DoABC#2)
// getAssetLibraryByName = "_-Sh" (String#23353, DoABC#2)
// getAssetLibraryByUrl = "_-2Cf" (String#19511, DoABC#2)
// addAssetLibrary = "_-1xU" (String#18869, DoABC#2)
// IAssetLibrary = "_-2q5" (String#7080, DoABC#2)
// IAssetLibrary = "_-38x" (String#7490, DoABC#2)
// IAssetLibrary = "_-08Y" (String#3730, DoABC#2)
// createAsset = "_-0rD" (String#1562, DoABC#2)
// IAssetLibrary = "_-1PR" (String#5342, DoABC#2)
// IAssetLibrary = "_-BD" (String#7892, DoABC#2)
// IAssetLibrary = "_-5x" (String#7779, DoABC#2)
// IAssetLibrary = "_-0rv" (String#4683, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


