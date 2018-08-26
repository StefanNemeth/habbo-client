
package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoHotelClosedMessageParser implements IMessageParser 
    {

        private var _openHour:int;
        private var _openMinute:int;
        private var _userThrownOutAtClose:Boolean;

        public function get openHour():int
        {
            return (this._openHour);
        }
        public function get openMinute():int
        {
            return (this._openMinute);
        }
        public function get userThrownOutAtClose():Boolean
        {
            return (this._userThrownOutAtClose);
        }
        public function flush():Boolean
        {
            this._openHour = 0;
            this._openMinute = 0;
            this._userThrownOutAtClose = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._openHour = _arg_1.readInteger();
            this._openMinute = _arg_1.readInteger();
            this._userThrownOutAtClose = (_arg_1.readInteger() > 0);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.availability

// InfoHotelClosedMessageParser = "_-3K9" (String#7707, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _openMinute = "_-1JD" (String#5227, DoABC#2)
// _userThrownOutAtClose = "_-0Px" (String#15059, DoABC#2)


