
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendListUpdateMessageParser implements IMessageParser 
    {

        private var _cats:Array;
        private var _removedFriendIds:Array;
        private var _addedFriends:Array;
        private var _updatedFriends:Array;

        public function flush():Boolean
        {
            this._cats = new Array();
            this._removedFriendIds = new Array();
            this._addedFriends = new Array();
            this._updatedFriends = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int;
            var _local_6:int;
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._cats.push(new FriendCategoryData(_arg_1));
                _local_3++;
            };
            var _local_4:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_4) {
                _local_5 = _arg_1.readInteger();
                if (_local_5 == -1){
                    _local_6 = _arg_1.readInteger();
                    this._removedFriendIds.push(_local_6);
                }
                else {
                    if (_local_5 == 0){
                        this._updatedFriends.push(new FriendData(_arg_1));
                    }
                    else {
                        if (_local_5 == 1){
                            this._addedFriends.push(new FriendData(_arg_1));
                        };
                    };
                };
                _local_3++;
            };
            return (true);
        }
        public function get cats():Array
        {
            return (this._cats);
        }
        public function get removedFriendIds():Array
        {
            return (this._removedFriendIds);
        }
        public function get addedFriends():Array
        {
            return (this._addedFriends);
        }
        public function get updatedFriends():Array
        {
            return (this._updatedFriends);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FriendCategoryData = "_-1Pd" (String#5346, DoABC#2)
// FriendData = "_-XR" (String#23541, DoABC#2)
// FriendListUpdateMessageParser = "_-1B-" (String#5094, DoABC#2)
// _cats = "_-2cS" (String#20543, DoABC#2)
// _addedFriends = "_-3JJ" (String#22256, DoABC#2)
// _updatedFriends = "_-0YL" (String#15373, DoABC#2)
// cats = "_-fa" (String#23869, DoABC#2)
// removedFriendIds = "_-27p" (String#19323, DoABC#2)
// addedFriends = "_-1B0" (String#16900, DoABC#2)
// updatedFriends = "_-D2" (String#22729, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


