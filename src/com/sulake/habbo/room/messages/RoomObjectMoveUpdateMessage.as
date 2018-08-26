
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectMoveUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _realTargetLoc:IVector3d;
        private var _isSlideUpdate:Boolean;

        public function RoomObjectMoveUpdateMessage(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3);
            this._isSlideUpdate = _arg_4;
            this._realTargetLoc = _arg_2;
        }
        public function get targetLoc():IVector3d
        {
            if (this._realTargetLoc == null){
                return (loc);
            };
            return (this._realTargetLoc);
        }
        public function get realTargetLoc():IVector3d
        {
            return (this._realTargetLoc);
        }
        public function get isSlideUpdate():Boolean
        {
            return (this._isSlideUpdate);
        }

    }
}//package com.sulake.habbo.room.messages

// IVector3d = "_-hf" (String#8547, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectMoveUpdateMessage = "_-2Es" (String#6339, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// targetLoc = "_-1Io" (String#17228, DoABC#2)
// _realTargetLoc = "_-0bq" (String#1509, DoABC#2)
// _isSlideUpdate = "_-7a" (String#22525, DoABC#2)
// realTargetLoc = "_-4C" (String#22386, DoABC#2)
// isSlideUpdate = "_-1cT" (String#17989, DoABC#2)


