
package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LatencyPingRequestMessageComposer implements IMessageComposer 
    {

        private var _id:int = 0;

        public function LatencyPingRequestMessageComposer(_arg_1:int)
        {
            this._id = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._id]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.tracking

// LatencyPingRequestMessageComposer = "_-2OZ" (String#6530, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


