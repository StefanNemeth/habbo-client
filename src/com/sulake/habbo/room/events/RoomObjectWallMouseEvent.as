
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectWallMouseEvent extends RoomObjectMouseEvent 
    {

        private var _x:Number;
        private var _y:Number;
        private var _direction:Number;
        private var _wallLocation:Vector3d = null;
        private var _wallWidth:Vector3d = null;
        private var _wallHeight:Vector3d = null;

        public function RoomObjectWallMouseEvent(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:IVector3d, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:Boolean=false, _arg_12:Boolean=false, _arg_13:Boolean=false, _arg_14:Boolean=false, _arg_15:Boolean=false, _arg_16:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_11, _arg_12, _arg_13, _arg_14, _arg_15, _arg_16);
            this._wallLocation = new Vector3d();
            this._wallLocation.assign(_arg_5);
            this._wallWidth = new Vector3d();
            this._wallWidth.assign(_arg_6);
            this._wallHeight = new Vector3d();
            this._wallHeight.assign(_arg_7);
            this._x = _arg_8;
            this._y = _arg_9;
            this._direction = _arg_10;
        }
        public function get wallLocation():IVector3d
        {
            return (this._wallLocation);
        }
        public function get wallWidth():IVector3d
        {
            return (this._wallWidth);
        }
        public function get wallHeight():IVector3d
        {
            return (this._wallHeight);
        }
        public function get x():Number
        {
            return (this._x);
        }
        public function get y():Number
        {
            return (this._y);
        }
        public function get direction():Number
        {
            return (this._direction);
        }

    }
}//package com.sulake.habbo.room.events

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectWallMouseEvent = "_-2ed" (String#20631, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// wallLocation = "_-12C" (String#16544, DoABC#2)
// _wallLocation = "_-1K7" (String#17278, DoABC#2)
// _wallWidth = "_-3GV" (String#22142, DoABC#2)
// _wallHeight = "_-2UE" (String#20209, DoABC#2)
// wallWidth = "_-GS" (String#22870, DoABC#2)


