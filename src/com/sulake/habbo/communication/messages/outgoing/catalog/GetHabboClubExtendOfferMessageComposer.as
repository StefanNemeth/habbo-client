
package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetHabboClubExtendOfferMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _data:Array;

        public function GetHabboClubExtendOfferMessageComposer()
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

// GetHabboClubExtendOfferMessageComposer = "_-1U7" (String#17671, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


