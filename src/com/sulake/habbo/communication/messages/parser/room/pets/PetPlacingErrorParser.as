
package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetPlacingErrorParser implements IMessageParser 
    {

        private var _errorCode:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function get errorCode():int
        {
            return (this._errorCode);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function flush():Boolean
        {
            this._errorCode = -1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._errorCode = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.pets

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PetPlacingErrorParser = "_-30n" (String#7322, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


