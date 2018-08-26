
package com.sulake.core.assets.loaders
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.net.URLRequest;

    public interface IAssetLoader extends IEventDispatcher, IDisposable 
    {

        function get url():String;
        function get ready():Boolean;
        function get content():Object;
        function get mimeType():String;
        function get bytesLoaded():uint;
        function get bytesTotal():uint;
        function get errorCode():uint;
        function load(_arg_1:URLRequest):void;

    }
}//package com.sulake.core.assets.loaders

// IAssetLoader = "_-0Nc" (String#4033, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)


