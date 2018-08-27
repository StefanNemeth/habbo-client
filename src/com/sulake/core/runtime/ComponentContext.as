
package com.sulake.core.runtime
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.core.runtime.events.WarningEvent;
    import com.sulake.core.runtime.events.ErrorEvent;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import com.sulake.core.Core;
    import flash.utils.ByteArray;
    import com.sulake.core.assets.AssetTypeDeclaration;
    import com.sulake.core.assets.IAsset;
    import flash.system.ApplicationDomain;
    import com.sulake.core.assets.AssetLibrary;
    import flash.utils.getDefinitionByName;
    import com.sulake.core.runtime.exceptions.InvalidComponentException;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.runtime.events.LockEvent;

    public class ComponentContext extends Component implements IContext 
    {

        protected var _components:Array;
        protected var _queuees:Array;
        protected var _SafeStr_8954:Array;
        protected var _debug:Boolean = false;
        protected var _displayObjectContainer:DisplayObjectContainer;

        public function ComponentContext(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, (_arg_2 | Component.COMPONENT_FLAG_CONTEXT), _arg_3);
            this._displayObjectContainer = new Sprite();
            this._components = new Array();
            this._queuees = new Array();
        }
        public function get root():IContext
        {
            if (((!(context)) || ((context == this)))){
                return (this);
            };
            return (context.root);
        }
        public function get displayObjectContainer():DisplayObjectContainer
        {
            return (this._displayObjectContainer);
        }
        public function debug(_arg_1:String):void
        {
            _SafeStr_8955 = _arg_1;
            if (((this._debug) && (events))){
                events.dispatchEvent(new Event(Component.COMPONENT_EVENT_DEBUG));
            };
        }
        public function getLastDebugMessage():String
        {
            return (_SafeStr_8955);
        }
        public function warning(_arg_1:String):void
        {
            _lastWarning = _arg_1;
            if (events == null){
                Logger.log(("Failed to dispatch warning because events was null.\nMessage: " + _arg_1));
            }
            else {
                events.dispatchEvent(new WarningEvent(Component.COMPONENT_EVENT_WARNING, _arg_1));
            };
        }
        public function getLastWarningMessage():String
        {
            return (_lastWarning);
        }
        public function error(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
        {
            _SafeStr_8959 = _arg_1;
            if (events == null){
                Logger.log(("Failed to dispatch an error because events was null.\nMessage: " + _arg_1));
            }
            else {
                events.dispatchEvent(new ErrorEvent(Component.COMPONENT_EVENT_ERROR, _arg_1, _arg_2, ((_arg_4) ? _arg_4.getStackTrace() : null)));
            };
        }
        public function getLastErrorMessage():String
        {
            return (_SafeStr_8959);
        }
        final public function loadFromFile(_arg_1:URLRequest, _arg_2:LoaderContext):LibraryLoader
        {
            if (this._SafeStr_8954 == null){
                this._SafeStr_8954 = new Array();
            };
            var _local_3:uint;
            while (_local_3 < this._SafeStr_8954.length) {
                if (this._SafeStr_8954[_local_3].url == _arg_1.url){
                    return (this._SafeStr_8954[_local_3].loadFromFile(_arg_1));
                };
                _local_3++;
            };
            var _local_4:LibraryLoader = new LibraryLoader(_arg_2, this._debug);
            _local_4.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadReadyHandler, false);
            _local_4.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler, false);
            _local_4.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DEBUG, this.loadDebugHandler, false);
            _local_4.load(_arg_1);
            this._SafeStr_8954.push(_local_4);
            return (_local_4);
        }
        final protected function loadReadyHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            this.removeLibraryLoader(_local_2);
            this.prepareComponent(_local_2.resource, Component.COMPONENT_FLAG_NULL, _local_2.domain);
        }
        protected function loadErrorHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            var _local_3:String = _local_2.getLastErrorMessage();
            this.removeLibraryLoader(_local_2);
            this.error((((('Failed to download component resource "' + _local_2.url) + '"!') + "\r") + _local_3), true, Core._SafeStr_8964);
        }
        protected function loadDebugHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            var _local_3:String = _local_2.getLastDebugMessage();
            this.debug(_local_3);
        }
        protected function removeLibraryLoader(_arg_1:LibraryLoader):void
        {
            _arg_1.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadReadyHandler, false);
            _arg_1.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadReadyHandler, false);
            _arg_1.dispose();
            var _local_2:uint;
            while (_local_2 < this._SafeStr_8954.length) {
                if (this._SafeStr_8954[_local_2] == _arg_1){
                    this._SafeStr_8954.splice(_local_2, 1);
                    return;
                };
                _local_2++;
            };
        }
        public function prepareAssetLibrary(_arg_1:XML, _arg_2:Class):Boolean
        {
            return (assets.loadFromResource(_arg_1, _arg_2));
        }
        final public function prepareComponent(resource:Class, flags:uint=0, domain:ApplicationDomain=null):IUnknown
        {
            var manifest:XML;
            var component:Component;
            var componentClass:Class;
            var componentString:String;
            var interfaceList:XMLList;
            var iid:IID;
            var iidList:Array;
            var iidClass:Class;
            var iidString:String;
            var item:XML;
            var version:String;
            var unknown:IUnknown;
            var source:Object;
            var bytes:ByteArray;
            var assetList:XMLList;
            var assetNode:XML;
            var assetName:String;
            var assetType:AssetTypeDeclaration;
            var asset:IAsset;
            var assetCount:uint;
            var assetLibrary:IAssetLibrary;
            var k:uint;
            var j:uint;
            if (domain == null){
                domain = ApplicationDomain.currentDomain;
            };
            try {
                source = (resource as Object).manifest;
                if ((source is XML)){
                    manifest = (source as XML);
                }
                else {
                    if ((source is Class)){
                        bytes = (new ((source as Class))() as ByteArray);
                        manifest = new XML(bytes.readUTFBytes(bytes.length));
                    };
                };
            }
            catch(e:Error) {
                manifest = null;
            };
            if (manifest == null){
                Logger.log((("Failed to find embedded manifest.xml in " + resource) + "!"));
                return (null);
            };
            var componentList:XMLList = manifest.child("component");
            var i:uint;
            while (i < componentList.length()) {
                item = componentList[i];
                version = item.attribute("version");
                assetList = item.child("assets");
                assetCount = assetList.length();
                assetLibrary = null;
                if (assetCount > 0){
                    assetList = assetList.child("asset");
                    assetCount = assetList.length();
                    assetLibrary = new AssetLibrary(("_assets@" + componentString));
                    k = 0;
                    while (k < assetCount) {
                        assetNode = assetList[k];
                        assetName = assetNode.attribute("name");
                        assetType = assetLibrary.getAssetTypeDeclarationByMimeType(assetNode.attribute("mimeType"));
                        asset = new (assetType.assetClass)(assetType);
                        asset.setUnknownContent(resource[assetName]);
                        if (!assetLibrary.setAsset(assetName, asset)){
                            this.error((((("Manifest for component " + componentString) + ' contains broken asset "') + assetName) + '"!'), true, Core._SafeStr_8966);
                        };
                        k++;
                    };
                };
                componentString = item.attribute("class");
                componentClass = (domain.getDefinition(componentString) as Class);
                if (componentClass == null){
                    componentClass = (getDefinitionByName(componentString) as Class);
                };
                if (componentClass == null){
                    this.error((("Invalid component class " + componentString) + "!"), true, Core._SafeStr_8966);
                    return (null);
                };
                component = (((assetLibrary)==null) ? new (componentClass)(this, flags) : new (componentClass)(this, flags, assetLibrary));
                if (component != null){
                    if (assetLibrary != null){
                        if (component.assets != assetLibrary){
                            assetLibrary.dispose();
                            this.error((('Component "' + componentString) + '" did not save provided asset library!'), true, Core._SafeStr_8966);
                        };
                    };
                    interfaceList = item.child("interface");
                    iidList = new Array();
                    j = 0;
                    while (j < interfaceList.length()) {
                        iidString = interfaceList[j].attribute("iid");
                        iidClass = (domain.getDefinition(iidString) as Class);
                        if (iidClass == null){
                            iidClass = (getDefinitionByName(iidString) as Class);
                        };
                        if (iidClass == null){
                            throw (new InvalidComponentException(("Identifier class defined in manifest not found: " + iidString)));
                        };
                        iid = new (iidClass)();
                        unknown = (component as IUnknown);
                        getInterfaceStructList(component).insert(new InterfaceStruct(iid, component));
                        iidList.push(iid);
                        j++;
                    };
                    this.attachComponent(component, iidList);
                };
                i++;
            };
            return ((component as IUnknown));
        }
        final public function attachComponent(_arg_1:Component, _arg_2:Array):void
        {
            var _local_3:uint;
            var _local_5:IID;
            var _local_6:IID;
            if (this._components.indexOf(_arg_1) > -1){
                this.error((("Component " + _arg_1) + " already attached to context!"), false);
                return;
            };
            this._components.push(_arg_1);
            if (_arg_1.locked){
                _arg_1.events.addEventListener(_INTERNAL_EVENT_UNLOCKED, this.lockEventHandler);
            };
            var _local_4:uint = _arg_2.length;
            _local_3 = 0;
            while (_local_3 < _local_4) {
                _local_5 = _arg_2[_local_3];
                if (getInterfaceStructList(_arg_1).find(_local_5) == null){
                    getInterfaceStructList(_arg_1).insert(new InterfaceStruct(_local_5, _arg_1));
                };
                getInterfaceStructList(this).insert(new InterfaceStruct(_local_5, _arg_1));
                _local_3++;
            };
            if (!_arg_1.locked){
                _local_3 = 0;
                while (_local_3 < _local_4) {
                    _local_6 = _arg_2[_local_3];
                    if (this.hasQueueForInterface(_local_6)){
                        this.announceInterfaceAvailability(_local_6, _arg_1);
                    };
                    _local_3++;
                };
            };
        }
        final public function detachComponent(_arg_1:Component):void
        {
            var _local_3:InterfaceStruct;
            var _local_2:InterfaceStructList = getInterfaceStructList(this);
            var _local_4:int = _local_2.getIndexByImplementor(_arg_1);
            while (_local_4 > -1) {
                _local_3 = _local_2.remove(_local_4);
                _local_4 = _local_2.getIndexByImplementor(_arg_1);
            };
            var _local_5:uint;
            while (_local_5 < this._components.length) {
                if (this._components[_local_5] == _arg_1){
                    this._components.splice(_local_5, 1);
                    _arg_1.events.removeEventListener(_INTERNAL_EVENT_UNLOCKED, this.lockEventHandler);
                    return;
                };
                _local_5++;
            };
        }
        override public function queueInterface(_arg_1:IID, _arg_2:Function=null):IUnknown
        {
            var _local_4:IUnknown;
            var _local_3:InterfaceStruct = getInterfaceStructList(this).getStructByInterface(_arg_1);
            if (_local_3 != null){
                _local_4 = _local_3.unknown.queueInterface(_arg_1, _arg_2);
                if (_local_4){
                    return (_local_4);
                };
            };
            if (_arg_2 != null){
                this.addQueueeForInterface(_arg_1, _arg_2);
                if (((context) && (!((context == this))))){
                    context.queueInterface(_arg_1, this.announceInterfaceAvailability);
                };
            };
            return (null);
        }
        final protected function addQueueeForInterface(_arg_1:IID, _arg_2:Function):void
        {
            var _local_3:ComponentInterfaceQueue;
            if (this.hasQueueForInterface(_arg_1)){
                _local_3 = this.getQueueForInterface(_arg_1);
            }
            else {
                _local_3 = new ComponentInterfaceQueue(_arg_1);
                this._queuees.push(_local_3);
            };
            _local_3.receivers.unshift(_arg_2);
        }
        final protected function hasQueueForInterface(_arg_1:IID):Boolean
        {
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_3:uint = this._queuees.length;
            var _local_4:uint;
            while (_local_4 < _local_3) {
                if (getQualifiedClassName(this._queuees[_local_4].identifier) == _local_2){
                    return (true);
                };
                _local_4++;
            };
            return (false);
        }
        final protected function getQueueForInterface(_arg_1:IID):ComponentInterfaceQueue
        {
            var _local_3:ComponentInterfaceQueue;
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_4:uint = this._queuees.length;
            var _local_5:uint;
            while (_local_5 < _local_4) {
                _local_3 = this._queuees[_local_5];
                if (getQualifiedClassName(_local_3.identifier) == _local_2){
                    return (_local_3);
                };
                _local_5++;
            };
            return (null);
        }
        final protected function announceInterfaceAvailability(_arg_1:IID, _arg_2:Component):void
        {
            var _local_4:IUnknown;
            var _local_3:ComponentInterfaceQueue = this.getQueueForInterface(_arg_1);
            if (_local_3 == null){
                return;
            };
            var _local_5:uint = _local_3.receivers.length;
            var _local_6:uint;
            while (_local_6 < _local_5) {
                _local_4 = _arg_2.queueInterface(_arg_1);
                if (_local_4 == null){
                    this.error((("Interface " + _arg_1) + " still unavailabe!"), true, Core._SafeStr_8975);
                };
                (_local_3.receivers.pop()(_arg_1, _local_4));
                _local_6++;
            };
        }
        override public function dispose():void
        {
            var _local_1:uint;
            var _local_2:LibraryLoader;
            if (!disposed){
                super.dispose();
                if (this._components != null){
                    _local_1 = this._components.length;
                    while (_local_1-- > 0) {
                        IUnknown(this._components.pop()).dispose();
                    };
                    this._components = null;
                };
                if (this._queuees != null){
                    _local_1 = this._queuees.length;
                    while (_local_1-- > 0) {
                        IDisposable(this._queuees.pop()).dispose();
                    };
                    this._queuees = null;
                };
                if (this._SafeStr_8954 != null){
                    _local_1 = this._SafeStr_8954.length;
                    while (_local_1-- > 0) {
                        _local_2 = this._SafeStr_8954[0];
                        this.removeLibraryLoader(_local_2);
                        _local_2.dispose();
                    };
                    this._SafeStr_8954 = null;
                };
            };
        }
        private function lockEventHandler(_arg_1:LockEvent):void
        {
            var _local_2:Component;
            var _local_3:Array;
            var _local_4:InterfaceStruct;
            if (_arg_1.type == _INTERNAL_EVENT_UNLOCKED){
                _local_2 = (_arg_1.unknown as Component);
                _local_2.events.removeEventListener(_INTERNAL_EVENT_UNLOCKED, this.lockEventHandler);
                if (!disposed){
                    _local_3 = new Array();
                    getInterfaceStructList(this).mapStructsByImplementor(_local_2, _local_3);
                    while (((((_local_3.length) && (!(_local_2.disposed)))) && (!(disposed)))) {
                        _local_4 = _local_3.pop();
                        this.announceInterfaceAvailability(_local_4.iid, _local_2);
                    };
                };
            };
        }
        override public function toXMLString(_arg_1:uint=0):String
        {
            var _local_6:InterfaceStruct;
            var _local_10:Component;
            var _local_2:String = "";
            var _local_3:uint;
            while (_local_3 < _arg_1) {
                _local_2 = (_local_2 + "\t");
                _local_3++;
            };
            var _local_4:String = getQualifiedClassName(this);
            var _local_5:String = "";
            _local_5 = (_local_5 + (((_local_2 + '<context class="') + _local_4) + '" >\n'));
            var _local_7:Array = new Array();
            var _local_8:uint = getInterfaceStructList(this).mapStructsByImplementor(this, _local_7);
            var _local_9:uint;
            while (_local_9 < _local_8) {
                _local_6 = _local_7[_local_9];
                _local_5 = (_local_5 + (((((_local_2 + '\t<interface iid="') + _local_6.iis) + '" refs="') + _local_6.references) + '"/>\n'));
                _local_9++;
            };
            var _local_11:uint;
            while (_local_11 < this._components.length) {
                _local_10 = (this._components[_local_11] as Component);
                if (_local_10 != this){
                    _local_5 = (_local_5 + _local_10.toXMLString((_arg_1 + 1)));
                };
                _local_11++;
            };
            return ((_local_5 + (_local_2 + "</context>\n")));
        }

    }
}//package com.sulake.core.runtime

