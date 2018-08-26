
package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WaveMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userId:int = 0;
        private var _isWaving:Boolean = true;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get isWaving():Boolean
        {
            return (this._isWaving);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._userId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.action

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// WaveMessageParser = "_-1ck" (String#5615, DoABC#2)
// _isWaving = "_-0lR" (String#1542, DoABC#2)
// isWaving = "_-0Ph" (String#15050, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


