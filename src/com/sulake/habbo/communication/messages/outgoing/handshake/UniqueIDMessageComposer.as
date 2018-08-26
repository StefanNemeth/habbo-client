
package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class UniqueIDMessageComposer implements IMessageComposer 
    {

        private var _machineID:String;

        public function UniqueIDMessageComposer(_arg_1:String)
        {
            this._machineID = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._machineID]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.handshake

// UniqueIDMessageComposer = "_-1uo" (String#5935, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _machineID = "_-0Z1" (String#4280, DoABC#2)


