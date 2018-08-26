
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureIceStormLogic extends FurnitureMultiStateLogic 
    {

        private var _SafeStr_12485:int = 0;
        private var _SafeStr_12486:Number = 0;
        private var _SafeStr_12487:int = 0;

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null){
                this.handleDataUpdateMessage(_local_2);
                return;
            };
            super.processUpdateMessage(_arg_1);
        }
        private function handleDataUpdateMessage(_arg_1:RoomObjectDataUpdateMessage):void
        {
            var _local_2:int = (_arg_1.state / 1000);
            var _local_3:int = (_arg_1.state % 1000);
            if (_local_3 == 0){
                this._SafeStr_12487 = 0;
                _arg_1 = new RoomObjectDataUpdateMessage(_local_2, String(_local_2), _arg_1.extra);
                super.processUpdateMessage(_arg_1);
            }
            else {
                this._SafeStr_12485 = _local_2;
                this._SafeStr_12486 = _arg_1.extra;
                this._SafeStr_12487 = (lastUpdateTime + _local_3);
            };
        }
        override public function update(_arg_1:int):void
        {
            var _local_2:RoomObjectDataUpdateMessage;
            if ((((this._SafeStr_12487 > 0)) && ((_arg_1 >= this._SafeStr_12487)))){
                this._SafeStr_12487 = 0;
                _local_2 = new RoomObjectDataUpdateMessage(this._SafeStr_12485, String(this._SafeStr_12485), this._SafeStr_12486);
                super.processUpdateMessage(_local_2);
            };
            super.update(_arg_1);
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// handleDataUpdateMessage = "_-4k" (String#2050, DoABC#2)
// _SafeStr_12485 = "_-18j" (String#16801, DoABC#2)
// _SafeStr_12486 = "_-2VR" (String#20259, DoABC#2)
// _SafeStr_12487 = "_-0ch" (String#15542, DoABC#2)
// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurnitureIceStormLogic = "_-32s" (String#21614, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// lastUpdateTime = "_-0US" (String#15222, DoABC#2)


