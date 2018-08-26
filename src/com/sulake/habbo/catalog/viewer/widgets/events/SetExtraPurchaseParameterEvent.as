
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class SetExtraPurchaseParameterEvent extends Event 
    {

        private var _parameter:String;

        public function SetExtraPurchaseParameterEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(WidgetEvent.CWE_SET_EXTRA_PARM, _arg_2, _arg_3);
            this._parameter = _arg_1;
        }
        public function get parameter():String
        {
            return (this._parameter);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// CWE_SET_EXTRA_PARM = "_-0-B" (String#14018, DoABC#2)
// SetExtraPurchaseParameterEvent = "_-2sO" (String#7128, DoABC#2)
// _parameter = "_-083" (String#1410, DoABC#2)


