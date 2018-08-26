
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetHabboGroupDetailsMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function GetHabboGroupDetailsMessageComposer(_arg_1:int)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
        }
        public function dispose():void
        {
            this._data = null;
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.users

// GetHabboGroupDetailsMessageComposer = "_-1BD" (String#16906, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


