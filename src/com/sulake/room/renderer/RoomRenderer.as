
package com.sulake.room.renderer
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.Component;
    import com.sulake.room.object.IRoomObject;
    import flash.utils.getTimer;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.room.utils.RoomGeometry;

    public class RoomRenderer implements IRoomRenderer, IRoomSpriteCanvasContainer 
    {

        private var _objects:Map;
        private var _SafeStr_6996:Map;
        private var _component:Component;
        private var _disposed:Boolean = false;
        private var _roomObjectVariableAccurateZ:String = null;

        public function RoomRenderer(_arg_1:Component)
        {
            this._objects = new Map();
            this._SafeStr_6996 = new Map();
            if (_arg_1 != null){
                this._component = _arg_1;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get roomObjectVariableAccurateZ():String
        {
            return (this._roomObjectVariableAccurateZ);
        }
        public function set roomObjectVariableAccurateZ(_arg_1:String):void
        {
            this._roomObjectVariableAccurateZ = _arg_1;
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:RoomSpriteCanvas;
            if (this.disposed){
                return;
            };
            if (this._SafeStr_6996 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_6996.length) {
                    _local_2 = (this._SafeStr_6996.getWithIndex(_local_1) as RoomSpriteCanvas);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_6996.dispose();
                this._SafeStr_6996 = null;
            };
            if (this._objects != null){
                this._objects.dispose();
                this._objects = null;
            };
            if (this._component != null){
                this._component = null;
            };
            this._disposed = true;
        }
        public function reset():void
        {
            this._objects.reset();
        }
        public function feedRoomObject(_arg_1:IRoomObject):void
        {
            if (_arg_1 == null){
                return;
            };
            this._objects.add(String(_arg_1.getInstanceId()), _arg_1);
        }
        public function removeRoomObject(_arg_1:int):void
        {
            var _local_4:RoomSpriteCanvas;
            var _local_2:String = String(_arg_1);
            this._objects.remove(_local_2);
            var _local_3:int;
            while (_local_3 < this._SafeStr_6996.length) {
                _local_4 = (this._SafeStr_6996.getWithIndex(_local_3) as RoomSpriteCanvas);
                if (_local_4 != null){
                    _local_4.roomObjectRemoved(_local_2);
                };
                _local_3++;
            };
        }
        public function getRoomObject(_arg_1:String):IRoomObject
        {
            return ((this._objects.getValue(_arg_1) as IRoomObject));
        }
        public function getRoomObjectWithIndex(_arg_1:int):IRoomObject
        {
            return ((this._objects.getWithIndex(_arg_1) as IRoomObject));
        }
        public function getRoomObjectIdWithIndex(_arg_1:int):String
        {
            return ((this._objects.getKey(_arg_1) as String));
        }
        public function getRoomObjectCount():int
        {
            return (this._objects.length);
        }
        public function render():void
        {
            var _local_3:IRoomRenderingCanvas;
            var _local_1:int = getTimer();
            ErrorReportStorage.addDebugData("Canvas count", ("Canvas count: " + this._SafeStr_6996.length));
            var _local_2:int = (this._SafeStr_6996.length - 1);
            while (_local_2 >= 0) {
                _local_3 = (this._SafeStr_6996.getWithIndex(_local_2) as IRoomRenderingCanvas);
                if (_local_3 != null){
                    _local_3.render(_local_1);
                };
                _local_2--;
            };
        }
        public function createCanvas(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomRenderingCanvas
        {
            var _local_6:RoomGeometry;
            var _local_5:IRoomRenderingCanvas = (this._SafeStr_6996.getValue(String(_arg_1)) as IRoomRenderingCanvas);
            if (_local_5 != null){
                _local_5.initialize(_arg_2, _arg_3);
                _local_6 = (_local_5.geometry as RoomGeometry);
                if (_local_6){
                    _local_6.scale = _arg_4;
                };
                return (_local_5);
            };
            _local_5 = new RoomSpriteCanvas(this, ("canvas_" + _arg_1), _arg_2, _arg_3, _arg_4);
            this._SafeStr_6996.add(String(_arg_1), _local_5);
            return (_local_5);
        }
        public function getCanvas(_arg_1:int):IRoomRenderingCanvas
        {
            return ((this._SafeStr_6996.getValue(String(_arg_1)) as IRoomRenderingCanvas));
        }
        public function disposeCanvas(_arg_1:int):Boolean
        {
            var _local_2:RoomSpriteCanvas = (this._SafeStr_6996.remove(String(_arg_1)) as RoomSpriteCanvas);
            if (_local_2 != null){
                _local_2.dispose();
            };
            return (false);
        }
        public function update(_arg_1:uint):void
        {
            var _local_3:RoomSpriteCanvas;
            this.render();
            var _local_2:int = (this._SafeStr_6996.length - 1);
            while (_local_2 >= 0) {
                _local_3 = (this._SafeStr_6996.getWithIndex(_local_2) as RoomSpriteCanvas);
                if (_local_3 != null){
                    _local_3.update();
                };
                _local_2--;
            };
        }

    }
}//package com.sulake.room.renderer

// createCanvas = "_-24l" (String#6132, DoABC#2)
// feedRoomObject = "_-36M" (String#7437, DoABC#2)
// removeRoomObject = "_-kC" (String#8605, DoABC#2)
// disposeCanvas = "_-37k" (String#7463, DoABC#2)
// getRoomObjectIdWithIndex = "_-0EL" (String#3833, DoABC#2)
// roomObjectRemoved = "_-13B" (String#16587, DoABC#2)
// IRoomRenderer = "_-2jS" (String#6944, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1jX" (String#5744, DoABC#2)
// RoomRenderer = "_-012" (String#3582, DoABC#2)
// RoomGeometry = "_-2l9" (String#20887, DoABC#2)
// IRoomRenderingCanvas = "_-22o" (String#6102, DoABC#2)
// RoomSpriteCanvas = "_-4K" (String#7752, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)
// _SafeStr_6996 = "_-1n9" (String#5800, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// getRoomObjectCount = "_-1Hy" (String#1654, DoABC#2)
// getRoomObjectWithIndex = "_-cJ" (String#2140, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)


