
package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    public class AvatarEffect 
    {

        private var _type:int;
        private var _duration:int;
        private var _inactiveEffectsInInventory:int;
        private var _secondsLeftIfActive:int;

        public function get type():int
        {
            return (this._type);
        }
        public function set type(_arg_1:int):void
        {
            this._type = _arg_1;
        }
        public function get duration():int
        {
            return (this._duration);
        }
        public function set duration(_arg_1:int):void
        {
            this._duration = _arg_1;
        }
        public function get inactiveEffectsInInventory():int
        {
            return (this._inactiveEffectsInInventory);
        }
        public function set inactiveEffectsInInventory(_arg_1:int):void
        {
            this._inactiveEffectsInInventory = _arg_1;
        }
        public function get secondsLeftIfActive():int
        {
            return (this._secondsLeftIfActive);
        }
        public function set secondsLeftIfActive(_arg_1:int):void
        {
            this._secondsLeftIfActive = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect

// AvatarEffect = "_-3JC" (String#22249, DoABC#2)
// _duration = "_-1OY" (String#606, DoABC#2)
// inactiveEffectsInInventory = "_-66" (String#22469, DoABC#2)
// secondsLeftIfActive = "_-11s" (String#16532, DoABC#2)
// _inactiveEffectsInInventory = "_-2lp" (String#20910, DoABC#2)
// _secondsLeftIfActive = "_-2YB" (String#20363, DoABC#2)


