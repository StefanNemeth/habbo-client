
package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class BanUserMessageComposer implements IMessageComposer 
    {

        private var _userId:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function BanUserMessageComposer(_arg_1:int, _arg_2:int=0, _arg_3:int=0)
        {
            this._userId = _arg_1;
            this._roomId = _arg_2;
            this._roomCategory = _arg_3;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._userId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.action

// BanUserMessageComposer = "_-3DU" (String#22014, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


