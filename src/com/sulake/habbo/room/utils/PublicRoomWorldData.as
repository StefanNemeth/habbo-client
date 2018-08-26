
package com.sulake.habbo.room.utils
{
    public class PublicRoomWorldData 
    {

        private var _worldType:String = "";
        private var _heightScale:Number = 1;
        private var _scale:Number = 1;

        public function PublicRoomWorldData(_arg_1:String, _arg_2:Number, _arg_3:Number)
        {
            this._worldType = _arg_1;
            this._scale = _arg_2;
            this._heightScale = _arg_3;
        }
        public function get heightScale():Number
        {
            return (this._heightScale);
        }
        public function get scale():Number
        {
            return (this._scale);
        }

    }
}//package com.sulake.habbo.room.utils

// _heightScale = "_-g-" (String#23891, DoABC#2)
// PublicRoomWorldData = "_-2IL" (String#6408, DoABC#2)


