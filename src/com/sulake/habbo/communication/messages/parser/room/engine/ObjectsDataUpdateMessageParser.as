
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectsDataUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _objects:Array;

        public function ObjectsDataUpdateMessageParser()
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
        public function get objectCount():int
        {
            return (this._objects.length);
        }
        public function getObjectData(_arg_1:int):ObjectData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.objectCount)))){
                return (null);
            };
            return (this._objects[_arg_1]);
        }
        public function flush():Boolean
        {
            this._objects = [];
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:String;
            var _local_6:int;
            var _local_7:Number;
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                _local_6 = 0;
                _local_7 = parseFloat(_local_5);
                if (!isNaN(_local_7)){
                    _local_6 = int(_local_5);
                };
                this._objects.push(new ObjectData(_local_4, _local_6, _local_5));
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ObjectsDataUpdateMessageParser = "_-fN" (String#8502, DoABC#2)
// ObjectData = "_-D" (String#7932, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// objectCount = "_-2Yw" (String#20393, DoABC#2)
// getObjectData = "_-1Bi" (String#16930, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


