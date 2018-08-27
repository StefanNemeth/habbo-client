
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenedMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import flash.events.Event;

    public class FurnitureEcotronBoxWidgetHandler implements IRoomWidgetHandler, IGetImageListener 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _objectId:int = -1;
        private var _name:String = "";

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_ECOTRONBOX_WIDGET);
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
            return ([RoomWidgetFurniToWidgetMessage.WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET, RoomWidgetEcotronBoxOpenMessage.RWEBOM_OPEN_ECOTRONBOX, RoomWidgetEcotronBoxOpenedMessage.RWEBOM_ECOTRONBOX_OPENED]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_4:RoomWidgetEcotronBoxOpenMessage;
            var _local_5:IRoomObjectModel;
            var _local_6:String;
            var _local_7:Boolean;
            var _local_8:RoomWidgetEcotronBoxDataUpdateEvent;
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET:
                    _local_2 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = this._container.roomEngine.getRoomObject(_local_2.roomId, _local_2.roomCategory, _local_2.id, _local_2.category);
                    if (_local_3 != null){
                        _local_5 = _local_3.getModel();
                        if (_local_5 != null){
                            this._objectId = _local_2.id;
                            _local_6 = _local_5.getString(RoomObjectVariableEnum._SafeStr_7217);
                            if (_local_6 == null){
                                return (null);
                            };
                            _local_7 = ((this._container.roomSession.isRoomOwner) || (this._container.sessionDataManager.isAnyRoomController));
                            _local_8 = new RoomWidgetEcotronBoxDataUpdateEvent(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_PACKAGEINFO, _local_2.id, _local_6, _local_7);
                            this._container.events.dispatchEvent(_local_8);
                        };
                    };
                    break;
                case RoomWidgetEcotronBoxOpenMessage.RWEBOM_OPEN_ECOTRONBOX:
                    _local_4 = (_arg_1 as RoomWidgetEcotronBoxOpenMessage);
                    if (_local_4.objectId != this._objectId){
                        return (null);
                    };
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        this._container.roomSession.sendPresentOpenMessage(_local_4.objectId);
                    };
                    break;
            };
            return (null);
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (this.disposed){
                return;
            };
            var _local_3:RoomWidgetEcotronBoxDataUpdateEvent = new RoomWidgetEcotronBoxDataUpdateEvent(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_CONTENTS, 0, this._name, false, _arg_2);
            this._container.events.dispatchEvent(_local_3);
        }
        public function getProcessedEvents():Array
        {
            return ([RoomSessionPresentEvent.RSPE_PRESENT_OPENED]);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionPresentEvent;
            var _local_3:ImageResult;
            var _local_4:IFurnitureData;
            var _local_5:RoomWidgetEcotronBoxDataUpdateEvent;
            if (_arg_1 == null){
                return;
            };
            if (((((!((this._container == null))) && (!((this._container.events == null))))) && (!((_arg_1 == null))))){
                switch (_arg_1.type){
                    case RoomSessionPresentEvent.RSPE_PRESENT_OPENED:
                        _local_2 = (_arg_1 as RoomSessionPresentEvent);
                        if (_local_2 != null){
                            _local_3 = null;
                            this._name = "";
                            if (_local_2.itemType == "s"){
                                _local_3 = this._container.roomEngine.getFurnitureIcon(_local_2.classId, this);
                                _local_4 = this._container.sessionDataManager.getFloorItemData(_local_2.classId);
                            }
                            else {
                                if (_local_2.itemType == "i"){
                                    _local_3 = this._container.roomEngine.getWallItemIcon(_local_2.classId, this);
                                    _local_4 = this._container.sessionDataManager.getWallItemData(_local_2.classId);
                                };
                            };
                            if (_local_4 != null){
                                this._name = _local_4.title;
                            };
                            if (_local_3 != null){
                                _local_5 = new RoomWidgetEcotronBoxDataUpdateEvent(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_CONTENTS, 0, this._name, false, _local_3.data);
                                this._container.events.dispatchEvent(_local_5);
                            };
                        };
                };
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// ImageResult = "_-31w" (String#21576, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomSessionPresentEvent = "_-30Q" (String#7312, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FurnitureEcotronBoxWidgetHandler = "_-3HK" (String#7653, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetEcotronBoxDataUpdateEvent = "_-18a" (String#16797, DoABC#2)
// RoomWidgetEcotronBoxOpenMessage = "_-1bG" (String#17946, DoABC#2)
// RoomWidgetEcotronBoxOpenedMessage = "_-0qv" (String#4659, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWEBOM_OPEN_ECOTRONBOX = "_-0Mx" (String#14952, DoABC#2)
// RWEBOM_ECOTRONBOX_OPENED = "_-2Ag" (String#19433, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// RWEBDUE_PACKAGEINFO = "_-1FM" (String#17088, DoABC#2)
// RWEBDUE_CONTENTS = "_-k8" (String#24041, DoABC#2)
// RWE_FURNI_ECOTRONBOX_WIDGET = "_-0R8" (String#15107, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RSPE_PRESENT_OPENED = "_-1eK" (String#18071, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// sendPresentOpenMessage = "_-3Es" (String#7609, DoABC#2)
// getFloorItemData = "_-08L" (String#3728, DoABC#2)
// getWallItemData = "_-Hc" (String#8029, DoABC#2)


