
package com.sulake.core.assets.loaders
{
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.net.URLLoaderDataFormat;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class BinaryFileLoader extends AssetLoaderEventBroker implements IAssetLoader 
    {

        protected var _url:String;
        protected var _type:String;
        protected var _data:String;
        protected var _content:URLLoader;

        public function BinaryFileLoader(_arg_1:String, _arg_2:URLRequest=null)
        {
            this._url = (((_arg_2 == null)) ? "" : _arg_2.url);
            this._type = _arg_1;
            this._content = new URLLoader();
            this._content.addEventListener(Event.COMPLETE, loadEventHandler);
            this._content.addEventListener(Event.UNLOAD, loadEventHandler);
            this._content.addEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
            this._content.addEventListener(ProgressEvent.PROGRESS, loadEventHandler);
            this._content.addEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
            this._content.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
            if (_arg_2 != null){
                this.load(_arg_2);
            };
        }
        public function get url():String
        {
            return (this._url);
        }
        public function get ready():Boolean
        {
            return ((((this.bytesTotal > 0)) ? (this.bytesTotal == this.bytesLoaded) : false));
        }
        public function get content():Object
        {
            return (((this._data) ? this._data : ((this._content) ? this._content.data : null)));
        }
        public function get mimeType():String
        {
            return (this._type);
        }
        public function get bytesLoaded():uint
        {
            return (((this._content) ? this._content.bytesLoaded : 0));
        }
        public function get bytesTotal():uint
        {
            return (((this._content) ? this._content.bytesTotal : 0));
        }
        public function load(_arg_1:URLRequest):void
        {
            this._url = _arg_1.url;
            this._data = null;
            _SafeStr_7404 = 0;
            this._content.dataFormat = (((this._type == "application/octet-stream")) ? URLLoaderDataFormat.BINARY : URLLoaderDataFormat.TEXT);
            this._content.load(_arg_1);
        }
        override protected function LibraryLoader():Boolean
        {
            if (!_disposed){
                if (++_SafeStr_7404 < _SafeStr_7405){
                    try {
                        this._content.close();
                    }
                    catch(e:Error) {
                    };
                    this._content.load(new URLRequest((((this._url + (((this._url.indexOf("?") == -1)) ? "?" : "&")) + "retry=") + _SafeStr_7404)));
                    return (true);
                };
            };
            return (false);
        }
        override public function dispose():void
        {
            if (!_disposed){
                super.dispose();
                this._content.removeEventListener(Event.COMPLETE, loadEventHandler);
                this._content.removeEventListener(Event.UNLOAD, loadEventHandler);
                this._content.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
                this._content.removeEventListener(ProgressEvent.PROGRESS, loadEventHandler);
                this._content.removeEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
                this._content.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
                try {
                    this._content.close();
                }
                catch(e:Error) {
                };
                this._content = null;
                this._type = null;
                this._data = null;
                this._url = null;
            };
        }
        private function timerEventHandler(_arg_1:TimerEvent):void
        {
            var _local_2:Timer = (_arg_1.target as Timer);
            if (_local_2){
                _local_2.stop();
                _local_2.removeEventListener(TimerEvent.TIMER, this.timerEventHandler);
            };
            if (!_disposed){
                loadEventHandler(new Event(Event.COMPLETE));
            };
        }

    }
}//package com.sulake.core.assets.loaders

// IAssetLoader = "_-0Nc" (String#4033, DoABC#2)
// AssetLoaderEventBroker = "_-1Da" (String#5137, DoABC#2)
// BinaryFileLoader = "_-26r" (String#19285, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)
// _SafeStr_7404 = "_-291" (String#19368, DoABC#2)
// _SafeStr_7405 = "_-Wu" (String#23519, DoABC#2)
// LibraryLoader = "_-0Ol" (String#816, DoABC#2)
// timerEventHandler = "_-0bW" (String#4333, DoABC#2)


