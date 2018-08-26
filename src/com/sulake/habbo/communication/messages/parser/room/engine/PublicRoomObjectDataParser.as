
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomObjectDataParser 
    {

        public static function parseObjectData(_arg_1:IMessageDataWrapper):PublicRoomObjectMessageData
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:Boolean = Boolean(_arg_1.readInteger());
            var _local_3:PublicRoomObjectMessageData = new PublicRoomObjectMessageData();
            var _local_4:String = _arg_1.readString();
            _local_3.name = _local_4;
            var _local_5:String = _arg_1.readString();
            _local_3.type = _local_5;
            _local_3.x = _arg_1.readInteger();
            _local_3.y = _arg_1.readInteger();
            _local_3.z = _arg_1.readInteger();
            if (!_local_2){
                _local_3.dir = ((_arg_1.readInteger() % 8) * 45);
            }
            else {
                _local_3.sizeX = _arg_1.readInteger();
                _local_3.sizeY = _arg_1.readInteger();
            };
            return (_local_3);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PublicRoomObjectMessageData = "_-6" (String#7780, DoABC#2)
// PublicRoomObjectDataParser = "_-0lH" (String#4529, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// parseObjectData = "_-dv" (String#23798, DoABC#2)
// sizeX = "_-0UO" (String#15219, DoABC#2)
// sizeY = "_-wz" (String#24569, DoABC#2)


