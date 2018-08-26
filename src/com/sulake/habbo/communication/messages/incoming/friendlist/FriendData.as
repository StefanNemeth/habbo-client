
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendData 
    {

        private var _id:int;
        private var _name:String;
        private var _gender:int;
        private var _online:Boolean;
        private var _followingAllowed:Boolean;
        private var _figure:String;
        private var _categoryId:int;
        private var _motto:String;
        private var _lastAccess:String;
        private var _realName:String;
        private var _facebookId:String;

        public function FriendData(_arg_1:IMessageDataWrapper)
        {
            this._id = _arg_1.readInteger();
            this._name = _arg_1.readString();
            this._gender = _arg_1.readInteger();
            this._online = _arg_1.readBoolean();
            this._followingAllowed = _arg_1.readBoolean();
            this._figure = _arg_1.readString();
            this._categoryId = _arg_1.readInteger();
            this._motto = _arg_1.readString();
            this._lastAccess = _arg_1.readString();
            this._realName = _arg_1.readString();
            this._facebookId = _arg_1.readString();
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get gender():int
        {
            return (this._gender);
        }
        public function get online():Boolean
        {
            return (this._online);
        }
        public function get followingAllowed():Boolean
        {
            return (this._followingAllowed);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get categoryId():int
        {
            return (this._categoryId);
        }
        public function get motto():String
        {
            return (this._motto);
        }
        public function get lastAccess():String
        {
            return (this._lastAccess);
        }
        public function get realName():String
        {
            return (this._realName);
        }
        public function get facebookId():String
        {
            return (this._facebookId);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// _lastAccess = "_-jH" (String#943, DoABC#2)
// _facebookId = "_-0r4" (String#16088, DoABC#2)
// lastAccess = "_-Es" (String#7968, DoABC#2)
// facebookId = "_-2Do" (String#19560, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FriendData = "_-XR" (String#23541, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _motto = "_-2ti" (String#453, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// _followingAllowed = "_-0eO" (String#1518, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// _online = "_-0-Y" (String#573, DoABC#2)


