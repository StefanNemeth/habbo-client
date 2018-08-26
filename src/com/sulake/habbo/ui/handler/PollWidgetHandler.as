
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPollUpdateEvent;
    import flash.events.Event;

    public class PollWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_ROOM_POLL);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function dispose():void
        {
            this._disposed = true;
            this._container = null;
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomWidgetPollMessage.ANSWER, RoomWidgetPollMessage.RWPM_REJECT, RoomWidgetPollMessage.RWPM_START]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetPollMessage = (_arg_1 as RoomWidgetPollMessage);
            if (_local_2 == null){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetPollMessage.RWPM_START:
                    this._container.roomSession.RoomSession(_local_2.id);
                    break;
                case RoomWidgetPollMessage.RWPM_REJECT:
                    this._container.roomSession.RoomSession(_local_2.id);
                    break;
                case RoomWidgetPollMessage.ANSWER:
                    this._container.roomSession.RoomSession(_local_2.id, _local_2.questionId, _local_2.answers);
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomSessionPollEvent.RWPUW_OFFER);
            _local_1.push(RoomSessionPollEvent.RWPUW_ERROR);
            _local_1.push(RoomSessionPollEvent.RWPUW_CONTENT);
            return (_local_1);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_3:RoomWidgetPollUpdateEvent;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            var _local_2:RoomSessionPollEvent = (_arg_1 as RoomSessionPollEvent);
            if (_local_2 == null){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionPollEvent.RWPUW_OFFER:
                    _local_3 = new RoomWidgetPollUpdateEvent(_local_2.id, RoomWidgetPollUpdateEvent.RWPUW_OFFER);
                    _local_3.summary = _local_2.summary;
                    break;
                case RoomSessionPollEvent.RWPUW_ERROR:
                    _local_3 = new RoomWidgetPollUpdateEvent(_local_2.id, RoomWidgetPollUpdateEvent.RWPUW_ERROR);
                    _local_3.summary = _local_2.summary;
                    break;
                case RoomSessionPollEvent.RWPUW_CONTENT:
                    _local_3 = new RoomWidgetPollUpdateEvent(_local_2.id, RoomWidgetPollUpdateEvent.RWPUW_CONTENT);
                    _local_3.startMessage = _local_2.startMessage;
                    _local_3.endMessage = _local_2.endMessage;
                    _local_3.numQuestions = _local_2.numQuestions;
                    _local_3.questionArray = _local_2.questionArray;
                    break;
            };
            if (_local_3 == null){
                return;
            };
            this._container.events.dispatchEvent(_local_3);
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomSessionPollEvent = "_-26l" (String#6181, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// PollWidgetHandler = "_-1wc" (String#18827, DoABC#2)
// RoomWidgetPollUpdateEvent = "_-0GJ" (String#3876, DoABC#2)
// RoomWidgetPollMessage = "_-0uI" (String#4731, DoABC#2)
// RWPM_START = "_-1VF" (String#17711, DoABC#2)
// RWPM_REJECT = "_-1pH" (String#18513, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// answers = "_-2rZ" (String#21139, DoABC#2)
// RWE_ROOM_POLL = "_-Y" (String#23560, DoABC#2)
// RWPUW_OFFER = "_-2v3" (String#21280, DoABC#2)
// RWPUW_ERROR = "_-0CA" (String#14535, DoABC#2)
// RWPUW_CONTENT = "_-su" (String#24399, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)
// numQuestions = "_-2M2" (String#19886, DoABC#2)
// startMessage = "_-1qR" (String#18561, DoABC#2)
// endMessage = "_-2a3" (String#20444, DoABC#2)
// questionArray = "_-37S" (String#21785, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// RoomSession = "_-0ug" (String#4736, DoABC#2)
// RoomSession = "_-IP" (String#8047, DoABC#2)
// RoomSession = "_-0Tt" (String#4177, DoABC#2)


