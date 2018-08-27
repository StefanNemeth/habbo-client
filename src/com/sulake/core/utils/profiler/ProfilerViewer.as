
package com.sulake.core.utils.profiler
{
    import flash.text.TextField;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IProfiler;
    import flash.text.TextFormat;

    public class ProfilerViewer extends TextField implements IDisposable 
    {

        protected var _disposed:Boolean = false;
        private var _profiler:IProfiler;

        public function ProfilerViewer(_arg_1:IProfiler)
        {
            var _local_2:TextFormat = new TextFormat("Courier New", 8);
            defaultTextFormat = _local_2;
            setTextFormat(_local_2);
            textColor = 0xFFFFFF;
            width = 10;
            height = 10;
            autoSize = "left";
            mouseEnabled = false;
            selectable = false;
            super();
            if (_arg_1){
                this._profiler = _arg_1;
                this._profiler.addStopEventListener(this.refresh);
            };
        }
        private static function padAlign(_arg_1:String, _arg_2:int, _arg_3:String=" ", _arg_4:Boolean=false):String
        {
            var _local_5:int = (_arg_2 - _arg_1.length);
            if (_local_5 <= 0){
                return (_arg_1.substring(0, _arg_2));
            };
            var _local_6:String = "";
            var _local_7:int;
            while (_local_7 < _local_5) {
                _local_6 = (_local_6 + _arg_3);
                _local_7++;
            };
            return (((_arg_4) ? (_local_6 + _arg_1) : (_arg_1 + _local_6)));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set profiler(_arg_1:IProfiler):void
        {
            if (((!(this._profiler)) && (_arg_1))){
                this._profiler = _arg_1;
                this._profiler.addStopEventListener(this.refresh);
            };
        }
        public function get profiler():IProfiler
        {
            return (this._profiler);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (parent != null){
                    parent.removeChild(this);
                };
                if (this._profiler){
                    this._profiler.removeStopEventListener(this.refresh);
                    this._profiler = null;
                };
                this._disposed = true;
            };
        }
        public function refresh():void
        {
            text = (((((((((((((((((((padAlign("task", 30) + "|") + padAlign("#rounds", 10, " ", true)) + "|") + padAlign("latest ms", 10, " ", true)) + "|") + padAlign("average ms", 10, " ", true)) + "|") + padAlign("total ms", 10, " ", true)) + "|\r") + padAlign("", 30, "-")) + "|") + padAlign("", 10, "-")) + "|") + padAlign("", 10, "-")) + "|") + padAlign("", 10, "-")) + "|") + padAlign("", 10, "-")) + "|\r");
            var _local_1:Array = this._profiler.getProfilerAgentsInArray();
            while (_local_1.length > 0) {
                this.recursiveUpdate(_local_1.pop(), 0);
            };
            if (parent){
                parent.swapChildren(this, parent.getChildAt((parent.numChildren - 1)));
            };
        }
        private function recursiveUpdate(_arg_1:ProfilerAgentTask, _arg_2:uint):void
        {
            text = (text + (((((((((padAlign(String(_arg_1.name), 30) + "|") + padAlign(String(_arg_1.rounds), 10)) + "|") + padAlign(String(_arg_1.latest), 10)) + "|") + padAlign(String(_arg_1.average), 10)) + "|") + padAlign(String(_arg_1.total), 10)) + "|\r"));
            var _local_3:uint;
            while (_local_3 < _arg_1.numSubTasks) {
                this.recursiveUpdate(_arg_1.getSubTaskAt(_local_3), (_arg_2 + 1));
                _local_3++;
            };
        }

    }
}//package com.sulake.core.utils.profiler

// ProfilerAgentTask = "_-0U3" (String#4185, DoABC#2)
// IProfiler = "_-Fo" (String#7989, DoABC#2)
// ProfilerViewer = "_-0t6" (String#16164, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// rounds = "_-1pu" (String#18538, DoABC#2)
// total = "_-2Ok" (String#19993, DoABC#2)
// latest = "_-0Hv" (String#14754, DoABC#2)
// numSubTasks = "_-25m" (String#19249, DoABC#2)
// getSubTaskAt = "_-2T5" (String#20167, DoABC#2)
// _profiler = "_-qk" (String#8720, DoABC#2)
// addStopEventListener = "_-3A-" (String#7511, DoABC#2)
// padAlign = "_-0pr" (String#4630, DoABC#2)
// removeStopEventListener = "_-1u8" (String#5924, DoABC#2)
// getProfilerAgentsInArray = "_-OW" (String#8173, DoABC#2)
// recursiveUpdate = "_-I6" (String#22933, DoABC#2)


