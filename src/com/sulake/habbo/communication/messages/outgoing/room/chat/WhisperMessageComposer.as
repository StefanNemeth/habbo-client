
package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class WhisperMessageComposer implements IMessageComposer 
    {

        private var _text:String;
        private var _recipientName:String;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function WhisperMessageComposer(_arg_1:String, _arg_2:String, _arg_3:int=0, _arg_4:int=0)
        {
            this._recipientName = _arg_1;
            this._text = _arg_2;
            this._roomId = _arg_3;
            this._roomCategory = _arg_4;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            var _local_1:String = ((this._recipientName + " ") + this._text);
            return ([_local_1]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.chat

// WhisperMessageComposer = "_-3C4" (String#21963, DoABC#2)
// _recipientName = "_-1yO" (String#6000, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


