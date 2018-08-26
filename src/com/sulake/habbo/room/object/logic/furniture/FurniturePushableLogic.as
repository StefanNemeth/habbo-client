
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurniturePushableLogic extends FurnitureMultiStateLogic 
    {

        private static const _SafeStr_12488:int = 0;
        private static const _SafeStr_12489:int = 1;
        private static const _SafeStr_12490:int = 10;

        private var _SafeStr_12491:Vector3d = null;

        public function FurniturePushableLogic()
        {
            moveUpdateInterval = _SafeStr_7603;
            this._SafeStr_12491 = new Vector3d();
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_4:IVector3d;
            var _local_5:IVector3d;
            var _local_6:IVector3d;
            if (_arg_1 == null){
                return;
            };
            var _local_2:RoomObjectMoveUpdateMessage = (_arg_1 as RoomObjectMoveUpdateMessage);
            if (((!((object == null))) && ((_local_2 == null)))){
                if (_arg_1.loc != null){
                    _local_4 = object.getLocation();
                    _local_5 = Vector3d.dif(_arg_1.loc, _local_4);
                    if (_local_5 != null){
                        if ((((Math.abs(_local_5.x) < 2)) && ((Math.abs(_local_5.y) < 2)))){
                            _local_6 = _local_4;
                            if ((((Math.abs(_local_5.x) > 1)) || ((Math.abs(_local_5.y) > 1)))){
                                _local_6 = Vector3d.sum(_local_4, Vector3d.product(_local_5, 0.5));
                            };
                            _local_2 = new RoomObjectMoveUpdateMessage(_local_6, _arg_1.loc, _arg_1.dir);
                            super.processUpdateMessage(_local_2);
                            return;
                        };
                    };
                };
            };
            if (((!((_arg_1.loc == null))) && ((_local_2 == null)))){
                _local_2 = new RoomObjectMoveUpdateMessage(_arg_1.loc, _arg_1.loc, _arg_1.dir);
                super.processUpdateMessage(_local_2);
            };
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null){
                if (_local_3.state > 0){
                    moveUpdateInterval = (_SafeStr_7603 / this.getUpdateIntervalValue(_local_3.state));
                }
                else {
                    moveUpdateInterval = 1;
                };
                this.handleDataUpdateMessage(_local_3);
                return;
            };
            if (((_local_2) && (_local_2.isSlideUpdate))){
                moveUpdateInterval = _SafeStr_7603;
            };
            super.processUpdateMessage(_arg_1);
        }
        protected function getUpdateIntervalValue(_arg_1:int):int
        {
            return ((_arg_1 / _SafeStr_12490));
        }
        protected function getAnimationValue(_arg_1:int):int
        {
            return ((_arg_1 % _SafeStr_12490));
        }
        private function handleDataUpdateMessage(_arg_1:RoomObjectDataUpdateMessage):void
        {
            var _local_2:int = this.getAnimationValue(_arg_1.state);
            if (_local_2 != _arg_1.state){
                _arg_1 = new RoomObjectDataUpdateMessage(_local_2, String(_local_2), _arg_1.extra);
            };
            super.processUpdateMessage(_arg_1);
        }
        override public function update(_arg_1:int):void
        {
            if (object != null){
                this._SafeStr_12491.assign(object.getLocation());
                super.update(_arg_1);
                if (Vector3d.dif(object.getLocation(), this._SafeStr_12491).length == 0){
                    if (object.getState(0) != _SafeStr_12488){
                        object.setState(_SafeStr_12488, 0);
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// handleDataUpdateMessage = "_-4k" (String#2050, DoABC#2)
// _SafeStr_12488 = "_-2k1" (String#20846, DoABC#2)
// _SafeStr_12489 = "_-3CV" (String#21975, DoABC#2)
// _SafeStr_12490 = "_-2zX" (String#21440, DoABC#2)
// _SafeStr_12491 = "_-0wn" (String#16303, DoABC#2)
// dif = "_-wu" (String#24566, DoABC#2)
// getUpdateIntervalValue = "_-02T" (String#14141, DoABC#2)
// getAnimationValue = "_-2Wv" (String#20319, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurniturePushableLogic = "_-0PS" (String#15041, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectMoveUpdateMessage = "_-2Es" (String#6339, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// product = "_-Bd" (String#22675, DoABC#2)
// _SafeStr_7603 = "_-0OF" (String#14998, DoABC#2)
// moveUpdateInterval = "_-0Fy" (String#14682, DoABC#2)
// isSlideUpdate = "_-1cT" (String#17989, DoABC#2)


