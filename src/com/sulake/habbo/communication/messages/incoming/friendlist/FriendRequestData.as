
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendRequestData 
    {

        private var _requestId:int;
        private var _requesterName:String;
        private var _requesterUserId:int;
        private var _figureString:String;

        public function FriendRequestData(_arg_1:IMessageDataWrapper)
        {
            this._requestId = _arg_1.readInteger();
            this._requesterName = _arg_1.readString();
            this._figureString = _arg_1.readString();
            this._requesterUserId = this._requestId;
        }
        public function get requestId():int
        {
            return (this._requestId);
        }
        public function get requesterName():String
        {
            return (this._requesterName);
        }
        public function get requesterUserId():int
        {
            return (this._requesterUserId);
        }
        public function get figureString():String
        {
            return (this._figureString);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// _requesterName = "_-2vo" (String#7195, DoABC#2)
// _requesterUserId = "_-31V" (String#7336, DoABC#2)
// requesterUserId = "_-3Gh" (String#22150, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FriendRequestData = "_-1aw" (String#17931, DoABC#2)
// _requestId = "_-1GH" (String#301, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// figureString = "_-P1" (String#23207, DoABC#2)
// requesterName = "_-1ki" (String#18318, DoABC#2)
// _figureString = "_-30g" (String#1986, DoABC#2)


