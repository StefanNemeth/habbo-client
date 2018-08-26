
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralTeaserActiveMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _data:ObjectMessageData;

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
            return (this._data);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._data = new ObjectMessageData(-1);
            this._data.x = ((Math.random() * 5) + 7);
            this._data.y = ((Math.random() * 5) + 5);
            this._data.z = (Math.random() * 3);
            this._data.dir = 0;
            this._data.type = _arg_1.readInteger();
            var _local_2:String = _arg_1.readString();
            if ((((_local_2 == null)) || ((_local_2.length == 0)))){
                _local_2 = "val11";
            };
            this._data.data = (("TYPE_INJECTED" + "+") + _local_2);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ObjectMessageData = "_-0jV" (String#4490, DoABC#2)
// ViralTeaserActiveMessageParser = "_-36i" (String#7444, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


