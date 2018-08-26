
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NavigatorSettingsMessageParser implements IMessageParser 
    {

        private var _homeRoomId:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._homeRoomId = _arg_1.readInteger();
            return (true);
        }
        public function get homeRoomId():int
        {
            return (this._homeRoomId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// NavigatorSettingsMessageParser = "_-nt" (String#8676, DoABC#2)
// homeRoomId = "_-0jF" (String#15801, DoABC#2)
// _homeRoomId = "_-zQ" (String#8867, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


