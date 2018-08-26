
package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OutfitData 
    {

        private var _slotId:int;
        private var _figureString:String;
        private var _gender:String;

        public function OutfitData(_arg_1:IMessageDataWrapper)
        {
            this._slotId = _arg_1.readInteger();
            this._figureString = _arg_1.readString();
            this._gender = _arg_1.readString();
        }
        public function get slotId():int
        {
            return (this._slotId);
        }
        public function get figureString():String
        {
            return (this._figureString);
        }
        public function get gender():String
        {
            return (this._gender);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.avatar

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// OutfitData = "_-3Q" (String#7734, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// figureString = "_-P1" (String#23207, DoABC#2)
// _slotId = "_-34j" (String#911, DoABC#2)
// _figureString = "_-30g" (String#1986, DoABC#2)


