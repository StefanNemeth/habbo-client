
package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class AssignRightsMessageComposer implements IMessageComposer 
    {

        private var _userId:int;

        public function AssignRightsMessageComposer(_arg_1:int)
        {
            this._userId = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._userId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.action

// AssignRightsMessageComposer = "_-34R" (String#21675, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


