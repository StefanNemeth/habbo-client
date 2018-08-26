
package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class InitCryptoMessageComposer implements IMessageComposer 
    {

        private var _content:Array;

        public function InitCryptoMessageComposer(_arg_1:int)
        {
            this._content = new Array();
            this._content.push(_arg_1);
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return (this._content);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.handshake

// InitCryptoMessageComposer = "_-Wc" (String#8338, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)


