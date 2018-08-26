
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssuePickFailedMessageParser implements IMessageParser 
    {

        private var _issues:Array;
        private var _retryEnabled:Boolean;
        private var _retryCount:int;

        public function get issues():Array
        {
            return (this._issues);
        }
        public function get retryEnabled():Boolean
        {
            return (this._retryEnabled);
        }
        public function get retryCount():int
        {
            return (this._retryCount);
        }
        public function flush():Boolean
        {
            this._issues = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:IssueMessageData;
            this._issues = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_7 = new IssueMessageData(_local_4, 0, 0, 0, 0, 0, 0, null, 0, null, _local_5, _local_6, null, 0, null, 0, null, 0, null, null, 0, 0);
                this._issues.push(_local_7);
                _local_3++;
            };
            this._retryEnabled = _arg_1.readBoolean();
            this._retryCount = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IssuePickFailedMessageParser = "_-Bc" (String#7903, DoABC#2)
// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _retryEnabled = "_-2My" (String#19924, DoABC#2)
// _retryCount = "_-2X4" (String#20326, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


