
package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityStatusMessageParser implements IMessageParser 
    {

        private var _isOpen:Boolean;
        private var _onShutDown:Boolean;

        public function get IssueBrowser():Boolean
        {
            return (this._isOpen);
        }
        public function get onShutDown():Boolean
        {
            return (this._onShutDown);
        }
        public function flush():Boolean
        {
            this._isOpen = false;
            this._onShutDown = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._isOpen = (_arg_1.readInteger() > 0);
            this._onShutDown = (_arg_1.readInteger() > 0);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.availability

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AvailabilityStatusMessageParser = "_-h8" (String#23936, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _isOpen = "_-by" (String#2139, DoABC#2)
// _onShutDown = "_-1YH" (String#17827, DoABC#2)
// onShutDown = "_-2YQ" (String#20374, DoABC#2)


