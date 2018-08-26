
package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.Util;

    public class FriendRequests 
    {

        private var _SafeStr_4674:IFriendRequestsDeps;
        private var _requests:Array;
        private var _limit:int;
        private var _clubLimit:int;
        private var _vipLimit:int;

        public function FriendRequests(_arg_1:IFriendRequestsDeps, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            this._requests = new Array();
            super();
            this._SafeStr_4674 = _arg_1;
            this._limit = _arg_2;
            this._clubLimit = _arg_3;
            this._vipLimit = _arg_4;
        }
        public function clearAndUpdateView(_arg_1:Boolean):void
        {
            var _local_3:FriendRequest;
            var _local_4:FriendRequest;
            var _local_2:Array = new Array();
            for each (_local_3 in this._requests) {
                if (((!(_arg_1)) || (!((_local_3.state == FriendRequest._SafeStr_7173))))){
                    _local_2.push(_local_3);
                };
            };
            for each (_local_4 in _local_2) {
                Util.remove(this._requests, _local_4);
                if (this._SafeStr_4674.view != null){
                    this._SafeStr_4674.view.removeRequest(_local_4);
                };
                _local_4.dispose();
            };
            this.refreshShading();
        }
        public function acceptFailed(_arg_1:String):void
        {
            var _local_2:FriendRequest = this.getRequestByRequesterName(_arg_1);
            if (_local_2 == null){
                Logger.log((("No friedrequest found " + _arg_1) + " when error received"));
                return;
            };
            _local_2.state = FriendRequest._state;
            this._SafeStr_4674.view.refreshRequestEntry(_local_2);
        }
        public function addRequest(_arg_1:FriendRequest):void
        {
            this._requests.push(_arg_1);
        }
        public function addRequestAndUpdateView(_arg_1:FriendRequest):void
        {
            this._requests.push(_arg_1);
            this._SafeStr_4674.view.addRequest(_arg_1);
        }
        public function getRequest(_arg_1:int):FriendRequest
        {
            var _local_2:FriendRequest;
            for each (_local_2 in this._requests) {
                if (_local_2.requestId == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getRequestByRequesterName(_arg_1:String):FriendRequest
        {
            var _local_2:FriendRequest;
            for each (_local_2 in this._requests) {
                if (_local_2.requesterName == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function refreshShading():void
        {
            var _local_2:FriendRequest;
            var _local_1:Boolean = true;
            for each (_local_2 in this._requests) {
                _local_1 = !(_local_1);
                this._SafeStr_4674.view.refreshShading(_local_2, _local_1);
            };
        }
        public function getCountOfOpenRequests():int
        {
            var _local_2:FriendRequest;
            var _local_1:int;
            for each (_local_2 in this.requests) {
                if (_local_2.state == FriendRequest._SafeStr_7173){
                    _local_1++;
                };
            };
            return (_local_1);
        }
        public function get requests():Array
        {
            return (this._requests);
        }
        public function get limit():int
        {
            return (this._limit);
        }
        public function get clubLimit():int
        {
            return (this._clubLimit);
        }
        public function get vipLimit():int
        {
            return (this._vipLimit);
        }
        public function set limit(_arg_1:int):void
        {
            this._limit = _arg_1;
        }

    }
}//package com.sulake.habbo.friendlist.domain

// _clubLimit = "_-0QH" (String#15074, DoABC#2)
// _vipLimit = "_-0du" (String#15582, DoABC#2)
// clearAndUpdateView = "_-3Bm" (String#21952, DoABC#2)
// refreshShading = "_-2Mr" (String#1866, DoABC#2)
// acceptFailed = "_-1xS" (String#18867, DoABC#2)
// getRequestByRequesterName = "_-1Lu" (String#17353, DoABC#2)
// _state = "_-1f4" (String#18101, DoABC#2)
// refreshRequestEntry = "_-3KJ" (String#7711, DoABC#2)
// addRequestAndUpdateView = "_-2Pi" (String#20032, DoABC#2)
// getRequest = "_-365" (String#21732, DoABC#2)
// getCountOfOpenRequests = "_-2Kr" (String#19839, DoABC#2)
// vipLimit = "_-2S5" (String#20123, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// FriendRequests = "_-0Cf" (String#14555, DoABC#2)
// IFriendRequestsDeps = "_-0Tc" (String#4171, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// _SafeStr_4674 = "_-2UU" (String#620, DoABC#2)
// addRequest = "_-2i" (String#1927, DoABC#2)
// removeRequest = "_-1qi" (String#1769, DoABC#2)
// requesterName = "_-1ki" (String#18318, DoABC#2)
// _SafeStr_7173 = "_-bS" (String#23691, DoABC#2)
// _limit = "_-1nj" (String#1760, DoABC#2)


