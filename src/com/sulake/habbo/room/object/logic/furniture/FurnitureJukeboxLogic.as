
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;

    public class FurnitureJukeboxLogic extends FurnitureMultiStateLogic 
    {

        private var _SafeStr_12460:Boolean;
        private var _isInitialized:Boolean = false;
        private var _SafeStr_7903:int = -1;

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_START, RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_MACHINE_STOP, RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_DISPOSE, RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_INIT, RoomObjectWidgetRequestEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function dispose():void
        {
            this.requestDispose();
            super.dispose();
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectDataUpdateMessage;
            var _local_3:IRoomObjectModelController;
            var _local_4:int;
            super.processUpdateMessage(_arg_1);
            if (object == null){
                return;
            };
            if (!this._isInitialized){
                this.requestInit();
            };
            if (object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12500) == 1){
                object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.RWEIEP_INFOSTAND_EXTRA_PARAM, RoomWidgetInfostandExtraParamEnum.RWEIEP_JUKEBOX);
                _local_2 = (_arg_1 as RoomObjectDataUpdateMessage);
                if (_local_2 == null){
                    return;
                };
                _local_3 = object.getModelController();
                if (_local_3 == null){
                    return;
                };
                _local_4 = object.getState(0);
                if (_local_4 != this._SafeStr_7903){
                    this._SafeStr_7903 = _local_4;
                    if (_local_4 == 1){
                        this.IPlayListController();
                    }
                    else {
                        if (_local_4 == 0){
                            this.requestStopPlaying();
                        };
                    };
                };
            };
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            switch (_arg_1.type){
                case MouseEvent.DOUBLE_CLICK:
                    this.useObject();
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
            };
        }
        override public function useObject():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:RoomObjectEvent;
            if (((!((eventDispatcher == null))) && (!((object == null))))){
                _local_1 = object.getId();
                _local_2 = object.getType();
                _local_3 = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR, _local_1, _local_2);
                eventDispatcher.dispatchEvent(_local_3);
                eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _local_1, _local_2, -1));
            };
        }
        private function requestInit():void
        {
            if ((((object == null)) || ((eventDispatcher == null)))){
                return;
            };
            this._SafeStr_12460 = true;
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_INIT, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
            this._isInitialized = true;
        }
        private function IPlayListController():void
        {
            if ((((object == null)) || ((eventDispatcher == null)))){
                return;
            };
            this._SafeStr_12460 = true;
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_START, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
        }
        private function requestStopPlaying():void
        {
            if ((((object == null)) || ((eventDispatcher == null)))){
                return;
            };
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_MACHINE_STOP, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
        }
        private function requestDispose():void
        {
            if (!this._SafeStr_12460){
                return;
            };
            if ((((object == null)) || ((eventDispatcher == null)))){
                return;
            };
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_JUKEBOX_DISPOSE, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12460 = "_-18R" (String#5046, DoABC#2)
// requestDispose = "_-80" (String#7823, DoABC#2)
// requestStopPlaying = "_-Ru" (String#8245, DoABC#2)
// requestInit = "_-Wr" (String#23518, DoABC#2)
// _SafeStr_12500 = "_-2Sa" (String#20140, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurnitureJukeboxLogic = "_-1uC" (String#18724, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectStateChangeEvent = "_-2D1" (String#19524, DoABC#2)
// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// RoomWidgetInfostandExtraParamEnum = "_-2ru" (String#7121, DoABC#2)
// RWEIEP_INFOSTAND_EXTRA_PARAM = "_-3J-" (String#22238, DoABC#2)
// RWEIEP_JUKEBOX = "_-2Bo" (String#19475, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// REOR_WIDGET_REQUEST_PLAYLIST_EDITOR = "_-0k" (String#15828, DoABC#2)
// ROFCAE_JUKEBOX_INIT = "_-uC" (String#24458, DoABC#2)
// ROFCAE_JUKEBOX_START = "_-0DL" (String#14583, DoABC#2)
// ROFCAE_JUKEBOX_MACHINE_STOP = "_-24A" (String#19183, DoABC#2)
// ROFCAE_JUKEBOX_DISPOSE = "_-00m" (String#14084, DoABC#2)
// ROSCE_STATE_CHANGE = "_-RU" (String#23304, DoABC#2)
// IPlayListController = "_-0Vy" (String#817, DoABC#2)
// _SafeStr_7903 = "_-04-" (String#577, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)


