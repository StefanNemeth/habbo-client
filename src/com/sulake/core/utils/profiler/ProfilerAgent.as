
package com.sulake.core.utils.profiler
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.utils.getQualifiedClassName;

    public class ProfilerAgent extends ProfilerAgentTask implements IDisposable 
    {

        protected var _receiver:IUpdateReceiver;

        public function ProfilerAgent(_arg_1:IUpdateReceiver)
        {
            this._receiver = _arg_1;
            var _local_2:String = getQualifiedClassName(this._receiver);
            super(_local_2.slice((_local_2.lastIndexOf(":") + 1), _local_2.length));
        }
        public function get receiver():IUpdateReceiver
        {
            return (this._receiver);
        }
        override public function dispose():void
        {
            this._receiver = null;
            super.dispose();
        }
        public function update(_arg_1:int):void
        {
            super.start();
            this._receiver.update(_arg_1);
            super.stop();
        }

    }
}//package com.sulake.core.utils.profiler

// ProfilerAgentTask = "_-0U3" (String#4185, DoABC#2)
// ProfilerAgent = "_-1hZ" (String#5699, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)


