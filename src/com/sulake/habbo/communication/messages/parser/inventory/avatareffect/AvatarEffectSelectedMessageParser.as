
package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectSelectedMessageParser implements IMessageParser 
    {

        private var _type:int;

        public function flush():Boolean
        {
            this._type = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._type = _arg_1.readInteger();
            return (true);
        }
        public function get type():int
        {
            return (this._type);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.avatareffect

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AvatarEffectSelectedMessageParser = "_-0Ff" (String#3865, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


