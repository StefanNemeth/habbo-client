
package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ShoutMessageComposer implements IMessageComposer 
    {

        private var _text:String;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function ShoutMessageComposer(_arg_1:String, _arg_2:int=0, _arg_3:int=0)
        {
            this._text = _arg_1;
            this._roomId = _arg_2;
            this._roomCategory = _arg_3;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._text]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.chat

// ShoutMessageComposer = "_-0W7" (String#15283, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


