
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChatTypingMessage extends RoomWidgetMessage 
    {

        public static const RWCTM_TYPING_STATUS:String = "RWCTM_TYPING_STATUS";

        private var _isTyping:Boolean;

        public function RoomWidgetChatTypingMessage(_arg_1:Boolean)
        {
            super(RWCTM_TYPING_STATUS);
            this._isTyping = _arg_1;
        }
        public function get isTyping():Boolean
        {
            return (this._isTyping);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetChatTypingMessage = "_-0Yw" (String#4277, DoABC#2)
// RWCTM_TYPING_STATUS = "_-1om" (String#18489, DoABC#2)
// _isTyping = "_-2z6" (String#624, DoABC#2)
// isTyping = "_-1wh" (String#18831, DoABC#2)


