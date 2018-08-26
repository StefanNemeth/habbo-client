
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetChatInputContentUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWWCIDE_CHAT_INPUT_CONTENT:String = "RWWCIDE_CHAT_INPUT_CONTENT";
        public static const _SafeStr_6208:String = "whisper";
        public static const _SafeStr_6209:String = "shout";

        private var _messageType:String = "";
        private var _userName:String = "";

        public function RoomWidgetChatInputContentUpdateEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(RWWCIDE_CHAT_INPUT_CONTENT, _arg_3, _arg_4);
            this._messageType = _arg_1;
            this._userName = _arg_2;
        }
        public function get messageType():String
        {
            return (this._messageType);
        }
        public function get userName():String
        {
            return (this._userName);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _messageType = "_-Al" (String#22645, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetChatInputContentUpdateEvent = "_-2V7" (String#20243, DoABC#2)
// RWWCIDE_CHAT_INPUT_CONTENT = "_-Kj" (String#23034, DoABC#2)
// messageType = "_-2PA" (String#20008, DoABC#2)
// _SafeStr_6208 = "_-Px" (String#23247, DoABC#2)
// _SafeStr_6209 = "_-xy" (String#24613, DoABC#2)


