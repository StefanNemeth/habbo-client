
package com.sulake.core.runtime
{
    import flash.events.IEventDispatcher;

    public interface ICore extends IContext 
    {

        function initialize():void;
        function readConfigDocument(_arg_1:XML, _arg_2:IEventDispatcher=null):void;
        function getNumberOfFilesPending():uint;
        function getNumberOfFilesLoaded():uint;
        function setProfilerMode(_arg_1:Boolean):void;

    }
}//package com.sulake.core.runtime

// ICore = "_-2kX" (String#6966, DoABC#2)
// getNumberOfFilesPending = "_-2Yn" (String#6742, DoABC#2)
// getNumberOfFilesLoaded = "_-2cq" (String#6808, DoABC#2)
// readConfigDocument = "_-0ct" (String#4365, DoABC#2)
// setProfilerMode = "_-hp" (String#8551, DoABC#2)


