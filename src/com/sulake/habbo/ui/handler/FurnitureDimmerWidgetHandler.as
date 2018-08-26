
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEventPresetItem;
    import flash.events.Event;

    public class FurnitureDimmerWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_ROOM_DIMMER);
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
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_DIMMER, RoomWidgetDimmerSavePresetMessage.RWSDPM_SAVE_PRESET, RoomWidgetDimmerChangeStateMessage.RWCDSM_CHANGE_STATE, RoomWidgetDimmerPreviewMessage.RWDPM_PREVIEW_DIMMER_PRESET]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:RoomWidgetDimmerPreviewMessage;
            var _local_5:RoomWidgetDimmerSavePresetMessage;
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_DIMMER:
                    if (this.FurnitureDimmerWidgetHandler()){
                        this._container.roomSession.RoomSession();
                    };
                    break;
                case RoomWidgetDimmerSavePresetMessage.RWSDPM_SAVE_PRESET:
                    if (this.FurnitureDimmerWidgetHandler()){
                        _local_5 = (_arg_1 as RoomWidgetDimmerSavePresetMessage);
                        this._container.roomSession.RoomSession(_local_5.presetNumber, _local_5.effectTypeId, _local_5.color, _local_5.brightness, _local_5.apply);
                    };
                    break;
                case RoomWidgetDimmerChangeStateMessage.RWCDSM_CHANGE_STATE:
                    if (this.FurnitureDimmerWidgetHandler()){
                        this._container.roomSession.RoomSession();
                    };
                    break;
                case RoomWidgetDimmerPreviewMessage.RWDPM_PREVIEW_DIMMER_PRESET:
                    _local_2 = this._container.roomSession.roomId;
                    _local_3 = this._container.roomSession.roomCategory;
                    _local_4 = (_arg_1 as RoomWidgetDimmerPreviewMessage);
                    if ((((_local_4 == null)) || ((this._container.roomEngine == null)))){
                        return (null);
                    };
                    this._container.roomEngine.RoomEngine(_local_2, _local_3, _local_4.color, _local_4.brightness, _local_4.bgOnly);
                    break;
            };
            return (null);
        }
        private function FurnitureDimmerWidgetHandler():Boolean
        {
            var _local_1:Boolean = this._container.roomSession.isRoomOwner;
            var _local_2:Boolean = this._container.sessionDataManager.isAnyRoomController;
            return (((_local_1) || (_local_2)));
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomSessionDimmerPresetsEvent.RSDPE_PRESETS);
            _local_1.push(RoomEngineDimmerStateEvent.RWDSUE_DIMMER_STATE);
            _local_1.push(RoomEngineObjectEvent.REOR_REMOVE_DIMMER);
            return (_local_1);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:RoomSessionDimmerPresetsEvent;
            var _local_3:RoomWidgetDimmerUpdateEvent;
            var _local_4:RoomEngineDimmerStateEvent;
            var _local_5:RoomWidgetDimmerStateUpdateEvent;
            var _local_6:int;
            var _local_7:RoomSessionDimmerPresetsEventPresetItem;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionDimmerPresetsEvent.RSDPE_PRESETS:
                    _local_2 = (_arg_1 as RoomSessionDimmerPresetsEvent);
                    _local_3 = new RoomWidgetDimmerUpdateEvent(RoomWidgetDimmerUpdateEvent.RWDUE_PRESETS);
                    _local_3.selectedPresetId = _local_2.selectedPresetId;
                    _local_6 = 0;
                    while (_local_6 < _local_2.presetCount) {
                        _local_7 = _local_2.RoomWidgetDimmerUpdateEvent(_local_6);
                        if (_local_7 != null){
                            _local_3.RoomWidgetDimmerUpdateEvent(_local_7.id, _local_7.type, _local_7.color, _local_7.light);
                        };
                        _local_6++;
                    };
                    this._container.events.dispatchEvent(_local_3);
                    return;
                case RoomEngineDimmerStateEvent.RWDSUE_DIMMER_STATE:
                    _local_4 = (_arg_1 as RoomEngineDimmerStateEvent);
                    _local_5 = new RoomWidgetDimmerStateUpdateEvent(_local_4.state, _local_4.presetId, _local_4.effectId, _local_4.color, _local_4.brightness);
                    this._container.events.dispatchEvent(_local_5);
                    return;
                case RoomEngineObjectEvent.REOR_REMOVE_DIMMER:
                    this._container.events.dispatchEvent(new RoomWidgetDimmerUpdateEvent(RoomWidgetDimmerUpdateEvent.RWDUE_HIDE));
                    return;
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// RoomSessionDimmerPresetsEvent = "_-1lO" (String#5773, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomEngineDimmerStateEvent = "_-kD" (String#24044, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// FurnitureDimmerWidgetHandler = "_-1HR" (String#17167, DoABC#2)
// RoomSessionDimmerPresetsEventPresetItem = "_-2E" (String#6321, DoABC#2)
// RoomWidgetDimmerChangeStateMessage = "_-0Nh" (String#4035, DoABC#2)
// RoomWidgetDimmerSavePresetMessage = "_-1D3" (String#5126, DoABC#2)
// RoomWidgetDimmerPreviewMessage = "_-yc" (String#8849, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-2Fv" (String#6362, DoABC#2)
// RoomWidgetDimmerStateUpdateEvent = "_-12o" (String#4930, DoABC#2)
// RWFWM_MESSAGE_REQUEST_DIMMER = "_-30d" (String#21526, DoABC#2)
// RWCDSM_CHANGE_STATE = "_-2jZ" (String#20828, DoABC#2)
// RWSDPM_SAVE_PRESET = "_-2RZ" (String#20101, DoABC#2)
// presetNumber = "_-9a" (String#22602, DoABC#2)
// effectTypeId = "_-ra" (String#24342, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)
// RWDPM_PREVIEW_DIMMER_PRESET = "_-14V" (String#16635, DoABC#2)
// bgOnly = "_-320" (String#21580, DoABC#2)
// RWE_ROOM_DIMMER = "_-2cE" (String#20532, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RSDPE_PRESETS = "_-3B3" (String#21925, DoABC#2)
// selectedPresetId = "_-0Pr" (String#15055, DoABC#2)
// presetCount = "_-Gt" (String#22886, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-0k4" (String#15834, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-0rG" (String#16096, DoABC#2)
// RoomEngine = "_-o" (String#2192, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// REOR_REMOVE_DIMMER = "_-1pt" (String#18537, DoABC#2)
// RWDSUE_DIMMER_STATE = "_-0A5" (String#14451, DoABC#2)
// presetId = "_-37i" (String#21795, DoABC#2)
// effectId = "_-0jW" (String#15809, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// FurnitureDimmerWidgetHandler = "_-2lk" (String#20908, DoABC#2)
// RoomSession = "_-0A0" (String#3758, DoABC#2)
// RoomSession = "_-0uH" (String#4730, DoABC#2)
// RoomSession = "_-23-" (String#6105, DoABC#2)
// RWDUE_PRESETS = "_-1i5" (String#18213, DoABC#2)
// RWDUE_HIDE = "_-0KF" (String#14852, DoABC#2)


