
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemDataParser 
    {

        public static function parseItemData(_arg_1:IMessageDataWrapper):ItemMessageData
        {
            var _local_12:String;
            var _local_13:String;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:String;
            var _local_19:Array;
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:Number;
            var _local_2:int = int(_arg_1.readString());
            var _local_3:int = _arg_1.readInteger();
            var _local_4:String = _arg_1.readString();
            var _local_5:String = _arg_1.readString();
            var _local_6:Boolean = _arg_1.readBoolean();
            var _local_7:int;
            var _local_8:Number = parseFloat(_local_5);
            if (!isNaN(_local_8)){
                _local_7 = int(_local_5);
            };
            Logger.log("\n\n PARSING WALL ITEM: ");
            Logger.log(("wallItemId: " + _local_2));
            Logger.log(("wallItemTypeId: " + _local_3));
            Logger.log(("location: " + _local_4));
            Logger.log(("dataStr: " + _local_5));
            Logger.log(("state: " + _local_7));
            var _local_9:ItemMessageData;
            var _local_10:Array;
            var _local_11:String;
            if (_local_4.indexOf(":") == 0){
                _local_9 = new ItemMessageData(_local_2, _local_3, false);
                _local_10 = _local_4.split(" ");
                if (_local_10.length >= 3){
                    _local_12 = String(_local_10[0]);
                    _local_13 = String(_local_10[1]);
                    _local_11 = String(_local_10[2]);
                    if ((((_local_12.length > 3)) && ((_local_13.length > 2)))){
                        _local_12 = _local_12.substr(3);
                        _local_13 = _local_13.substr(2);
                        _local_10 = _local_12.split(",");
                        if (_local_10.length >= 2){
                            _local_14 = int(_local_10[0]);
                            _local_15 = int(_local_10[1]);
                            _local_10 = _local_13.split(",");
                            if (_local_10.length >= 2){
                                _local_16 = int(_local_10[0]);
                                _local_17 = int(_local_10[1]);
                                _local_9.wallX = _local_14;
                                _local_9.wallY = _local_15;
                                _local_9.localX = _local_16;
                                _local_9.localY = _local_17;
                                _local_9.dir = _local_11;
                                _local_9.data = _local_5;
                                _local_9.state = _local_7;
                            };
                        };
                    };
                };
            }
            else {
                _local_9 = new ItemMessageData(_local_2, _local_3, true);
                _local_10 = _local_4.split(" ");
                if (_local_10.length >= 2){
                    _local_11 = String(_local_10[0]);
                    if ((((_local_11 == "rightwall")) || ((_local_11 == "frontwall")))){
                        _local_11 = "r";
                    }
                    else {
                        _local_11 = "l";
                    };
                    _local_18 = String(_local_10[1]);
                    _local_19 = _local_18.split(",");
                    if (_local_19.length >= 3){
                        _local_20 = 0;
                        _local_21 = parseFloat(_local_19[0]);
                        _local_22 = parseFloat(_local_19[1]);
                        _local_9.y = _local_21;
                        _local_9.z = _local_22;
                        _local_9.dir = _local_11;
                        _local_9.data = _local_5;
                        _local_9.state = _local_7;
                    };
                };
            };
            _local_9.knownAsUsable = _local_6;
            return (_local_9);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ItemMessageData = "_-1Nr" (String#5309, DoABC#2)
// ItemDataParser = "_-15y" (String#4993, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// parseItemData = "_-34d" (String#7401, DoABC#2)
// wallX = "_-0Jc" (String#14826, DoABC#2)
// wallY = "_-2VK" (String#20254, DoABC#2)