// IID = "_-3KV" (String#7712, DoABC#2)
// ComponentInterfaceQueue = "_-Ou" (String#8183, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// ComponentContext = "_-0jP" (String#4488, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// LockEvent = "_-4a" (String#22400, DoABC#2)
// InvalidComponentException = "_-QL" (String#8208, DoABC#2)
// InterfaceStructList = "_-0ur" (String#16233, DoABC#2)
// InterfaceStruct = "_-2vc" (String#7189, DoABC#2)
// WarningEvent = "_-16b" (String#5007, DoABC#2)
// ErrorEvent = "_-cA" (String#8459, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setAsset = "_-08Y" (String#3730, DoABC#2)
// getAssetTypeDeclarationByMimeType = "_-BD" (String#7892, DoABC#2)
// assetClass = "_-39W" (String#21863, DoABC#2)
// loadErrorHandler = "_-0IT" (String#1448, DoABC#2)
// _displayObjectContainer = "_-179" (String#16740, DoABC#2)
// attachComponent = "_-1G" (String#5169, DoABC#2)
// detachComponent = "_-28T" (String#6212, DoABC#2)
// _SafeStr_8954 = "_-3CG" (String#2020, DoABC#2)
// _SafeStr_8955 = "_-0qy" (String#16083, DoABC#2)
// getLastDebugMessage = "_-0Gl" (String#3889, DoABC#2)
// warning = "_-1MU" (String#5283, DoABC#2)
// getLastWarningMessage = "_-5e" (String#7775, DoABC#2)
// _SafeStr_8959 = "_-0NR" (String#4029, DoABC#2)
// loadReadyHandler = "_-1kP" (String#18305, DoABC#2)
// loadDebugHandler = "_-0NG" (String#14965, DoABC#2)
// removeLibraryLoader = "_-1yS" (String#18907, DoABC#2)
// prepareComponent = "_-hI" (String#8541, DoABC#2)
// _SafeStr_8964 = "_-3JI" (String#22255, DoABC#2)
// prepareAssetLibrary = "_-3GZ" (String#7637, DoABC#2)
// _SafeStr_8966 = "_-0p7" (String#16021, DoABC#2)
// getInterfaceStructList = "_-1xl" (String#18879, DoABC#2)
// _INTERNAL_EVENT_UNLOCKED = "_-1Ik" (String#17224, DoABC#2)
// lockEventHandler = "_-2EO" (String#19581, DoABC#2)
// hasQueueForInterface = "_-2Qr" (String#20082, DoABC#2)
// announceInterfaceAvailability = "_-0S-" (String#15136, DoABC#2)
// getIndexByImplementor = "_-m6" (String#24113, DoABC#2)
// addQueueeForInterface = "_-2Xh" (String#20347, DoABC#2)
// getQueueForInterface = "_-0Ep" (String#14636, DoABC#2)
// _SafeStr_8975 = "_-3-U" (String#21481, DoABC#2)
// iis = "_-2RW" (String#20099, DoABC#2)
// references = "_-1yb" (String#18912, DoABC#2)


