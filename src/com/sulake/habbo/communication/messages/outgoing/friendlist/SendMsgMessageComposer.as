
package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class SendMsgMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function SendMsgMessageComposer(_arg_1:int, _arg_2:String)
        {
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1);
            this._messageArray.push(_arg_2);
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
}//package com.sulake.habbo.communication.messages.outgoing.friendlist

// SendMsgMessageComposer = "_-2Gh" (String#19668, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


