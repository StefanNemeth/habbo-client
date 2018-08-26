
package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.getTimer;

    public class TryLoginMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4601:String;
        private var _password:String;
        private var _userId:int;

        public function TryLoginMessageComposer(_arg_1:String, _arg_2:String, _arg_3:int)
        {
            this._SafeStr_4601 = _arg_1;
            this._password = _arg_2;
            this._userId = _arg_3;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4601, this._password, this._userId, getTimer()]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.handshake

// TryLoginMessageComposer = "_-1uh" (String#5932, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4601 = "_-1gB" (String#18148, DoABC#2)


