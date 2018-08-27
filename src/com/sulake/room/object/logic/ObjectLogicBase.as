
package com.sulake.room.object.logic
{
    import flash.events.IEventDispatcher;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class ObjectLogicBase implements IRoomObjectEventHandler 
    {

        private var _events:IEventDispatcher;
        private var _object:IRoomObjectController;

        public function get eventDispatcher():IEventDispatcher
        {
            return (this._events);
        }
        public function set eventDispatcher(_arg_1:IEventDispatcher):void
        {
            this._events = _arg_1;
        }
        public function getEventTypes():Array
        {
            return ([]);
        }
        protected function getAllEventTypes(_arg_1:Array, _arg_2:Array):Array
        {
            var _local_4:String;
            var _local_3:Array = _arg_1.concat();
            for each (_local_4 in _arg_2) {
                if (_local_3.indexOf(_local_4) < 0){
                    _local_3.push(_local_4);
                };
            };
            return (_local_3);
        }
        public function dispose():void
        {
            this._object = null;
        }
        public function set object(_arg_1:IRoomObjectController):void
        {
            if (this._object == _arg_1){
                return;
            };
            if (this._object != null){
                this._object.setEventHandler(null);
            };
            if (_arg_1 == null){
                this.dispose();
                this._object = null;
            }
            else {
                this._object = _arg_1;
                this._object.setEventHandler(this);
            };
        }
        public function get object():IRoomObjectController
        {
            return (this._object);
        }
        public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
        }
        public function initialize(_arg_1:XML):void
        {
        }
        public function update(_arg_1:int):void
        {
        }
        public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            if (_arg_1 != null){
                if (this._object != null){
                    this._object.setLocation(_arg_1.loc);
                    this._object.setDirection(_arg_1.dir);
                };
            };
        }
        public function useObject():void
        {
        }

    }
}//package com.sulake.room.object.logic

// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// ObjectLogicBase = "_-VT" (String#8310, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// getAllEventTypes = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// _object = "_-ZQ" (String#8406, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)
// setEventHandler = "_-2X9" (String#6703, DoABC#2)


