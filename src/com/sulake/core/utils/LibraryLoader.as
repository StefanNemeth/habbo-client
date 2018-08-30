
package com.sulake.core.utils
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.utils.getTimer;
    import flash.display.DisplayObject;
    import flash.net.URLRequestHeader;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.MovieClip;
    import flash.display.FrameLabel;
    import flash.utils.ByteArray;
    import com.sulake.core.Core;

    public class LibraryLoader extends EventDispatcher implements IDisposable 
    {

        protected static const _SafeStr_9024:uint = 1;
        protected static const _SafeStr_9025:uint = 2;
        protected static const _SafeStr_9026:uint = 4;
        protected static const _SafeStr_9027:uint = 3;
        protected static const _SafeStr_5891:uint = 7;
        public static const _SafeStr_9028:int = 5;
        public static const LIBRARY_LOADER_FINALIZE:String = "LIBRARY_LOADER_FINALIZE";
        public static const _SafeStr_9029:Boolean = false;
        public static const _SafeStr_9017:int = 2;
        private static var _SafeStr_9030:Array = new Array();
        private static var _SafeStr_9031:Array = new Array();

        protected var _content:Loader;
        protected var _context:LoaderContext;
        protected var _status:int = 0;
        protected var _request:URLRequest;
        protected var _manifest:XML;
        protected var _resource:Class;
        protected var _SafeStr_9033:uint = 0;
        protected var _name:String;
        protected var _ready:Boolean = false;
        protected var _debug:Boolean = false;
        protected var _paused:Boolean = false;
        protected var _lastErrorMessage:String = "";
        protected var _lastDebugMessage:String = "";
        protected var _SafeStr_9037:int;
        protected var _SafeStr_9038:int;
        protected var _SafeStr_9039:int;
        protected var _SafeStr_9040:uint = 0;
        protected var _SafeStr_9041:Boolean = true;

        public function LibraryLoader(_arg_1:LoaderContext=null, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            if (_arg_1 == null){
                this._context = new LoaderContext();
                this._context.applicationDomain = ApplicationDomain.currentDomain;
            }
            else {
                this._context = _arg_1;
            };
            this._paused = _arg_2;
            this._debug = _arg_3;
            this._status = 0;
            this._content = new Loader();
            this._content.contentLoaderInfo.addEventListener(Event.INIT, this.loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(Event.UNLOAD, this.loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadEventHandler);
            super();
        }
        protected static function parseNameFromUrl(_arg_1:String):String
        {
            var _local_2:int;
            _local_2 = _arg_1.indexOf("?", 0);
            if (_local_2 > -1){
                _arg_1 = _arg_1.slice(0, _local_2);
            };
            _local_2 = _arg_1.lastIndexOf(".");
            if (_local_2 > -1){
                _arg_1 = _arg_1.slice(0, _local_2);
            };
            _local_2 = _arg_1.lastIndexOf("/");
            if (_local_2 > -1){
                _arg_1 = _arg_1.slice((_local_2 + 1), _arg_1.length);
            };
            return (_arg_1);
        }
        protected static function queue(_arg_1:LibraryLoader):void
        {
            if (_SafeStr_9029){
                if (_SafeStr_9030.indexOf(_arg_1) == -1){
                    _SafeStr_9030.push(_arg_1);
                };
                throttle();
            }
            else {
                _arg_1._content.load(_arg_1._request, _arg_1._context);
            };
        }
        protected static function throttle():void
        {
            var _local_1:LibraryLoader;
            var _local_2:int;
            if (_SafeStr_9029){
                _local_2 = (_SafeStr_9031.length - 1);
                while (_local_2 > -1) {
                    _local_1 = (_SafeStr_9031[_local_2] as LibraryLoader);
                    if (((_local_1) && (((_local_1.ready) || (_local_1.disposed))))){
                        _SafeStr_9031.splice(_local_2, 1);
                    };
                    _local_2--;
                };
                while ((((_SafeStr_9031.length < _SafeStr_9017)) && ((_SafeStr_9030.length > 0)))) {
                    _local_1 = (_SafeStr_9030.shift() as LibraryLoader);
                    if (((!(_local_1.ready)) && (!(_local_1.disposed)))){
                        _SafeStr_9031.push(_local_1);
                        _local_1._content.load(_local_1._request, _local_1._context);
                    };
                };
            };
        }

        public function get url():String
        {
            return (((this._request) ? this._request.url : null));
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get ready():Boolean
        {
            return (this._ready);
        }
        public function get status():int
        {
            return (this._status);
        }
        public function get domain():ApplicationDomain
        {
            return (this._content.contentLoaderInfo.applicationDomain);
        }
        public function get request():URLRequest
        {
            return (this._request);
        }
        public function get resource():Class
        {
            return (this._resource);
        }
        public function get manifest():XML
        {
            return (this._manifest);
        }
        public function get bytesTotal():uint
        {
            return (this._content.contentLoaderInfo.bytesTotal);
        }
        public function get bytesLoaded():uint
        {
            return (this._content.contentLoaderInfo.bytesLoaded);
        }
        public function get elapsedTime():uint
        {
            return (((this._ready) ? (this._SafeStr_9038 - this._SafeStr_9037) : (getTimer() - this._SafeStr_9037)));
        }
        public function get paused():Boolean
        {
            return (this._paused);
        }
        protected function get content():DisplayObject
        {
            return (this._content.content);
        }
        override public function dispose():void
        {
            if (!disposed){
                dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DISPOSE, this._status, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                try {
                    this._content.close();
                }
                catch(e:Error) {
                };
                try {
                    this._content.unload();
                }
                catch(e:Error) {
                };
                this._content = null;
                this._context = null;
                this._resource = null;
                this._manifest = null;
                super.dispose();
            };
        }
        public function load(_arg_1:URLRequest, _arg_2:int=5):void
        {
            this._request = _arg_1;
            this._name = parseNameFromUrl(this._request.url);
            this._ready = false;
            this._SafeStr_9039 = _arg_2;
            ErrorReportStorage.addDebugData("Library url", ("Library url " + _arg_1.url));
            ErrorReportStorage.addDebugData("Library name", ("Library name " + this._name));
            if (!this._paused){
                this._paused = true;
                this.final();
            };
        }
        public function final():void
        {
            if (((this._paused) && (!(_disposed)))){
                this._paused = false;
                if (((!(this._ready)) && (this._request))){
                    this._SafeStr_9038 = -1;
                    this._SafeStr_9037 = getTimer();
                    queue(this);
                };
            };
        }
        protected function retry():Boolean
        {
            if (((((!(this._ready)) && (!(_disposed)))) && ((this._SafeStr_9039 > 0)))){
                try {
                    this._content.close();
                    this._content.unload();
                }
                catch(e:Error) {
                };
                this.addRequestCounterToUrlRequest(this._request, (_SafeStr_9028 - this._SafeStr_9039));
                if (this._SafeStr_9041){
                    this._request.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
                    this._request.requestHeaders.push(new URLRequestHeader("Cache-Control", "no-cache"));
                    this._SafeStr_9041 = false;
                };
                this._SafeStr_9039--;
                this._SafeStr_9033 = 0;
                this._content.load(this._request, this._context);
                return (true);
            };
            return (false);
        }
        public function hasDefinition(name:String):Boolean
        {
            var result:Boolean;
            try {
                result = this._content.contentLoaderInfo.applicationDomain.hasDefinition(name);
            }
            catch(e:Error) {
            };
            return (result);
        }
        public function getDefinition(name:String):Object
        {
            var result:Object;
            try {
                if (this._content.contentLoaderInfo.applicationDomain.hasDefinition(name)){
                    result = this._content.contentLoaderInfo.applicationDomain.getDefinition(name);
                };
            }
            catch(e:Error) {
            };
            return (result);
        }
        protected function loadEventHandler(_arg_1:Event):void
        {
            var _local_2:Timer;
            switch (_arg_1.type){
                case Event.INIT:
                    this.debug((('Load event INIT for file "' + this.url) + '"'));
                    this._SafeStr_9033 = (this._SafeStr_9033 | LibraryLoader._SafeStr_9025);
                    break;
                case Event.COMPLETE:
                    this.debug((('Load event COMPLETE for file "' + this.url) + '"'));
                    this._SafeStr_9033 = (this._SafeStr_9033 | LibraryLoader._SafeStr_9024);
                    break;
                case Event.ENTER_FRAME:
                    break;
                case HTTPStatusEvent.HTTP_STATUS:
                    this._status = HTTPStatusEvent(_arg_1).status;
                    this.debug((((("Load event STATUS " + this._status) + ' for file "') + this.url) + '"'));
                    break;
                case Event.UNLOAD:
                    this.debug((('Load event UNLOAD for file "' + this.url) + '"'));
                    dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_UNLOAD, this._status, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                    break;
                case ProgressEvent.PROGRESS:
                    this.debug(((((('Load event PROGRESS for file "' + this.url) + '"  bytes: ') + this.bytesLoaded) + "/") + this.bytesTotal));
                    dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this._status, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                    break;
                case IOErrorEvent.IO_ERROR:
                    this.debug((('Load event IO ERROR for file "' + this.url) + '"'));
                    if (!this.handleHttpStatus(this._status)){
                        this._SafeStr_9038 = getTimer();
                        this.failure((('IO Error, send or load operation failed for file "' + this.url) + '"'));
                        this.removeEventListeners();
                    };
                    break;
                case SecurityErrorEvent.SECURITY_ERROR:
                    this._SafeStr_9038 = getTimer();
                    this.failure((('Security Error, security violation with file "' + this.url) + '"'));
                    this.removeEventListeners();
                    break;
                case TimerEvent.TIMER:
                    _local_2 = (TimerEvent(_arg_1).target as Timer);
                    _local_2.removeEventListener(TimerEvent.TIMER, this.loadEventHandler);
                    _local_2.stop();
                    if (!_disposed){
                        this._SafeStr_9033 = LibraryLoader._SafeStr_5891;
                        this.loadEventHandler(new Event(Event.COMPLETE));
                    };
                    return;
                default:
                    Logger.log((("LibraryLoader::loadEventHandler(" + _arg_1) + ")"));
            };
            if (this._SafeStr_9033 == LibraryLoader._SafeStr_9027){
                if (this.analyzeLibrary()){
                    this._SafeStr_9033 = (this._SafeStr_9033 | LibraryLoader._SafeStr_9026);
                };
            };
            if (this._SafeStr_9033 == LibraryLoader._SafeStr_5891){
                if (this.prepareLibrary()){
                    this._ready = true;
                    this._SafeStr_9038 = getTimer();
                    this.removeEventListeners();
                    throttle();
                    dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this._status, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                    dispatchEvent(new Event(LIBRARY_LOADER_FINALIZE));
                };
            };
        }
        protected function analyzeLibrary():Boolean
        {
            var _local_1:MovieClip;
            var _local_2:FrameLabel;
            var _local_3:Array;
            var _local_4:uint;
            this.debug((((('Analyzing library "' + this._name) + '", content ') + (((this.content is MovieClip)) ? "is" : "is not")) + " a MovieClip"));
            this.debug(((("\tBytes loaded: " + this._content.contentLoaderInfo.bytesLoaded) + "/") + this._content.contentLoaderInfo.bytesTotal));
            if ((this.content is MovieClip)){
                _local_1 = (this.content as MovieClip);
                _local_3 = _local_1.currentLabels;
                this.debug((((((('\tLibrary "' + this._name) + '" is in frame ') + _local_1.currentFrame) + "(") + _local_1.currentLabel) + ")"));
                if (_local_3.length > 1){
                    _local_4 = 0;
                    while (_local_4 < _local_3.length) {
                        _local_2 = (_local_3[_local_4] as FrameLabel);
                        if (_local_2.name == this._name){
                            if (_local_2.frame != _local_1.currentFrame){
                                _local_1.addEventListener(Event.ENTER_FRAME, this.loadEventHandler);
                                return (false);
                            };
                        };
                        _local_4++;
                    };
                };
            };
            return (true);
        }
        protected function prepareLibrary():Boolean
        {
            var xmlClass:Class;
            this.debug((('Preparing library "' + this._name) + '"'));
            this._resource = (this.getDefinition(this._name) as Class);
            if (this._resource == null){
                if (!this.retry()){
                    this.failure((((('Failed to find resource class "' + this._name) + '" from library ') + this._request.url) + "!"));
                };
                return (false);
            };
            var result:Boolean = true;
            try {
                xmlClass = (this._resource.manifest as Class);
                if (xmlClass == null){
                    return (false);
                };
            }
            catch(e:Error) {
                if (!retry()){
                    failure((("Failed to find embedded manifest.xml from library " + _request.url) + "!"));
                };
                result = false;
            };
            if (!result){
                return (false);
            };
            var bytes:ByteArray = (new (xmlClass)() as ByteArray);
            try {
                this._manifest = new XML(bytes.readUTFBytes(bytes.length));
            }
            catch(e:Error) {
                if (!retry()){
                    failure(((("Failed to extract manifest.xml from library " + _name) + "!\n") + e.message));
                };
                result = false;
            };
            return (result);
        }
        protected function handleHttpStatus(_arg_1:int):Boolean
        {
            if ((((_arg_1 == 0)) || ((_arg_1 >= 400)))){
                if (this.retry()){
                    return (true);
                };
                this.failure((((("HTTP Error " + _arg_1) + ' "') + this._content.contentLoaderInfo.url) + '"'));
                this.removeEventListeners();
            };
            return (false);
        }
        protected function addRequestCounterToUrlRequest(_arg_1:URLRequest, _arg_2:int):void
        {
            var _local_9:int;
            var _local_10:String;
            if ((((_arg_1.url == null)) || ((_arg_1.url == "")))){
                return;
            };
            var _local_3:Array = _arg_1.url.split("?");
            var _local_4:String = _local_3[0];
            var _local_5:String = (((_local_3.length > 1)) ? _local_3[1] : "");
            var _local_6:String = "counterparameter";
            var _local_7:Array = _local_5.split("&");
            var _local_8:Boolean;
            _local_9 = 0;
            while (_local_9 < _local_7.length) {
                _local_10 = _local_7[_local_9];
                if (_local_10.indexOf((_local_6 + "=")) >= 0){
                    _local_10 = ((_local_6 + "=") + _arg_2.toString());
                    _local_7[_local_9] = _local_10;
                    _local_8 = true;
                    break;
                };
                _local_9++;
            };
            if (!_local_8){
                _local_7.push(((_local_6 + "=") + _arg_2));
            };
            _local_9 = 0;
            while (_local_9 < _local_7.length) {
                _local_4 = (_local_4 + ((((_local_9 == 0)) ? "?" : "&") + _local_7[_local_9]));
                _local_9++;
            };
            _arg_1.url = _local_4;
        }
        protected function removeEventListeners():void
        {
            if (this._content){
                if (this._content.content != null){
                    this._content.content.removeEventListener(Event.ENTER_FRAME, this.loadEventHandler);
                };
                this._content.contentLoaderInfo.removeEventListener(Event.INIT, this.loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(Event.UNLOAD, this.loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadEventHandler);
            };
        }
        protected function debug(_arg_1:String):void
        {
            Core.debug(_arg_1);
            this._lastDebugMessage = _arg_1;
            if (this._debug){
                dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DEBUG, this._status, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
            };
        }
        protected function failure(_arg_1:String):void
        {
            Core.warning(_arg_1);
            this._lastErrorMessage = _arg_1;
            throttle();
            dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this._status, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
            dispatchEvent(new Event(LIBRARY_LOADER_FINALIZE));
        }
        public function getLastDebugMessage():String
        {
            return (this._lastDebugMessage);
        }
        public function getLastErrorMessage():String
        {
            return (this._lastErrorMessage);
        }

    }
}//package com.sulake.core.utils

// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// _SafeStr_5891 = "_-1Ny" (String#852, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)
// _ready = "_-2-1" (String#1794, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// retry = "_-0Ol" (String#816, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// _resource = "_-1tH" (String#5907, DoABC#2)
// elapsedTime = "_-3Cm" (String#21986, DoABC#2)
// getLastDebugMessage = "_-0Gl" (String#3889, DoABC#2)
// warning = "_-1MU" (String#5283, DoABC#2)
// _SafeStr_9017 = "_-aZ" (String#2134, DoABC#2)
// paused = "_-1WA" (String#17749, DoABC#2)
// _SafeStr_9024 = "_-2V1" (String#20239, DoABC#2)
// _SafeStr_9025 = "_-1JB" (String#17244, DoABC#2)
// _SafeStr_9026 = "_-3Jt" (String#22279, DoABC#2)
// _SafeStr_9027 = "_-rJ" (String#24330, DoABC#2)
// _SafeStr_9028 = "_-1Cq" (String#16976, DoABC#2)
// _SafeStr_9029 = "_-2nt" (String#20995, DoABC#2)
// _SafeStr_9030 = "_-2wK" (String#21324, DoABC#2)
// _SafeStr_9031 = "_-0dq" (String#15578, DoABC#2)
// _request = "_-2Uq" (String#20231, DoABC#2)
// _SafeStr_9033 = "_-2mh" (String#20948, DoABC#2)
// _paused = "_-0fL" (String#15645, DoABC#2)
// _lastErrorMessage = "_-1Sx" (String#17622, DoABC#2)
// _lastDebugMessage = "_-28o" (String#19363, DoABC#2)
// _SafeStr_9037 = "_-1se" (String#18661, DoABC#2)
// _SafeStr_9038 = "_-28n" (String#19362, DoABC#2)
// _SafeStr_9039 = "_-2Z4" (String#20400, DoABC#2)
// _SafeStr_9040 = "_-Kg" (String#23031, DoABC#2)
// _SafeStr_9041 = "_-1em" (String#18090, DoABC#2)
// parseNameFromUrl = "_-1lU" (String#18352, DoABC#2)
// queue = "_-2g5" (String#20696, DoABC#2)
// throttle = "_-1bN" (String#17952, DoABC#2)
// request = "_-0bL" (String#15490, DoABC#2)
// addRequestCounterToUrlRequest = "_-2HV" (String#19706, DoABC#2)
// handleHttpStatus = "_-0Te" (String#15195, DoABC#2)
// removeEventListeners = "_-2ji" (String#20835, DoABC#2)
// analyzeLibrary = "_-27-" (String#19293, DoABC#2)
// prepareLibrary = "_-3GJ" (String#22134, DoABC#2)


