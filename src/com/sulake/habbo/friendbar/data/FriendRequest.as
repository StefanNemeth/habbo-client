
package com.sulake.habbo.friendbar.data
{
    public class FriendRequest 
    {

        private var _id:int;
        private var _name:String;
        private var _figure:String;

        public function FriendRequest(_arg_1:int, _arg_2:String, _arg_3:String)
        {
            this._id = _arg_1;
            this._name = _arg_2;
            this._figure = _arg_3;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get figure():String
        {
            return (this._figure);
        }

    }
}//package com.sulake.habbo.friendbar.data

// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)


