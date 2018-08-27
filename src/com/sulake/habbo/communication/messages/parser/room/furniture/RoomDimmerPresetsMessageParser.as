
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomDimmerPresetsMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _selectedPresetId:int = 0;
        private var _presets:Array;

        public function RoomDimmerPresetsMessageParser()
        {
            this._presets = [];
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
        public function get presetCount():int
        {
            return (this._presets.length);
        }
        public function get selectedPresetId():int
        {
            return (this._selectedPresetId);
        }
        public function getPreset(_arg_1:int):RoomDimmerPresetsMessageData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.presetCount)))){
                return (null);
            };
            return (this._presets[_arg_1]);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._presets = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:int;
            var _local_8:int;
            var _local_9:RoomDimmerPresetsMessageData;
            var _local_2:int = _arg_1.readInteger();
            this._selectedPresetId = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_7 = parseInt(_local_6.substr(1), 16);
                _local_8 = _arg_1.readInteger();
                _local_9 = new RoomDimmerPresetsMessageData(_local_4);
                _local_9.type = _local_5;
                _local_9.color = _local_7;
                _local_9.light = _local_8;
                _local_9.setReadOnly();
                this._presets.push(_local_9);
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomDimmerPresetsMessageParser = "_-1xY" (String#5982, DoABC#2)
// RoomDimmerPresetsMessageData = "_-0sE" (String#4690, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// selectedPresetId = "_-0Pr" (String#15055, DoABC#2)
// presetCount = "_-Gt" (String#22886, DoABC#2)
// getPreset = "_-0rG" (String#16096, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


