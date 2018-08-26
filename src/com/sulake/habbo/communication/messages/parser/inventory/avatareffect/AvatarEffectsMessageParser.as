
package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectsMessageParser implements IMessageParser 
    {

        private var _effects:Array;

        public function flush():Boolean
        {
            this._effects = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:AvatarEffect;
            this._effects = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = new AvatarEffect();
                _local_4.type = _arg_1.readInteger();
                _local_4.duration = _arg_1.readInteger();
                _local_4.inactiveEffectsInInventory = _arg_1.readInteger();
                _local_4.secondsLeftIfActive = _arg_1.readInteger();
                this._effects.push(_local_4);
                _local_3++;
            };
            return (true);
        }
        public function get effects():Array
        {
            return (this._effects);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.avatareffect

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AvatarEffectsMessageParser = "_-2m-" (String#20918, DoABC#2)
// AvatarEffect = "_-3JC" (String#22249, DoABC#2)
// _effects = "_-1d5" (String#856, DoABC#2)
// inactiveEffectsInInventory = "_-66" (String#22469, DoABC#2)
// secondsLeftIfActive = "_-11s" (String#16532, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


