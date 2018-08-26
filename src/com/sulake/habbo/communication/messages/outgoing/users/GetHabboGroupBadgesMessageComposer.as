
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetHabboGroupBadgesMessageComposer implements IMessageComposer, IDisposable 
    {

        public function getMessageArray():Array
        {
            return ([]);
        }
        public function dispose():void
        {
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.users

// GetHabboGroupBadgesMessageComposer = "_-1Z4" (String#17854, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


