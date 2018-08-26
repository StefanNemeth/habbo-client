
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendCategoryData 
    {

        private var _id:int;
        private var _name:String;

        public function FriendCategoryData(_arg_1:IMessageDataWrapper)
        {
            this._id = _arg_1.readInteger();
            this._name = _arg_1.readString();
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FriendCategoryData = "_-1Pd" (String#5346, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)


