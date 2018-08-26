
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureCreditWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_CREDIT_WIDGET);
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
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_CREDITFURNI, RoomWidgetCreditFurniRedeemMessage.RWFCRM_REDEEM]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_3:RoomWidgetFurniToWidgetMessage;
            var _local_4:IRoomObject;
            var _local_5:RoomWidgetCreditFurniRedeemMessage;
            var _local_6:IRoomObjectModel;
            var _local_7:Number;
            var _local_8:RoomWidgetCreditFurniUpdateEvent;
            var _local_2:Boolean = ((this._container.roomSession.isRoomOwner) || (this._container.sessionDataManager.isAnyRoomController));
            if (!_local_2){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_CREDITFURNI:
                    _local_3 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_4 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_3.roomId, _local_3.roomCategory, _local_3.id, _local_3.category);
                    if (_local_4 != null){
                        _local_6 = _local_4.getModel();
                        if (_local_6 != null){
                            _local_7 = _local_6.getNumber(RoomObjectVariableEnum._SafeStr_7286);
                            _local_8 = new RoomWidgetCreditFurniUpdateEvent(RoomWidgetCreditFurniUpdateEvent.RWCFUE_CREDIT_FURNI_UPDATE, _local_3.id, _local_7);
                            this._container.events.dispatchEvent(_local_8);
                        };
                    };
                    break;
                case RoomWidgetCreditFurniRedeemMessage.RWFCRM_REDEEM:
                    _local_5 = (_arg_1 as RoomWidgetCreditFurniRedeemMessage);
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        this._container.roomSession.RoomSession(_local_5.objectId);
                    };
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
            if (((((!((this._container == null))) && (!((this._container.events == null))))) && (!((_local_2 == null))))){
                this._container.events.dispatchEvent(_local_2);
            };
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
// FurnitureCreditWidgetHandler = "_-2UV" (String#20219, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetCreditFurniRedeemMessage = "_-2oe" (String#7051, DoABC#2)
// RoomWidgetCreditFurniUpdateEvent = "_-2z4" (String#7265, DoABC#2)
// RWFWM_MESSAGE_REQUEST_CREDITFURNI = "_-20W" (String#19030, DoABC#2)
// RWFCRM_REDEEM = "_-27Y" (String#19313, DoABC#2)
// RWE_FURNI_CREDIT_WIDGET = "_-2b9" (String#20495, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7286 = "_-2UO" (String#20216, DoABC#2)
// RWCFUE_CREDIT_FURNI_UPDATE = "_-1Xg" (String#17802, DoABC#2)
// RoomSession = "_-2gO" (String#6879, DoABC#2)


