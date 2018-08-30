
package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class RemoveRightsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function RemoveRightsMessageComposer(_arg_1:Array)
        {
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1.length);
            var _local_2:int;
            while (_local_2 < _arg_1.length) {
                this._messageArray.push(_arg_1[_local_2]);
                _local_2++;
            };
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

// RemoveRightsMessageComposer = "_-1Op" (String#17460, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


