
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class AvatarActionMessageData 
    {

        private var _actionType:String;
        private var _actionParameter:String;

        public function AvatarActionMessageData(_arg_1:String, _arg_2:String)
        {
            this._actionType = _arg_1;
            this._actionParameter = _arg_2;
        }
        public function get actionType():String
        {
            return (this._actionType);
        }
        public function get actionParameter():String
        {
            return (this._actionParameter);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// AvatarActionMessageData = "_-iI" (String#8562, DoABC#2)
// _actionType = "_-9M" (String#7851, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)


