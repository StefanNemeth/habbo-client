
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomData implements IDisposable 
    {

        private var _exists:Boolean;
        private var _name:String;
        private var _desc:String;
        private var _tags:Array;
        private var _disposed:Boolean;

        public function RoomData(_arg_1:IMessageDataWrapper)
        {
            this._tags = new Array();
            super();
            this._exists = _arg_1.readBoolean();
            if (!this.exists){
                return;
            };
            this._name = _arg_1.readString();
            this._desc = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._tags.push(_arg_1.readString());
                _local_3++;
            };
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
            this._tags = null;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get desc():String
        {
            return (this._desc);
        }
        public function get tags():Array
        {
            return (this._tags);
        }
        public function get exists():Boolean
        {
            return (this._exists);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// _exists = "_-Bh" (String#7905, DoABC#2)
// exists = "_-23h" (String#19163, DoABC#2)


