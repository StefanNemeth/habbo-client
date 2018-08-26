
package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;

    public class ChangeUserNameResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static var _SafeStr_7096:int = 0;
        public static var _SafeStr_7097:int = 1;
        public static var _SafeStr_7098:int = 2;
        public static var _SafeStr_7099:int = 3;
        public static var _SafeStr_7100:int = 4;
        public static var _SafeStr_7101:int = 5;
        public static var _SafeStr_7102:int = 6;
        public static var _SafeStr_7103:int = 7;

        public function ChangeUserNameResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ChangeUserNameResultMessageParser);
        }
        public function getParser():ChangeUserNameResultMessageParser
        {
            return ((_parser as ChangeUserNameResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.avatar

// ChangeUserNameResultMessageParser = "_-9" (String#22578, DoABC#2)
// ChangeUserNameResultMessageEvent = "_-3HW" (String#22180, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_7096 = "_-OP" (String#23184, DoABC#2)
// _SafeStr_7097 = "_-Ni" (String#23153, DoABC#2)
// _SafeStr_7098 = "_-30B" (String#21507, DoABC#2)
// _SafeStr_7099 = "_-0Hq" (String#14750, DoABC#2)
// _SafeStr_7100 = "_-0nI" (String#15948, DoABC#2)
// _SafeStr_7101 = "_-3-P" (String#21478, DoABC#2)
// _SafeStr_7102 = "_-1Hn" (String#17183, DoABC#2)
// _SafeStr_7103 = "_-2YA" (String#20362, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


