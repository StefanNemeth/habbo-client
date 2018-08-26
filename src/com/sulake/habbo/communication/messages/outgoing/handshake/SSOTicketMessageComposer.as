
package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.getTimer;

    public class SSOTicketMessageComposer implements IMessageComposer 
    {

        private var _message:Array;

        public function SSOTicketMessageComposer(_arg_1:String)
        {
            this._message = new Array();
            this._message.push(_arg_1);
            this._message.push(getTimer());
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return (this._message);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.handshake

// SSOTicketMessageComposer = "_-0cf" (String#4356, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


