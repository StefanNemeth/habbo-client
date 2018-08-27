
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomQueueStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.YouAreSpectatorMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.session.GoToFlatMessageComposer;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueSet;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageParser;

    public class RoomSessionHandler extends BaseHandler 
    {

        public static const RS_CONNECTED:String = "RS_CONNECTED";
        public static const RS_READY:String = "RS_READY";
        public static const RS_DISCONNECTED:String = "RS_DISCONNECTED";

        public function RoomSessionHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new OpenConnectionMessageEvent(this.onRoomConnected));
            _arg_1.addMessageEvent(new FlatAccessibleMessageEvent(this.onFlatAccessible));
            _arg_1.addMessageEvent(new RoomReadyMessageEvent(this.onRoomReady));
            _arg_1.addMessageEvent(new CloseConnectionMessageEvent(this.onRoomDisconnected));
            _arg_1.addMessageEvent(new FlatAccessDeniedMessageEvent(this.onFlatAccessDenied));
            _arg_1.addMessageEvent(new RoomQueueStatusMessageEvent(this.onRoomQueueStatus));
            _arg_1.addMessageEvent(new YouAreSpectatorMessageEvent(this.onYouAreSpectator));
        }
        private function onRoomConnected(_arg_1:IMessageEvent):void
        {
            var _local_2:int = _xxxRoomId;
            var _local_3:int = _SafeStr_6312;
            if (listener){
                listener.sessionUpdate(_local_2, _local_3, RoomSessionHandler.RS_CONNECTED);
            };
        }
        private function onFlatAccessible(_arg_1:FlatAccessibleMessageEvent):void
        {
            var _local_6:IRoomSession;
            var _local_2:int = _xxxRoomId;
            var _local_3:int = _SafeStr_6312;
            var _local_4:FlatAccessibleMessageParser = _arg_1.getParser();
            if (_local_4 == null){
                return;
            };
            var _local_5:String = _local_4.userName;
            if ((((_local_5 == null)) || ((_local_5.length == 0)))){
                connection.send(new GoToFlatMessageComposer(_local_2));
            }
            else {
                if (((listener) && (listener.events))){
                    _local_6 = listener.getSession(_local_2, _local_3);
                    if (_local_6 != null){
                        listener.events.dispatchEvent(new RoomSessionDoorbellEvent(RoomSessionDoorbellEvent.RWDE_ACCEPTED, _local_6, _local_5));
                    };
                };
            };
        }
        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            var _local_7:RoomReadyMessageParser;
            var _local_2:int = _xxxRoomId;
            var _local_3:int = _SafeStr_6312;
            var _local_4:int = _local_2;
            var _local_5:int = _local_3;
            var _local_6:RoomReadyMessageEvent = (_arg_1 as RoomReadyMessageEvent);
            if (_local_6 != null){
                _local_7 = _local_6.getParser();
                if (_local_7 != null){
                    _local_4 = _local_7.roomId;
                    _local_5 = _local_7.roomCategory;
                };
            };
            if (listener){
                listener.sessionReinitialize(_local_2, _local_3, _local_4, _local_5);
                listener.sessionUpdate(_local_2, _local_3, RoomSessionHandler.RS_READY);
            };
        }
        private function onFlatAccessDenied(_arg_1:FlatAccessDeniedMessageEvent):void
        {
            var _local_6:IRoomSession;
            var _local_2:int = _xxxRoomId;
            var _local_3:int = _SafeStr_6312;
            var _local_4:FlatAccessDeniedMessageParser = _arg_1.getParser();
            if (_local_4 == null){
                return;
            };
            var _local_5:String = _local_4.userName;
            if ((((_local_5 == null)) || ((_local_5.length == 0)))){
                if (listener){
                    listener.sessionUpdate(_local_2, _local_3, RoomSessionHandler.RS_DISCONNECTED);
                };
            }
            else {
                if (((listener) && (listener.events))){
                    _local_6 = listener.getSession(_local_2, _local_3);
                    if (_local_6 != null){
                        listener.events.dispatchEvent(new RoomSessionDoorbellEvent(RoomSessionDoorbellEvent.RWDE_REJECTED, _local_6, _local_5));
                    };
                };
            };
        }
        private function onRoomDisconnected(_arg_1:IMessageEvent):void
        {
            var _local_2:int = _xxxRoomId;
            var _local_3:int = _SafeStr_6312;
            if (listener){
                listener.sessionUpdate(_local_2, _local_3, RoomSessionHandler.RS_DISCONNECTED);
            };
        }
        private function onRoomQueueStatus(_arg_1:RoomQueueStatusMessageEvent):void
        {
            var _local_4:RoomQueueSet;
            var _local_5:RoomSessionQueueEvent;
            var _local_7:Array;
            var _local_9:int;
            var _local_10:String;
            if ((((listener == null)) || ((listener.events == null)))){
                return;
            };
            var _local_2:RoomQueueStatusMessageParser = _arg_1.getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            var _local_6:Array = _local_2.getQueueSetTargets();
            var _local_8:int = _local_2.activeTarget;
            for each (_local_9 in _local_6) {
                _local_4 = _local_2.getQueueSet(_local_9);
                _local_5 = new RoomSessionQueueEvent(_local_3, _local_4.name, _local_4.target, (_local_4.target == _local_8));
                _local_7 = _local_4.queueTypes;
                for each (_local_10 in _local_7) {
                    _local_5.addQueue(_local_10, _local_4.getQueueSize(_local_10));
                };
                listener.events.dispatchEvent(_local_5);
            };
        }
        private function onYouAreSpectator(_arg_1:YouAreSpectatorMessageEvent):void
        {
            if (listener == null){
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            _local_2.isSpectatorMode = true;
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// RoomSessionHandler = "_-243" (String#6124, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionDoorbellEvent = "_-30k" (String#7320, DoABC#2)
// RoomSessionQueueEvent = "_-0n4" (String#4569, DoABC#2)
// RoomReadyMessageEvent = "_-1uW" (String#5930, DoABC#2)
// RoomReadyMessageParser = "_-1zm" (String#18958, DoABC#2)
// GoToFlatMessageComposer = "_-1W0" (String#17744, DoABC#2)
// FlatAccessDeniedMessageParser = "_-1oe" (String#5835, DoABC#2)
// OpenConnectionMessageEvent = "_-UX" (String#8296, DoABC#2)
// RoomQueueSet = "_-0bO" (String#4330, DoABC#2)
// FlatAccessibleMessageEvent = "_-e-" (String#23802, DoABC#2)
// RoomQueueStatusMessageParser = "_-1qx" (String#5873, DoABC#2)
// FlatAccessDeniedMessageEvent = "_-3Cj" (String#7570, DoABC#2)
// YouAreSpectatorMessageEvent = "_-PJ" (String#23219, DoABC#2)
// FlatAccessibleMessageParser = "_-1d1" (String#5616, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// RWDE_REJECTED = "_-1MV" (String#17378, DoABC#2)
// queueTypes = "_-1Hm" (String#17182, DoABC#2)
// getQueueSize = "_-2ar" (String#20482, DoABC#2)
// addQueue = "_-RF" (String#23293, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// RS_CONNECTED = "_-2VD" (String#20249, DoABC#2)
// RS_READY = "_-2uu" (String#21274, DoABC#2)
// RS_DISCONNECTED = "_-2nj" (String#20988, DoABC#2)
// onRoomConnected = "_-19u" (String#16851, DoABC#2)
// onFlatAccessible = "_-1c8" (String#17977, DoABC#2)
// onRoomReady = "_-0KO" (String#583, DoABC#2)
// onRoomDisconnected = "_-2mG" (String#20929, DoABC#2)
// onFlatAccessDenied = "_-1qT" (String#5863, DoABC#2)
// onRoomQueueStatus = "_-2BL" (String#19458, DoABC#2)
// onYouAreSpectator = "_-3G-" (String#22115, DoABC#2)
// getQueueSetTargets = "_-0lJ" (String#15877, DoABC#2)
// activeTarget = "_-38N" (String#21817, DoABC#2)
// getQueueSet = "_-1sT" (String#18652, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)


