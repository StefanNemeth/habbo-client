
package com.sulake.core.runtime
{
    import com.sulake.core.utils.LibraryLoaderQueue;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.core.Core;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.sulake.core.utils.profiler.ProfilerViewer;
    import flash.display.DisplayObjectContainer;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.utils.LibraryLoader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.runtime.events.LibraryProgressEvent;
    import flash.utils.getQualifiedClassName;

    public final class CoreComponentContext extends ComponentContext implements ICore 
    {

        private static const _SafeStr_8900:uint = 3;
        private static const _SafeStr_8901:String = "asset-libraries";
        private static const _SafeStr_8902:String = "library";
        private static const _SafeStr_8903:String = "service-libraries";
        private static const _SafeStr_8904:String = "library";
        private static const _SafeStr_8905:String = "component-libraries";
        private static const _SafeStr_8906:String = "library";
        private static const _SafeStr_8907:String = "error_data";
        private static const _SafeStr_8908:String = "error_cat";
        private static const _SafeStr_8909:String = "error_desc";

        private var _SafeStr_8910:LibraryLoaderQueue;
        private var _SafeStr_8911:IEventDispatcher;
        private var _SafeStr_8912:uint;
        private var _SafeStr_8913:Function;
        private var _profiler:Profiler;
        private var _SafeStr_8914:Array;
        private var _SafeStr_8915:Array;
        private var _lastUpdateTimeMs:uint;
        private var _SafeStr_8916:uint = 0;

        public function CoreComponentContext(_arg_1:DisplayObjectContainer, _arg_2:uint)
        {
            super(this, Component.COMPONENT_FLAG_CONTEXT, new AssetLibraryCollection("_core_assets"));
            this._SafeStr_8916 = _arg_2;
            _debug = ((_arg_2 & Core.CORE_SETUP_DEBUG) == Core.CORE_SETUP_DEBUG);
            this._SafeStr_8914 = new Array();
            this._SafeStr_8915 = new Array();
            _displayObjectContainer = _arg_1;
            var _local_3:uint;
            while (_local_3 < CoreComponentContext._SafeStr_8900) {
                this._SafeStr_8914.push(new Array());
                this._SafeStr_8915.push(0);
                _local_3++;
            };
            this._lastUpdateTimeMs = getTimer();
            attachComponent(this, [new IIDCore()]);
            _displayObjectContainer.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            switch ((_arg_2 & Core._SafeStr_8919)){
                case Core._SafeStr_8921:
                    debug("Core; using simple frame update handler");
                    this._SafeStr_8913 = this.simpleFrameUpdateHandler;
                    return;
                case Core._SafeStr_8923:
                    debug("Core; using complex frame update handler");
                    this._SafeStr_8913 = this.complexFrameUpdateHandler;
                    return;
                case Core._SafeStr_8925:
                    debug("Core; using profiler frame update handler");
                    this._SafeStr_8913 = this.profilerFrameUpdateHandler;
                    this._profiler = new Profiler(this);
                    attachComponent(this._profiler, [new IIDProfiler()]);
                    _displayObjectContainer.addChild(new ProfilerViewer(this._profiler));
                    return;
                case Core._SafeStr_8927:
                    debug("Core; using experimental frame update handler");
                    this._SafeStr_8913 = this.experimentalFrameUpdateHandler;
                    return;
                case Core.CORE_SETUP_DEBUG:
                    debug("Core; using debug frame update handler");
                    this._SafeStr_8913 = this.debugFrameUpdateHandler;
                    return;
            };
        }
        public function getNumberOfFilesPending():uint
        {
            return (this._SafeStr_8910.length);
        }
        public function getNumberOfFilesLoaded():uint
        {
            return ((this._SafeStr_8912 - this.getNumberOfFilesPending()));
        }
        public function initialize():void
        {
            events.dispatchEvent(new Event(Component.COMPONENT_EVENT_RUNNING));
            Logger.log(toXMLString());
        }
        override public function dispose():void
        {
            var length:uint;
            var receivers:Array;
            var receiver:* = undefined;
            var i:uint;
            if (!disposed){
                debug("Disposing core");
                try {
                    i = 0;
                    while (i < CoreComponentContext._SafeStr_8900) {
                        receivers = (this._SafeStr_8914[i] as Array);
                        length = receivers.length;
                        while (length-- > 0) {
                            receiver = receivers.pop();
                            if ((receiver is UpdateDelegate)){
                                UpdateDelegate(receiver).dispose();
                            };
                        };
                        i++;
                    };
                }
                catch(e:Error) {
                };
                if (_displayObjectContainer){
                    _displayObjectContainer.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                    _displayObjectContainer = null;
                };
                if (this._SafeStr_8910 != null){
                    this._SafeStr_8910.dispose();
                    this._SafeStr_8910 = null;
                };
                super.dispose();
            };
        }
        override public function error(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
        {
            if (_arg_4){
                ErrorReportStorage.setParameter(_SafeStr_8907, String(_arg_4.getStackTrace()));
            };
            ErrorReportStorage.setParameter(_SafeStr_8908, String(_arg_3));
            ErrorReportStorage.setParameter(_SafeStr_8909, _arg_1);
            super.error(_arg_1, _arg_2, _arg_3, _arg_4);
            if (_arg_2){
                this.dispose();
            };
        }
        public function readConfigDocument(config:XML, loadingEventDelegate:IEventDispatcher=null):void
        {
            var node:XML;
            var list:XMLList;
            var item:XML;
            var url:String;
            var loader:LibraryLoader;
            var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            debug("Parsing config document");
            this._SafeStr_8911 = loadingEventDelegate;
            if (this._SafeStr_8910 == null){
                this._SafeStr_8910 = new LibraryLoaderQueue(_debug);
            };
            try {
                node = config.child(_SafeStr_8901)[0];
                if (node != null){
                    list = node.child(_SafeStr_8902);
                    for each (item in list) {
                        url = item.attribute("url").toString();
                        loader = new LibraryLoader(context, true, _debug);
                        assets.loadFromFile(loader, true);
                        loader.load(new URLRequest(url));
                        this._SafeStr_8910.push(loader);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                        this._SafeStr_8912++;
                    };
                };
            }
            catch(e:Error) {
                error("Failed to parse asset libraries from config xml!", true, Core._SafeStr_8935, e);
            };
            try {
                node = config.child(_SafeStr_8903)[0];
                if (node != null){
                    list = node.child(_SafeStr_8904);
                    for each (item in list) {
                        url = item.attribute("url").toString();
                        loader = new LibraryLoader(context, true, _debug);
                        loader.load(new URLRequest(url));
                        this._SafeStr_8910.push(loader);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                        this._SafeStr_8912++;
                    };
                };
            }
            catch(e:Error) {
                error("Failed to parse interfaces from config xml!", true, Core._SafeStr_8935, e);
            };
            try {
                node = config.child(_SafeStr_8905)[0];
                if (node != null){
                    list = node.child(_SafeStr_8906);
                    for each (item in list) {
                        url = item.attribute("url").toString();
                        loader = new LibraryLoader(context, true, _debug);
                        loader.load(new URLRequest(url));
                        this._SafeStr_8910.push(loader);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                        this._SafeStr_8912++;
                    };
                };
            }
            catch(e:Error) {
                error("Failed to parse components from config xml!", true, Core._SafeStr_8935, e);
            };
            if (!disposed){
                this.updateLoadingProcess();
            };
        }
        private function errorInLoadingProcess(_arg_1:LibraryLoaderEvent=null):void
        {
            var _local_2:LibraryLoader = LibraryLoader(_arg_1.target);
            this.error(((((('Failed to download library "' + _local_2.url) + '" HTTP status ') + _arg_1.status) + ": ") + _local_2.getLastErrorMessage()), true, Core._SafeStr_8936);
            if (!disposed){
                this.updateLoadingProcess(_arg_1);
            };
        }
        private function finalizeLoadingEventDelegate():void
        {
            if (this._SafeStr_8911){
                this._SafeStr_8911.dispatchEvent(new Event(Event.COMPLETE));
            };
        }
        private function updateLoadingProgress(_arg_1:LibraryLoaderEvent=null):void
        {
            var _local_2:LibraryLoader;
            if (this._SafeStr_8911){
                _local_2 = (_arg_1.target as LibraryLoader);
                this._SafeStr_8911.dispatchEvent(new LibraryProgressEvent(_local_2.url, _arg_1.bytesLoaded, _arg_1.bytesTotal, _local_2.elapsedTime));
            };
        }
        private function updateLoadingProcess(_arg_1:LibraryLoaderEvent=null):void
        {
            var _local_2:LibraryLoader;
            var _local_3:String;
            if (_arg_1 != null){
                if ((((_arg_1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE)) || ((_arg_1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR)))){
                    _local_2 = (_arg_1.target as LibraryLoader);
                    _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                    _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                    _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.updateLoadingProgress);
                    _local_3 = _local_2.url;
                    debug(((('Loading library "' + _local_3) + '" ') + (((_arg_1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE)) ? "ready" : ("failed\n" + _local_2.getLastErrorMessage()))));
                    _local_2.dispose();
                    if (!disposed){
                        if (this._SafeStr_8911){
                            this._SafeStr_8911.dispatchEvent(new LibraryProgressEvent(_local_2.url, (this._SafeStr_8912 - this._SafeStr_8910.length), this._SafeStr_8912, _local_2.elapsedTime));
                        };
                    };
                };
            };
            if (!disposed){
                if (this._SafeStr_8910.length == 0){
                    this.finalizeLoadingEventDelegate();
                    debug("All libraries loaded, Core is now running");
                };
            };
        }
        override public function registerUpdateReceiver(_arg_1:IUpdateReceiver, _arg_2:uint):void
        {
            this.removeUpdateReceiver(_arg_1);
            _arg_2 = (((_arg_2 >= CoreComponentContext._SafeStr_8900)) ? (CoreComponentContext._SafeStr_8900 - 1) : _arg_2);
            var _local_3:int = ((this._profiler) ? Core._SafeStr_8925 : (this._SafeStr_8916 & Core._SafeStr_8919));
            if (_local_3 == Core._SafeStr_8927){
                this._SafeStr_8914[_arg_2].push(new UpdateDelegate(_arg_1, this, _arg_2));
            }
            else {
                this._SafeStr_8914[_arg_2].push(_arg_1);
            };
        }
        override public function removeUpdateReceiver(_arg_1:IUpdateReceiver):void
        {
            var _local_2:int;
            var _local_3:Array;
            var _local_6:UpdateDelegate;
            if (disposed){
                return;
            };
            var _local_4:int = ((this._profiler) ? Core._SafeStr_8925 : (this._SafeStr_8916 & Core._SafeStr_8919));
            var _local_5:uint;
            while (_local_5 < CoreComponentContext._SafeStr_8900) {
                _local_3 = (this._SafeStr_8914[_local_5] as Array);
                if (_local_4 == Core._SafeStr_8927){
                    for each (_local_6 in _local_3) {
                        if (_local_6.receiver == _arg_1){
                            _local_6.dispose();
                            return;
                        };
                    };
                }
                else {
                    _local_2 = _local_3.indexOf(_arg_1);
                    if (_local_2 > -1){
                        _local_3[_local_2] = null;
                        return;
                    };
                };
                _local_5++;
            };
        }
        private function onEnterFrame(_arg_1:Event):void
        {
            var _local_2:uint = getTimer();
            this._SafeStr_8913(_local_2, (_local_2 - this._lastUpdateTimeMs));
            this._lastUpdateTimeMs = _local_2;
        }
        private function simpleFrameUpdateHandler(msCurrentTime:uint, msSinceLastUpdate:uint):void
        {
            var priority:uint;
            var receivers:Array;
            var receiver:IUpdateReceiver;
            var length:uint;
            var index:uint;
            priority = 0;
            while (priority < CoreComponentContext._SafeStr_8900) {
                this._SafeStr_8915[priority] = 0;
                receivers = this._SafeStr_8914[priority];
                index = 0;
                length = receivers.length;
                while (index != length) {
                    receiver = IUpdateReceiver(receivers[index]);
                    if ((((receiver == null)) || (receiver.disposed))){
                        receivers.splice(index, 1);
                        length--;
                    }
                    else {
                        try {
                            receiver.update(msSinceLastUpdate);
                        }
                        catch(e:Error) {
                            error(((('Error in update receiver "' + getQualifiedClassName(receiver)) + '": ') + e.message), true, e.errorID, e);
                            return;
                        };
                        index++;
                    };
                };
                priority++;
            };
        }
        private function complexFrameUpdateHandler(msCurrentTime:uint, msSinceLastUpdate:uint):void
        {
            var priority:uint;
            var receivers:Array;
            var receiver:IUpdateReceiver;
            var length:uint;
            var index:uint;
            var skip:Boolean;
            var t:uint;
            var proceed:Boolean = true;
            var maxTimePerFrame:uint = (1000 / _displayObjectContainer.stage.frameRate);
            priority = 0;
            while (priority < CoreComponentContext._SafeStr_8900) {
                t = getTimer();
                skip = false;
                if ((t - msCurrentTime) > maxTimePerFrame){
                    if (this._SafeStr_8915[priority] < priority){
                        var _local_4 = this._SafeStr_8915;
                        var _local_5 = priority;
                        var _local_6 = (_local_4[_local_5] + 1);
                        _local_4[_local_5] = _local_6;
                        skip = true;
                    };
                };
                if (!skip){
                    this._SafeStr_8915[priority] = 0;
                    receivers = this._SafeStr_8914[priority];
                    index = 0;
                    length = receivers.length;
                    while (((!((index == length))) && (proceed))) {
                        receiver = IUpdateReceiver(receivers[index]);
                        if ((((receiver == null)) || (receiver.disposed))){
                            receivers.splice(index, 1);
                            length--;
                        }
                        else {
                            try {
                                receiver.update(msSinceLastUpdate);
                            }
                            catch(e:Error) {
                                error(((('Error in update receiver "' + getQualifiedClassName(receiver)) + '": ') + e.message), true, e.errorID, e);
                                proceed = false;
                            };
                            index++;
                        };
                    };
                };
                priority++;
            };
        }
        private function profilerFrameUpdateHandler(msCurrentTime:uint, msSinceLastUpdate:uint):void
        {
            var priority:uint;
            var receivers:Array;
            var receiver:IUpdateReceiver;
            var length:uint;
            var index:uint;
            this._profiler.start();
            priority = 0;
            while (priority < CoreComponentContext._SafeStr_8900) {
                this._SafeStr_8915[priority] = 0;
                receivers = this._SafeStr_8914[priority];
                index = 0;
                length = receivers.length;
                while (index != length) {
                    receiver = IUpdateReceiver(receivers[index]);
                    if ((((receiver == null)) || (receiver.disposed))){
                        receivers.splice(index, 1);
                        length--;
                    }
                    else {
                        try {
                            this._profiler.update(receiver, msSinceLastUpdate);
                        }
                        catch(e:Error) {
                            error(((('Error in update receiver "' + getQualifiedClassName(receiver)) + '": ') + e.message), true, e.errorID, e);
                            return;
                        };
                        index++;
                    };
                };
                priority++;
            };
            this._profiler.stop();
        }
        private function experimentalFrameUpdateHandler(_arg_1:uint, _arg_2:uint):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_3:int;
            while (_local_3 < CoreComponentContext._SafeStr_8900) {
                _local_4 = this._SafeStr_8914[_local_3];
                _local_5 = (_local_4.length - 1);
                while (_local_5 > -1) {
                    if (_local_4[_local_5].disposed){
                        _local_4.splice(_local_5, 1);
                    };
                    _local_5--;
                };
                _local_3++;
            };
        }
        private function debugFrameUpdateHandler(_arg_1:uint, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_4:Array;
            var _local_5:IUpdateReceiver;
            var _local_6:uint;
            var _local_7:uint;
            _local_3 = 0;
            while (_local_3 < CoreComponentContext._SafeStr_8900) {
                this._SafeStr_8915[_local_3] = 0;
                _local_4 = this._SafeStr_8914[_local_3];
                _local_7 = 0;
                _local_6 = _local_4.length;
                while (_local_7 != _local_6) {
                    _local_5 = IUpdateReceiver(_local_4[_local_7]);
                    if ((((_local_5 == null)) || (_local_5.disposed))){
                        _local_4.splice(_local_7, 1);
                        _local_6--;
                    }
                    else {
                        _local_5.update(_arg_2);
                        _local_7++;
                    };
                };
                _local_3++;
            };
        }
        public function setProfilerMode(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:Array;
            var _local_4:Object;
            var _local_5:int;
            if (_arg_1){
                this._SafeStr_8913 = this.profilerFrameUpdateHandler;
                if (!this._profiler){
                    this._profiler = new Profiler(this);
                    attachComponent(this._profiler, [new IIDProfiler()]);
                };
                _local_2 = 0;
                while (_local_2 < CoreComponentContext._SafeStr_8900) {
                    _local_3 = this._SafeStr_8914[_local_2];
                    _local_5 = (_local_3.length - 1);
                    while (_local_5 > -1) {
                        _local_4 = _local_3[_local_5];
                        if ((_local_4 is UpdateDelegate)){
                            _local_3[_local_5] = UpdateDelegate(_local_4).receiver;
                            UpdateDelegate(_local_4).dispose();
                        };
                        _local_5--;
                    };
                    _local_2++;
                };
            }
            else {
                if (this._profiler){
                    detachComponent(this._profiler);
                    this._profiler.dispose();
                    this._profiler = null;
                };
                switch ((this._SafeStr_8916 & Core._SafeStr_8919)){
                    case Core._SafeStr_8921:
                        this._SafeStr_8913 = this.simpleFrameUpdateHandler;
                        return;
                    case Core._SafeStr_8923:
                        this._SafeStr_8913 = this.complexFrameUpdateHandler;
                        return;
                    case Core._SafeStr_8927:
                        this._SafeStr_8913 = this.experimentalFrameUpdateHandler;
                        _local_2 = 0;
                        while (_local_2 < CoreComponentContext._SafeStr_8900) {
                            _local_3 = this._SafeStr_8914[_local_2];
                            _local_5 = (_local_3.length - 1);
                            while (_local_5 > -1) {
                                _local_4 = _local_3[_local_5];
                                if ((_local_4 is IUpdateReceiver)){
                                    _local_3[_local_5] = new UpdateDelegate(IUpdateReceiver(_local_4), this, _local_2);
                                };
                                _local_5--;
                            };
                            _local_2++;
                        };
                        return;
                    default:
                        this._SafeStr_8913 = this.debugFrameUpdateHandler;
                };
            };
        }

    }
}//package com.sulake.core.runtime

