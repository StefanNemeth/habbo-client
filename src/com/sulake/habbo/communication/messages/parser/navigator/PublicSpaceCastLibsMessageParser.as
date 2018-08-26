
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicSpaceCastLibsMessageParser implements IMessageParser 
    {

        private var _nodeId:int;
        private var _castLibs:String;
        private var _unitPort:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._nodeId = _arg_1.readInteger();
            this._castLibs = _arg_1.readString();
            this._unitPort = _arg_1.readInteger();
            return (true);
        }
        public function get nodeId():int
        {
            return (this._nodeId);
        }
        public function get castLibs():String
        {
            return (this._castLibs);
        }
        public function get unitPort():int
        {
            return (this._unitPort);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PublicSpaceCastLibsMessageParser = "_-3Dk" (String#7592, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// castLibs = "_-0m9" (String#15901, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// _nodeId = "_-0zZ" (String#830, DoABC#2)
// _unitPort = "_-0vq" (String#1579, DoABC#2)
// _castLibs = "_-29c" (String#6242, DoABC#2)
// unitPort = "_-2js" (String#20840, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


