
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserNotificationEvent extends RoomSessionEvent 
    {

        public static const RSUN_USER_NOTIFICATION:String = "RSUN_USER_NOTIFICATION";

        private var _title:String = "";
        private var _message:String = "";
        private var _parameters:Array;

        public function RoomSessionUserNotificationEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        public function get title():String
        {
            return (this._title);
        }
        public function get message():String
        {
            return (this._message);
        }
        public function get parameters():Array
        {
            return (this._parameters);
        }
        public function set title(_arg_1:String):void
        {
            this._title = _arg_1;
        }
        public function set message(_arg_1:String):void
        {
            this._message = _arg_1;
        }
        public function set parameters(_arg_1:Array):void
        {
            this._parameters = _arg_1;
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionUserNotificationEvent = "_-0pw" (String#4633, DoABC#2)
// RSUN_USER_NOTIFICATION = "_-0ni" (String#15964, DoABC#2)
// _parameters = "_-r-" (String#945, DoABC#2)


