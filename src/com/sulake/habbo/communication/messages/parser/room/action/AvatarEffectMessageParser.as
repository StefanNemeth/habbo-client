
package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userId:int = 0;
        private var _effectId:int = 0;
        private var _delayMilliSeconds:int = 0;

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
        public function get effectId():int
        {
            return (this._effectId);
        }
        public function get delayMilliSeconds():int
        {
            return (this._delayMilliSeconds);
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
            this._effectId = _arg_1.readInteger();
            this._delayMilliSeconds = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.action

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AvatarEffectMessageParser = "_-17O" (String#5023, DoABC#2)
// _effectId = "_-06d" (String#580, DoABC#2)
// effectId = "_-0jW" (String#15809, DoABC#2)
// delayMilliSeconds = "_-Rk" (String#23313, DoABC#2)
// _delayMilliSeconds = "_-1N0" (String#5292, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


