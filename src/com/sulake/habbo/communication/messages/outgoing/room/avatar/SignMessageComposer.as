
package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SignMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4038:int;

        public function SignMessageComposer(_arg_1:int)
        {
            this._SafeStr_4038 = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4038]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.avatar

// SignMessageComposer = "_-1A" (String#16857, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4038 = "_-2NR" (String#19942, DoABC#2)


