
package com.sulake.core.runtime.events
{
    public class ErrorEvent extends WarningEvent 
    {

        protected var _critical:Boolean;
        protected var _stackTrace:String;

        public function ErrorEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean, _arg_4:String=null)
        {
            this._critical = _arg_3;
            this._stackTrace = _arg_4;
            super(_arg_1, _arg_2);
        }
        public function get critical():Boolean
        {
            return (this._critical);
        }
        public function get stackTrace():String
        {
            return (this._stackTrace);
        }

    }
}//package com.sulake.core.runtime.events

// WarningEvent = "_-16b" (String#5007, DoABC#2)
// ErrorEvent = "_-cA" (String#8459, DoABC#2)
// _stackTrace = "_-0Vs" (String#4225, DoABC#2)
// _critical = "_-1Ho" (String#17184, DoABC#2)
// critical = "_-0i8" (String#15754, DoABC#2)
// stackTrace = "_-0-f" (String#14039, DoABC#2)


