
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisualizationSettingsParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _wallsHidden:Boolean = false;
        private var _wallThicknessMultiplier:Number = 1;
        private var _floorThicknessMultiplier:Number = 1;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get wallsHidden():Boolean
        {
            return (this._wallsHidden);
        }
        public function get wallThicknessMultiplier():Number
        {
            return (this._wallThicknessMultiplier);
        }
        public function get floorThicknessMultiplier():Number
        {
            return (this._floorThicknessMultiplier);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._wallsHidden = false;
            this._wallThicknessMultiplier = 1;
            this._floorThicknessMultiplier = 1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._wallsHidden = _arg_1.readBoolean();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            if (_local_2 < -2){
                _local_2 = -2;
            }
            else {
                if (_local_2 > 1){
                    _local_2 = 1;
                };
            };
            if (_local_3 < -2){
                _local_3 = -2;
            }
            else {
                if (_local_3 > 1){
                    _local_3 = 1;
                };
            };
            this._wallThicknessMultiplier = Math.pow(2, _local_2);
            this._floorThicknessMultiplier = Math.pow(2, _local_3);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomVisualizationSettingsParser = "_-1vY" (String#5952, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _wallsHidden = "_-V7" (String#23453, DoABC#2)
// _wallThicknessMultiplier = "_-LU" (String#2093, DoABC#2)
// _floorThicknessMultiplier = "_-3Ab" (String#2015, DoABC#2)
// wallsHidden = "_-Nd" (String#23150, DoABC#2)
// wallThicknessMultiplier = "_-0wt" (String#16306, DoABC#2)
// floorThicknessMultiplier = "_-1NT" (String#17417, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


