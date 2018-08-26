
package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoHotelClosingMessageParser implements IMessageParser 
    {

        private var _minutesUntilClosing:int;

        public function get minutesUntilClosing():int
        {
            return (this._minutesUntilClosing);
        }
        public function flush():Boolean
        {
            this._minutesUntilClosing = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._minutesUntilClosing = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.availability

// InfoHotelClosingMessageParser = "_-1Iy" (String#5219, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _minutesUntilClosing = "_-12a" (String#16562, DoABC#2)


