
package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.assets.loaders.BinaryFileLoader;
    import com.sulake.core.assets.loaders.BitmapFileLoader;
    import com.sulake.core.assets.loaders.ZipFileLoader;
    import com.sulake.core.assets.loaders.SoundFileLoader;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.assets.loaders.IAssetLoader;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.assets.loaders.*;

    public class AssetLibrary extends EventDispatcher implements IAssetLibrary 
    {

        public static const _SafeStr_8782:String = "AssetLibraryReady";
        public static const _SafeStr_8758:String = "AssetLibraryLoaded";
        public static const _SafeStr_8783:String = "AssetLibraryUnloaded";
        public static const _SafeStr_8784:String = "AssetLibraryLoadError";
        private static const _SafeStr_8785:String = "name";
        private static const _SafeStr_8786:String = "asset";
        private static const _SafeStr_8787:String = "param";
        private static const TYPE:String = "mimeType";
        private static const _SafeStr_8788:String = "library";
        private static var _SafeStr_8789:Dictionary;
        private static var _SafeStr_8790:LazyAssetProcessor = new LazyAssetProcessor();
        private static var _SafeStr_8791:uint = 0;
        private static var _SafeStr_8792:Array = new Array();

        private var _name:String;
        private var _url:String;
        private var _manifest:XML;
        private var _isReady:Boolean;
        private var _numAssets:uint;
        private var _content:LibraryLoader;
        private var _resource:Class;
        private var _SafeStr_8797:Dictionary;
        private var _SafeStr_8798:Dictionary;
        private var _SafeStr_8799:Boolean = true;
        private var _SafeStr_8800:Dictionary;
        private var _nameArray:Array;
        private var _SafeStr_8802:Dictionary;

        public function AssetLibrary(_arg_1:String)
        {
            this._name = _arg_1;
            this._manifest = new XML();
            this._numAssets = 0;
            this._nameArray = new Array();
            if (_SafeStr_8789 == null){
                _SafeStr_8789 = new Dictionary(false);
                this.IAssetLibrary(new AssetTypeDeclaration("application/octet-stream", UnknownAsset, BinaryFileLoader));
                this.IAssetLibrary(new AssetTypeDeclaration("application/x-shockwave-flash", DisplayAsset, BitmapFileLoader, "swf"));
                this.IAssetLibrary(new AssetTypeDeclaration("application/x-font-truetype", FontAsset, BinaryFileLoader, "ttf", "otf"));
                this.IAssetLibrary(new AssetTypeDeclaration("application/zip", UnknownAsset, ZipFileLoader, "zip"));
                this.IAssetLibrary(new AssetTypeDeclaration("text/xml", XmlAsset, BinaryFileLoader, "xml"));
                this.IAssetLibrary(new AssetTypeDeclaration("text/html", XmlAsset, BinaryFileLoader, "htm", "html"));
                this.IAssetLibrary(new AssetTypeDeclaration("text/plain", TextAsset, BinaryFileLoader, "txt"));
                this.IAssetLibrary(new AssetTypeDeclaration("image/jpeg", BitmapDataAsset, BitmapFileLoader, "jpg", "jpeg"));
                this.IAssetLibrary(new AssetTypeDeclaration("image/gif", BitmapDataAsset, BitmapFileLoader, "gif"));
                this.IAssetLibrary(new AssetTypeDeclaration("image/png", BitmapDataAsset, BitmapFileLoader, "png"));
                this.IAssetLibrary(new AssetTypeDeclaration("image/tiff", BitmapDataAsset, BitmapFileLoader, "tif", "tiff"));
                this.IAssetLibrary(new AssetTypeDeclaration("sound/mp3", SoundAsset, SoundFileLoader, "mp3"));
            };
            _SafeStr_8791++;
            this._SafeStr_8802 = new Dictionary(false);
            this._SafeStr_8800 = new Dictionary(false);
            this._SafeStr_8797 = new Dictionary(false);
            this._SafeStr_8798 = new Dictionary(false);
            _SafeStr_8792.push(this);
        }
        public static function get numAssetLibraryInstances():uint
        {
            return (_SafeStr_8791);
        }
        public static function get assetLibraryRefArray():Array
        {
            return (_SafeStr_8792);
        }
        private static function AssetLibrary(_arg_1:AssetLibrary, _arg_2:XML, _arg_3:Class):Boolean
        {
            var _local_6:XML;
            var _local_7:String;
            var _local_8:String;
            var _local_9:AssetTypeDeclaration;
            var _local_10:IAsset;
            var _local_11:XMLList;
            var _local_12:int;
            var _local_13:AssetTypeDeclaration;
            var _local_14:String;
            var _local_15:uint;
            var _local_4:int = getTimer();
            if (_arg_3 == null){
                throw (new Error((("Library " + _arg_1._url) + " doesn't contain valid resource class!")));
            };
            var _local_5:XMLList = _arg_2.child(_SafeStr_8788);
            if (_local_5 == null){
                throw (Error("Provided manifest doesn't contain library node!"));
            };
            _local_5 = _local_5[0].assets;
            if (_local_5 != null){
                _local_5 = _local_5.child(_SafeStr_8786);
                _local_12 = _local_5.length();
                _local_14 = null;
                _local_15 = 0;
                while (_local_15 < _local_12) {
                    _local_6 = _local_5[_local_15];
                    _local_7 = _local_6.attribute(_SafeStr_8785);
                    _local_8 = _local_6.attribute(TYPE);
                    if (_local_8 == _local_14){
                        _local_9 = _local_13;
                    }
                    else {
                        _local_9 = _arg_1.IAssetLibrary(_local_8);
                        _local_14 = _local_8;
                        _local_13 = _local_9;
                    };
                    if (_local_9 != null){
                        _local_10 = (new (_local_9.assetClass)(_local_9) as IAsset);
                        _local_10.setUnknownContent(_arg_3[_local_7]);
                        _local_11 = _local_6.child(_SafeStr_8787);
                        if (_local_11.length()){
                            _local_10.setParamsDesc(_local_11);
                        };
                        _arg_1.IAssetLibrary(_local_7, _local_10);
                    }
                    else {
                        Logger.log((((("Failed to extract asset " + _local_7) + " from Library ") + _arg_1._url) + "!"));
                    };
                    _local_15++;
                };
            };
            _local_4 = (getTimer() - _local_4);
            return (true);
        }

        public function get url():String
        {
            return (this._url);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get isReady():Boolean
        {
            return (this._isReady);
        }
        public function get manifest():XML
        {
            return (this._manifest);
        }
        public function get numAssets():uint
        {
            return (this._numAssets);
        }
        public function get nameArray():Array
        {
            return (this._nameArray);
        }
        override public function dispose():void
        {
            if (!disposed){
                this.unload();
                super.dispose();
                _SafeStr_8792.splice(_SafeStr_8792.indexOf(this), 1);
                _SafeStr_8791--;
                this._SafeStr_8800 = null;
                this._SafeStr_8797 = null;
                this._SafeStr_8798 = null;
                this._nameArray = null;
                this._manifest = null;
                this._numAssets = 0;
                this._isReady = false;
                this._name = null;
            };
        }
        public function loadFromFile(_arg_1:LibraryLoader, _arg_2:Boolean=true):void
        {
            if ((((this._url == _arg_1.url)) && (this._isReady))){
                if (((!(this._SafeStr_8799)) && (_arg_2))){
                    AssetLibrary.AssetLibrary(this, this._manifest, this._resource);
                };
                this._SafeStr_8799 = _arg_2;
                dispatchEvent(new Event(AssetLibrary._SafeStr_8782));
            }
            else {
                if ((((this._content == null)) || (this._content.disposed))){
                    this._content = _arg_1;
                    this._content.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.LibraryLoaderQueue);
                    this._content.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.LibraryLoaderQueue);
                };
                this._SafeStr_8799 = _arg_2;
                this._url = this._content.url;
            };
        }
        public function loadFromResource(_arg_1:XML, _arg_2:Class):Boolean
        {
            return (AssetLibrary.AssetLibrary(this, _arg_1, _arg_2));
        }
        public function unload():void
        {
            var _local_1:String;
            var _local_2:AssetLoaderStruct;
            for (_local_1 in this._SafeStr_8800) {
                _local_2 = this._SafeStr_8800[_local_1];
                _local_2.assetLoader.dispose();
                delete this._SafeStr_8800[_local_1];
            };
            for (_local_1 in this._SafeStr_8798) {
                delete this._SafeStr_8798[_local_1];
            };
            for (_local_1 in this._SafeStr_8797) {
                delete this._SafeStr_8797[_local_1];
            };
            if (this._content != null){
                this._content.dispose();
                this._content = null;
            };
            this._numAssets = 0;
            this._isReady = false;
            this._url = null;
            dispatchEvent(new Event(AssetLibrary._SafeStr_8783));
        }
        public function getClass(_arg_1:String):Class
        {
            var _local_2:Class = this._SafeStr_8797[_arg_1];
            if (_local_2 != null){
                return (_local_2);
            };
            if (this._content != null){
                if (this._content.hasDefinition(_arg_1)){
                    _local_2 = (this._content.getDefinition(_arg_1) as Class);
                    if (_local_2 != null){
                        this._SafeStr_8797[_arg_1] = _local_2;
                        return (_local_2);
                    };
                };
            };
            return (null);
        }
        public function loadAssetFromFile(_arg_1:String, _arg_2:URLRequest, _arg_3:String=null):AssetLoaderStruct
        {
            var _local_5:AssetTypeDeclaration;
            if (this.getAssetByName(_arg_1) != null){
                throw (new Error((("Asset with name " + _arg_1) + " already exists!")));
            };
            var _local_4:AssetLoaderStruct = this._SafeStr_8800[_arg_2.url];
            if (_local_4 != null){
                if (_local_4.assetName == _arg_1){
                    return (_local_4);
                };
            };
            if (_arg_3 == null){
                _local_5 = this.solveAssetTypeDeclarationFromUrl(_arg_2.url);
                if (_local_5 == null){
                    throw (new Error((("Couldn't solve asset type for file " + _arg_2.url) + "!")));
                };
            }
            else {
                _local_5 = this.IAssetLibrary(_arg_3, true);
                if (_local_5 == null){
                    throw (new Error((("Asset type declaration for mime type " + _arg_3) + "not found!")));
                };
            };
            var _local_6:IAssetLoader = new (_local_5.loaderClass)(_local_5.mimeType, _arg_2);
            if (_local_6 == null){
                throw (new Error((("Invalid file loader class defined for mime type " + _arg_3) + "!")));
            };
            _local_6.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.assetLoadEventHandler);
            _local_6.addEventListener(AssetLoaderEvent._SafeStr_4221, this.assetLoadEventHandler);
            _local_6.addEventListener(AssetLoaderEvent._SafeStr_7407, this.assetLoadEventHandler);
            _local_6.addEventListener(AssetLoaderEvent._SafeStr_7409, this.assetLoadEventHandler);
            _local_6.addEventListener(AssetLoaderEvent._SafeStr_7406, this.assetLoadEventHandler);
            _local_6.addEventListener(AssetLoaderEvent._SafeStr_7408, this.assetLoadEventHandler);
            _local_4 = new AssetLoaderStruct(_arg_1, _local_6);
            this._SafeStr_8800[_arg_2.url] = _local_4;
            return (_local_4);
        }
        private function assetLoadEventHandler(e:AssetLoaderEvent):void
        {
            var loader:IAssetLoader;
            var type:String;
            var decl:AssetTypeDeclaration;
            var asset:IAsset;
            var remove:Boolean;
            loader = (e.target as IAssetLoader);
            if (loader == null){
                throw (new Error("Failed to downcast object to asset loader!"));
            };
            var struct:AssetLoaderStruct = this._SafeStr_8800[loader.url];
            if (struct == null){
                throw (new Error(("Asset loader structure was lost! " + ((loader) ? loader.url : ""))));
            };
            switch (e.type){
                case AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE:
                    type = loader.mimeType;
                    decl = this.IAssetLibrary(type);
                    remove = true;
                    if (decl != null){
                        asset = new (decl.assetClass)(decl, loader.url);
                        try {
                            asset.setUnknownContent(loader.content);
                        }
                        catch(error:Error) {
                            asset.dispose();
                            Logger.log(((((((('Failed to build asset from loaded file "' + loader.url) + '" type: ') + type) + " error: ") + error.name) + " / ") + error.message));
                            e = new AssetLoaderEvent(AssetLoaderEvent._SafeStr_4221, e.status);
                            break;
                        };
                        if (this._SafeStr_8798[struct.assetName] == null){
                            this._numAssets++;
                            this._nameArray.push(struct.assetName);
                        };
                        this._SafeStr_8798[struct.assetName] = asset;
                    }
                    else {
                        Logger.log(((('Failed to resolve asset type declaration: "' + loader.url) + '" type: ') + type));
                        e = new AssetLoaderEvent(AssetLoaderEvent._SafeStr_4221, e.status);
                    };
                    break;
                case AssetLoaderEvent._SafeStr_4221:
                    remove = true;
                    Logger.log(((('Failed to download file "' + loader.url) + '" error: ') + loader.errorCode));
                    break;
            };
            struct.dispatchEvent(new AssetLoaderEvent(e.type, e.status));
            if (remove){
                if (((!(_disposed)) && (loader))){
                    delete this._SafeStr_8800[loader.url];
                };
                if (struct){
                    struct.dispose();
                };
            };
        }
        public function getAssetByName(_arg_1:String):IAsset
        {
            var _local_2:IAsset = this._SafeStr_8798[_arg_1];
            if (_local_2 != null){
                return (_local_2);
            };
            if (this._SafeStr_8799){
                return (null);
            };
            return (this.fetchAssetFromResource(_arg_1));
        }
        public function getAssetByIndex(_arg_1:uint):IAsset
        {
            return ((((_arg_1)<this._nameArray.length) ? this.getAssetByName(this._nameArray[_arg_1]) : null));
        }
        public function IAssetLibrary(_arg_1:Object):IAsset
        {
            var _local_2:String;
            var _local_3:IAsset;
            for (_local_2 in this._SafeStr_8798) {
                _local_3 = this._SafeStr_8798[_local_2];
                if (_local_3.content === _arg_1){
                    return (_local_3);
                };
            };
            return (null);
        }
        public function IAssetLibrary(_arg_1:IAsset):int
        {
            var _local_2:String;
            for (_local_2 in this._SafeStr_8798) {
                if (this._SafeStr_8798[_local_2] == _arg_1){
                    return (this._nameArray.indexOf(_local_2));
                };
            };
            return (-1);
        }
        public function hasAsset(_arg_1:String):Boolean
        {
            return (((!((this._SafeStr_8798[_arg_1] == null))) || ((((this._resource)!=null) ? !((this._resource[_arg_1] == null)) : false))));
        }
        public function IAssetLibrary(_arg_1:String, _arg_2:IAsset, _arg_3:Boolean=true):Boolean
        {
            var _local_4 = (this._SafeStr_8798[_arg_1] == null);
            if (((((_arg_3) || (_local_4))) && (_arg_2))){
                if (_local_4){
                    this._numAssets++;
                    this._nameArray.push(_arg_1);
                };
                this._SafeStr_8798[_arg_1] = _arg_2;
                if ((_arg_2 is ILazyAsset)){
                    _SafeStr_8790.push((_arg_2 as ILazyAsset));
                };
                return (true);
            };
            return (false);
        }
        public function createAsset(_arg_1:String, _arg_2:AssetTypeDeclaration):IAsset
        {
            if (((this.hasAsset(_arg_1)) || (!(_arg_2)))){
                return (null);
            };
            var _local_3:IAsset = new (_arg_2.assetClass)(_arg_2);
            if (!this.IAssetLibrary(_arg_1, _local_3)){
                _local_3.dispose();
                _local_3 = null;
            };
            return (_local_3);
        }
        public function removeAsset(_arg_1:IAsset):IAsset
        {
            var _local_2:String;
            if (_arg_1){
                for (_local_2 in this._SafeStr_8798) {
                    if (this._SafeStr_8798[_local_2] == _arg_1){
                        this._nameArray.splice(this._nameArray.indexOf(_local_2), 1);
                        delete this._SafeStr_8798[_local_2];
                        this._numAssets--;
                        return (_arg_1);
                    };
                };
            };
            return (null);
        }
        public function IAssetLibrary(_arg_1:AssetTypeDeclaration, _arg_2:Boolean=true):Boolean
        {
            if (_arg_2){
                if (_SafeStr_8789.hasOwnProperty(_arg_1.mimeType)){
                    throw (new Error((("Asset type " + _arg_1.mimeType) + " already registered!")));
                };
                _SafeStr_8789[_arg_1.mimeType] = _arg_1;
            }
            else {
                if (this._SafeStr_8802.hasOwnProperty(_arg_1.mimeType)){
                    throw (new Error((("Asset type " + _arg_1.mimeType) + " already registered!")));
                };
                this._SafeStr_8802[_arg_1.mimeType] = _arg_1;
            };
            return (true);
        }
        public function IAssetLibrary(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:AssetTypeDeclaration;
            if (_arg_2){
                _local_3 = AssetTypeDeclaration(_SafeStr_8789[_arg_1]);
                if (_local_3 != null){
                    return (_local_3);
                };
            };
            return (AssetTypeDeclaration(this._SafeStr_8802[_arg_1]));
        }
        public function IAssetLibrary(_arg_1:Class, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:AssetTypeDeclaration;
            var _local_4:String;
            if (_arg_2){
                for (_local_4 in _SafeStr_8789) {
                    _local_3 = AssetTypeDeclaration(_SafeStr_8789[_local_4]);
                    if (_local_3 != null){
                        if (_local_3.assetClass == _arg_1){
                            return (_local_3);
                        };
                    };
                };
            };
            for (_local_4 in this._SafeStr_8802) {
                _local_3 = AssetTypeDeclaration(this._SafeStr_8802[_local_4]);
                if (_local_3 != null){
                    if (_local_3.assetClass == _arg_1){
                        return (_local_3);
                    };
                };
            };
            return (null);
        }
        public function IAssetLibrary(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_4:AssetTypeDeclaration;
            var _local_5:String;
            var _local_3:String = _arg_1.substr((_arg_1.lastIndexOf(".") + 1), _arg_1.length);
            if (_local_3.indexOf("?")){
                _local_3 = _local_3.substr(0, (_local_3.indexOf("?") - 1));
            };
            if (_arg_2){
                for (_local_5 in _SafeStr_8789) {
                    _local_4 = AssetTypeDeclaration(_SafeStr_8789[_local_5]);
                    if (_local_4 != null){
                        if (_local_4.fileTypes.indexOf(_local_3)){
                            return (_local_4);
                        };
                    };
                };
            };
            for (_local_5 in this._SafeStr_8802) {
                _local_4 = AssetTypeDeclaration(this._SafeStr_8802[_local_5]);
                if (_local_4 != null){
                    if (_local_4.fileTypes.indexOf(_local_3)){
                        return (_local_4);
                    };
                };
            };
            return (null);
        }
        private function LibraryLoaderQueue(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            if (_local_2.manifest == null){
                throw (new Error("loader.manifest was null, which would have caused error 1009 anyway. See HL-22347."));
            };
            this._manifest = _local_2.manifest.copy();
            this._resource = _local_2.resource;
            this._url = _local_2.url;
            if (this._SafeStr_8799){
                AssetLibrary.AssetLibrary(this, this._manifest, this._resource);
            };
            this._isReady = true;
            dispatchEvent(new Event(AssetLibrary._SafeStr_8758));
            dispatchEvent(new Event(AssetLibrary._SafeStr_8782));
            if (this._SafeStr_8799){
                this._content.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.LibraryLoaderQueue);
                this._content.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.LibraryLoaderQueue);
                this._content.addEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                this._content = null;
                this._resource = null;
            };
        }
        private function finalizeLoaderEventHandler(_arg_1:Event):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            if (((_local_2) && (!(_local_2.disposed)))){
                if (!_local_2.hasEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE)){
                    _local_2.removeEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                    _local_2.dispose();
                };
            };
        }
        private function onLoadProgress(_arg_1:ProgressEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }
        private function LibraryLoaderQueue(_arg_1:LibraryLoaderEvent):void
        {
            this._isReady = false;
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            var _local_3:String = ((_local_2) ? _local_2.name : "unknown");
            Logger.log(((("Cannot load the specified file: " + _local_3) + " ") + _arg_1.status));
            dispatchEvent(new Event(AssetLibrary._SafeStr_8784));
            this._content = null;
        }
        private function solveAssetTypeDeclarationFromUrl(_arg_1:String):AssetTypeDeclaration
        {
            var _local_2:int;
            var _local_3:AssetTypeDeclaration;
            var _local_4:Array;
            var _local_5:String;
            _local_2 = _arg_1.indexOf("?", 0);
            if (_local_2 > 0){
                _arg_1 = _arg_1.slice(0, _local_2);
            };
            _local_2 = _arg_1.lastIndexOf(".");
            if (_local_2 == -1){
                return (null);
            };
            _arg_1 = _arg_1.slice((_local_2 + 1), _arg_1.length);
            for (_local_5 in this._SafeStr_8802) {
                _local_3 = this._SafeStr_8802[_local_5];
                _local_4 = _local_3.fileTypes;
                if (_local_4 != null){
                    if (_local_4.indexOf(_arg_1, 0) > -1){
                        return (_local_3);
                    };
                };
            };
            for (_local_5 in _SafeStr_8789) {
                _local_3 = _SafeStr_8789[_local_5];
                _local_4 = _local_3.fileTypes;
                if (_local_4 != null){
                    if (_local_4.indexOf(_arg_1, 0) > -1){
                        return (_local_3);
                    };
                };
            };
            return (null);
        }
        private function fetchAssetFromResource(_arg_1:String):IAsset
        {
            var _local_3:XML;
            var _local_4:AssetTypeDeclaration;
            var _local_5:IAsset;
            var _local_6:XMLList;
            var _local_7:int;
            var _local_8:uint;
            if (!this._resource){
                return (null);
            };
            var _local_2:XMLList = this._manifest.child(_SafeStr_8788);
            if (_local_2 == null){
                throw (new Error("Provided manifest doesn't contain library node!"));
            };
            if (_local_2.length() == 0){
                return (null);
            };
            _local_2 = _local_2[0].assets;
            if (_local_2 != null){
                _local_2 = _local_2.child(_SafeStr_8786);
                if (_local_2 != null){
                    _local_5 = null;
                    _local_7 = _local_2.length();
                    _local_8 = 0;
                    while (_local_8 < _local_7) {
                        _local_3 = _local_2[_local_8];
                        if (((_local_3.attribute(_SafeStr_8785)) && ((_local_3.attribute(_SafeStr_8785).toString() == _arg_1)))){
                            _local_4 = this.IAssetLibrary(_local_3.attribute(TYPE));
                            if (_local_4 == null){
                                throw (new Error((((("Failed to extract asset " + _arg_1) + " from Library ") + this._url) + "!")));
                            };
                            _local_5 = (new (_local_4.assetClass)(_local_4) as IAsset);
                            _local_5.setUnknownContent(this._resource[_arg_1]);
                            _local_6 = _local_3.child(_SafeStr_8787);
                            if (((_local_6) && (_local_6.length()))){
                                _local_5.setParamsDesc(_local_6);
                            };
                            this.IAssetLibrary(_arg_1, _local_5);
                            return (_local_5);
                        };
                        _local_8++;
                    };
                };
            };
            return (null);
        }
        public function toString():String
        {
            return (((getQualifiedClassName(this) + ": ") + this._name));
        }

    }
}//package com.sulake.core.assets

