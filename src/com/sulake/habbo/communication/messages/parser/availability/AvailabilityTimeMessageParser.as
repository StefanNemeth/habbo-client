
package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityTimeMessageParser implements IMessageParser 
    {

        private var _isOpen:Boolean;
        private var _minutesUntilChange:int;

        public function get IssueBrowser():Boolean
        {
            return (this._isOpen);
        }
        public function get minutesUntilChange():int
        {
            return (this._minutesUntilChange);
        }
        public function flush():Boolean
        {
            this._isOpen = false;
            this._minutesUntilChange = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._isOpen = (_arg_1.readInteger() > 0);
            this._minutesUntilChange = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.availability

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AvailabilityTimeMessageParser = "_-eJ" (String#8489, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _isOpen = "_-by" (String#2139, DoABC#2)
// _minutesUntilChange = "_-1nu" (String#18457, DoABC#2)
// minutesUntilChange = "_-1Iv" (String#17234, DoABC#2)


