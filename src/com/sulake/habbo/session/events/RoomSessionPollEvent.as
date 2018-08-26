
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPollEvent extends RoomSessionEvent 
    {

        public static const RWPUW_OFFER:String = "RSPE_POLL_OFFER";
        public static const RWPUW_ERROR:String = "RSPE_POLL_ERROR";
        public static const RWPUW_CONTENT:String = "RSPE_POLL_CONTENT";

        private var _id:int = -1;
        private var _summary:String;
        private var _numQuestions:int = 0;
        private var _startMessage:String = "";
        private var _endMessage:String = "";
        private var _questionArray:Array = null;

        public function RoomSessionPollEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:int)
        {
            this._id = _arg_3;
            super(_arg_1, _arg_2);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get summary():String
        {
            return (this._summary);
        }
        public function set summary(_arg_1:String):void
        {
            this._summary = _arg_1;
        }
        public function get numQuestions():int
        {
            return (this._numQuestions);
        }
        public function set numQuestions(_arg_1:int):void
        {
            this._numQuestions = _arg_1;
        }
        public function get startMessage():String
        {
            return (this._startMessage);
        }
        public function set startMessage(_arg_1:String):void
        {
            this._startMessage = _arg_1;
        }
        public function get endMessage():String
        {
            return (this._endMessage);
        }
        public function set endMessage(_arg_1:String):void
        {
            this._endMessage = _arg_1;
        }
        public function get questionArray():Array
        {
            return (this._questionArray);
        }
        public function set questionArray(_arg_1:Array):void
        {
            this._questionArray = _arg_1;
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionPollEvent = "_-26l" (String#6181, DoABC#2)
// RWPUW_OFFER = "_-2v3" (String#21280, DoABC#2)
// RWPUW_ERROR = "_-0CA" (String#14535, DoABC#2)
// RWPUW_CONTENT = "_-su" (String#24399, DoABC#2)
// _summary = "_-0Dd" (String#811, DoABC#2)
// _numQuestions = "_-1ac" (String#1715, DoABC#2)
// _startMessage = "_-1q0" (String#1766, DoABC#2)
// _endMessage = "_-0ua" (String#826, DoABC#2)
// _questionArray = "_-1Oi" (String#1678, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)
// numQuestions = "_-2M2" (String#19886, DoABC#2)
// startMessage = "_-1qR" (String#18561, DoABC#2)
// endMessage = "_-2a3" (String#20444, DoABC#2)
// questionArray = "_-37S" (String#21785, DoABC#2)


