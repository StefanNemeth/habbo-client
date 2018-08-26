
package com.sulake.core.runtime.events
{
    import flash.events.Event;
    import com.sulake.core.runtime.IUnknown;

    public class LockEvent extends Event 
    {

        public var unknown:IUnknown;

        public function LockEvent(_arg_1:String, _arg_2:IUnknown)
        {
            this.unknown = _arg_2;
            super(_arg_1);
        }
    }
}//package com.sulake.core.runtime.events

// LockEvent = "_-4a" (String#22400, DoABC#2)


