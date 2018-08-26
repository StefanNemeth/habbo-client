
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _data:ObjectMessageData = null;

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
            this._data = null;
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function get data():ObjectMessageData
        {
            var _local_1:ObjectMessageData = this._data;
            if (_local_1 != null){
                _local_1.setReadOnly();
            };
            return (_local_1);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._data = ObjectDataParser.parseObjectData(_arg_1);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ObjectUpdateMessageParser = "_-3Da" (String#7589, DoABC#2)
// ObjectMessageData = "_-0jV" (String#4490, DoABC#2)
// ObjectDataParser = "_-NK" (String#8152, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// parseObjectData = "_-dv" (String#23798, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


