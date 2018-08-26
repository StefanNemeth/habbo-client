
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionVoteEvent extends RoomSessionEvent 
    {

        public static const RWPUE_VOTE_QUESTION:String = "RSPE_VOTE_QUESTION";
        public static const RWPUE_VOTE_RESULT:String = "RSPE_VOTE_RESULT";

        private var _question:String = "";
        private var _SafeStr_4767:Array;
        private var _SafeStr_4768:Array;
        private var _totalVotes:int = 0;

        public function RoomSessionVoteEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:String, _arg_4:Array, _arg_5:Array=null, _arg_6:int=0, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            this._SafeStr_4767 = [];
            this._SafeStr_4768 = [];
            super(_arg_1, _arg_2, _arg_7, _arg_8);
            this._question = _arg_3;
            this._SafeStr_4767 = _arg_4;
            this._SafeStr_4768 = _arg_5;
            if (this._SafeStr_4768 == null){
                this._SafeStr_4768 = [];
            };
            this._totalVotes = _arg_6;
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
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionVoteEvent = "_-19h" (String#5071, DoABC#2)
// RWPUE_VOTE_QUESTION = "_-1cE" (String#17980, DoABC#2)
// RWPUE_VOTE_RESULT = "_-1I3" (String#17195, DoABC#2)
// _question = "_-10p" (String#596, DoABC#2)
// _SafeStr_4767 = "_-1ya" (String#872, DoABC#2)
// _SafeStr_4768 = "_-0J4" (String#1450, DoABC#2)
// _totalVotes = "_-hq" (String#2160, DoABC#2)
// votes = "_-2a2" (String#20443, DoABC#2)
// totalVotes = "_-0EU" (String#14625, DoABC#2)


