
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SelectFavouriteHabboGroupMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function SelectFavouriteHabboGroupMessageComposer(_arg_1:int)
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

// SelectFavouriteHabboGroupMessageComposer = "_-15p" (String#16689, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


