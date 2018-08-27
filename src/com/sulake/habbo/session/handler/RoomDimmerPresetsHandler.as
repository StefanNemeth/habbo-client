
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomDimmerPresetsMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomDimmerPresetsHandler extends BaseHandler 
    {

        public function RoomDimmerPresetsHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new RoomDimmerPresetsMessageEvent(this.onRoomDimmerPresets));
        }
        private function onRoomDimmerPresets(_arg_1:IMessageEvent):void
        {
            var _local_9:RoomDimmerPresetsMessageData;
            var _local_2:RoomDimmerPresetsMessageEvent = (_arg_1 as RoomDimmerPresetsMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:RoomDimmerPresetsMessageParser = _local_2.getParser();
            var _local_4:int = _local_3.roomId;
            var _local_5:int = _local_3.roomCategory;
            var _local_6:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_6 == null){
                return;
            };
            var _local_7:RoomSessionDimmerPresetsEvent = new RoomSessionDimmerPresetsEvent(RoomSessionDimmerPresetsEvent.RSDPE_PRESETS, _local_6);
            _local_7.selectedPresetId = _local_3.selectedPresetId;
            var _local_8:int;
            while (_local_8 < _local_3.presetCount) {
                _local_9 = _local_3.getPreset(_local_8);
                if (_local_9 != null){
                    _local_7.storePreset(_local_9.id, _local_9.type, _local_9.color, _local_9.light);
                };
                _local_8++;
            };
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(_local_7);
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// RoomDimmerPresetsHandler = "_-060" (String#3686, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionDimmerPresetsEvent = "_-1lO" (String#5773, DoABC#2)
// RoomDimmerPresetsMessageEvent = "_-gw" (String#23926, DoABC#2)
// RoomDimmerPresetsMessageParser = "_-1xY" (String#5982, DoABC#2)
// RoomDimmerPresetsMessageData = "_-0sE" (String#4690, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSDPE_PRESETS = "_-3B3" (String#21925, DoABC#2)
// selectedPresetId = "_-0Pr" (String#15055, DoABC#2)
// presetCount = "_-Gt" (String#22886, DoABC#2)
// storePreset = "_-0k4" (String#15834, DoABC#2)
// getPreset = "_-0rG" (String#16096, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onRoomDimmerPresets = "_-0zr" (String#16421, DoABC#2)


