
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.poll.PollContentsEvent;
    import com.sulake.habbo.communication.messages.incoming.poll.PollOfferEvent;
    import com.sulake.habbo.communication.messages.incoming.poll.PollErrorEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.poll.PollOfferParser;
    import com.sulake.habbo.communication.messages.parser.poll.PollErrorParser;
    import com.sulake.habbo.communication.messages.parser.poll.PollContentsParser;

    public class PollHandler extends BaseHandler 
    {

        public function PollHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (!_arg_1){
                return;
            };
            _arg_1.addMessageEvent(new PollContentsEvent(this.onPollContentsEvent));
            _arg_1.addMessageEvent(new PollOfferEvent(this.onPollOfferEvent));
            _arg_1.addMessageEvent(new PollErrorEvent(this.onPollErrorEvent));
        }
        private function onPollOfferEvent(_arg_1:PollOfferEvent):void
        {
            var _local_4:RoomSessionPollEvent;
            if (!_arg_1){
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            var _local_3:PollOfferParser = _arg_1.getParser();
            _local_4 = new RoomSessionPollEvent(RoomSessionPollEvent.RWPUW_OFFER, _local_2, _local_3.id);
            _local_4.summary = _local_3.summary;
            listener.events.dispatchEvent(_local_4);
        }
        private function onPollErrorEvent(_arg_1:PollErrorEvent):void
        {
            var _local_4:RoomSessionPollEvent;
            if (!_arg_1){
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            var _local_3:PollErrorParser = _arg_1.getParser();
            _local_4 = new RoomSessionPollEvent(RoomSessionPollEvent.RWPUW_ERROR, _local_2, -1);
            _local_4.summary = "???";
            listener.events.dispatchEvent(_local_4);
        }
        private function onPollContentsEvent(_arg_1:PollContentsEvent):void
        {
            var _local_4:RoomSessionPollEvent;
            if (!_arg_1){
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            var _local_3:PollContentsParser = _arg_1.getParser();
            _local_4 = new RoomSessionPollEvent(RoomSessionPollEvent.RWPUW_CONTENT, _local_2, _local_3.id);
            _local_4.startMessage = _local_3.startMessage;
            _local_4.endMessage = _local_3.endMessage;
            _local_4.numQuestions = _local_3.numQuestions;
            _local_4.questionArray = _local_3.questionArray;
            listener.events.dispatchEvent(_local_4);
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// PollHandler = "_-2G9" (String#6369, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionPollEvent = "_-26l" (String#6181, DoABC#2)
// PollContentsEvent = "_-0Fi" (String#14671, DoABC#2)
// PollOfferEvent = "_-37p" (String#21798, DoABC#2)
// PollContentsParser = "_-125" (String#4918, DoABC#2)
// PollOfferParser = "_-13H" (String#4940, DoABC#2)
// PollErrorParser = "_-0KC" (String#3956, DoABC#2)
// PollErrorEvent = "_-9t" (String#22614, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RWPUW_OFFER = "_-2v3" (String#21280, DoABC#2)
// RWPUW_ERROR = "_-0CA" (String#14535, DoABC#2)
// RWPUW_CONTENT = "_-su" (String#24399, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)
// numQuestions = "_-2M2" (String#19886, DoABC#2)
// startMessage = "_-1qR" (String#18561, DoABC#2)
// endMessage = "_-2a3" (String#20444, DoABC#2)
// questionArray = "_-37S" (String#21785, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onPollContentsEvent = "_-Cr" (String#22721, DoABC#2)
// onPollOfferEvent = "_-7G" (String#22512, DoABC#2)
// onPollErrorEvent = "_-0eL" (String#15600, DoABC#2)


