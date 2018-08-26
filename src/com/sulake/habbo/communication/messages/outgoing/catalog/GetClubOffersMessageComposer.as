
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetClubOffersMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _data:Array;

        public function GetClubOffersMessageComposer()
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
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.catalog

// GetClubOffersMessageComposer = "_-2Z2" (String#20398, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


