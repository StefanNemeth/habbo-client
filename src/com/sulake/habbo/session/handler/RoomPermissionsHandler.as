
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreNotControllerMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreOwnerMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomPermissionsHandler extends BaseHandler 
    {

        public function RoomPermissionsHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new YouAreControllerMessageEvent(this.onYouAreController));
            _arg_1.addMessageEvent(new YouAreNotControllerMessageEvent(this.onYouAreNotController));
            _arg_1.addMessageEvent(new YouAreOwnerMessageEvent(this.onYouAreOwner));
        }
        private function onYouAreController(_arg_1:IMessageEvent):void
        {
            var _local_2:YouAreControllerMessageEvent = (_arg_1 as YouAreControllerMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            _local_3.isRoomController = true;
        }
        private function onYouAreNotController(_arg_1:IMessageEvent):void
        {
            var _local_2:YouAreNotControllerMessageEvent = (_arg_1 as YouAreNotControllerMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            _local_3.isRoomController = false;
        }
        private function onYouAreOwner(_arg_1:IMessageEvent):void
        {
            var _local_2:YouAreOwnerMessageEvent = (_arg_1 as YouAreOwnerMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            _local_3.isRoomOwner = true;
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// RoomPermissionsHandler = "_-1E9" (String#5143, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// YouAreOwnerMessageEvent = "_-0bo" (String#15504, DoABC#2)
// YouAreNotControllerMessageEvent = "_-2jG" (String#20814, DoABC#2)
// YouAreControllerMessageEvent = "_-28l" (String#19360, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onYouAreController = "_-1aG" (String#17906, DoABC#2)
// onYouAreNotController = "_-1IT" (String#17212, DoABC#2)
// onYouAreOwner = "_-1Jz" (String#17273, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)


