
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPollMessage extends RoomWidgetMessage 
    {

        public static const RWPM_START:String = "RWPM_START";
        public static const RWPM_REJECT:String = "RWPM_REJECT";
        public static const ANSWER:String = "RWPM_ANSWER";

        private var _id:int = -1;
        private var _questionId:int = 0;
        private var _answers:Array = null;

        public function RoomWidgetPollMessage(_arg_1:String, _arg_2:int)
        {
            this._id = _arg_2;
            super(_arg_1);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get questionId():int
        {
            return (this._questionId);
        }
        public function set questionId(_arg_1:int):void
        {
            this._questionId = _arg_1;
        }
        public function get answers():Array
        {
            return (this._answers);
        }
        public function set answers(_arg_1:Array):void
        {
            this._answers = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetPollMessage = "_-0uI" (String#4731, DoABC#2)
// RWPM_START = "_-1VF" (String#17711, DoABC#2)
// RWPM_REJECT = "_-1pH" (String#18513, DoABC#2)
// _questionId = "_-1oG" (String#865, DoABC#2)
// _answers = "_-dJ" (String#23771, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// answers = "_-2rZ" (String#21139, DoABC#2)


