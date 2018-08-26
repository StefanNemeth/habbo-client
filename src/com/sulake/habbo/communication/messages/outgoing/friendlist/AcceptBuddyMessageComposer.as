
package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class AcceptBuddyMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_4517:Array;

        public function AcceptBuddyMessageComposer()
        {
            this._SafeStr_4517 = new Array();
            super();
        }
        public function getMessageArray():Array
        {
            var _local_1:Array = new Array();
            _local_1.push(this._SafeStr_4517.length);
            var _local_2:int;
            while (_local_2 < this._SafeStr_4517.length) {
                _local_1.push(this._SafeStr_4517[_local_2]);
                _local_2++;
            };
            return (_local_1);
        }
        public function addAcceptedRequest(_arg_1:int):void
        {
            this._SafeStr_4517.push(_arg_1);
        }
        public function dispose():void
        {
            this._SafeStr_4517 = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.friendlist

// AcceptBuddyMessageComposer = "_-3-o" (String#21493, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4517 = "_-V8" (String#23454, DoABC#2)
// addAcceptedRequest = "_-5v" (String#22461, DoABC#2)


