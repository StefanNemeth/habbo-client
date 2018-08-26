
package com.sulake.habbo.communication.messages.incoming.navigator
{
    public class RoomThumbnailObjectData 
    {

        private var _pos:int;
        private var _imgId:int;

        public function getCopy():RoomThumbnailObjectData
        {
            var _local_1:RoomThumbnailObjectData = new RoomThumbnailObjectData();
            _local_1._pos = this._pos;
            _local_1._imgId = this._imgId;
            return (_local_1);
        }
        public function set pos(_arg_1:int):void
        {
            this._pos = _arg_1;
        }
        public function set imgId(_arg_1:int):void
        {
            this._imgId = _arg_1;
        }
        public function get pos():int
        {
            return (this._pos);
        }
        public function get imgId():int
        {
            return (this._imgId);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// RoomThumbnailObjectData = "_-bW" (String#8446, DoABC#2)
// pos = "_-g8" (String#23898, DoABC#2)
// imgId = "_-wA" (String#24536, DoABC#2)
// getCopy = "_-119" (String#16504, DoABC#2)
// _pos = "_-W5" (String#23496, DoABC#2)
// _imgId = "_-0YP" (String#15375, DoABC#2)


