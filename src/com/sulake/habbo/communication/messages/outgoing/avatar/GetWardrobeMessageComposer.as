
package com.sulake.habbo.communication.messages.outgoing.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetWardrobeMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function GetWardrobeMessageComposer()
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
}//package com.sulake.habbo.communication.messages.outgoing.avatar

// GetWardrobeMessageComposer = "_-1xw" (String#18884, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


