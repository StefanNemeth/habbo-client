
package com.sulake.room
{
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;
    import com.sulake.room.renderer.IRoomRendererBase;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import flash.utils.getTimer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.*;

    public class RoomInstance implements IRoomInstance 
    {

        private var _SafeStr_14407:Dictionary;
        private var _SafeStr_14408:Dictionary;
        private var _SafeStr_14411:Array;
        private var _SafeStr_14412:Array;
        private var _SafeStr_14529:Map;
        private var _updateCategories:Array;
        private var _renderer:IRoomRendererBase;
        private var _container:IRoomInstanceContainer;
        private var _id:String;

        public function RoomInstance(_arg_1:String, _arg_2:IRoomInstanceContainer)
        {
            this._SafeStr_14529 = new Map();
            this._updateCategories = [];
            this._container = _arg_2;
            this._id = _arg_1;
            this._SafeStr_14407 = new Dictionary();
            this._SafeStr_14408 = new Dictionary();
            this._SafeStr_14411 = [];
            this._SafeStr_14412 = [];
        }
        public function get id():String
        {
            return (this._id);
        }
        public function dispose():void
        {
            var _local_1:String;
            var _local_2:int;
            var _local_3:IRoomObjectManager;
            if (this._SafeStr_14529 != null){
                _local_2 = 0;
                while (_local_2 < this._SafeStr_14529.length) {
                    _local_3 = (this._SafeStr_14529.getWithIndex(_local_2) as IRoomObjectManager);
                    if (_local_3 != null){
                        _local_3.dispose();
                    };
                    _local_2++;
                };
                this._SafeStr_14529.dispose();
                this._SafeStr_14529 = null;
            };
            if (this._renderer != null){
                this._renderer.dispose();
                this._renderer = null;
            };
            this._container = null;
            this._updateCategories = null;
            if (this._SafeStr_14407 != null){
                for (_local_1 in this._SafeStr_14407) {
                    delete this._SafeStr_14407[_local_1];
                };
                this._SafeStr_14407 = null;
            };
            if (this._SafeStr_14408 != null){
                for (_local_1 in this._SafeStr_14408) {
                    delete this._SafeStr_14408[_local_1];
                };
                this._SafeStr_14408 = null;
            };
            this._SafeStr_14412 = [];
            this._SafeStr_14411 = [];
        }
        public function getNumber(_arg_1:String):Number
        {
            return (this._SafeStr_14407[_arg_1]);
        }
        public function setNumber(_arg_1:String, _arg_2:Number, _arg_3:Boolean=false):void
        {
            if (this._SafeStr_14411.indexOf(_arg_1) >= 0){
                return;
            };
            if (_arg_3){
                this._SafeStr_14411.push(_arg_1);
            };
            if (this._SafeStr_14407[_arg_1] != _arg_2){
                this._SafeStr_14407[_arg_1] = _arg_2;
            };
        }
        public function getString(_arg_1:String):String
        {
            return (this._SafeStr_14408[_arg_1]);
        }
        public function setString(_arg_1:String, _arg_2:String, _arg_3:Boolean=false):void
        {
            if (this._SafeStr_14412.indexOf(_arg_1) >= 0){
                return;
            };
            if (_arg_3){
                this._SafeStr_14412.push(_arg_1);
            };
            if (this._SafeStr_14408[_arg_1] != _arg_2){
                this._SafeStr_14408[_arg_1] = _arg_2;
            };
        }
        public function addObjectUpdateCategory(_arg_1:int):void
        {
            var _local_2:int = this._updateCategories.indexOf(_arg_1);
            if (_local_2 >= 0){
                return;
            };
            this._updateCategories.push(_arg_1);
        }
        public function removeObjectUpdateCategory(_arg_1:int):void
        {
            var _local_2:int = this._updateCategories.indexOf(_arg_1);
            if (_local_2 >= 0){
                this._updateCategories.splice(_local_2, 1);
            };
        }
        public function update():void
        {
            var _local_3:int;
            var _local_4:IRoomObjectManager;
            var _local_5:int;
            var _local_6:IRoomObjectController;
            var _local_7:IRoomObjectEventHandler;
            var _local_1:int = getTimer();
            var _local_2:int = (this._updateCategories.length - 1);
            while (_local_2 >= 0) {
                _local_3 = int(this._updateCategories[_local_2]);
                _local_4 = this.getObjectManager(_local_3);
                if (_local_4 != null){
                    _local_5 = (_local_4.getObjectCount() - 1);
                    while (_local_5 >= 0) {
                        _local_6 = _local_4.getObjectWithIndex(_local_5);
                        if (_local_6 != null){
                            _local_7 = _local_6.getEventHandler();
                            if (_local_7 != null){
                                _local_7.update(_local_1);
                            };
                        };
                        _local_5--;
                    };
                };
                _local_2--;
            };
        }
        public function createRoomObject(_arg_1:int, _arg_2:String, _arg_3:int):IRoomObject
        {
            if (this._container != null){
                return (this._container.createRoomObject(this._id, _arg_1, _arg_2, _arg_3));
            };
            return (null);
        }
        public function createObjectInternal(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):IRoomObject
        {
            var _local_6:IRoomObject;
            var _local_5:IRoomObjectManager = this.createObjectManager(_arg_4);
            if (_local_5 != null){
                _local_6 = _local_5.createObject(_arg_1, _arg_2, _arg_3);
                if (this._renderer != null){
                    this._renderer.feedRoomObject(_local_6);
                };
                return (_local_6);
            };
            return (null);
        }
        public function getObject(_arg_1:int, _arg_2:int):IRoomObject
        {
            var _local_3:IRoomObjectManager = this.getObjectManager(_arg_2);
            if (_local_3 != null){
                return (_local_3.getObject(_arg_1));
            };
            return (null);
        }
        public function getObjectWithIndex(_arg_1:int, _arg_2:int):IRoomObject
        {
            var _local_3:IRoomObjectManager = this.getObjectManager(_arg_2);
            if (_local_3 != null){
                return (_local_3.getObjectWithIndex(_arg_1));
            };
            return (null);
        }
        public function getObjectCount(_arg_1:int):int
        {
            var _local_2:IRoomObjectManager = this.getObjectManager(_arg_1);
            if (_local_2 != null){
                return (_local_2.getObjectCount());
            };
            return (0);
        }
        public function getObjectWithIndexAndType(_arg_1:int, _arg_2:String, _arg_3:int):IRoomObject
        {
            var _local_4:IRoomObjectManager = this.getObjectManager(_arg_3);
            if (_local_4 != null){
                return (_local_4.getObjectWithIndexAndType(_arg_1, _arg_2));
            };
            return (null);
        }
        public function getObjectCountForType(_arg_1:String, _arg_2:int):int
        {
            var _local_3:IRoomObjectManager = this.getObjectManager(_arg_2);
            if (_local_3 != null){
                return (_local_3.getObjectCountForType(_arg_1));
            };
            return (0);
        }
        public function disposeObject(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:IRoomObject;
            var _local_3:IRoomObjectManager = this.getObjectManager(_arg_2);
            if (_local_3 != null){
                _local_4 = _local_3.getObject(_arg_1);
                if (_local_4 != null){
                    if (this._renderer){
                        this._renderer.removeRoomObject(_local_4.getInstanceId());
                    };
                    return (_local_3.disposeObject(_arg_1));
                };
            };
            return (false);
        }
        public function disposeObjects(_arg_1:int):int
        {
            var _local_4:int;
            var _local_5:IRoomObjectController;
            var _local_6:int;
            var _local_2:int;
            var _local_3:IRoomObjectManager = this.getObjectManager(_arg_1);
            if (_local_3 != null){
                _local_2 = _local_3.getObjectCount();
                _local_4 = 0;
                while (_local_4 < _local_2) {
                    _local_5 = (_local_3.getObjectWithIndex(_local_4) as IRoomObjectController);
                    if (_local_5 != null){
                        _local_6 = _local_5.getInstanceId();
                        _local_5.dispose();
                        if (this._renderer){
                            this._renderer.removeRoomObject(_local_6);
                        };
                    };
                    _local_4++;
                };
                _local_3.reset();
            };
            return (_local_2);
        }
        public function setRenderer(_arg_1:IRoomRendererBase):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:IRoomObjectController;
            if (_arg_1 == this._renderer){
                return;
            };
            if (this._renderer != null){
                this._renderer.dispose();
            };
            this._renderer = _arg_1;
            if (this._renderer == null){
                return;
            };
            this._renderer.reset();
            var _local_2:Array = this.getObjectManagerIds();
            var _local_3:int = (_local_2.length - 1);
            while (_local_3 >= 0) {
                _local_4 = int(_local_2[_local_3]);
                _local_5 = this.getObjectCount(_local_4);
                _local_6 = (_local_5 - 1);
                while (_local_6 >= 0) {
                    _local_7 = (this.getObjectWithIndex(_local_6, _local_4) as IRoomObjectController);
                    if (_local_7 != null){
                        this._renderer.feedRoomObject(_local_7);
                    };
                    _local_6--;
                };
                _local_3--;
            };
        }
        public function getRenderer():IRoomRendererBase
        {
            return (this._renderer);
        }
        public function getObjectManagerIds():Array
        {
            return (this._SafeStr_14529.getKeys());
        }
        protected function createObjectManager(_arg_1:int):IRoomObjectManager
        {
            var _local_2:String = String(_arg_1);
            if (this._SafeStr_14529.getValue(_local_2) != null){
                return ((this._SafeStr_14529.getValue(_local_2) as IRoomObjectManager));
            };
            if (this._container == null){
                return (null);
            };
            var _local_3:IRoomObjectManager = this._container.createRoomObjectManager();
            if (_local_3 != null){
                this._SafeStr_14529.add(_local_2, _local_3);
            };
            return (_local_3);
        }
        protected function getObjectManager(_arg_1:int):IRoomObjectManager
        {
            return ((this._SafeStr_14529.getValue(String(_arg_1)) as IRoomObjectManager));
        }
        protected function disposeObjectManager(_arg_1:int):Boolean
        {
            var _local_3:IRoomObjectManager;
            var _local_2:String = String(_arg_1);
            this.disposeObjects(_arg_1);
            if (this._SafeStr_14529.getValue(_local_2) != null){
                _local_3 = (this._SafeStr_14529.remove(_local_2) as IRoomObjectManager);
                if (_local_3 != null){
                    _local_3.dispose();
                };
                return (true);
            };
            return (false);
        }

    }
}//package com.sulake.room

