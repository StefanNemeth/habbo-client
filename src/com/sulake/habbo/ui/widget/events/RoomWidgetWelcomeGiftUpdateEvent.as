
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetWelcomeGiftUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_8012:String = "rwwgue_welcome_gift_widget_status";

        private var _email:String;
        private var _isVerified:Boolean;
        private var _allowEmailChange:Boolean;
        private var _furniId:int;
        private var _requestedByUser:Boolean;

        public function RoomWidgetWelcomeGiftUpdateEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super(_SafeStr_8012, _arg_1, _arg_2);
        }
        public function get email():String
        {
            return (this._email);
        }
        public function get isVerified():Boolean
        {
            return (this._isVerified);
        }
        public function get allowEmailChange():Boolean
        {
            return (this._allowEmailChange);
        }
        public function get furniId():int
        {
            return (this._furniId);
        }
        public function get requestedByUser():Boolean
        {
            return (this._requestedByUser);
        }
        public function set email(_arg_1:String):void
        {
            this._email = _arg_1;
        }
        public function set isVerified(_arg_1:Boolean):void
        {
            this._isVerified = _arg_1;
        }
        public function set allowEmailChange(_arg_1:Boolean):void
        {
            this._allowEmailChange = _arg_1;
        }
        public function set furniId(_arg_1:int):void
        {
            this._furniId = _arg_1;
        }
        public function set requestedByUser(_arg_1:Boolean):void
        {
            this._requestedByUser = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _requestedByUser = "_-2BA" (String#6271, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetWelcomeGiftUpdateEvent = "_-1ad" (String#5570, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// isVerified = "_-0hd" (String#15732, DoABC#2)
// allowEmailChange = "_-FE" (String#22823, DoABC#2)
// requestedByUser = "_-1cw" (String#18009, DoABC#2)
// _email = "_-1k7" (String#1751, DoABC#2)
// _isVerified = "_-0TI" (String#1479, DoABC#2)
// _allowEmailChange = "_-2hd" (String#6899, DoABC#2)
// _SafeStr_8012 = "_-2it" (String#20802, DoABC#2)


