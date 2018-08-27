
package com.sulake.core.runtime
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IProfiler;
    import flash.utils.Dictionary;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import com.sulake.core.runtime.IDisposable;
    import flash.net.LocalConnection;
    import flash.events.Event;
    import flash.utils.getTimer;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.utils.profiler.ProfilerAgent;
    import com.sulake.core.runtime.*;

    class Profiler extends Component implements IProfiler 
    {

        public static const PROFILER_START:String = "PROFILER_START";
        public static const PROFILER_STOP:String = "PROFILER_STOP";

        private var _SafeStr_8950:Dictionary;
        private var _SafeStr_8077:int;
        private var _SafeStr_8951:int;

        public function Profiler(_arg_1:IContext)
        {
            this._SafeStr_8950 = new Dictionary(true);
            super(_arg_1, 0, null);
        }
        public function get numAssetLibraryInstances():uint
        {
            return (AssetLibrary.numAssetLibraryInstances);
        }
        public function get numBitmapAssetInstances():uint
        {
            return (BitmapDataAsset.instances);
        }
        public function get numAllocatedBitmapDataBytes():uint
        {
            return (BitmapDataAsset.allocatedByteCount);
        }
        public function get numTrackedBitmapDataInstances():uint
        {
            return (TrackedBitmapData.numInstances);
        }
        public function get numTrackedBitmapDataBytes():uint
        {
            return (TrackedBitmapData.allocatedByteCount);
        }
        override public function dispose():void
        {
            var _local_1:Object;
            if (!disposed){
                for (_local_1 in this._SafeStr_8950) {
                    IDisposable(this._SafeStr_8950[_local_1]).dispose();
                    delete this._SafeStr_8950[_local_1];
                };
                super.dispose();
            };
        }
        public function gc():void
        {
            try {
                new LocalConnection().connect("foo");
                new LocalConnection().connect("foo");
            }
            catch(e) {
            };
        }
        public function start():void
        {
            events.dispatchEvent(new Event(PROFILER_START, false, false));
            this._SafeStr_8077 = getTimer();
        }
        public function stop():void
        {
            this._SafeStr_8951 = (getTimer() - this._SafeStr_8077);
            events.dispatchEvent(new Event(PROFILER_STOP, false, false));
        }
        public function update(_arg_1:IUpdateReceiver, _arg_2:uint):void
        {
            this.getProfilerAgentForReceiver(_arg_1).update(_arg_2);
        }
        public function get numProfilerAgents():uint
        {
            var _local_2:Object;
            var _local_1:uint;
            for (_local_2 in this._SafeStr_8950) {
                if (!IDisposable(_local_2).disposed){
                    _local_1++;
                };
            };
            return (_local_1);
        }
        public function getProfilerAgentsInArray():Array
        {
            var _local_2:IUpdateReceiver;
            var _local_3:Object;
            var _local_1:Array = new Array();
            for (_local_3 in this._SafeStr_8950) {
                _local_2 = (_local_3 as IUpdateReceiver);
                if (IDisposable(_local_3).disposed){
                    IDisposable(this._SafeStr_8950[_local_3]).dispose();
                    delete this._SafeStr_8950[_local_3];
                }
                else {
                    _local_1.push(this._SafeStr_8950[_local_3]);
                };
            };
            return (_local_1);
        }
        public function getProfilerAgentForReceiver(_arg_1:IUpdateReceiver):ProfilerAgent
        {
            var _local_2:ProfilerAgent = this._SafeStr_8950[_arg_1];
            return ((((_local_2)!=null) ? _local_2 : this.addProfilerAgentForReceiver(_arg_1)));
        }
        public function addProfilerAgentForReceiver(_arg_1:IUpdateReceiver):ProfilerAgent
        {
            if (this._SafeStr_8950[_arg_1] != null){
                throw (new Error("Profiler for receiver already exists!"));
            };
            var _local_2:ProfilerAgent = new ProfilerAgent(_arg_1);
            this._SafeStr_8950[_arg_1] = _local_2;
            return (_local_2);
        }
        public function addStartEventListener(_arg_1:Function):void
        {
            events.addEventListener(PROFILER_START, _arg_1);
        }
        public function addStopEventListener(_arg_1:Function):void
        {
            events.addEventListener(PROFILER_STOP, _arg_1);
        }
        public function removeStartEventListener(_arg_1:Function):void
        {
            events.removeEventListener(PROFILER_START, _arg_1);
        }
        public function removeStopEventListener(_arg_1:Function):void
        {
            events.removeEventListener(PROFILER_STOP, _arg_1);
        }

    }
}//package com.sulake.core.runtime

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IProfiler = "_-Fo" (String#7989, DoABC#2)
// Profiler = "_-1j4" (String#5736, DoABC#2)
// ProfilerAgent = "_-1hZ" (String#5699, DoABC#2)
// TrackedBitmapData = "_-1gF" (String#5666, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// numInstances = "_-1Up" (String#17697, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// _SafeStr_8077 = "_-3HJ" (String#2035, DoABC#2)
// addStopEventListener = "_-3A-" (String#7511, DoABC#2)
// removeStopEventListener = "_-1u8" (String#5924, DoABC#2)
// getProfilerAgentsInArray = "_-OW" (String#8173, DoABC#2)
// instances = "_-1Ai" (String#16889, DoABC#2)
// numAssetLibraryInstances = "_-2Aj" (String#6261, DoABC#2)
// getProfilerAgentForReceiver = "_-XH" (String#8354, DoABC#2)
// addStartEventListener = "_-36d" (String#7442, DoABC#2)
// removeStartEventListener = "_-3EH" (String#7598, DoABC#2)
// numBitmapAssetInstances = "_-lG" (String#8631, DoABC#2)
// numAllocatedBitmapDataBytes = "_-24G" (String#6127, DoABC#2)
// numTrackedBitmapDataInstances = "_-1YE" (String#5524, DoABC#2)
// numTrackedBitmapDataBytes = "_-Lb" (String#8116, DoABC#2)
// _SafeStr_8950 = "_-1aa" (String#17918, DoABC#2)
// _SafeStr_8951 = "_-Nz" (String#23165, DoABC#2)
// numProfilerAgents = "_-71" (String#22502, DoABC#2)
// addProfilerAgentForReceiver = "_-tI" (String#24419, DoABC#2)


