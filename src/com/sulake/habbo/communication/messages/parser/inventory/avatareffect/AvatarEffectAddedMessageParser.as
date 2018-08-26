
package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectAddedMessageParser implements IMessageParser 
    {

        private var _type:int;
        private var _duration:int;

        public function flush():Boolean
        {
            this._type = 0;
            this._duration = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._type = _arg_1.readInteger();
            this._duration = _arg_1.readInteger();
            return (true);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get duration():int
        {
            return (this._duration);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.avatareffect

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AvatarEffectAddedMessageParser = "_-317" (String#21543, DoABC#2)
// _duration = "_-1OY" (String#606, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


