
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomPropertyMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _floorType:String = null;
        private var _wallType:String = null;
        private var _landscapeType:String = null;
        private var _animatedLandskapeType:String = null;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get floorType():String
        {
            return (this._floorType);
        }
        public function get wallType():String
        {
            return (this._wallType);
        }
        public function get landscapeType():String
        {
            return (this._landscapeType);
        }
        public function get animatedLandskapeType():String
        {
            return (this._animatedLandskapeType);
        }
        public function flush():Boolean
        {
            this._floorType = null;
            this._wallType = null;
            this._landscapeType = null;
            this._animatedLandskapeType = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:String = _arg_1.readString();
            var _local_3:String = _arg_1.readString();
            switch (_local_2){
                case "floor":
                    this._floorType = _local_3;
                    break;
                case "wallpaper":
                    this._wallType = _local_3;
                    break;
                case "landscape":
                    this._landscapeType = _local_3;
                    break;
                case "landscapeanim":
                    this._animatedLandskapeType = _local_3;
                    break;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomPropertyMessageParser = "_-fP" (String#8503, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _wallType = "_-04G" (String#578, DoABC#2)
// _landscapeType = "_-2Wo" (String#621, DoABC#2)
// _animatedLandskapeType = "_-X7" (String#23526, DoABC#2)
// floorType = "_-1D4" (String#16985, DoABC#2)
// wallType = "_-0n5" (String#15942, DoABC#2)
// landscapeType = "_-29h" (String#19391, DoABC#2)
// animatedLandskapeType = "_-2T3" (String#20165, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


