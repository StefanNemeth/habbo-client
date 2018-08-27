
package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class MovingObjectLogic extends ObjectLogicBase 
    {

        public static const _SafeStr_7603:int = 500;
        private static var _SafeStr_7604:Vector3d = new Vector3d();

        private var _SafeStr_7605:Vector3d;
        private var _loc:Vector3d;
        private var _SafeStr_7606:Number = 0;
        private var _lastUpdateTime:int = 0;
        private var _SafeStr_7607:int;
        private var _moveUpdateInterval:int = 500;

        public function MovingObjectLogic()
        {
            this._SafeStr_7605 = new Vector3d();
            this._loc = new Vector3d();
            super();
        }
        protected function get lastUpdateTime():int
        {
            return (this._lastUpdateTime);
        }
        override public function dispose():void
        {
            super.dispose();
            this._loc = null;
            this._SafeStr_7605 = null;
        }
        override public function set object(_arg_1:IRoomObjectController):void
        {
            super.object = _arg_1;
            if (_arg_1 != null){
                this._loc.assign(_arg_1.getLocation());
            };
        }
        protected function set moveUpdateInterval(_arg_1:int):void
        {
            if (_arg_1 <= 0){
                _arg_1 = 1;
            };
            this._moveUpdateInterval = _arg_1;
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_3:IVector3d;
            if (_arg_1 == null){
                return;
            };
            super.processUpdateMessage(_arg_1);
            if (_arg_1.loc != null){
                this._loc.assign(_arg_1.loc);
            };
            var _local_2:RoomObjectMoveUpdateMessage = (_arg_1 as RoomObjectMoveUpdateMessage);
            if (_local_2 == null){
                return;
            };
            if (object != null){
                if (_arg_1.loc != null){
                    _local_3 = _local_2.targetLoc;
                    this._SafeStr_7607 = this._lastUpdateTime;
                    this._SafeStr_7605.assign(_local_3);
                    this._SafeStr_7605.sub(this._loc);
                };
            };
        }
        protected function getLocationOffset():IVector3d
        {
            return (null);
        }
        override public function update(_arg_1:int):void
        {
            var _local_4:int;
            var _local_2:IVector3d = this.getLocationOffset();
            var _local_3:IRoomObjectModelController = object.getModelController();
            if (_local_3 != null){
                if (_local_2 != null){
                    if (this._SafeStr_7606 != _local_2.z){
                        this._SafeStr_7606 = _local_2.z;
                        _local_3.setNumber(RoomObjectVariableEnum._SafeStr_7613, this._SafeStr_7606);
                    };
                }
                else {
                    if (this._SafeStr_7606 != 0){
                        this._SafeStr_7606 = 0;
                        _local_3.setNumber(RoomObjectVariableEnum._SafeStr_7613, this._SafeStr_7606);
                    };
                };
            };
            if ((((this._SafeStr_7605.length > 0)) || (!((_local_2 == null))))){
                _local_4 = (_arg_1 - this._SafeStr_7607);
                if (_local_4 == (this._moveUpdateInterval >> 1)){
                    _local_4++;
                };
                if (_local_4 > this._moveUpdateInterval){
                    _local_4 = this._moveUpdateInterval;
                };
                if (this._SafeStr_7605.length > 0){
                    _SafeStr_7604.assign(this._SafeStr_7605);
                    _SafeStr_7604.mul((_local_4 / Number(this._moveUpdateInterval)));
                    _SafeStr_7604.add(this._loc);
                }
                else {
                    _SafeStr_7604.assign(this._loc);
                };
                if (_local_2 != null){
                    _SafeStr_7604.add(_local_2);
                };
                if (object != null){
                    object.setLocation(_SafeStr_7604);
                };
                if (_local_4 == this._moveUpdateInterval){
                    this._SafeStr_7605.x = 0;
                    this._SafeStr_7605.y = 0;
                    this._SafeStr_7605.z = 0;
                };
            };
            this._lastUpdateTime = _arg_1;
        }

    }
}//package com.sulake.habbo.room.object.logic

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// ObjectLogicBase = "_-VT" (String#8310, DoABC#2)
// MovingObjectLogic = "_-36D" (String#21738, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectMoveUpdateMessage = "_-2Es" (String#6339, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// sub = "_-2e2" (String#20605, DoABC#2)
// mul = "_-tH" (String#24418, DoABC#2)
// _SafeStr_7603 = "_-0OF" (String#14998, DoABC#2)
// _SafeStr_7604 = "_-0so" (String#16154, DoABC#2)
// _SafeStr_7605 = "_-0Ps" (String#15056, DoABC#2)
// _SafeStr_7606 = "_-2te" (String#21227, DoABC#2)
// _SafeStr_7607 = "_-0q1" (String#16053, DoABC#2)
// _moveUpdateInterval = "_-1LT" (String#1665, DoABC#2)
// lastUpdateTime = "_-0US" (String#15222, DoABC#2)
// moveUpdateInterval = "_-0Fy" (String#14682, DoABC#2)
// targetLoc = "_-1Io" (String#17228, DoABC#2)
// getLocationOffset = "_-2EM" (String#6330, DoABC#2)
// _SafeStr_7613 = "_-lN" (String#24082, DoABC#2)


