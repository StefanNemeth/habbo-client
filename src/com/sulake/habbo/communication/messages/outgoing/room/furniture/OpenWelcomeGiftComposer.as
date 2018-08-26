
package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenWelcomeGiftComposer implements IMessageComposer 
    {

        private var _furniId:int;

        public function OpenWelcomeGiftComposer(_arg_1:int)
        {
            this._furniId = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._furniId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.furniture

// OpenWelcomeGiftComposer = "_-8F" (String#22551, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


