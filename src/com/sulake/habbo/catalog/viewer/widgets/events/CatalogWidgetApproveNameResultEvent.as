
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetApproveNameResultEvent extends Event 
    {

        private var _result:int;
        private var _nameValidationInfo:String;

        public function CatalogWidgetApproveNameResultEvent(_arg_1:int, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(WidgetEvent.CWE_APPROVE_RESULT, _arg_3, _arg_4);
            this._result = _arg_1;
            this._nameValidationInfo = _arg_2;
        }
        public function get result():int
        {
            return (this._result);
        }
        public function get nameValidationInfo():String
        {
            return (this._nameValidationInfo);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// CWE_APPROVE_RESULT = "_-2zr" (String#21455, DoABC#2)
// CatalogWidgetApproveNameResultEvent = "_-By" (String#22687, DoABC#2)
// _nameValidationInfo = "_-2R" (String#619, DoABC#2)


