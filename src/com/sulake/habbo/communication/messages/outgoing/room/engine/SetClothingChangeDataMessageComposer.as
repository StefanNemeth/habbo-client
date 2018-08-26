
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetClothingChangeDataMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _objectId:int;
        private var _gender:String;
        private var _SafeStr_4331:String;

        public function SetClothingChangeDataMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String="", _arg_4:int=0, _arg_5:int=0)
        {
            this._objectId = _arg_1;
            this._gender = _arg_2;
            this._SafeStr_4331 = _arg_3;
            this._roomId = _arg_4;
            this._roomCategory = _arg_5;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._objectId, this._gender, this._SafeStr_4331]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// SetClothingChangeDataMessageComposer = "_-3j" (String#22363, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4331 = "_-2-G" (String#18980, DoABC#2)