import com.sulake.core.runtime.IDisposable;
import com.sulake.core.runtime.IUpdateReceiver;
import com.sulake.core.runtime.IContext;
import flash.events.Event;
import flash.utils.getTimer;
import flash.utils.getQualifiedClassName;

class UpdateDelegate implements IDisposable 
{

    /*private*/ var _receiver:IUpdateReceiver;
    /*private*/ var _context:IContext;
    /*private*/ var _priority:int;
    /*private*/ var _lastUpdateTimeMs:uint;
    /*private*/ var _framesSkipped:uint = 0;

    public function UpdateDelegate(_arg_1:IUpdateReceiver, _arg_2:IContext, _arg_3:int)
    {
        if (((_arg_2) && (_arg_1))){
            this._receiver = _arg_1;
            this._context = _arg_2;
            this._priority = _arg_3;
            _arg_2.displayObjectContainer.stage.addEventListener((((this._priority == 0)) ? Event.EXIT_FRAME : Event.ENTER_FRAME), this.onFrameUpdate);
            this._lastUpdateTimeMs = getTimer();
        };
    }
    public function get priority():int
    {
        return (this._priority);
    }
    public function get receiver():IUpdateReceiver
    {
        return (this._receiver);
    }
    public function get disposed():Boolean
    {
        return (((this._receiver) ? this._receiver.disposed : true));
    }
    public function dispose():void
    {
        if (this._receiver){
            this._receiver = null;
            this._context.displayObjectContainer.stage.removeEventListener((((this._priority == 0)) ? Event.EXIT_FRAME : Event.ENTER_FRAME), this.onFrameUpdate);
            this._context = null;
        };
    }
    /*private*/ function onFrameUpdate(event:Event):void
    {
        var msCurrentTime:uint;
        var msDeltaTime:uint;
        if (!this.disposed){
            msCurrentTime = getTimer();
            msDeltaTime = (msCurrentTime - this._lastUpdateTimeMs);
            this._lastUpdateTimeMs = msCurrentTime;
            if ((((this._priority > 0)) && ((this._framesSkipped < this._priority)))){
                if (msDeltaTime > (1000 / this._context.displayObjectContainer.stage.frameRate)){
                    this._framesSkipped++;
                    return;
                };
            };
            this._framesSkipped = 0;
            try {
                this._receiver.update(msDeltaTime);
            }
            catch(e:Error) {
                _context.error(((('Error in update receiver "' + getQualifiedClassName(_receiver)) + '": ') + e.message), true, e.errorID, e);
            };
        };
    }

}

