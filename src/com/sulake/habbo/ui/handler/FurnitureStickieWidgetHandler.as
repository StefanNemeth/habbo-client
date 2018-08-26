
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureStickieWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_STICKIE_WIDGET);
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
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_STICKIE, RoomWidgetStickieSendUpdateMessage.RWSUM_STICKIE_SEND_DELETE, RoomWidgetStickieSendUpdateMessage.RWSUM_STICKIE_SEND_UPDATE]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_4:RoomWidgetStickieSendUpdateMessage;
            var _local_5:RoomWidgetStickieSendUpdateMessage;
            var _local_6:IRoomObjectModel;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:Boolean;
            var _local_11:RoomWidgetStickieDataUpdateEvent;
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_STICKIE:
                    _local_2 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_2.roomId, _local_2.roomCategory, _local_2.id, _local_2.category);
                    if (_local_3 != null){
                        _local_6 = _local_3.getModel();
                        if (_local_6 != null){
                            _local_7 = _local_6.getString(RoomObjectVariableEnum._SafeStr_7309);
                            if (_local_7.length < 6){
                                return (null);
                            };
                            _local_9 = "";
                            if (_local_7.indexOf(" ") > 0){
                                _local_8 = _local_7.slice(0, _local_7.indexOf(" "));
                                _local_9 = _local_7.slice((_local_7.indexOf(" ") + 1), _local_7.length);
                            }
                            else {
                                _local_8 = _local_7;
                            };
                            _local_10 = ((this._container.roomSession.isRoomOwner) || (this._container.sessionDataManager.isAnyRoomController));
                            _local_11 = new RoomWidgetStickieDataUpdateEvent(RoomWidgetStickieDataUpdateEvent.RWSDUE_STICKIE_DATA, _local_2.id, _local_3.getType(), _local_9, _local_8, _local_10);
                            this._container.events.dispatchEvent(_local_11);
                        };
                    };
                    break;
                case RoomWidgetStickieSendUpdateMessage.RWSUM_STICKIE_SEND_UPDATE:
                    _local_4 = (_arg_1 as RoomWidgetStickieSendUpdateMessage);
                    if (_local_4 == null){
                        return (null);
                    };
                    if (((!((this._container == null))) && (!((this._container.roomEngine == null))))){
                        this._container.roomEngine.RoomEngine(_local_4.objectId, RoomObjectCategoryEnum._SafeStr_4330, ((_local_4.colorHex + " ") + _local_4.text));
                    };
                    break;
                case RoomWidgetStickieSendUpdateMessage.RWSUM_STICKIE_SEND_DELETE:
                    _local_5 = (_arg_1 as RoomWidgetStickieSendUpdateMessage);
                    if (_local_5 == null){
                        return (null);
                    };
                    if (((!((this._container == null))) && (!((this._container.roomEngine == null))))){
                        this._container.roomEngine.RoomEngine(_local_5.objectId, RoomObjectCategoryEnum._SafeStr_4330);
                    };
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:Event;
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FurnitureStickieWidgetHandler = "_-0MB" (String#14922, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetStickieDataUpdateEvent = "_-1X9" (String#5500, DoABC#2)
// RoomWidgetStickieSendUpdateMessage = "_-1vS" (String#5950, DoABC#2)
// RWFWM_MESSAGE_REQUEST_STICKIE = "_-0C3" (String#14529, DoABC#2)
// RWSUM_STICKIE_SEND_UPDATE = "_-0Zu" (String#15438, DoABC#2)
// RWSUM_STICKIE_SEND_DELETE = "_-v1" (String#24492, DoABC#2)
// colorHex = "_-3I3" (String#22203, DoABC#2)
// RWE_FURNI_STICKIE_WIDGET = "_-05M" (String#14258, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// RWSDUE_STICKIE_DATA = "_-0tT" (String#16178, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7309 = "_-2Cm" (String#19516, DoABC#2)
// RoomEngine = "_-0Eh" (String#3843, DoABC#2)
// RoomEngine = "_-1YS" (String#5529, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


