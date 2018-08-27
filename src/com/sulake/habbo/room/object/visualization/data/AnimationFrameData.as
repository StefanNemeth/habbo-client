
package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrameData 
    {

        private var _id:int = 0;
        private var _x:int = 0;
        private var _y:int = 0;
        private var _randomX:int = 0;
        private var _randomY:int = 0;
        private var _repeats:int = 1;

        public function AnimationFrameData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            this._id = _arg_1;
            this._x = _arg_2;
            this._y = _arg_3;
            this._randomX = _arg_4;
            this._randomY = _arg_5;
            this._repeats = _arg_6;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function hasDirectionalOffsets():Boolean
        {
            return (false);
        }
        public function getX(_arg_1:int):int
        {
            return (this._x);
        }
        public function getY(_arg_1:int):int
        {
            return (this._y);
        }
        public function get x():int
        {
            return (this._x);
        }
        public function get y():int
        {
            return (this._x);
        }
        public function get randomX():int
        {
            return (this._randomX);
        }
        public function get randomY():int
        {
            return (this._randomY);
        }
        public function get repeats():int
        {
            return (this._repeats);
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// getX = "_-bw" (String#8454, DoABC#2)
// getY = "_-2Wq" (String#6697, DoABC#2)
// repeats = "_-0Lv" (String#14909, DoABC#2)
// _repeats = "_-3CQ" (String#7561, DoABC#2)
// hasDirectionalOffsets = "_-jk" (String#24025, DoABC#2)
// _randomX = "_-DQ" (String#22746, DoABC#2)
// _randomY = "_-2Oz" (String#20000, DoABC#2)
// AnimationFrameData = "_-19W" (String#5067, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)


