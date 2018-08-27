
package com.sulake.core.runtime
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObjectContainer;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import com.sulake.core.utils.LibraryLoader;
    import flash.system.ApplicationDomain;

    public interface IContext extends IUnknown 
    {

        function get assets():IAssetLibrary;
        function get events():IEventDispatcher;
        function get root():IContext;
        function error(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void;
        function getLastErrorMessage():String;
        function debug(_arg_1:String):void;
        function getLastDebugMessage():String;
        function warning(_arg_1:String):void;
        function getLastWarningMessage():String;
        function get displayObjectContainer():DisplayObjectContainer;
        function loadFromFile(_arg_1:URLRequest, _arg_2:LoaderContext):LibraryLoader;
        function attachComponent(_arg_1:Component, _arg_2:Array):void;
        function detachComponent(_arg_1:Component):void;
        function prepareComponent(_arg_1:Class, _arg_2:uint=0, _arg_3:ApplicationDomain=null):IUnknown;
        function prepareAssetLibrary(_arg_1:XML, _arg_2:Class):Boolean;
        function registerUpdateReceiver(_arg_1:IUpdateReceiver, _arg_2:uint):void;
        function removeUpdateReceiver(_arg_1:IUpdateReceiver):void;
        function toXMLString(_arg_1:uint=0):String;

    }
}//package com.sulake.core.runtime

// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// attachComponent = "_-1G" (String#5169, DoABC#2)
// detachComponent = "_-28T" (String#6212, DoABC#2)
// getLastDebugMessage = "_-0Gl" (String#3889, DoABC#2)
// warning = "_-1MU" (String#5283, DoABC#2)
// getLastWarningMessage = "_-5e" (String#7775, DoABC#2)
// prepareComponent = "_-hI" (String#8541, DoABC#2)
// prepareAssetLibrary = "_-3GZ" (String#7637, DoABC#2)


