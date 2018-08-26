
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomModerationData implements IDisposable 
    {

        private var _flatId:int;
        private var _userCount:int;
        private var _ownerInRoom:Boolean;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _room:RoomData;
        private var _event:RoomData;
        private var _disposed:Boolean;

        public function RoomModerationData(_arg_1:IMessageDataWrapper)
        {
            this._flatId = _arg_1.readInteger();
            this._userCount = _arg_1.readInteger();
            this._ownerInRoom = _arg_1.readBoolean();
            this._ownerId = _arg_1.readInteger();
            this._ownerName = _arg_1.readString();
            this._room = new RoomData(_arg_1);
            this._event = new RoomData(_arg_1);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._room != null){
                this._room.dispose();
                this._room = null;
            };
            if (this._event != null){
                this._event.dispose();
                this._event = null;
            };
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get userCount():int
        {
            return (this._userCount);
        }
        public function get ownerInRoom():Boolean
        {
            return (this._ownerInRoom);
        }
        public function get ownerId():int
        {
            return (this._ownerId);
        }
        public function get ownerName():String
        {
            return (this._ownerName);
        }
        public function get room():RoomData
        {
            return (this._room);
        }
        public function get event():RoomData
        {
            return (this._event);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// RoomModerationData = "_-1Zn" (String#5559, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// userCount = "_-3Ez" (String#22075, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// ownerId = "_-0Kl" (String#3968, DoABC#2)
// _userCount = "_-3Cp" (String#918, DoABC#2)
// _ownerInRoom = "_-0FM" (String#14659, DoABC#2)
// _ownerId = "_-2Ze" (String#622, DoABC#2)
// _room = "_-1eJ" (String#1732, DoABC#2)
// _event = "_-3R" (String#2046, DoABC#2)
// ownerInRoom = "_-1QU" (String#17531, DoABC#2)


