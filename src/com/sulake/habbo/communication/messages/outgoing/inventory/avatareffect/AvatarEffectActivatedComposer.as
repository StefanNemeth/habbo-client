
package com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class AvatarEffectActivatedComposer implements IMessageComposer 
    {

        private var _type:int;

        public function AvatarEffectActivatedComposer(_arg_1:int)
        {
            this._type = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            var _local_1:Array = new Array();
            _local_1.push(this._type);
            return (_local_1);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect

// AvatarEffectActivatedComposer = "_-2ZH" (String#20409, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


