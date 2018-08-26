
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class JoinHabboGroupMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function JoinHabboGroupMessageComposer(_arg_1:int)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }
        public function dispose():void
        {
            this._data = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.users

// JoinHabboGroupMessageComposer = "_-1v1" (String#18757, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


