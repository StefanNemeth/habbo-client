
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WelcomeGiftStatusParser implements IMessageParser 
    {

        private var _email:String;
        private var _isVerified:Boolean;
        private var _allowChange:Boolean;
        private var _furniId:int;
        private var _requestedByUser:Boolean;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._email = _arg_1.readString();
            this._isVerified = _arg_1.readBoolean();
            this._allowChange = _arg_1.readBoolean();
            this._furniId = _arg_1.readInteger();
            this._requestedByUser = _arg_1.readBoolean();
            return (true);
        }
        public function get requestedByUser():Boolean
        {
            return (this._requestedByUser);
        }
        public function get email():String
        {
            return (this._email);
        }
        public function get isVerified():Boolean
        {
            return (this._isVerified);
        }
        public function get allowChange():Boolean
        {
            return (this._allowChange);
        }
        public function get furniId():int
        {
            return (this._furniId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// _allowChange = "_-33F" (String#21631, DoABC#2)
// _requestedByUser = "_-2BA" (String#6271, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// isVerified = "_-0hd" (String#15732, DoABC#2)
// allowChange = "_-2Ma" (String#19910, DoABC#2)
// requestedByUser = "_-1cw" (String#18009, DoABC#2)
// _email = "_-1k7" (String#1751, DoABC#2)
// _isVerified = "_-0TI" (String#1479, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


