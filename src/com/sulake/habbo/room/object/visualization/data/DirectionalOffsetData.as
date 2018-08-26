
package com.sulake.habbo.room.object.visualization.data
{
    import flash.utils.Dictionary;

    public class DirectionalOffsetData 
    {

        private var _offsetX:Dictionary;
        private var _originalOffsetY:Dictionary;

        public function DirectionalOffsetData()
        {
            this._offsetX = new Dictionary();
            this._originalOffsetY = new Dictionary();
            super();
        }
        public function getOffsetX(_arg_1:int, _arg_2:int):int
        {
            if (this._offsetX[_arg_1] == null){
                return (_arg_2);
            };
            return (this._offsetX[_arg_1]);
        }
        public function getOffsetY(_arg_1:int, _arg_2:int):int
        {
            if (this._originalOffsetY[_arg_1] == null){
                return (_arg_2);
            };
            return (this._originalOffsetY[_arg_1]);
        }
        public function setOffset(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            this._offsetX[_arg_1] = _arg_2;
            this._originalOffsetY[_arg_1] = _arg_3;
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// setOffset = "_-2O1" (String#19966, DoABC#2)
// getOffsetX = "_-7U" (String#22522, DoABC#2)
// getOffsetY = "_-1ox" (String#18498, DoABC#2)
// DirectionalOffsetData = "_-0oK" (String#4599, DoABC#2)
// _originalOffsetY = "_-hb" (String#375, DoABC#2)


