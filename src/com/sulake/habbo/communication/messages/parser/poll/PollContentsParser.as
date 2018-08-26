
package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PollContentsParser implements IMessageParser 
    {

        private var _id:int = -1;
        private var _startMessage:String = "";
        private var _endMessage:String = "";
        private var _numQuestions:int = 0;
        private var _questionArray:Array = null;

        public function get id():int
        {
            return (this._id);
        }
        public function get startMessage():String
        {
            return (this._startMessage);
        }
        public function get endMessage():String
        {
            return (this._endMessage);
        }
        public function get numQuestions():int
        {
            return (this._numQuestions);
        }
        public function get questionArray():Array
        {
            return (this._questionArray);
        }
        public function flush():Boolean
        {
            this._id = -1;
            this._startMessage = "";
            this._endMessage = "";
            this._numQuestions = 0;
            this._questionArray = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:Dictionary;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:int;
            this._id = _arg_1.readInteger();
            this._startMessage = _arg_1.readString();
            this._endMessage = _arg_1.readString();
            this._numQuestions = _arg_1.readInteger();
            this._questionArray = new Array();
            var _local_2:int;
            while (_local_2 < this._numQuestions) {
                _local_3 = new Dictionary();
                this._questionArray.push(_local_3);
                _local_3["id"] = _arg_1.readInteger();
                _local_3["number"] = _arg_1.readInteger();
                _local_3["type"] = _arg_1.readInteger();
                _local_3["content"] = _arg_1.readString();
                if ((((_local_3["type"] == 1)) || ((_local_3["type"] == 2)))){
                    _local_4 = _arg_1.readInteger();
                    _local_5 = new Array();
                    _local_3["selections"] = _local_5;
                    _local_3["selection_count"] = _local_4;
                    _local_3["selection_min"] = _arg_1.readInteger();
                    _local_3["selection_max"] = _arg_1.readInteger();
                    _local_6 = 0;
                    while (_local_6 < _local_4) {
                        _local_5.push(_arg_1.readString());
                        _local_6++;
                    };
                };
                _local_2++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.poll

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PollContentsParser = "_-125" (String#4918, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _numQuestions = "_-1ac" (String#1715, DoABC#2)
// _startMessage = "_-1q0" (String#1766, DoABC#2)
// _endMessage = "_-0ua" (String#826, DoABC#2)
// _questionArray = "_-1Oi" (String#1678, DoABC#2)
// numQuestions = "_-2M2" (String#19886, DoABC#2)
// startMessage = "_-1qR" (String#18561, DoABC#2)
// endMessage = "_-2a3" (String#20444, DoABC#2)
// questionArray = "_-37S" (String#21785, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


