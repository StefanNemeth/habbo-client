
package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class KickBotMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_5930:int;

        public function KickBotMessageComposer(_arg_1:int)
        {
            this._SafeStr_5930 = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_5930]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.action

// KickBotMessageComposer = "_-0To" (String#15200, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_5930 = "_-1I7" (String#17197, DoABC#2)


