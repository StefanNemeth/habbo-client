
package com.sulake.habbo.communication.messages.outgoing.recycler
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RecycleItemsMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_5521:Array;

        public function RecycleItemsMessageComposer(_arg_1:Array)
        {
            this._SafeStr_5521 = new Array();
            this._SafeStr_5521.push(_arg_1.length);
            this._SafeStr_5521 = this._SafeStr_5521.concat(_arg_1);
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return (this._SafeStr_5521);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.recycler

// RecycleItemsMessageComposer = "_-24X" (String#19202, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_5521 = "_-1yk" (String#18918, DoABC#2)


