
package com.sulake.habbo.communication.messages.outgoing.advertisement
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetRoomAdMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function GetRoomAdMessageComposer()
        {
            this._data = [];
            super();
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
}//package com.sulake.habbo.communication.messages.outgoing.advertisement

// GetRoomAdMessageComposer = "_-2H3" (String#19686, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


