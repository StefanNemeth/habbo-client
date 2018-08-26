
package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class RemoveBuddyMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_4511:Array;

        public function RemoveBuddyMessageComposer()
        {
            this._SafeStr_4511 = new Array();
            super();
        }
        public function getMessageArray():Array
        {
            var _local_1:Array = new Array();
            _local_1.push(this._SafeStr_4511.length);
            var _local_2:int;
            while (_local_2 < this._SafeStr_4511.length) {
                _local_1.push(this._SafeStr_4511[_local_2]);
                _local_2++;
            };
            return (_local_1);
        }
        public function addRemovedFriend(_arg_1:int):void
        {
            this._SafeStr_4511.push(_arg_1);
        }
        public function dispose():void
        {
            this._SafeStr_4511 = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.friendlist

// RemoveBuddyMessageComposer = "_-0OX" (String#15009, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4511 = "_-12H" (String#16548, DoABC#2)
// addRemovedFriend = "_-1BE" (String#16907, DoABC#2)