// getEventHandler = "_-1dG" (String#5618, DoABC#2)
// getRenderer = "_-05z" (String#3684, DoABC#2)
// addObjectUpdateCategory = "_-2A6" (String#6251, DoABC#2)
// createRoomObject = "_-20d" (String#1799, DoABC#2)
// setRenderer = "_-1zT" (String#6024, DoABC#2)
// getObjectWithIndex = "_-252" (String#1807, DoABC#2)
// createObject = "_-j8" (String#2167, DoABC#2)
// disposeObject = "_-3E-" (String#921, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// createRoomObjectManager = "_-1Ry" (String#1688, DoABC#2)
// _SafeStr_14407 = "_-0fZ" (String#4416, DoABC#2)
// _SafeStr_14408 = "_-1Kj" (String#5257, DoABC#2)
// _SafeStr_14411 = "_-lX" (String#8634, DoABC#2)
// _SafeStr_14412 = "_-0O1" (String#4047, DoABC#2)
// feedRoomObject = "_-36M" (String#7437, DoABC#2)
// removeRoomObject = "_-kC" (String#8605, DoABC#2)
// getObjectCountForType = "_-2T0" (String#1882, DoABC#2)
// getObjectWithIndexAndType = "_-2OS" (String#1870, DoABC#2)
// disposeObjects = "_-sJ" (String#8743, DoABC#2)
// _SafeStr_14529 = "_-BA" (String#22661, DoABC#2)
// removeObjectUpdateCategory = "_-0Cw" (String#3806, DoABC#2)
// getObjectManager = "_-2OH" (String#19977, DoABC#2)
// createObjectInternal = "_-00P" (String#14070, DoABC#2)
// createObjectManager = "_-0wb" (String#16294, DoABC#2)
// getObjectManagerIds = "_-2-B" (String#18977, DoABC#2)
// disposeObjectManager = "_-2hI" (String#20742, DoABC#2)
// IRoomObjectManager = "_-iT" (String#8568, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// IRoomInstance = "_-1j8" (String#5739, DoABC#2)
// RoomInstance = "_-OJ" (String#8170, DoABC#2)
// IRoomRendererBase = "_-0Eq" (String#3847, DoABC#2)
// getObjectCount = "_-09y" (String#1415, DoABC#2)
// getObject = "_-1GT" (String#844, DoABC#2)
// _renderer = "_-32W" (String#628, DoABC#2)


