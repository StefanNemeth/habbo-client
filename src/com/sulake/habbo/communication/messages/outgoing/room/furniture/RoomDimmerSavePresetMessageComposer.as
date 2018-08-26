
package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RoomDimmerSavePresetMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _presetNumber:int;
        private var _effectTypeId:int;
        private var _SafeStr_6446:String;
        private var _SafeStr_6447:int;
        private var _SafeStr_6448:Boolean;

        public function RoomDimmerSavePresetMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean, _arg_6:int=0, _arg_7:int=0)
        {
            this._roomId = _arg_6;
            this._roomCategory = _arg_7;
            this._presetNumber = _arg_1;
            this._effectTypeId = _arg_2;
            this._SafeStr_6446 = _arg_3;
            this._SafeStr_6447 = _arg_4;
            this._SafeStr_6448 = _arg_5;
        }
        public function getMessageArray():Array
        {
            return ([this._presetNumber, this._effectTypeId, this._SafeStr_6446, this._SafeStr_6447, int(this._SafeStr_6448)]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.furniture

// RoomDimmerSavePresetMessageComposer = "_-3LP" (String#22343, DoABC#2)
// _presetNumber = "_-37x" (String#7468, DoABC#2)
// _effectTypeId = "_-0rw" (String#4684, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_6446 = "_-Hk" (String#22922, DoABC#2)
// _SafeStr_6447 = "_-30p" (String#21532, DoABC#2)
// _SafeStr_6448 = "_-2Hw" (String#19724, DoABC#2)


