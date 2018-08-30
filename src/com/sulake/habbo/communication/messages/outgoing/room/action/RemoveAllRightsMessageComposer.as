
package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class RemoveAllRightsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function RemoveAllRightsMessageComposer(_arg_1:int)
        {
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1);
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
}//package com.sulake.habbo.communication.messages.outgoing.room.action

// RemoveAllRightsMessageComposer = "_-0Rw" (String#15132, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


