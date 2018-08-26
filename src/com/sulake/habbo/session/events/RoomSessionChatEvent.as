
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionChatEvent extends RoomSessionEvent 
    {

        public static const RSCE_CHAT_EVENT:String = "RSCE_CHAT_EVENT";
        public static const RSCE_FLOOD_EVENT:String = "RSCE_FLOOD_EVENT";
        public static const _SafeStr_3620:int = 0;
        public static const _SafeStr_3621:int = 1;
        public static const _SafeStr_3622:int = 2;
        public static const _SafeStr_4788:int = 3;
        public static const _SafeStr_4789:int = 4;

        private var _userId:int = 0;
        private var _text:String = "";
        private var _chatType:int = 0;
        private var _links:Array;

        public function RoomSessionChatEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:int, _arg_4:String, _arg_5:int=0, _arg_6:Array=null, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_7, _arg_8);
            this._userId = _arg_3;
            this._text = _arg_4;
            this._chatType = _arg_5;
            this._links = _arg_6;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get chatType():int
        {
            return (this._chatType);
        }
        public function get links():Array
        {
            return (this._links);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionChatEvent = "_-2e3" (String#6834, DoABC#2)
// _SafeStr_3620 = "_-xF" (String#24578, DoABC#2)
// _SafeStr_3621 = "_-0Bz" (String#14526, DoABC#2)
// _SafeStr_3622 = "_-0O5" (String#14992, DoABC#2)
// _chatType = "_-0Dp" (String#812, DoABC#2)
// chatType = "_-TQ" (String#23382, DoABC#2)
// RSCE_CHAT_EVENT = "_-0km" (String#15857, DoABC#2)
// RSCE_FLOOD_EVENT = "_-2Pn" (String#20035, DoABC#2)
// _SafeStr_4788 = "_-1rK" (String#18597, DoABC#2)
// _SafeStr_4789 = "_-2ut" (String#21273, DoABC#2)
// _links = "_-Qt" (String#2105, DoABC#2)


