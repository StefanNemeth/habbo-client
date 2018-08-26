
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AcceptBuddyFailureData 
    {

        private var _senderName:String;
        private var _errorCode:int;

        public function AcceptBuddyFailureData(_arg_1:IMessageDataWrapper)
        {
            this._senderName = _arg_1.readString();
            this._errorCode = _arg_1.readInteger();
        }
        public function get senderName():String
        {
            return (this._senderName);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// _senderName = "_-1oU" (String#5831, DoABC#2)
// senderName = "_-1WP" (String#17758, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AcceptBuddyFailureData = "_-06x" (String#14321, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)


