
package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoteResultMessageParser implements IMessageParser 
    {

        private var _question:String;
        private var _SafeStr_4767:Array;
        private var _SafeStr_4768:Array;
        private var _totalVotes:int;

        public function get question():String
        {
            return (this._question);
        }
        public function get choices():Array
        {
            return (this._SafeStr_4767.slice());
        }
        public function get votes():Array
        {
            return (this._SafeStr_4768.slice());
        }
        public function get totalVotes():int
        {
            return (this._totalVotes);
        }
        public function flush():Boolean
        {
            this._question = "";
            this._SafeStr_4767 = [];
            this._SafeStr_4768 = [];
            this._totalVotes = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._question = _arg_1.readString();
            this._SafeStr_4767 = [];
            this._SafeStr_4768 = [];
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _arg_1.readInteger();
                this._SafeStr_4767.push(_arg_1.readString());
                this._SafeStr_4768.push(_arg_1.readInteger());
                _local_3++;
            };
            this._totalVotes = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.poll

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// VoteResultMessageParser = "_-b6" (String#8443, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _question = "_-10p" (String#596, DoABC#2)
// _SafeStr_4767 = "_-1ya" (String#872, DoABC#2)
// _SafeStr_4768 = "_-0J4" (String#1450, DoABC#2)
// _totalVotes = "_-hq" (String#2160, DoABC#2)
// votes = "_-2a2" (String#20443, DoABC#2)
// totalVotes = "_-0EU" (String#14625, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


