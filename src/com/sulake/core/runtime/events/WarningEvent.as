
package com.sulake.core.runtime.events
{
    import flash.events.Event;

    public class WarningEvent extends Event 
    {

        protected var _message:String;

        public function WarningEvent(_arg_1:String, _arg_2:String)
        {
            this._message = (((_arg_2 == null)) ? "undefined" : _arg_2);
            super(_arg_1);
        }
        public function get message():String
        {
            return (this._message);
        }

    }
}//package com.sulake.core.runtime.events

// WarningEvent = "_-16b" (String#5007, DoABC#2)


