
package com.sulake.habbo.room.utils
{
    public class RoomData 
    {

        private var _roomId:int;
        private var _roomCategory:int;
        private var _data:XML;
        private var _floorType:String = null;
        private var _wallType:String = null;
        private var _landscapeType:String = null;

        public function RoomData(_arg_1:int, _arg_2:int, _arg_3:XML)
        {
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
            this._data = _arg_3;
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get data():XML
        {
            return (this._data);
        }
        public function get floorType():String
        {
            return (this._floorType);
        }
        public function set floorType(_arg_1:String):void
        {
            this._floorType = _arg_1;
        }
        public function get wallType():String
        {
            return (this._wallType);
        }
        public function set wallType(_arg_1:String):void
        {
            this._wallType = _arg_1;
        }
        public function get landscapeType():String
        {
            return (this._landscapeType);
        }
        public function set landscapeType(_arg_1:String):void
        {
            this._landscapeType = _arg_1;
        }

    }
}//package com.sulake.habbo.room.utils

// _wallType = "_-04G" (String#578, DoABC#2)
// _landscapeType = "_-2Wo" (String#621, DoABC#2)
// floorType = "_-1D4" (String#16985, DoABC#2)
// wallType = "_-0n5" (String#15942, DoABC#2)
// landscapeType = "_-29h" (String#19391, DoABC#2)


