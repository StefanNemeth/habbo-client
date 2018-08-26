
package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetEventStreamingAllowedComposer implements IMessageComposer 
    {

        private var _param:Boolean;

        public function SetEventStreamingAllowedComposer(_arg_1:Boolean)
        {
            this._param = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._param]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.friendlist

// SetEventStreamingAllowedComposer = "_-2Hr" (String#19721, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _param = "_-2d3" (String#306, DoABC#2)


