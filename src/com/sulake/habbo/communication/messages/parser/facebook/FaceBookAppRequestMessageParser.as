
package com.sulake.habbo.communication.messages.parser.facebook
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaceBookAppRequestMessageParser implements IMessageParser 
    {

        private var _authToken:String;
        private var _data:String;
        private var _userFilter:String;
        private var _senderReference:int;

        public function get authToken():String
        {
            return (this._authToken);
        }
        public function get data():String
        {
            return (this._data);
        }
        public function get userFilter():String
        {
            return (this._userFilter);
        }
        public function get senderReference():int
        {
            return (this._senderReference);
        }
        public function flush():Boolean
        {
            this._authToken = (this._data = (this._userFilter = null));
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._authToken = _arg_1.readString();
            this._data = _arg_1.readString();
            this._userFilter = _arg_1.readString();
            this._senderReference = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.facebook

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FaceBookAppRequestMessageParser = "_-07e" (String#3714, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _authToken = "_-1Ni" (String#17425, DoABC#2)
// _userFilter = "_-09" (String#14407, DoABC#2)
// _senderReference = "_-2AK" (String#19418, DoABC#2)
// authToken = "_-2in" (String#20798, DoABC#2)
// userFilter = "_-1bI" (String#17948, DoABC#2)
// senderReference = "_-2tE" (String#21211, DoABC#2)


