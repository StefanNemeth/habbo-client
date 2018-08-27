
package com.sulake.habbo.ui.widget.friendrequest
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetUserLocationMessage;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;

    public class FriendRequestWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private var _component:Component;
        private var _requests:Map;

        public function FriendRequestWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:Component)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._component = _arg_5;
            this._requests = new Map();
        }
        override public function dispose():void
        {
            var _local_1:FriendRequestDialog;
            if (disposed){
                return;
            };
            if (this._component){
                this._component.removeUpdateReceiver(this);
                this._component = null;
            };
            if (this._requests){
                for each (_local_1 in this._requests) {
                    _local_1.dispose();
                    _local_1 = null;
                };
                this._requests.dispose();
                this._requests = null;
            };
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1){
                return;
            };
            _arg_1.addEventListener(RoomWidgetFriendRequestUpdateEvent.RWFRUE_SHOW_FRIEND_REQUEST, this.eventHandler);
            _arg_1.addEventListener(RoomWidgetFriendRequestUpdateEvent.RWFRUE_HIDE_FRIEND_REQUEST, this.eventHandler);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetFriendRequestUpdateEvent.RWFRUE_SHOW_FRIEND_REQUEST, this.eventHandler);
            _arg_1.removeEventListener(RoomWidgetFriendRequestUpdateEvent.RWFRUE_HIDE_FRIEND_REQUEST, this.eventHandler);
        }
        private function eventHandler(_arg_1:RoomWidgetFriendRequestUpdateEvent):void
        {
            if (!_arg_1){
                return;
            };
            switch (_arg_1.type){
                case RoomWidgetFriendRequestUpdateEvent.RWFRUE_SHOW_FRIEND_REQUEST:
                    this.addRequest(_arg_1.requestId, new FriendRequestDialog(this, _arg_1.requestId, _arg_1.userId, _arg_1.userName));
                    break;
                case RoomWidgetFriendRequestUpdateEvent.RWFRUE_HIDE_FRIEND_REQUEST:
                    this.removeRequest(_arg_1.requestId);
                    break;
            };
            this.checkUpdateNeed();
        }
        public function checkUpdateNeed():void
        {
            if (!this._component){
                return;
            };
            if (((this._requests) && ((this._requests.length > 0)))){
                this._component.registerUpdateReceiver(this, 10);
            }
            else {
                this._component.removeUpdateReceiver(this);
            };
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:FriendRequestDialog;
            var _local_3:RoomWidgetUserLocationUpdateEvent;
            if (!this._requests){
                return;
            };
            for each (_local_2 in this._requests) {
                if (_local_2){
                    _local_3 = (messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(_local_2.userId, RoomObjectTypeEnum._SafeStr_3740)) as RoomWidgetUserLocationUpdateEvent);
                    if (_local_3){
                        _local_2.targetRect = _local_3.rectangle;
                    };
                };
            };
        }
        public function acceptRequest(_arg_1:int):void
        {
            if (!messageListener){
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage(RoomWidgetFriendRequestMessage.RWFRM_ACCEPT, _arg_1));
            this.removeRequest(_arg_1);
        }
        public function declineRequest(_arg_1:int):void
        {
            if (!messageListener){
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage(RoomWidgetFriendRequestMessage.RWFRM_DECLINE, _arg_1));
            this.removeRequest(_arg_1);
        }
        public function ignoreRequest(_arg_1:int):void
        {
            this.removeRequest(_arg_1);
        }
        private function addRequest(_arg_1:int, _arg_2:FriendRequestDialog):void
        {
            if (((!(this._requests)) || (!(_arg_2)))){
                return;
            };
            this._requests.add(_arg_1, _arg_2);
        }
        private function removeRequest(_arg_1:int):void
        {
            if (!this._requests){
                return;
            };
            var _local_2:FriendRequestDialog = (this._requests.getValue(_arg_1) as FriendRequestDialog);
            if (!_local_2){
                return;
            };
            this._requests.remove(_arg_1);
            _local_2.dispose();
            this.checkUpdateNeed();
        }

    }
}//package com.sulake.habbo.ui.widget.friendrequest

// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// FriendRequestWidget = "_-1-w" (String#4866, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// FriendRequestDialog = "_-2g7" (String#6869, DoABC#2)
// RoomWidgetFriendRequestUpdateEvent = "_-mJ" (String#8650, DoABC#2)
// RoomWidgetFriendRequestMessage = "_-2Pw" (String#6560, DoABC#2)
// RoomWidgetGetUserLocationMessage = "_-2z-" (String#7262, DoABC#2)
// RoomWidgetUserLocationUpdateEvent = "_-2ox" (String#7058, DoABC#2)
// RWFRM_ACCEPT = "_-31F" (String#21548, DoABC#2)
// RWFRM_DECLINE = "_-05q" (String#14276, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// _SafeStr_3740 = "_-39-" (String#21844, DoABC#2)
// eventHandler = "_-34P" (String#217, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)
// RWFRUE_SHOW_FRIEND_REQUEST = "_-0R-" (String#15102, DoABC#2)
// RWFRUE_HIDE_FRIEND_REQUEST = "_-12A" (String#16542, DoABC#2)
// addRequest = "_-2i" (String#1927, DoABC#2)
// removeRequest = "_-1qi" (String#1769, DoABC#2)
// checkUpdateNeed = "_-21r" (String#19084, DoABC#2)
// targetRect = "_-2aZ" (String#20467, DoABC#2)
// acceptRequest = "_-3CU" (String#7565, DoABC#2)
// declineRequest = "_-1A2" (String#5078, DoABC#2)
// ignoreRequest = "_-30P" (String#21518, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)