// CoreComponentContext = "_-2R5" (String#6581, DoABC#2)
// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// IIDProfiler = "_-1l" (String#18333, DoABC#2)
// IIDCore = "_-2To" (String#20191, DoABC#2)
// Profiler = "_-1j4" (String#5736, DoABC#2)
// ProfilerViewer = "_-0t6" (String#16164, DoABC#2)
// LibraryLoaderQueue = "_-00R" (String#14071, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// onEnterFrame = "_-20T" (String#6057, DoABC#2)
// ICore = "_-2kX" (String#6966, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// LibraryProgressEvent = "_-26o" (String#19282, DoABC#2)
// ComponentContext = "_-0jP" (String#4488, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// _profiler = "_-qk" (String#8720, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// elapsedTime = "_-3Cm" (String#21986, DoABC#2)
// _SafeStr_8900 = "_-2YM" (String#20371, DoABC#2)
// _SafeStr_8901 = "_-yD" (String#24623, DoABC#2)
// _SafeStr_8902 = "_-0nH" (String#15947, DoABC#2)
// _SafeStr_8903 = "_-Ae" (String#22642, DoABC#2)
// _SafeStr_8904 = "_-1I8" (String#17198, DoABC#2)
// _SafeStr_8905 = "_-OG" (String#23178, DoABC#2)
// _SafeStr_8906 = "_-1b3" (String#17936, DoABC#2)
// _SafeStr_8907 = "_-Tz" (String#23406, DoABC#2)
// _SafeStr_8908 = "_-1eE" (String#18067, DoABC#2)
// _SafeStr_8909 = "_-2oE" (String#21011, DoABC#2)
// _SafeStr_8910 = "_-061" (String#14283, DoABC#2)
// _SafeStr_8911 = "_-2Jo" (String#19802, DoABC#2)
// _SafeStr_8912 = "_-33q" (String#21653, DoABC#2)
// _SafeStr_8913 = "_-00Y" (String#14076, DoABC#2)
// _SafeStr_8914 = "_-34k" (String#21686, DoABC#2)
// _SafeStr_8915 = "_-1Tw" (String#17663, DoABC#2)
// _SafeStr_8916 = "_-27n" (String#877, DoABC#2)
// _displayObjectContainer = "_-179" (String#16740, DoABC#2)
// attachComponent = "_-1G" (String#5169, DoABC#2)
// _SafeStr_8919 = "_-2Sm" (String#20150, DoABC#2)
// simpleFrameUpdateHandler = "_-0pS" (String#16034, DoABC#2)
// _SafeStr_8921 = "_-1te" (String#18704, DoABC#2)
// complexFrameUpdateHandler = "_-0MQ" (String#14931, DoABC#2)
// _SafeStr_8923 = "_-3J" (String#22237, DoABC#2)
// profilerFrameUpdateHandler = "_-2QU" (String#20066, DoABC#2)
// _SafeStr_8925 = "_-0uX" (String#16222, DoABC#2)
// experimentalFrameUpdateHandler = "_-T-" (String#23365, DoABC#2)
// _SafeStr_8927 = "_-1lp" (String#18368, DoABC#2)
// debugFrameUpdateHandler = "_-2sE" (String#21168, DoABC#2)
// getNumberOfFilesPending = "_-2Yn" (String#6742, DoABC#2)
// getNumberOfFilesLoaded = "_-2cq" (String#6808, DoABC#2)
// setParameter = "_-33Y" (String#21643, DoABC#2)
// readConfigDocument = "_-0ct" (String#4365, DoABC#2)
// updateLoadingProcess = "_-2hf" (String#20760, DoABC#2)
// errorInLoadingProcess = "_-2Q9" (String#20051, DoABC#2)
// _SafeStr_8935 = "_-0DA" (String#14575, DoABC#2)
// _SafeStr_8936 = "_-Y9" (String#23568, DoABC#2)
// finalizeLoadingEventDelegate = "_-2OQ" (String#19983, DoABC#2)
// updateLoadingProgress = "_-2KE" (String#19813, DoABC#2)
// setProfilerMode = "_-hp" (String#8551, DoABC#2)
// detachComponent = "_-28T" (String#6212, DoABC#2)


