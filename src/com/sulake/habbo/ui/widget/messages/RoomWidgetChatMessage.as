
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChatMessage extends RoomWidgetMessage 
    {

        public static const RWCM_MESSAGE_CHAT:String = "RWCM_MESSAGE_CHAT";
        public static const _SafeStr_3620:int = 0;
        public static const _SafeStr_3621:int = 1;
        public static const _SafeStr_3622:int = 2;

        private var _chatType:int = 0;
        private var _text:String = "";
        private var _recipientName:String = "";

        public function RoomWidgetChatMessage(_arg_1:String, _arg_2:String, _arg_3:int=0, _arg_4:String="")
        {
            super(_arg_1);
            this._text = _arg_2;
            this._chatType = _arg_3;
            this._recipientName = _arg_4;
        }
        public function get chatType():int
        {
            return (this._chatType);
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get recipientName():String
        {
            return (this._recipientName);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RWCM_MESSAGE_CHAT = "_-2Zj" (String#20430, DoABC#2)
// _SafeStr_3620 = "_-xF" (String#24578, DoABC#2)
// _SafeStr_3621 = "_-0Bz" (String#14526, DoABC#2)
// _SafeStr_3622 = "_-0O5" (String#14992, DoABC#2)
// _chatType = "_-0Dp" (String#812, DoABC#2)
// _recipientName = "_-1yO" (String#6000, DoABC#2)
// chatType = "_-TQ" (String#23382, DoABC#2)
// recipientName = "_-147" (String#16622, DoABC#2)


