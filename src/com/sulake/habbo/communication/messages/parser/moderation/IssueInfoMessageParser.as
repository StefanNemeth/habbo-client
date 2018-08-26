
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.getTimer;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueInfoMessageParser implements IMessageParser 
    {

        private var _issueData:IssueMessageData;

        public function get issueData():IssueMessageData
        {
            return (this._issueData);
        }
        public function flush():Boolean
        {
            this._issueData = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_18:String;
            var _local_19:int;
            var _local_20:int;
            var _local_21:String;
            var _local_22:int;
            var _local_23:String;
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            var _local_4:int = _arg_1.readInteger();
            var _local_5:int = _arg_1.readInteger();
            var _local_6:int = (getTimer() - _arg_1.readInteger());
            var _local_7:int = _arg_1.readInteger();
            var _local_8:int = _arg_1.readInteger();
            var _local_9:String = _arg_1.readString();
            var _local_10:int = _arg_1.readInteger();
            var _local_11:String = _arg_1.readString();
            var _local_12:int = _arg_1.readInteger();
            var _local_13:String = _arg_1.readString();
            var _local_14:String = _arg_1.readString();
            var _local_15:int = _arg_1.readInteger();
            var _local_16:String = _arg_1.readString();
            var _local_17:int = _arg_1.readInteger();
            if (_local_17 == 0){
                _local_18 = _arg_1.readString();
                _local_19 = _arg_1.readInteger();
                _local_20 = _arg_1.readInteger();
            }
            else {
                if (_local_17 == 1){
                    _local_21 = _arg_1.readString();
                    _local_22 = _arg_1.readInteger();
                    _local_23 = _arg_1.readString();
                };
            };
            this._issueData = new IssueMessageData(_local_2, _local_3, _local_4, _local_5, _local_6, _local_7, _local_8, _local_9, _local_10, _local_11, _local_12, _local_13, _local_14, _local_15, _local_16, _local_17, _local_21, _local_22, _local_23, _local_18, _local_19, _local_20);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IssueInfoMessageParser = "_-2NS" (String#6511, DoABC#2)
// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// issueData = "_-0Ah" (String#14476, DoABC#2)
// _issueData = "_-0Lz" (String#14912, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


