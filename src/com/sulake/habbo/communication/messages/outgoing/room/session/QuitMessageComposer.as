
package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class QuitMessageComposer implements IMessageComposer 
    {

        public function getMessageArray():Array
        {
            return (new Array());
        }
        public function dispose():void
        {
        }
        public function get disposed():Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.session

// QuitMessageComposer = "_-FM" (String#22827, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


