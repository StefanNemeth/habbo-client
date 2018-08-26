
package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CantConnectMessageParser implements IMessageParser 
    {

        public static const _SafeStr_8510:int = 1;
        public static const _SafeStr_8511:int = 2;
        public static const _SafeStr_8512:int = 3;
        public static const _SafeStr_8513:int = 4;

        private var _reason:int = 0;
        private var _parameter:String = "";

        public function flush():Boolean
        {
            this._reason = 0;
            this._parameter = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._reason = _arg_1.readInteger();
            if (this._reason == 3){
                this._parameter = _arg_1.readString();
            }
            else {
                this._parameter = "";
            };
            return (true);
        }
        public function get reason():int
        {
            return (this._reason);
        }
        public function get parameter():String
        {
            return (this._parameter);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.session

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CantConnectMessageParser = "_-07a" (String#3712, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _reason = "_-10m" (String#831, DoABC#2)
// _parameter = "_-083" (String#1410, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _SafeStr_8510 = "_-0Oa" (String#15010, DoABC#2)
// _SafeStr_8511 = "_-08b" (String#14390, DoABC#2)
// _SafeStr_8512 = "_-2ja" (String#20829, DoABC#2)
// _SafeStr_8513 = "_-xJ" (String#24581, DoABC#2)


