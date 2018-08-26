
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomObjectsMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _objects:Array;

        public function PublicRoomObjectsMessageParser()
        {
            this._objects = [];
            super();
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function flush():Boolean
        {
            this._objects = [];
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function RoomInstance():int
        {
            return (this._objects.length);
        }
        public function RoomInstance(_arg_1:int):PublicRoomObjectMessageData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.RoomInstance())))){
                return (null);
            };
            var _local_2:PublicRoomObjectMessageData = (this._objects[_arg_1] as PublicRoomObjectMessageData);
            if (_local_2 != null){
                _local_2.setReadOnly();
            };
            return (_local_2);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:PublicRoomObjectMessageData;
            if (_arg_1 == null){
                return (false);
            };
            this._objects = [];
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = PublicRoomObjectDataParser.parseObjectData(_arg_1);
                if (_local_4 != null){
                    this._objects.push(_local_4);
                };
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PublicRoomObjectMessageData = "_-6" (String#7780, DoABC#2)
// PublicRoomObjectsMessageParser = "_-if" (String#8570, DoABC#2)
// PublicRoomObjectDataParser = "_-0lH" (String#4529, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// parseObjectData = "_-dv" (String#23798, DoABC#2)
// RoomInstance = "_-09y" (String#1415, DoABC#2)
// RoomInstance = "_-1GT" (String#844, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


