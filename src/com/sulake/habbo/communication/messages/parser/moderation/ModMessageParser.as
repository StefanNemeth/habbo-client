
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModMessageParser implements IMessageParser 
    {

        private var _message:String;
        private var _url:String;

        public function get message():String
        {
            return (this._message);
        }
        public function get url():String
        {
            return (this._url);
        }
        public function flush():Boolean
        {
            this._message = "";
            this._url = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._message = _arg_1.readString();
            this._url = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// ModMessageParser = "_-2IO" (String#6409, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


