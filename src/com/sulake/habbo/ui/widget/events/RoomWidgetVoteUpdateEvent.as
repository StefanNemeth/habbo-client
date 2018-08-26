
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetVoteUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWPUE_VOTE_QUESTION:String = "RWPUE_VOTE_QUESTION";
        public static const RWPUE_VOTE_RESULT:String = "RWPUE_VOTE_RESULT";

        private var _question:String;
        private var _SafeStr_4767:Array;
        private var _SafeStr_4768:Array;
        private var _totalVotes:int;

        public function RoomWidgetVoteUpdateEvent(_arg_1:String, _arg_2:String, _arg_3:Array, _arg_4:Array=null, _arg_5:int=0, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            this._question = _arg_2;
            this._SafeStr_4767 = _arg_3;
            this._SafeStr_4768 = _arg_4;
            if (this._SafeStr_4768 == null){
                this._SafeStr_4768 = [];
            };
            this._totalVotes = _arg_5;
        }
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

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetVoteUpdateEvent = "_-2qd" (String#7089, DoABC#2)
// RWPUE_VOTE_QUESTION = "_-1cE" (String#17980, DoABC#2)
// RWPUE_VOTE_RESULT = "_-1I3" (String#17195, DoABC#2)
// _question = "_-10p" (String#596, DoABC#2)
// _SafeStr_4767 = "_-1ya" (String#872, DoABC#2)
// _SafeStr_4768 = "_-0J4" (String#1450, DoABC#2)
// _totalVotes = "_-hq" (String#2160, DoABC#2)
// votes = "_-2a2" (String#20443, DoABC#2)
// totalVotes = "_-0EU" (String#14625, DoABC#2)


