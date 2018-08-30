
package com.sulake.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;
    import com.sulake.room.utils.*;

    public class RoomObject implements IRoomObjectController 
    {

        private static var _SafeStr_5547:int = 0;

        private var _id:int;
        private var _type:String = "";
        private var _loc:Vector3d;
        private var _dir:Vector3d;
        private var _location:Vector3d;
        private var _direction:Vector3d;
        private var _SafeStr_14405:Array;
        private var _modelController:RoomObjectModel;
        private var _visualization:IRoomObjectVisualization;
        private var _eventHandler:IRoomObjectEventHandler;
        private var _updateID:int;
        private var _instanceId:int = 0;

        public function RoomObject(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            this._id = _arg_1;
            this._loc = new Vector3d();
            this._dir = new Vector3d();
            this._location = new Vector3d();
            this._direction = new Vector3d();
            this._SafeStr_14405 = new Array(_arg_2);
            var _local_4:Number = (_arg_2 - 1);
            while (_local_4 >= 0) {
                this._SafeStr_14405[_local_4] = 0;
                _local_4--;
            };
            this._type = _arg_3;
            this._modelController = new RoomObjectModel();
            this._visualization = null;
            this._eventHandler = null;
            this._updateID = 0;
            this._instanceId = _SafeStr_5547++;
        }
        public function dispose():void
        {
            this._loc = null;
            this._dir = null;
            if (this._modelController != null){
                this._modelController.dispose();
                this._modelController = null;
            };
            this._SafeStr_14405 = null;
            this.setVisualization(null);
            this.setEventHandler(null);
        }
        public function getId():int
        {
            return (this._id);
        }
        public function getType():String
        {
            return (this._type);
        }
        public function getInstanceId():int
        {
            return (this._instanceId);
        }
        public function getLocation():IVector3d
        {
            this._location.assign(this._loc);
            return (this._location);
        }
        public function getDirection():IVector3d
        {
            this._direction.assign(this._dir);
            return (this._direction);
        }
        public function getModel():IRoomObjectModel
        {
            return (this._modelController);
        }
        public function getModelController():IRoomObjectModelController
        {
            return (this._modelController);
        }
        public function getState(_arg_1:int):int
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_14405.length)))){
                return (this._SafeStr_14405[_arg_1]);
            };
            return (-1);
        }
        public function getVisualization():IRoomObjectVisualization
        {
            return (this._visualization);
        }
        public function setLocation(_arg_1:IVector3d):void
        {
            if (_arg_1 == null){
                return;
            };
            if (((((!((this._loc.x == _arg_1.x))) || (!((this._loc.y == _arg_1.y))))) || (!((this._loc.z == _arg_1.z))))){
                this._loc.x = _arg_1.x;
                this._loc.y = _arg_1.y;
                this._loc.z = _arg_1.z;
                this._updateID++;
            };
        }
        public function setDirection(_arg_1:IVector3d):void
        {
            if (_arg_1 == null){
                return;
            };
            if (((((!((this._dir.x == _arg_1.x))) || (!((this._dir.y == _arg_1.y))))) || (!((this._dir.z == _arg_1.z))))){
                this._dir.x = (((_arg_1.x % 360) + 360) % 360);
                this._dir.y = (((_arg_1.y % 360) + 360) % 360);
                this._dir.z = (((_arg_1.z % 360) + 360) % 360);
                this._updateID++;
            };
        }
        public function setState(_arg_1:int, _arg_2:int):Boolean
        {
            if ((((_arg_2 >= 0)) && ((_arg_2 < this._SafeStr_14405.length)))){
                if (this._SafeStr_14405[_arg_2] != _arg_1){
                    this._SafeStr_14405[_arg_2] = _arg_1;
                    this._updateID++;
                };
                return (true);
            };
            return (false);
        }
        public function setVisualization(_arg_1:IRoomObjectVisualization):void
        {
            if (_arg_1 != this._visualization){
                if (this._visualization != null){
                    this._visualization.dispose();
                };
                this._visualization = _arg_1;
                if (this._visualization != null){
                    this._visualization.object = this;
                };
            };
        }
        public function setEventHandler(_arg_1:IRoomObjectEventHandler):void
        {
            if (_arg_1 == this._eventHandler){
                return;
            };
            var _local_2:IRoomObjectEventHandler = this._eventHandler;
            if (_local_2 != null){
                this._eventHandler = null;
                _local_2.object = null;
            };
            this._eventHandler = _arg_1;
            if (this._eventHandler != null){
                this._eventHandler.object = this;
            };
        }
        public function getEventHandler():IRoomObjectEventHandler
        {
            return (this._eventHandler);
        }
        public function getUpdateID():int
        {
            return (this._updateID);
        }
        public function getMouseHandler():IRoomObjectMouseHandler
        {
            return (this.getEventHandler());
        }

    }
}//package com.sulake.room.object

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// getMouseHandler = "_-EC" (String#7957, DoABC#2)
// getEventHandler = "_-1dG" (String#5618, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// getVisualization = "_-1At" (String#5090, DoABC#2)
// _location = "_-0O2" (String#14990, DoABC#2)
// _direction = "_-0Fz" (String#14683, DoABC#2)
// _SafeStr_14405 = "_-0aw" (String#15471, DoABC#2)
// _eventHandler = "_-Po" (String#23240, DoABC#2)
// IRoomObjectMouseHandler = "_-2xI" (String#7227, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// IRoomObjectVisualization = "_-3D2" (String#7575, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _modelController = "_-0XB" (String#112, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// _SafeStr_5547 = "_-2iI" (String#1928, DoABC#2)
// _instanceId = "_-1cJ" (String#854, DoABC#2)
// setEventHandler = "_-2X9" (String#6703, DoABC#2)


