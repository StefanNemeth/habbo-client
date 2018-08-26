
package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PollRejectComposer implements IMessageComposer 
    {

        private var _data:Array = null;

        public function PollRejectComposer(_arg_1:int)
        {
            this._data = [_arg_1];
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }
        public function dispose():void
        {
            this._data = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.poll

// PollRejectComposer = "_-2EB" (String#19574, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


