
package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class DanceMessageComposer implements IMessageComposer 
    {

        private var _style:int;

        public function DanceMessageComposer(_arg_1:int)
        {
            this._style = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._style]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.avatar

// DanceMessageComposer = "_-05v" (String#14278, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


