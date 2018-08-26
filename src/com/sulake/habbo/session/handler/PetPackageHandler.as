
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageRequestedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageResultMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageRequestedMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageResultMessageParser;

    public class PetPackageHandler extends BaseHandler 
    {

        public function PetPackageHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new OpenPetPackageRequestedMessageEvent(this.onOpenPetPackageRequested));
            _arg_1.addMessageEvent(new OpenPetPackageResultMessageEvent(this.onOpenPetPackageResult));
        }
        private function onOpenPetPackageRequested(_arg_1:IMessageEvent):void
        {
            var _local_2:OpenPetPackageRequestedMessageParser = (_arg_1 as OpenPetPackageRequestedMessageEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(new RoomSessionPetPackageEvent(RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_REQUESTED, _local_3, _local_2.objectId, _local_2.petType, _local_2.breed, _local_2.color, 0, null));
            };
        }
        private function onOpenPetPackageResult(_arg_1:IMessageEvent):void
        {
            var _local_2:OpenPetPackageResultMessageParser = (_arg_1 as OpenPetPackageResultMessageEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(new RoomSessionPetPackageEvent(RoomSessionPetPackageEvent.RSOPPE_OPEN_PET_PACKAGE_RESULT, _local_3, _local_2.objectId, -1, -1, "", _local_2.nameValidationStatus, _local_2.nameValidationInfo));
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// PetPackageHandler = "_-2GG" (String#6371, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionPetPackageEvent = "_-0sq" (String#4702, DoABC#2)
// OpenPetPackageRequestedMessageEvent = "_-1EY" (String#17050, DoABC#2)
// OpenPetPackageResultMessageEvent = "_-1Ob" (String#17453, DoABC#2)
// OpenPetPackageResultMessageParser = "_-09b" (String#3750, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_REQUESTED = "_-FG" (String#22824, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_RESULT = "_-2JR" (String#19786, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onOpenPetPackageRequested = "_-Ev" (String#22808, DoABC#2)
// onOpenPetPackageResult = "_-15e" (String#16681, DoABC#2)


