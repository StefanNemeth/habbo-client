
package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PollStartComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function PollStartComposer(_arg_1:int)
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

// PollStartComposer = "_-332" (String#21622, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


