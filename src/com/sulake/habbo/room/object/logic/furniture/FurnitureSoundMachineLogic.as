
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureSoundMachineLogic extends FurnitureMultiStateLogic 
    {

        private var _SafeStr_12460:Boolean;
        private var _isInitialized:Boolean = false;
        private var _SafeStr_7903:int = -1;

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_START, RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_STOP, RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_DISPOSE, RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_INIT];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }
        override public function dispose():void
        {
            this.requestDispose();
            super.dispose();
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            if (object == null){
                return;
            };
            if (!this._isInitialized){
                this.requestInitialize();
            };
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = object.getState(0);
            if (_local_3 != this._SafeStr_7903){
                this._SafeStr_7903 = _local_3;
                if (_local_3 == 1){
                    this.requestPlayList();
                }
                else {
                    if (_local_3 == 0){
                        this.requestStopPlaying();
                    };
                };
            };
        }
        private function requestInitialize():void
        {
            if ((((object == null)) || ((eventDispatcher == null)))){
                return;
            };
            this._SafeStr_12460 = true;
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_INIT, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
            this._isInitialized = true;
        }
        private function requestPlayList():void
        {
            if ((((object == null)) || ((eventDispatcher == null)))){
                return;
            };
            this._SafeStr_12460 = true;
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_START, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
        }
        private function requestStopPlaying():void
        {
            if ((((object == null)) || ((eventDispatcher == null)))){
                return;
            };
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_STOP, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
        }
        private function requestDispose():void
        {
            if (!this._SafeStr_12460){
                return;
            };
            var _local_1:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_SOUND_MACHINE_DISPOSE, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_local_1);
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12460 = "_-18R" (String#5046, DoABC#2)
// requestDispose = "_-80" (String#7823, DoABC#2)
// requestInitialize = "_-0lj" (String#15887, DoABC#2)
// requestStopPlaying = "_-Ru" (String#8245, DoABC#2)
// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurnitureSoundMachineLogic = "_-0MI" (String#14925, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// getAllEventTypes = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// ROFCAE_SOUND_MACHINE_INIT = "_-0Ww" (String#15313, DoABC#2)
// ROFCAE_SOUND_MACHINE_START = "_-0gM" (String#15688, DoABC#2)
// ROFCAE_SOUND_MACHINE_STOP = "_-1Ps" (String#17503, DoABC#2)
// ROFCAE_SOUND_MACHINE_DISPOSE = "_-7t" (String#22538, DoABC#2)
// requestPlayList = "_-0Vy" (String#817, DoABC#2)
// _SafeStr_7903 = "_-04-" (String#577, DoABC#2)


