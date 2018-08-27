
package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrameDirectionalData extends AnimationFrameData 
    {

        private var _SafeStr_12593:DirectionalOffsetData;

        public function AnimationFrameDirectionalData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:DirectionalOffsetData, _arg_7:int)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_7);
            this._SafeStr_12593 = _arg_6;
        }
        override public function hasDirectionalOffsets():Boolean
        {
            return (!((this._SafeStr_12593 == null)));
        }
        override public function getX(_arg_1:int):int
        {
            if (this._SafeStr_12593 != null){
                return (this._SafeStr_12593.getOffsetX(_arg_1, super.getX(_arg_1)));
            };
            return (super.getX(_arg_1));
        }
        override public function getY(_arg_1:int):int
        {
            if (this._SafeStr_12593 != null){
                return (this._SafeStr_12593.getOffsetY(_arg_1, super.getY(_arg_1)));
            };
            return (super.getY(_arg_1));
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// getX = "_-bw" (String#8454, DoABC#2)
// getY = "_-2Wq" (String#6697, DoABC#2)
// getOffsetX = "_-7U" (String#22522, DoABC#2)
// getOffsetY = "_-1ox" (String#18498, DoABC#2)
// hasDirectionalOffsets = "_-jk" (String#24025, DoABC#2)
// _SafeStr_12593 = "_-1hT" (String#18190, DoABC#2)
// DirectionalOffsetData = "_-0oK" (String#4599, DoABC#2)
// AnimationFrameData = "_-19W" (String#5067, DoABC#2)
// AnimationFrameDirectionalData = "_-01i" (String#3596, DoABC#2)


