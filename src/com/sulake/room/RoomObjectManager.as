
package com.sulake.room
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.RoomObject;
    import com.sulake.room.object.IRoomObjectController;

    public class RoomObjectManager implements IRoomObjectManager 
    {

        private var _objects:Map;
        private var _SafeStr_14526:Map;

        public function RoomObjectManager()
        {
            this._objects = new Map();
            this._SafeStr_14526 = new Map();
        }
        public function dispose():void
        {
            this.reset();
            if (this._objects != null){
                this._objects.dispose();
                this._objects = null;
            };
            if (this._SafeStr_14526 != null){
                this._SafeStr_14526.dispose();
                this._SafeStr_14526 = null;
            };
        }
        public function createObject(_arg_1:int, _arg_2:uint, _arg_3:String):IRoomObjectController
        {
            var _local_4:RoomObject = new RoomObject(_arg_1, _arg_2, _arg_3);
            return (this.addObject(String(_arg_1), _arg_3, _local_4));
        }
        private function addObject(_arg_1:String, _arg_2:String, _arg_3:IRoomObjectController):IRoomObjectController
        {
            if (this._objects.getValue(_arg_1) != null){
                _arg_3.dispose();
                return (null);
            };
            this._objects.add(_arg_1, _arg_3);
            var _local_4:Map = this.getObjectsForType(_arg_2);
            _local_4.add(_arg_1, _arg_3);
            return (_arg_3);
        }
        private function getObjectsForType(_arg_1:String, _arg_2:Boolean=true):Map
        {
            var _local_3:Map = this._SafeStr_14526.getValue(_arg_1);
            if ((((_local_3 == null)) && (_arg_2))){
                _local_3 = new Map();
                this._SafeStr_14526.add(_arg_1, _local_3);
            };
            return (_local_3);
        }
        public function RoomInstance(_arg_1:int):IRoomObjectController
        {
            return ((this._objects.getValue(String(_arg_1)) as IRoomObjectController));
        }
        public function RoomInstance(_arg_1:int):IRoomObjectController
        {
            return ((this._objects.getWithIndex(_arg_1) as IRoomObjectController));
        }
        public function RoomInstance():int
        {
            return (this._objects.length);
        }
        public function RoomInstance(_arg_1:String):int
        {
            var _local_2:Map = this.getObjectsForType(_arg_1, false);
            if (_local_2 != null){
                return (_local_2.length);
            };
            return (0);
        }
        public function RoomInstance(_arg_1:int, _arg_2:String):IRoomObjectController
        {
            var _local_4:IRoomObjectController;
            var _local_3:Map = this.getObjectsForType(_arg_2, false);
            if (_local_3 != null){
                return ((_local_3.getWithIndex(_arg_1) as IRoomObjectController));
            };
            return (null);
        }
        public function RoomInstance(_arg_1:int):Boolean
        {
            var _local_4:String;
            var _local_5:Map;
            var _local_2:String = String(_arg_1);
            var _local_3:RoomObject = (this._objects.remove(_local_2) as RoomObject);
            if (_local_3 != null){
                _local_4 = _local_3.getType();
                _local_5 = this.getObjectsForType(_local_4, false);
                if (_local_5 != null){
                    _local_5.remove(_local_2);
                };
                _local_3.dispose();
                return (true);
            };
            return (false);
        }
        public function reset():void
        {
            var _local_1:int;
            var _local_2:IRoomObjectController;
            var _local_3:int;
            var _local_4:Map;
            if (this._objects != null){
                _local_1 = 0;
                while (_local_1 < this._objects.length) {
                    _local_2 = (this._objects.getWithIndex(_local_1) as IRoomObjectController);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._objects.reset();
            };
            if (this._SafeStr_14526 != null){
                _local_3 = 0;
                while (_local_3 < this._SafeStr_14526.length) {
                    _local_4 = (this._SafeStr_14526.getWithIndex(_local_3) as Map);
                    if (_local_4 != null){
                        _local_4.dispose();
                    };
                    _local_3++;
                };
                this._SafeStr_14526.reset();
            };
        }

    }
}//package com.sulake.room

// RoomInstance = "_-252" (String#1807, DoABC#2)
// createObject = "_-j8" (String#2167, DoABC#2)
// RoomInstance = "_-3E-" (String#921, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// RoomInstance = "_-2T0" (String#1882, DoABC#2)
// RoomInstance = "_-2OS" (String#1870, DoABC#2)
// _SafeStr_14526 = "_-00A" (String#14060, DoABC#2)
// getObjectsForType = "_-2He" (String#19711, DoABC#2)
// IRoomObjectManager = "_-iT" (String#8568, DoABC#2)
// RoomObjectManager = "_-0zf" (String#16415, DoABC#2)
// RoomInstance = "_-09y" (String#1415, DoABC#2)
// RoomInstance = "_-1GT" (String#844, DoABC#2)
// addObject = "_-0EW" (String#1435, DoABC#2)


