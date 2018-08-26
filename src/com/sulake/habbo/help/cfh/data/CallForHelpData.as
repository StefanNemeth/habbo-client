
package com.sulake.habbo.help.cfh.data
{
    public class CallForHelpData 
    {

        private var _topicIndex:int;
        private var _reportedUserId:int;
        private var _reportedUserName:String = "";

        public function get topicIndex():int
        {
            return (this._topicIndex);
        }
        public function get reportedUserId():int
        {
            return (this._reportedUserId);
        }
        public function get reportedUserName():String
        {
            return (this._reportedUserName);
        }
        public function set topicIndex(_arg_1:int):void
        {
            this._topicIndex = _arg_1;
        }
        public function set reportedUserId(_arg_1:int):void
        {
            this._reportedUserId = _arg_1;
        }
        public function set reportedUserName(_arg_1:String):void
        {
            this._reportedUserName = _arg_1;
        }
        public function get userSelected():Boolean
        {
            return ((this._reportedUserId > 0));
        }
        public function getTopicKey(_arg_1:int):String
        {
            return ((((this.userSelected) ? "help.cfh.topicwithharasser." : "help.cfh.topic.") + _arg_1));
        }
        public function flush():void
        {
            this._reportedUserId = 0;
            this._reportedUserName = "";
        }

    }
}//package com.sulake.habbo.help.cfh.data

// CallForHelpData = "_-4I" (String#22389, DoABC#2)
// _topicIndex = "_-03" (String#14162, DoABC#2)
// _reportedUserId = "_-0gc" (String#819, DoABC#2)
// _reportedUserName = "_-1yn" (String#6009, DoABC#2)


