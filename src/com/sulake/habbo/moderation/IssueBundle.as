
package com.sulake.habbo.moderation
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;

    public class IssueBundle 
    {

        private var _id:int;
        private var _issues:Map;
        private var _state:int;
        private var _pickerUserId:int = 0;
        private var _pickerName:String = "";
        private var _reportedUserId:int;
        private var _prioritySum:int = 0;
        private var _messageCount:int = 0;
        private var _SafeStr_11902:IssueMessageData = null;
        private var _SafeStr_11903:IssueMessageData = null;

        public function IssueBundle(_arg_1:int, _arg_2:IssueMessageData)
        {
            this._id = _arg_1;
            this._issues = new Map();
            this._state = _arg_2.state;
            this._pickerUserId = _arg_2.pickerUserId;
            this._pickerName = _arg_2.pickerUserName;
            this._reportedUserId = _arg_2.reportedUserId;
            this.addIssue(_arg_2);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get issues():Array
        {
            return (this._issues.Map());
        }
        public function get state():int
        {
            return (this._state);
        }
        public function get pickerUserId():int
        {
            return (this._pickerUserId);
        }
        public function get pickerName():String
        {
            return (this._pickerName);
        }
        public function updateIssue(_arg_1:IssueMessageData):void
        {
            this.removeIssue(_arg_1.issueId);
            this.addIssue(_arg_1);
        }
        private function addIssue(_arg_1:IssueMessageData):void
        {
            this._issues.add(_arg_1.issueId, _arg_1);
            this._prioritySum = (this._prioritySum + _arg_1.priority);
            if (((!((_arg_1.message == null))) && (!((_arg_1.message == ""))))){
                this._messageCount++;
            };
            if ((((this._SafeStr_11902 == null)) || ((_arg_1.timeStamp < this._SafeStr_11902.timeStamp)))){
                this._SafeStr_11902 = _arg_1;
            };
            if ((((this._SafeStr_11903 == null)) || ((_arg_1.priority > this._SafeStr_11903.timeStamp)))){
                this._SafeStr_11903 = _arg_1;
            };
        }
        public function removeIssue(_arg_1:int):IssueMessageData
        {
            var _local_2:IssueMessageData = (this._issues.remove(_arg_1) as IssueMessageData);
            if (_local_2 != null){
                this._prioritySum = (this._prioritySum - _local_2.priority);
                if (((!((_local_2.message == null))) && (!((_local_2.message == ""))))){
                    this._messageCount--;
                };
                if (this._SafeStr_11902 == _local_2){
                    this._SafeStr_11902 = null;
                };
                if (this._SafeStr_11903 == _local_2){
                    this._SafeStr_11903 = null;
                };
            };
            return (_local_2);
        }
        public function get prioritySum():int
        {
            return (this._prioritySum);
        }
        public function getHighestPriorityIssue():IssueMessageData
        {
            var _local_2:IssueMessageData;
            var _local_3:int;
            var _local_1:IssueMessageData = this._SafeStr_11903;
            if (_local_1 == null){
                if ((((this._issues == null)) || ((this._issues.length < 1)))){
                    return (null);
                };
                _local_1 = this._issues.getWithIndex(0);
                _local_3 = 1;
                while (_local_3 < this._issues.length) {
                    _local_2 = this._issues.getWithIndex(_local_3);
                    if (((!((_local_2 == null))) && ((_local_2.priority > _local_1.priority)))){
                        _local_1 = _local_2;
                    };
                    _local_3++;
                };
                this._SafeStr_11903 = _local_1;
            };
            return (_local_1);
        }
        public function getIssueCount():int
        {
            if (this._issues == null){
                return (0);
            };
            return (this._issues.length);
        }
        public function getIssueIds():Array
        {
            if (this._issues == null){
                return ([]);
            };
            return (this._issues.getKeys());
        }
        public function get reportedUserId():int
        {
            return (this._reportedUserId);
        }
        public function getMessageCount():int
        {
            return (this._messageCount);
        }
        public function getOpenTime(_arg_1:int):String
        {
            var _local_3:IssueMessageData;
            var _local_2:IssueMessageData = this._SafeStr_11902;
            if (_local_2 == null){
                for each (_local_3 in this._issues) {
                    if ((((_local_2 == null)) || ((_local_3.timeStamp < _local_2.timeStamp)))){
                        _local_2 = _local_3;
                    };
                };
                this._SafeStr_11902 = _local_2;
            };
            if (_local_2 != null){
                return (_local_2.getOpenTime(_arg_1));
            };
            return ("");
        }

    }
}//package com.sulake.habbo.moderation

// _messageCount = "_-sn" (String#8750, DoABC#2)
// updateIssue = "_-3KL" (String#22296, DoABC#2)
// removeIssue = "_-25y" (String#19257, DoABC#2)
// getHighestPriorityIssue = "_-22z" (String#19134, DoABC#2)
// _pickerName = "_-046" (String#14206, DoABC#2)
// _prioritySum = "_-Uq" (String#23439, DoABC#2)
// _SafeStr_11902 = "_-1Ei" (String#17057, DoABC#2)
// _SafeStr_11903 = "_-2oW" (String#21024, DoABC#2)
// addIssue = "_-1i7" (String#18214, DoABC#2)
// pickerName = "_-1l9" (String#18337, DoABC#2)
// getIssueCount = "_-3HT" (String#22178, DoABC#2)
// getIssueIds = "_-2Xm" (String#20349, DoABC#2)
// getMessageCount = "_-0nm" (String#15967, DoABC#2)
// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// IssueBundle = "_-1x4" (String#18850, DoABC#2)
// Map = "_-2U9" (String#20205, DoABC#2)
// _reportedUserId = "_-0gc" (String#819, DoABC#2)
// issueId = "_-1yh" (String#18916, DoABC#2)
// _pickerUserId = "_-jY" (String#8588, DoABC#2)
// pickerUserId = "_-4E" (String#22387, DoABC#2)
// pickerUserName = "_-6G" (String#22476, DoABC#2)
// getOpenTime = "_-P3" (String#23209, DoABC#2)


