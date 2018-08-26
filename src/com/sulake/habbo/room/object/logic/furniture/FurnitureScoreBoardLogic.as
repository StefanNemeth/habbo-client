
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.utils.getTimer;

    public class FurnitureScoreBoardLogic extends FurnitureLogic 
    {

        private static const _SafeStr_4848:int = 50;
        private static const _SafeStr_12455:int = 3000;

        private var _score:int = 0;
        private var _SafeStr_12456:int = 0;
        private var _moveUpdateInterval:int = 50;

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null){
                this.updateScore(_local_2.state);
                return;
            };
            super.processUpdateMessage(_arg_1);
        }
        private function updateScore(_arg_1:int):void
        {
            var _local_3:int;
            this._score = _arg_1;
            var _local_2:int = object.getState(0);
            if (this._score != _local_2){
                _local_3 = (this._score - _local_2);
                if (_local_3 < 0){
                    _local_3 = -(_local_3);
                };
                if ((_local_3 * _SafeStr_4848) > _SafeStr_12455){
                    this._moveUpdateInterval = (_SafeStr_12455 / _local_3);
                }
                else {
                    this._moveUpdateInterval = _SafeStr_4848;
                };
                this._SafeStr_12456 = getTimer();
            };
        }
        override public function update(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            super.update(_arg_1);
            if (object != null){
                _local_2 = object.getState(0);
                if (((!((_local_2 == this._score))) && ((_arg_1 >= (this._SafeStr_12456 + this._moveUpdateInterval))))){
                    _local_3 = (_arg_1 - this._SafeStr_12456);
                    _local_4 = (_local_3 / this._moveUpdateInterval);
                    _local_5 = 1;
                    if (this._score < _local_2){
                        _local_5 = -1;
                    };
                    if (_local_4 > (_local_5 * (this._score - _local_2))){
                        _local_4 = (_local_5 * (this._score - _local_2));
                    };
                    object.setState((_local_2 + (_local_5 * _local_4)), 0);
                    this._SafeStr_12456 = (_arg_1 - (_local_3 - (_local_4 * this._moveUpdateInterval)));
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12455 = "_-1Wn" (String#17772, DoABC#2)
// _SafeStr_12456 = "_-dq" (String#23794, DoABC#2)
// updateScore = "_-gU" (String#23911, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureScoreBoardLogic = "_-2V0" (String#20238, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// _SafeStr_4848 = "_-0i-" (String#1531, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// _score = "_-2ca" (String#1911, DoABC#2)
// _moveUpdateInterval = "_-1LT" (String#1665, DoABC#2)


