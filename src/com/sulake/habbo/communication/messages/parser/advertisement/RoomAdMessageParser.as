
package com.sulake.habbo.communication.messages.parser.advertisement
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomAdMessageParser implements IMessageParser 
    {

        private var _imageUrl:String;
        private var _clickUrl:String;

        public function get imageUrl():String
        {
            return (this._imageUrl);
        }
        public function get clickUrl():String
        {
            return (this._clickUrl);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._imageUrl = _arg_1.readString();
            this._clickUrl = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.advertisement

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomAdMessageParser = "_-0w3" (String#4770, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _clickUrl = "_-2-C" (String#303, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


