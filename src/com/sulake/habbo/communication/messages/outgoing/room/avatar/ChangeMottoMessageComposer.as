
package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChangeMottoMessageComposer implements IMessageComposer 
    {

        private var _motto:String;

        public function ChangeMottoMessageComposer(_arg_1:String)
        {
            this._motto = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._motto]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.avatar

// ChangeMottoMessageComposer = "_-25K" (String#19231, DoABC#2)
// _motto = "_-2ti" (String#453, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


