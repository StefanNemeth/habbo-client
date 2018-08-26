
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetConversionPointMessage extends RoomWidgetMessage 
    {

        public static const RWCPM_CONVERSION_POINT:String = "RWCPM_CONVERSION_POINT";

        private var _category:String;
        private var _pointType:String;
        private var _action:String;
        private var _extraString:String;
        private var _extraInt:int;

        public function RoomWidgetConversionPointMessage(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String="", _arg_6:int=0)
        {
            super(_arg_1);
            this._category = _arg_2;
            this._pointType = _arg_3;
            this._action = _arg_4;
            this._extraString = ((_arg_5) ? _arg_5 : "");
            this._extraInt = ((_arg_6) ? _arg_6 : 0);
        }
        public function get category():String
        {
            return (this._category);
        }
        public function get pointType():String
        {
            return (this._pointType);
        }
        public function get action():String
        {
            return (this._action);
        }
        public function get extraString():String
        {
            return (this._extraString);
        }
        public function get extraInt():int
        {
            return (this._extraInt);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RWCPM_CONVERSION_POINT = "_-0hK" (String#15721, DoABC#2)
// _pointType = "_-18V" (String#16794, DoABC#2)
// _extraString = "_-ZJ" (String#8401, DoABC#2)
// _extraInt = "_-0sh" (String#4701, DoABC#2)
// pointType = "_-0xk" (String#16343, DoABC#2)
// extraString = "_-0hC" (String#15718, DoABC#2)
// extraInt = "_-2G0" (String#19645, DoABC#2)


