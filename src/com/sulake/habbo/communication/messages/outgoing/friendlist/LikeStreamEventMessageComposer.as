
package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LikeStreamEventMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_4507:int;
        private var _avatarId:int;

        public function LikeStreamEventMessageComposer(_arg_1:int, _arg_2:int)
        {
            this._SafeStr_4507 = _arg_1;
            this._avatarId = _arg_2;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_4507, this._avatarId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.friendlist

// LikeStreamEventMessageComposer = "_-23U" (String#19154, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_4507 = "_-2uM" (String#21254, DoABC#2)
// _avatarId = "_-0qk" (String#592, DoABC#2)


