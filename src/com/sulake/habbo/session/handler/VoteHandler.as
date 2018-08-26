
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.poll.VoteQuestionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.poll.VoteResultMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.events.RoomSessionVoteEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.poll.VoteQuestionMessageParser;
    import com.sulake.habbo.communication.messages.parser.poll.VoteResultMessageParser;

    public class VoteHandler extends BaseHandler 
    {

        public function VoteHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (!_arg_1){
                return;
            };
            _arg_1.addMessageEvent(new VoteQuestionMessageEvent(this.onVoteQuestionEvent));
            _arg_1.addMessageEvent(new VoteResultMessageEvent(this.onVoteResultEvent));
        }
        private function onVoteQuestionEvent(_arg_1:VoteQuestionMessageEvent):void
        {
            var _local_4:RoomSessionVoteEvent;
            if (!_arg_1){
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            var _local_3:VoteQuestionMessageParser = _arg_1.getParser();
            _local_4 = new RoomSessionVoteEvent(RoomSessionVoteEvent.RWPUE_VOTE_QUESTION, _local_2, _local_3.question, _local_3.choices);
            listener.events.dispatchEvent(_local_4);
        }
        private function onVoteResultEvent(_arg_1:VoteResultMessageEvent):void
        {
            var _local_4:RoomSessionVoteEvent;
            if (!_arg_1){
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            var _local_3:VoteResultMessageParser = _arg_1.getParser();
            _local_4 = new RoomSessionVoteEvent(RoomSessionVoteEvent.RWPUE_VOTE_RESULT, _local_2, _local_3.question, _local_3.choices, _local_3.votes, _local_3.totalVotes);
            listener.events.dispatchEvent(_local_4);
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// VoteHandler = "_-gx" (String#8534, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionVoteEvent = "_-19h" (String#5071, DoABC#2)
// VoteResultMessageParser = "_-b6" (String#8443, DoABC#2)
// VoteQuestionMessageEvent = "_-1WZ" (String#17761, DoABC#2)
// VoteResultMessageEvent = "_-1Gz" (String#17150, DoABC#2)
// VoteQuestionMessageParser = "_-2bI" (String#6778, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RWPUE_VOTE_QUESTION = "_-1cE" (String#17980, DoABC#2)
// RWPUE_VOTE_RESULT = "_-1I3" (String#17195, DoABC#2)
// votes = "_-2a2" (String#20443, DoABC#2)
// totalVotes = "_-0EU" (String#14625, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onVoteQuestionEvent = "_-0BY" (String#14508, DoABC#2)
// onVoteResultEvent = "_-co" (String#23746, DoABC#2)


