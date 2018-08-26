
package com.sulake.core.utils.profiler
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.getTimer;

    public class ProfilerAgentTask implements IDisposable 
    {

        private var _name:String;
        private var _rounds:uint;
        private var _total:int;
        private var _latest:int;
        private var _average:Number;
        private var _caption:String;
        private var _running:Boolean;
        private var _disposed:Boolean = false;
        private var _children:Array;
        private var _SafeStr_8077:uint;

        public function ProfilerAgentTask(_arg_1:String, _arg_2:String="")
        {
            this._name = _arg_1;
            this._rounds = 0;
            this._average = 0;
            this._running = false;
            this._children = new Array();
            this._caption = _arg_2;
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
            };
        }
        public function start():void
        {
            if (!this._running){
                this._SafeStr_8077 = getTimer();
                this._running = true;
            };
        }
        public function stop():void
        {
            if (this._running){
                this._latest = (getTimer() - this._SafeStr_8077);
                this._rounds++;
                this._total = (this._total + this._latest);
                this._average = (this._total / this._rounds);
                this._running = false;
            };
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get rounds():uint
        {
            return (this._rounds);
        }
        public function get total():int
        {
            return (this._total);
        }
        public function get latest():int
        {
            return (this._latest);
        }
        public function get average():Number
        {
            return (this._average);
        }
        public function get caption():String
        {
            return (this._caption);
        }
        public function set caption(_arg_1:String):void
        {
            this._caption = this.caption;
        }
        public function get running():Boolean
        {
            return (this._running);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get numSubTasks():uint
        {
            return (this._children.length);
        }
        public function ProfilerAgentTask(_arg_1:ProfilerAgentTask):void
        {
            if (this.ProfilerAgentTask(_arg_1.name) != null){
                throw (new Error((('Component profiler task with name "' + _arg_1.name) + '" already exists!')));
            };
            this._children.push(_arg_1);
        }
        public function ProfilerAgentTask(_arg_1:ProfilerAgentTask):ProfilerAgentTask
        {
            var _local_2:int = this._children.indexOf(_arg_1);
            if (_local_2 > -1){
                this._children.splice(_local_2, 1);
            };
            return (_arg_1);
        }
        public function ProfilerAgentTask(_arg_1:uint):ProfilerAgentTask
        {
            return ((this._children[_arg_1] as ProfilerAgentTask));
        }
        public function ProfilerAgentTask(_arg_1:String):ProfilerAgentTask
        {
            var _local_4:ProfilerAgentTask;
            var _local_2:uint = this._children.length;
            var _local_3:uint;
            while (_local_3 < _local_2) {
                _local_4 = (this._children[_local_3++] as ProfilerAgentTask);
                if (_local_4.name == _arg_1){
                    return (_local_4);
                };
            };
            return (null);
        }

    }
}//package com.sulake.core.utils.profiler

// ProfilerAgentTask = "_-0U3" (String#4185, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _running = "_-00c" (String#353, DoABC#2)
// _rounds = "_-00X" (String#14075, DoABC#2)
// _total = "_-Lq" (String#23075, DoABC#2)
// _latest = "_-IK" (String#22942, DoABC#2)
// _average = "_-0IY" (String#14781, DoABC#2)
// _caption = "_-p" (String#8690, DoABC#2)
// _SafeStr_8077 = "_-3HJ" (String#2035, DoABC#2)
// rounds = "_-1pu" (String#18538, DoABC#2)
// total = "_-2Ok" (String#19993, DoABC#2)
// latest = "_-0Hv" (String#14754, DoABC#2)
// numSubTasks = "_-25m" (String#19249, DoABC#2)
// ProfilerAgentTask = "_-0mE" (String#15905, DoABC#2)
// ProfilerAgentTask = "_-dU" (String#23780, DoABC#2)
// ProfilerAgentTask = "_-2HI" (String#19695, DoABC#2)
// ProfilerAgentTask = "_-2T5" (String#20167, DoABC#2)


