
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChangeEmailComposer implements IMessageComposer 
    {

        private var _newEmail:String;

        public function ChangeEmailComposer(_arg_1:String)
        {
            this._newEmail = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._newEmail]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.users

// ChangeEmailComposer = "_-CY" (String#22707, DoABC#2)
// _newEmail = "_-16d" (String#5008, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


