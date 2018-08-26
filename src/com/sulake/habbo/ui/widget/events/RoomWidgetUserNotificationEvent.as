
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUserNotificationEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUNE_NOTIFICATION:String = "RWUNE_NOTIFICATION";

        private var _title:String;
        private var _message:String;
        private var _parameters:Array;

        public function RoomWidgetUserNotificationEvent(_arg_1:String=null)
        {
            super((((_arg_1)!=null) ? _arg_1 : RWUNE_NOTIFICATION));
        }
        public function set title(_arg_1:String):void
        {
            this._title = _arg_1;
        }
        public function get title():String
        {
            return (this._title);
        }
        public function set message(_arg_1:String):void
        {
            this._message = _arg_1;
        }
        public function get message():String
        {
            return (this._message);
        }
        public function set parameters(_arg_1:Array):void
        {
            this._parameters = _arg_1;
        }
        public function get parameters():Array
        {
            return (this._parameters);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetUserNotificationEvent = "_-0ns" (String#4588, DoABC#2)
// _parameters = "_-r-" (String#945, DoABC#2)
// RWUNE_NOTIFICATION = "_-0Vj" (String#4221, DoABC#2)


