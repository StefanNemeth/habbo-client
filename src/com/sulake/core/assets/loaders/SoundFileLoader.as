
package com.sulake.core.assets.loaders
{
    import flash.media.Sound;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;

    public class SoundFileLoader extends AssetLoaderEventBroker implements IAssetLoader 
    {

        protected var _url:String;
        protected var _type:String;
        protected var _content:Sound;

        public function SoundFileLoader(_arg_1:String, _arg_2:URLRequest=null)
        {
            this._url = (((_arg_2 == null)) ? "" : _arg_2.url);
            this._type = _arg_1;
            this._content = new Sound(null, null);
            this._content.addEventListener(Event.ID3, loadEventHandler);
            this._content.addEventListener(Event.OPEN, loadEventHandler);
            this._content.addEventListener(Event.COMPLETE, loadEventHandler);
            this._content.addEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
            this._content.addEventListener(ProgressEvent.PROGRESS, loadEventHandler);
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
            return (this._content);
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
        override public function dispose():void
        {
            if (!disposed){
                this._content.removeEventListener(Event.ID3, loadEventHandler);
                this._content.removeEventListener(Event.OPEN, loadEventHandler);
                this._content.removeEventListener(Event.COMPLETE, loadEventHandler);
                this._content.removeEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
                this._content.removeEventListener(ProgressEvent.PROGRESS, loadEventHandler);
                this._content = null;
                this._type = null;
                this._url = null;
                super.dispose();
            };
        }
        public function load(_arg_1:URLRequest):void
        {
            this._url = _arg_1.url;
            this._content.load(_arg_1, null);
        }

    }
}//package com.sulake.core.assets.loaders

// IAssetLoader = "_-0Nc" (String#4033, DoABC#2)
// AssetLoaderEventBroker = "_-1Da" (String#5137, DoABC#2)
// SoundFileLoader = "_-0LQ" (String#14893, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)


