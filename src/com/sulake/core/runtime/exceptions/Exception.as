
package com.sulake.core.runtime.exceptions
{
    public class Exception extends Error 
    {

        private var _stackTrace:String;

        public function Exception(_arg_1:String, _arg_2:String="")
        {
            this._stackTrace = _arg_2;
            super(_arg_1);
        }
        public function toString():String
        {
            return (("Exception: " + super.message));
        }
        override public function getStackTrace():String
        {
            return ((((this._stackTrace)!="") ? this._stackTrace : super.getStackTrace()));
        }

    }
}//package com.sulake.core.runtime.exceptions

// Exception = "_-1C6" (String#16948, DoABC#2)
// _stackTrace = "_-0Vs" (String#4225, DoABC#2)


