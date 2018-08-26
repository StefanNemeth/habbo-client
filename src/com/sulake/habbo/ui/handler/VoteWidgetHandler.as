
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetVoteMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionVoteEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetVoteUpdateEvent;
    import flash.events.Event;

    public class VoteWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_ROOM_VOTE);
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
            return ([RoomWidgetVoteMessage.RWE_ROOM_VOTE]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetVoteMessage;
            switch (_arg_1.type){
                case RoomWidgetVoteMessage.RWE_ROOM_VOTE:
                    _local_2 = (_arg_1 as RoomWidgetVoteMessage);
                    if (_local_2 == null){
                        return (null);
                    };
                    this._container.roomSession.RoomSession(_local_2.vote);
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomSessionVoteEvent.RWPUE_VOTE_QUESTION);
            _local_1.push(RoomSessionVoteEvent.RWPUE_VOTE_RESULT);
            return (_local_1);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_3:RoomWidgetVoteUpdateEvent;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            var _local_2:RoomSessionVoteEvent = (_arg_1 as RoomSessionVoteEvent);
            if (_local_2 == null){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionVoteEvent.RWPUE_VOTE_QUESTION:
                    _local_3 = new RoomWidgetVoteUpdateEvent(RoomWidgetVoteUpdateEvent.RWPUE_VOTE_QUESTION, _local_2.question, _local_2.choices);
                    break;
                case RoomSessionVoteEvent.RWPUE_VOTE_RESULT:
                    _local_3 = new RoomWidgetVoteUpdateEvent(RoomWidgetVoteUpdateEvent.RWPUE_VOTE_RESULT, _local_2.question, _local_2.choices, _local_2.votes, _local_2.totalVotes);
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

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomSessionVoteEvent = "_-19h" (String#5071, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// VoteWidgetHandler = "_-134" (String#16583, DoABC#2)
// RoomWidgetVoteMessage = "_-0ie" (String#4475, DoABC#2)
// RoomWidgetVoteUpdateEvent = "_-2qd" (String#7089, DoABC#2)
// RWE_ROOM_VOTE = "_-1yq" (String#18921, DoABC#2)
// vote = "_-AW" (String#7878, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RWPUE_VOTE_QUESTION = "_-1cE" (String#17980, DoABC#2)
// RWPUE_VOTE_RESULT = "_-1I3" (String#17195, DoABC#2)
// votes = "_-2a2" (String#20443, DoABC#2)
// totalVotes = "_-0EU" (String#14625, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// RoomSession = "_-2W0" (String#6684, DoABC#2)


