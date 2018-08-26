
package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenConnectionMessageComposer implements IMessageComposer 
    {

        private var _roomId:int;
        private var _SafeStr_8370:Boolean;
        private var _SafeStr_8371:int;

        public function OpenConnectionMessageComposer(_arg_1:Boolean, _arg_2:int, _arg_3:int=0)
        {
            this._roomId = _arg_2;
            this._SafeStr_8370 = _arg_1;
            this._SafeStr_8371 = _arg_3;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([int(this._SafeStr_8370), this._roomId, this._SafeStr_8371]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.session

// OpenConnectionMessageComposer = "_-0d8" (String#15555, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_8370 = "_-3-8" (String#21466, DoABC#2)
// _SafeStr_8371 = "_-1-C" (String#16437, DoABC#2)


