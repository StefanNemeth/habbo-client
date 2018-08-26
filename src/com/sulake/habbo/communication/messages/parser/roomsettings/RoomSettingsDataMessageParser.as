
package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsDataMessageParser implements IMessageParser 
    {

        private var _data:RoomSettingsData;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomSettingsData();
            this._data.roomId = _arg_1.readInteger();
            this._data.name = _arg_1.readString();
            this._data.description = _arg_1.readString();
            this._data.doorMode = _arg_1.readInteger();
            this._data.categoryId = _arg_1.readInteger();
            this._data.maximumVisitors = _arg_1.readInteger();
            this._data.maximumVisitorsLimit = _arg_1.readInteger();
            this._data.tags = [];
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._data.tags.push(_arg_1.readString());
                _local_3++;
            };
            this._data.controllers = [];
            var _local_4:int = _arg_1.readInteger();
            var _local_5:int;
            while (_local_5 < _local_4) {
                this._data.controllers.push(new FlatControllerData(_arg_1));
                _local_5++;
            };
            this._data.controllerCount = _arg_1.readInteger();
            this._data.allowPets = (_arg_1.readInteger() == 1);
            this._data.allowFoodConsume = (_arg_1.readInteger() == 1);
            this._data.allowWalkThrough = (_arg_1.readInteger() == 1);
            this._data.hideWalls = (_arg_1.readInteger() == 1);
            this._data.wallThickness = _arg_1.readInteger();
            this._data.floorThickness = _arg_1.readInteger();
            return (true);
        }
        public function flush():Boolean
        {
            this._data = null;
            return (true);
        }
        public function get data():RoomSettingsData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.roomsettings

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomSettingsData = "_-we" (String#8817, DoABC#2)
// RoomSettingsDataMessageParser = "_-0dz" (String#4391, DoABC#2)
// FlatControllerData = "_-0aS" (String#4311, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// allowPets = "_-2Zu" (String#20436, DoABC#2)
// allowFoodConsume = "_-18w" (String#16812, DoABC#2)
// allowWalkThrough = "_-1aX" (String#17916, DoABC#2)
// hideWalls = "_-2O7" (String#19970, DoABC#2)
// wallThickness = "_-bn" (String#23705, DoABC#2)
// maximumVisitors = "_-1Ex" (String#17069, DoABC#2)
// maximumVisitorsLimit = "_-S3" (String#23327, DoABC#2)
// controllers = "_-0A4" (String#14450, DoABC#2)
// controllerCount = "_-0WL" (String#15293, DoABC#2)
// _data = "_-uu" (String#24487, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


