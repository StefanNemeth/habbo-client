
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetUserNotificationsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _disposed:Boolean = false;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function getMessageArray():Array
        {
            return ([]);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
            };
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.users

// GetUserNotificationsMessageComposer = "_-Wh" (String#23513, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


