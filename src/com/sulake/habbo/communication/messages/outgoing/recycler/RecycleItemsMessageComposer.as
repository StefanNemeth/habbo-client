
package com.sulake.habbo.communication.messages.outgoing.recycler
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RecycleItemsMessageComposer implements IMessageComposer 
    {

        private var _messageArray:Array;

        public function RecycleItemsMessageComposer(_arg_1:Array)
        {
            this._messageArray = new Array();
            this._messageArray.push(_arg_1.length);
            this._messageArray = this._messageArray.concat(_arg_1);
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return (this._messageArray);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.recycler

// RecycleItemsMessageComposer = "_-24X" (String#19202, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _messageArray = "_-1yk" (String#18918, DoABC#2)


