
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CanCreateRoomEventMessageParser implements IMessageParser 
    {

        private var _canCreateEvent:Boolean;
        private var _errorCode:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._canCreateEvent = _arg_1.readBoolean();
            this._errorCode = _arg_1.readInteger();
            return (true);
        }
        public function get canCreateEvent():Boolean
        {
            return (this._canCreateEvent);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CanCreateRoomEventMessageParser = "_-cN" (String#8463, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// _canCreateEvent = "_-2ds" (String#20596, DoABC#2)
// canCreateEvent = "_-nu" (String#24186, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


