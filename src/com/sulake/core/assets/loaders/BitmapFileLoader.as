
package com.sulake.core.assets.loaders
{
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class BitmapFileLoader extends AssetLoaderEventBroker implements IAssetLoader 
    {

        protected var _url:String;
        protected var _type:String;
        protected var _content:Loader;
        protected var _loaderContext:LoaderContext;

        public function BitmapFileLoader(_arg_1:String, _arg_2:URLRequest=null)
        {
            this._url = (((_arg_2 == null)) ? "" : _arg_2.url);
            this._type = _arg_1;
            this._content = new Loader();
            this._loaderContext = new LoaderContext();
            this._loaderContext.checkPolicyFile = true;
            this._content.contentLoaderInfo.addEventListener(Event.COMPLETE, loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(Event.UNLOAD, loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
            this._content.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
            if (((!((_arg_2 == null))) && (!((_arg_2.url == null))))){
                this._content.load(_arg_2, this._loaderContext);
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
            return (((this._content) ? this._content.content : null));
        }
        public function get mimeType():String
        {
            return (this._type);
        }
        public function get bytesLoaded():uint
        {
            return (((this._content) ? this._content.contentLoaderInfo.bytesLoaded : 0));
        }
        public function get bytesTotal():uint
        {
            return (((this._content) ? this._content.contentLoaderInfo.bytesTotal : 0));
        }
        public function get loaderContext():LoaderContext
        {
            return (this._loaderContext);
        }
        public function load(_arg_1:URLRequest):void
        {
            this._url = _arg_1.url;
            _SafeStr_7404 = 0;
            this._content.load(_arg_1, this._loaderContext);
        }
        override protected function retry():Boolean
        {
            if (!_disposed){
                if (++_SafeStr_7404 < _SafeStr_7405){
                    try {
                        this._content.close();
                        this._content.unload();
                    }
                    catch(e:Error) {
                    };
                    this._content.load(new URLRequest((((this._url + (((this._url.indexOf("?") == -1)) ? "?" : "&")) + "retry=") + _SafeStr_7404)), this._loaderContext);
                    return (true);
                };
            };
            return (false);
        }
        override public function dispose():void
        {
            if (!_disposed){
                super.dispose();
                this._content.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(Event.UNLOAD, loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
                this._content.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
                try {
                    this._content.close();
                }
                catch(e) {
                };
                this._content.unload();
                this._content = null;
                this._type = null;
                this._url = null;
            };
        }

    }
}//package com.sulake.core.assets.loaders

// IAssetLoader = "_-0Nc" (String#4033, DoABC#2)
// AssetLoaderEventBroker = "_-1Da" (String#5137, DoABC#2)
// BitmapFileLoader = "_-Nw" (String#23162, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)
// _SafeStr_7404 = "_-291" (String#19368, DoABC#2)
// _SafeStr_7405 = "_-Wu" (String#23519, DoABC#2)
// retry = "_-0Ol" (String#816, DoABC#2)
// _loaderContext = "_-0PU" (String#4082, DoABC#2)
// loaderContext = "_-27g" (String#19318, DoABC#2)


