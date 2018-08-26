
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CanCreateRoomMessageParser implements IMessageParser 
    {

        public static const _SafeStr_8042:int = 0;
        public static const _SafeStr_8043:int = 1;

        private var _resultCode:int;
        private var _roomLimit:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._resultCode = _arg_1.readInteger();
            this._roomLimit = _arg_1.readInteger();
            return (true);
        }
        public function get resultCode():int
        {
            return (this._resultCode);
        }
        public function get roomLimit():int
        {
            return (this._roomLimit);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CanCreateRoomMessageParser = "_-303" (String#7305, DoABC#2)
// _SafeStr_8042 = "_-xA" (String#24575, DoABC#2)
// _SafeStr_8043 = "_-1mv" (String#18418, DoABC#2)
// _resultCode = "_-3An" (String#916, DoABC#2)
// _roomLimit = "_-3AV" (String#21901, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// roomLimit = "_-0tF" (String#16169, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


