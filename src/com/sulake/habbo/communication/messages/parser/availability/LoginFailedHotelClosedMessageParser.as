
package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class LoginFailedHotelClosedMessageParser implements IMessageParser 
    {

        private var _openHour:int;
        private var _openMinute:int;

        public function get openHour():int
        {
            return (this._openHour);
        }
        public function get openMinute():int
        {
            return (this._openMinute);
        }
        public function flush():Boolean
        {
            this._openHour = 0;
            this._openMinute = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._openHour = _arg_1.readInteger();
            this._openMinute = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.availability

// LoginFailedHotelClosedMessageParser = "_-1rF" (String#5879, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _openMinute = "_-1JD" (String#5227, DoABC#2)


