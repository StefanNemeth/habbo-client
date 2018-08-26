
package com.sulake.core.runtime
{
    import com.sulake.core.utils.profiler.ProfilerAgent;

    public interface IProfiler 
    {

        function getProfilerAgentForReceiver(_arg_1:IUpdateReceiver):ProfilerAgent;
        function getProfilerAgentsInArray():Array;
        function addStartEventListener(_arg_1:Function):void;
        function addStopEventListener(_arg_1:Function):void;
        function removeStartEventListener(_arg_1:Function):void;
        function removeStopEventListener(_arg_1:Function):void;
        function gc():void;
        function get numAssetLibraryInstances():uint;
        function get numBitmapAssetInstances():uint;
        function get numAllocatedBitmapDataBytes():uint;
        function get numTrackedBitmapDataInstances():uint;
        function get numTrackedBitmapDataBytes():uint;

    }
}//package com.sulake.core.runtime

// IProfiler = "_-Fo" (String#7989, DoABC#2)
// ProfilerAgent = "_-1hZ" (String#5699, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// addStopEventListener = "_-3A-" (String#7511, DoABC#2)
// removeStopEventListener = "_-1u8" (String#5924, DoABC#2)
// getProfilerAgentsInArray = "_-OW" (String#8173, DoABC#2)
// numAssetLibraryInstances = "_-2Aj" (String#6261, DoABC#2)
// getProfilerAgentForReceiver = "_-XH" (String#8354, DoABC#2)
// addStartEventListener = "_-36d" (String#7442, DoABC#2)
// removeStartEventListener = "_-3EH" (String#7598, DoABC#2)
// numBitmapAssetInstances = "_-lG" (String#8631, DoABC#2)
// numAllocatedBitmapDataBytes = "_-24G" (String#6127, DoABC#2)
// numTrackedBitmapDataInstances = "_-1YE" (String#5524, DoABC#2)
// numTrackedBitmapDataBytes = "_-Lb" (String#8116, DoABC#2)


