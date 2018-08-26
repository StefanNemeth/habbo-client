
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectDataParser 
    {

        public static function parseObjectData(_arg_1:IMessageDataWrapper):ObjectMessageData
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:int = _arg_1.readInteger();
            var _local_3:ObjectMessageData = new ObjectMessageData(_local_2);
            var _local_4:int = _arg_1.readInteger();
            _local_3.type = _local_4;
            _local_3.x = _arg_1.readInteger();
            _local_3.y = _arg_1.readInteger();
            _local_3.dir = ((_arg_1.readInteger() % 8) * 45);
            _local_3.z = Number(_arg_1.readString());
            _local_3.extra = _arg_1.readInteger();
            _local_3.data = _arg_1.readString();
            var _local_5:Number = parseFloat(_local_3.data);
            if (!isNaN(_local_5)){
                _local_3.state = int(_local_3.data);
            };
            _local_3.expiryTime = _arg_1.readInteger();
            _local_3.knownAsUsable = _arg_1.readBoolean();
            if (_local_4 < 0){
                _local_3.staticClass = _arg_1.readString();
            };
            return (_local_3);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ObjectMessageData = "_-0jV" (String#4490, DoABC#2)
// ObjectDataParser = "_-NK" (String#8152, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// parseObjectData = "_-dv" (String#23798, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// staticClass = "_-1HW" (String#17170, DoABC#2)


