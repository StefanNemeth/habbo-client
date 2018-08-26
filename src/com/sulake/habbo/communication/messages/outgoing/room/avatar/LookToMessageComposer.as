
package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LookToMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4039:int;
        private var _SafeStr_4040:int;

        public function LookToMessageComposer(_arg_1:int, _arg_2:int)
        {
            this._SafeStr_4039 = _arg_1;
            this._SafeStr_4040 = _arg_2;
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4039, this._SafeStr_4040]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.avatar

// LookToMessageComposer = "_-29v" (String#19401, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4039 = "_-1g1" (String#18140, DoABC#2)
// _SafeStr_4040 = "_-1zf" (String#18955, DoABC#2)


