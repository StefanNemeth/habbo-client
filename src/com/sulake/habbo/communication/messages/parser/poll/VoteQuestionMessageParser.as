
package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoteQuestionMessageParser implements IMessageParser 
    {

        private var _question:String;
        private var _SafeStr_4767:Array;

        public function get question():String
        {
            return (this._question);
        }
        public function get choices():Array
        {
            return (this._SafeStr_4767.slice());
        }
        public function flush():Boolean
        {
            this._question = "";
            this._SafeStr_4767 = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._question = _arg_1.readString();
            this._SafeStr_4767 = [];
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _arg_1.readInteger();
                this._SafeStr_4767.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.poll

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// VoteQuestionMessageParser = "_-2bI" (String#6778, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _question = "_-10p" (String#596, DoABC#2)
// _SafeStr_4767 = "_-1ya" (String#872, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


