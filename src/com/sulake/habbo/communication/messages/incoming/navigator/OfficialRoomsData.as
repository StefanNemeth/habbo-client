
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomsData implements IDisposable, MsgWithRequestId 
    {

        private var _entries:Array;
        private var _disposed:Boolean;

        public function OfficialRoomsData(_arg_1:IMessageDataWrapper)
        {
            this._entries = new Array();
            super();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._entries.push(new OfficialRoomEntryData(_arg_1));
                _local_3++;
            };
        }
        public function dispose():void
        {
            var _local_1:OfficialRoomEntryData;
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._entries != null){
                for each (_local_1 in this._entries) {
                    _local_1.dispose();
                };
            };
            this._entries = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get entries():Array
        {
            return (this._entries);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MsgWithRequestId = "_-1zv" (String#6029, DoABC#2)
// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// OfficialRoomsData = "_-pq" (String#8704, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// entries = "_-1eU" (String#18076, DoABC#2)
// _entries = "_-1mm" (String#5795, DoABC#2)


