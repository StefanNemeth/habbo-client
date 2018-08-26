
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChangeMottoMessage extends RoomWidgetMessage 
    {

        public static const RWVM_CHANGE_MOTTO_MESSAGE:String = "RWVM_CHANGE_MOTTO_MESSAGE";

        private var _motto:String;

        public function RoomWidgetChangeMottoMessage(_arg_1:String)
        {
            super(RWVM_CHANGE_MOTTO_MESSAGE);
            this._motto = _arg_1;
        }
        public function get motto():String
        {
            return (this._motto);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetChangeMottoMessage = "_-iB" (String#8557, DoABC#2)
// RWVM_CHANGE_MOTTO_MESSAGE = "_-0xu" (String#16349, DoABC#2)
// _motto = "_-2ti" (String#453, DoABC#2)


