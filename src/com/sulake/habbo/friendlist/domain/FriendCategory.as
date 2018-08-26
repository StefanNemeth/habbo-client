
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.Util;

    public class FriendCategory implements IDisposable 
    {

        public static const _SafeStr_11171:int = 100;
        public static const _SafeStr_11172:int = 0;
        public static const _SafeStr_11173:int = -1;

        private var _id:int;
        private var _name:String;
        private var _open:Boolean;
        private var _friends:Array;
        private var _received:Boolean;
        private var _disposed:Boolean;
        private var _view:IWindowContainer;
        private var _pageIndex:int;

        public function FriendCategory(_arg_1:int, _arg_2:String)
        {
            this._friends = [];
            super();
            this._id = _arg_1;
            this._name = _arg_2;
            this._open = !((this._id == _SafeStr_11173));
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._view = null;
        }
        public function addFriend(_arg_1:Friend):void
        {
            var _local_4:Friend;
            if (this._friends.indexOf(_arg_1) >= 0){
                return;
            };
            var _local_2:String = _arg_1.name.toLowerCase();
            var _local_3:int;
            while (_local_3 < this._friends.length) {
                _local_4 = this._friends[_local_3];
                if (_local_2 < _local_4.name.toLowerCase()){
                    this._friends.splice(_local_3, 0, _arg_1);
                    return;
                };
                _local_3++;
            };
            this._friends.push(_arg_1);
        }
        public function getSelectedFriends(_arg_1:Array):void
        {
            var _local_2:Friend;
            for each (_local_2 in this._friends) {
                if (_local_2.selected){
                    _arg_1.push(_local_2);
                };
            };
        }
        public function getFriend(_arg_1:int):Friend
        {
            var _local_2:Friend;
            for each (_local_2 in this._friends) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getFriendCount(_arg_1:Boolean, _arg_2:Boolean=false):int
        {
            var _local_4:Friend;
            var _local_3:int;
            for each (_local_4 in this._friends) {
                if (((((!(_arg_1)) || (_local_4.online))) && (((!(_arg_2)) || (_local_4.followingAllowed))))){
                    _local_3 = (_local_3 + 1);
                };
            };
            return (_local_3);
        }
        public function removeFriend(_arg_1:int):Friend
        {
            var _local_2:Friend = this.getFriend(_arg_1);
            if (_local_2 != null){
                Util.remove(this._friends, _local_2);
                return (_local_2);
            };
            return (null);
        }
        private function checkPageIndex():void
        {
            if (this._pageIndex >= this.getPageCount()){
                this._pageIndex = Math.max(0, (this.getPageCount() - 1));
            };
        }
        public function getPageCount():int
        {
            return (Math.ceil((this._friends.length / _SafeStr_11171)));
        }
        public function getStartFriendIndex():int
        {
            this.checkPageIndex();
            return ((this._pageIndex * _SafeStr_11171));
        }
        public function getEndFriendIndex():int
        {
            this.checkPageIndex();
            return (Math.min(((this._pageIndex + 1) * _SafeStr_11171), this._friends.length));
        }
        public function setOpen(_arg_1:Boolean):void
        {
            var _local_2:Friend;
            this._open = _arg_1;
            if (!_arg_1){
                for each (_local_2 in this._friends) {
                    _local_2.selected = false;
                };
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get received():Boolean
        {
            return (this._received);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get friends():Array
        {
            return (this._friends);
        }
        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function get open():Boolean
        {
            return (this._open);
        }
        public function get pageIndex():int
        {
            return (this._pageIndex);
        }
        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function set view(_arg_1:IWindowContainer):void
        {
            this._view = _arg_1;
        }
        public function set received(_arg_1:Boolean):void
        {
            this._received = _arg_1;
        }
        public function set pageIndex(_arg_1:int):void
        {
            this._pageIndex = _arg_1;
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _SafeStr_11171 = "_-0mP" (String#15913, DoABC#2)
// _SafeStr_11172 = "_-0UQ" (String#15220, DoABC#2)
// _SafeStr_11173 = "_-2kn" (String#20876, DoABC#2)
// _received = "_-2oT" (String#21023, DoABC#2)
// _pageIndex = "_-0Pp" (String#15054, DoABC#2)
// getFriendCount = "_-1oZ" (String#5833, DoABC#2)
// removeFriend = "_-39O" (String#7499, DoABC#2)
// checkPageIndex = "_-0W1" (String#15277, DoABC#2)
// getPageCount = "_-2O-" (String#19965, DoABC#2)
// getStartFriendIndex = "_-21d" (String#19079, DoABC#2)
// setOpen = "_-1u7" (String#18721, DoABC#2)
// received = "_-3HA" (String#22170, DoABC#2)
// pageIndex = "_-0GU" (String#14700, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// FriendCategory = "_-3FV" (String#7619, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _friends = "_-02K" (String#576, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// getFriend = "_-WG" (String#8329, DoABC#2)


