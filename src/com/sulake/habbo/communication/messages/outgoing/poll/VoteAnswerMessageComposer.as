
package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class VoteAnswerMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function VoteAnswerMessageComposer(_arg_1:int)
        {
            this._data = [];
            super();
            this._data = [_arg_1];
        }
        public function dispose():void
        {
            this._data = null;
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.poll

// VoteAnswerMessageComposer = "_-25A" (String#19226, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


