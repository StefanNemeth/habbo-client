
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class TextInputEvent extends Event 
    {

        private var _text:String;

        public function TextInputEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(WidgetEvent.CWE_TEXT_INPUT, _arg_2, _arg_3);
            this._text = _arg_1;
        }
        public function get text():String
        {
            return (this._text);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// TextInputEvent = "_-2kd" (String#6969, DoABC#2)