// IAssetLoader = "_-0Nc" (String#4033, DoABC#2)
// ILazyAsset = "_-0Yb" (String#4275, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// TextAsset = "_-0HX" (String#14738, DoABC#2)
// LazyAssetProcessor = "_-K2" (String#23007, DoABC#2)
// DisplayAsset = "_-wp" (String#24561, DoABC#2)
// BitmapFileLoader = "_-Nw" (String#23162, DoABC#2)
// BinaryFileLoader = "_-26r" (String#19285, DoABC#2)
// UnknownAsset = "_-0bU" (String#15496, DoABC#2)
// ZipFileLoader = "_-8q" (String#22572, DoABC#2)
// SoundFileLoader = "_-0LQ" (String#14893, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// _SafeStr_7406 = "_-2p3" (String#21044, DoABC#2)
// _SafeStr_7407 = "_-2Dr" (String#19562, DoABC#2)
// _SafeStr_7408 = "_-3F-" (String#22076, DoABC#2)
// _SafeStr_7409 = "_-2JT" (String#19788, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setParamsDesc = "_-0ro" (String#4682, DoABC#2)
// isReady = "_-2Wr" (String#6698, DoABC#2)
// _SafeStr_8758 = "_-2H5" (String#19688, DoABC#2)
// IAssetLibrary = "_-2q5" (String#7080, DoABC#2)
// IAssetLibrary = "_-38x" (String#7490, DoABC#2)
// IAssetLibrary = "_-08Y" (String#3730, DoABC#2)
// createAsset = "_-0rD" (String#1562, DoABC#2)
// IAssetLibrary = "_-1PR" (String#5342, DoABC#2)
// IAssetLibrary = "_-BD" (String#7892, DoABC#2)
// IAssetLibrary = "_-5x" (String#7779, DoABC#2)
// IAssetLibrary = "_-0rv" (String#4683, DoABC#2)
// assetClass = "_-39W" (String#21863, DoABC#2)
// loaderClass = "_-0PF" (String#15033, DoABC#2)
// fileTypes = "_-xg" (String#24597, DoABC#2)
// _SafeStr_8782 = "_-1jx" (String#18283, DoABC#2)
// _SafeStr_8783 = "_-07H" (String#14337, DoABC#2)
// _SafeStr_8784 = "_-1BU" (String#16917, DoABC#2)
// _SafeStr_8785 = "_-1OX" (String#605, DoABC#2)
// _SafeStr_8786 = "_-2J2" (String#19768, DoABC#2)
// _SafeStr_8787 = "_-3Fk" (String#22106, DoABC#2)
// _SafeStr_8788 = "_-vX" (String#24509, DoABC#2)
// _SafeStr_8789 = "_-i3" (String#23967, DoABC#2)
// _SafeStr_8790 = "_-1gd" (String#18163, DoABC#2)
// _SafeStr_8791 = "_-1hQ" (String#18189, DoABC#2)
// _SafeStr_8792 = "_-75" (String#22504, DoABC#2)
// _url = "_-3Gf" (String#22148, DoABC#2)
// _isReady = "_-0tK" (String#4713, DoABC#2)
// _numAssets = "_-2Lz" (String#19883, DoABC#2)
// _resource = "_-1tH" (String#5907, DoABC#2)
// _SafeStr_8797 = "_-2I8" (String#19732, DoABC#2)
// _SafeStr_8798 = "_-oQ" (String#24211, DoABC#2)
// _SafeStr_8799 = "_-2DG" (String#19536, DoABC#2)
// _SafeStr_8800 = "_-1-j" (String#16456, DoABC#2)
// _nameArray = "_-Sm" (String#23356, DoABC#2)
// _SafeStr_8802 = "_-zO" (String#24668, DoABC#2)
// numAssetLibraryInstances = "_-2Aj" (String#6261, DoABC#2)
// assetLibraryRefArray = "_-2Y1" (String#20357, DoABC#2)
// AssetLibrary = "_-38r" (String#21836, DoABC#2)
// LibraryLoaderQueue = "_-0GL" (String#3878, DoABC#2)
// LibraryLoaderQueue = "_-0IT" (String#1448, DoABC#2)
// getClass = "_-1Mn" (String#17391, DoABC#2)
// solveAssetTypeDeclarationFromUrl = "_-1C0" (String#16943, DoABC#2)
// assetLoadEventHandler = "_-1SD" (String#17589, DoABC#2)
// fetchAssetFromResource = "_-bl" (String#23703, DoABC#2)
// finalizeLoaderEventHandler = "_-2Uc" (String#20222, DoABC#2)
// onLoadProgress = "_-db" (String#23786, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


