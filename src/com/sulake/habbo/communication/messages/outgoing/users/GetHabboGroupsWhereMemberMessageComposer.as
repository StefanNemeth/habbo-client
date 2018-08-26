
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetHabboGroupsWhereMemberMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function GetHabboGroupsWhereMemberMessageComposer()
        {
            this._data = [];
            super();
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

// GetHabboGroupsWhereMemberMessageComposer = "_-1Zd" (String#17875, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


