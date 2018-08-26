
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCreatedMessageParser implements IMessageParser 
    {

        private var _flatId:int;
        private var _flatName:String;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            this._flatName = _arg_1.readString();
            Logger.log(((("FLAT CREATED: " + this._flatId) + ", ") + this._flatName));
            return (true);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get flatName():String
        {
            return (this._flatName);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatCreatedMessageParser = "_-2nr" (String#7037, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// _flatName = "_-02q" (String#14152, DoABC#2)
// flatName = "_-Js" (String#23002, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


