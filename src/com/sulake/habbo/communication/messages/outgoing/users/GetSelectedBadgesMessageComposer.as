
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetSelectedBadgesMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function GetSelectedBadgesMessageComposer(_arg_1:int)
        {
            this._messageArray = [];
            super();
            this._messageArray.push(int(_arg_1));
        }
        public function getMessageArray():Array
        {
            return (this._messageArray);
        }
        public function dispose():void
        {
            this._messageArray = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.users

// GetSelectedBadgesMessageComposer = "_-24x" (String#19219, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


