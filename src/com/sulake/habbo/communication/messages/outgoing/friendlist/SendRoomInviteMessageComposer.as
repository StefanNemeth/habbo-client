
package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class SendRoomInviteMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_4513:Array;
        private var _msg:String;

        public function SendRoomInviteMessageComposer(_arg_1:String)
        {
            this._SafeStr_4513 = new Array();
            super();
            this._msg = _arg_1;
        }
        public function getMessageArray():Array
        {
            var _local_1:Array = new Array();
            _local_1.push(this._SafeStr_4513.length);
            var _local_2:int;
            while (_local_2 < this._SafeStr_4513.length) {
                _local_1.push(this._SafeStr_4513[_local_2]);
                _local_2++;
            };
            _local_1.push(this._msg);
            return (_local_1);
        }
        public function addInvitedFriend(_arg_1:int):void
        {
            this._SafeStr_4513.push(_arg_1);
        }
        public function dispose():void
        {
            this._SafeStr_4513 = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.friendlist

// SendRoomInviteMessageComposer = "_-2fR" (String#20666, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4513 = "_-1UQ" (String#17681, DoABC#2)
// _msg = "_-Zx" (String#937, DoABC#2)
// addInvitedFriend = "_-2SM" (String#20131, DoABC#2)


