
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectDataUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int = 0;
        private var _state:int = 0;
        private var _data:String;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get state():int
        {
            return (this._state);
        }
        public function get data():String
        {
            return (this._data);
        }
        public function flush():Boolean
        {
            this._state = 0;
            this._data = "";
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:String = _arg_1.readString();
            this._id = int(_local_2);
            this._data = _arg_1.readString();
            var _local_3:Number = parseFloat(this._data);
            if (!isNaN(_local_3)){
                this._state = int(this._data);
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ObjectDataUpdateMessageParser = "_-2K4" (String#6444, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


