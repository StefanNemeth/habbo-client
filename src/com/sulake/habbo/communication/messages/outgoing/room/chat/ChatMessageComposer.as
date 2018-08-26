
package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChatMessageComposer implements IMessageComposer 
    {

        private var _text:String;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _SafeStr_5098:int = 0;

        public function ChatMessageComposer(_arg_1:String, _arg_2:int=-1, _arg_3:int=0, _arg_4:int=0)
        {
            this._text = _arg_1;
            this._roomId = _arg_3;
            this._roomCategory = _arg_4;
            this._SafeStr_5098 = _arg_2;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._text, this._SafeStr_5098]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.chat

// ChatMessageComposer = "_-Fl" (String#22841, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_5098 = "_-0RZ" (String#4124, DoABC#2)


