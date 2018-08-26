
package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChangeQueueMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_8369:int;

        public function ChangeQueueMessageComposer(_arg_1:int)
        {
            this._SafeStr_8369 = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_8369]);
        }
        public function dispose():void
        {
        }
        public function get disposed():Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.session

// ChangeQueueMessageComposer = "_-0MP" (String#14930, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_8369 = "_-0qI" (String#16061, DoABC#2)


