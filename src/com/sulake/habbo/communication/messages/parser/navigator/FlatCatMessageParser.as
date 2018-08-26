
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCatMessageParser implements IMessageParser 
    {

        private var _flatId:int;
        private var _nodeId:int;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            this._nodeId = _arg_1.readInteger();
            return (true);
        }
        public function flush():Boolean
        {
            this._flatId = 0;
            this._nodeId = 0;
            return (true);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get nodeId():int
        {
            return (this._nodeId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatCatMessageParser = "_-mh" (String#8655, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// _nodeId = "_-0zZ" (String#830, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


