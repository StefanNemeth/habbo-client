
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetTrophyDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWTDUE_TROPHY_DATA:String = "RWTDUE_TROPHY_DATA";

        private var _color:Number;
        private var _name:String;
        private var _date:String;
        private var _message:String;

        public function RoomWidgetTrophyDataUpdateEvent(_arg_1:String, _arg_2:Number, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            this._color = _arg_2;
            this._name = _arg_3;
            this._date = _arg_4;
            this._message = _arg_5;
        }
        public function get color():Number
        {
            return (this._color);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get date():String
        {
            return (this._date);
        }
        public function get message():String
        {
            return (this._message);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetTrophyDataUpdateEvent = "_-3LM" (String#7726, DoABC#2)
// _date = "_-1Dw" (String#1636, DoABC#2)
// RWTDUE_TROPHY_DATA = "_-0ag" (String#15461, DoABC#2)


