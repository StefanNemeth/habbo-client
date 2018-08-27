
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetUserLocationMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IUserData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
    import flash.events.Event;

    public class FriendRequestWidgetHandler implements IRoomWidgetHandler 
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
        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetGetUserLocationMessage.RWGOI_MESSAGE_GET_USER_LOCATION);
            _local_1.push(RoomWidgetFriendRequestMessage.RWFRM_ACCEPT);
            _local_1.push(RoomWidgetFriendRequestMessage.RWFRM_DECLINE);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetGetUserLocationMessage;
            var _local_3:IRoomSession;
            var _local_4:IUserData;
            var _local_5:Rectangle;
            var _local_6:Point;
            var _local_7:RoomWidgetFriendRequestMessage;
            var _local_8:RoomWidgetFriendRequestMessage;
            var _local_9:Rectangle;
            if (((!(_arg_1)) || (!(this._container)))){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetGetUserLocationMessage.RWGOI_MESSAGE_GET_USER_LOCATION:
                    _local_2 = (_arg_1 as RoomWidgetGetUserLocationMessage);
                    if (!_local_2){
                        return (null);
                    };
                    _local_3 = this._container.roomSession;
                    if (((!(_local_3)) || (!(_local_3.userDataManager)))){
                        return (null);
                    };
                    _local_4 = _local_3.userDataManager.getUserDataByType(_local_2.userId, _local_2.userType);
                    if (_local_4){
                        _local_5 = this._container.roomEngine.getRoomObjectBoundingRectangle(_local_3.roomId, _local_3.roomCategory, _local_4.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, this._container.getFirstCanvasId());
                        _local_6 = this._container.roomEngine.getRoomObjectScreenLocation(_local_3.roomId, _local_3.roomCategory, _local_4.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, this._container.getFirstCanvasId());
                        _local_9 = this._container.getRoomViewRect();
                        if (((((_local_5) && (_local_9))) && (_local_6))){
                            _local_5.offset(_local_9.x, _local_9.y);
                            _local_6.offset(_local_9.x, _local_9.y);
                        };
                    };
                    return (new RoomWidgetUserLocationUpdateEvent(_local_2.userId, _local_5, _local_6));
                case RoomWidgetFriendRequestMessage.RWFRM_ACCEPT:
                    _local_7 = (_arg_1 as RoomWidgetFriendRequestMessage);
                    if (((!(_local_7)) || (!(this._container.friendList)))){
                        return (null);
                    };
                    this._container.friendList.acceptFriendRequest(_local_7.requestId);
                    break;
                case RoomWidgetFriendRequestMessage.RWFRM_DECLINE:
                    _local_8 = (_arg_1 as RoomWidgetFriendRequestMessage);
                    if (((!(_local_8)) || (!(this._container.friendList)))){
                        return (null);
                    };
                    this._container.friendList.declineFriendRequest(_local_8.requestId);
                    break;
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomSessionFriendRequestEvent.RSFRE_FRIEND_REQUEST);
            _local_1.push(FriendRequestEvent.RWDE_ACCEPTED);
            _local_1.push(FriendRequestEvent.FRE_DECLINED);
            return (_local_1);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomWidgetFriendRequestUpdateEvent;
            var _local_3:String;
            var _local_4:RoomSessionFriendRequestEvent;
            var _local_5:FriendRequestEvent;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionFriendRequestEvent.RSFRE_FRIEND_REQUEST:
                    _local_4 = (_arg_1 as RoomSessionFriendRequestEvent);
                    if (!_local_4){
                        return;
                    };
                    _local_3 = RoomWidgetFriendRequestUpdateEvent.RWFRUE_SHOW_FRIEND_REQUEST;
                    _local_2 = new RoomWidgetFriendRequestUpdateEvent(_local_3, _local_4.requestId, _local_4.userId, _local_4.userName);
                    break;
                case FriendRequestEvent.RWDE_ACCEPTED:
                case FriendRequestEvent.FRE_DECLINED:
                    _local_5 = (_arg_1 as FriendRequestEvent);
                    if (!_local_5){
                        return;
                    };
                    _local_3 = RoomWidgetFriendRequestUpdateEvent.RWFRUE_HIDE_FRIEND_REQUEST;
                    _local_2 = new RoomWidgetFriendRequestUpdateEvent(_local_3, _local_5.requestId);
                    break;
            };
            if (_local_2){
                this._container.events.dispatchEvent(_local_2);
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionFriendRequestEvent = "_-31R" (String#21557, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// FriendRequestEvent = "_-1SF" (String#17590, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FriendRequestWidgetHandler = "_-1St" (String#17619, DoABC#2)
// RoomWidgetFriendRequestUpdateEvent = "_-mJ" (String#8650, DoABC#2)
// RoomWidgetFriendRequestMessage = "_-2Pw" (String#6560, DoABC#2)
// RoomWidgetGetUserLocationMessage = "_-2z-" (String#7262, DoABC#2)
// RoomWidgetUserLocationUpdateEvent = "_-2ox" (String#7058, DoABC#2)
// RWFRM_ACCEPT = "_-31F" (String#21548, DoABC#2)
// RWFRM_DECLINE = "_-05q" (String#14276, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// RWGOI_MESSAGE_GET_USER_LOCATION = "_-kp" (String#24062, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// RWE_ROOM_POLL = "_-Y" (String#23560, DoABC#2)
// RSFRE_FRIEND_REQUEST = "_-2Wu" (String#20318, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// FRE_DECLINED = "_-2IY" (String#19749, DoABC#2)
// getRoomObjectBoundingRectangle = "_-0PC" (String#4075, DoABC#2)
// RWFRUE_SHOW_FRIEND_REQUEST = "_-0R-" (String#15102, DoABC#2)
// RWFRUE_HIDE_FRIEND_REQUEST = "_-12A" (String#16542, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// getFirstCanvasId = "_-iH" (String#8561, DoABC#2)
// getUserDataByType = "_-1UX" (String#5443, DoABC#2)
// getRoomObjectScreenLocation = "_-3l" (String#7742, DoABC#2)
// getRoomViewRect = "_-1ZD" (String#5545, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


