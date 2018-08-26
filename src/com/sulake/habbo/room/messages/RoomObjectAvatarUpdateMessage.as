
package com.sulake.habbo.room.messages
{
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectAvatarUpdateMessage extends RoomObjectMoveUpdateMessage 
    {

        private var _dirHead:int;

        public function RoomObjectAvatarUpdateMessage(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:int)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._dirHead = _arg_4;
        }
        public function get dirHead():int
        {
            return (this._dirHead);
        }

    }
}//package com.sulake.habbo.room.messages

// IVector3d = "_-hf" (String#8547, DoABC#2)
// RoomObjectMoveUpdateMessage = "_-2Es" (String#6339, DoABC#2)
// RoomObjectAvatarUpdateMessage = "_-1ht" (String#18207, DoABC#2)
// _dirHead = "_-209" (String#6050, DoABC#2)
// dirHead = "_-2Ej" (String#19594, DoABC#2)


