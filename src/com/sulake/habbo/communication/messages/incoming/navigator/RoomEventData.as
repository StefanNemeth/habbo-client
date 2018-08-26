
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEventData implements IDisposable 
    {

        private var _exists:Boolean;
        private var _ownerAvatarId:int;
        private var _ownerAvatarName:String;
        private var _flatId:int;
        private var _eventType:int;
        private var _eventName:String;
        private var _eventDescription:String;
        private var _creationTime:String;
        private var _tags:Array;
        private var _disposed:Boolean;

        public function RoomEventData(_arg_1:IMessageDataWrapper)
        {
            var _local_5:String;
            this._tags = new Array();
            super();
            var _local_2:String = _arg_1.readString();
            if (_local_2 == "-1"){
                Logger.log("Got null room event");
                this._exists = false;
                return;
            };
            this._exists = true;
            this._ownerAvatarId = int(_local_2);
            this._ownerAvatarName = _arg_1.readString();
            this._flatId = int(_arg_1.readString());
            this._eventType = _arg_1.readInteger();
            this._eventName = _arg_1.readString();
            this._eventDescription = _arg_1.readString();
            this._creationTime = _arg_1.readString();
            var _local_3:int = _arg_1.readInteger();
            var _local_4:int;
            while (_local_4 < _local_3) {
                _local_5 = _arg_1.readString();
                this._tags.push(_local_5);
                _local_4++;
            };
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._tags = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get ownerAvatarId():int
        {
            return (this._ownerAvatarId);
        }
        public function get ownerAvatarName():String
        {
            return (this._ownerAvatarName);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get eventType():int
        {
            return (this._eventType);
        }
        public function get eventName():String
        {
            return (this._eventName);
        }
        public function get eventDescription():String
        {
            return (this._eventDescription);
        }
        public function get creationTime():String
        {
            return (this._creationTime);
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
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomEventData = "_-07q" (String#3718, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// _exists = "_-Bh" (String#7905, DoABC#2)
// exists = "_-23h" (String#19163, DoABC#2)
// _ownerAvatarId = "_-1qq" (String#18573, DoABC#2)
// _ownerAvatarName = "_-1bQ" (String#17953, DoABC#2)
// _eventType = "_-1iq" (String#18239, DoABC#2)
// _eventName = "_-1p-" (String#5838, DoABC#2)
// _eventDescription = "_-yy" (String#24646, DoABC#2)
// _creationTime = "_-0ZT" (String#15421, DoABC#2)
// ownerAvatarId = "_-34" (String#21657, DoABC#2)
// ownerAvatarName = "_-1hB" (String#18182, DoABC#2)
// eventType = "_-2Se" (String#20142, DoABC#2)
// eventName = "_-1tL" (String#18690, DoABC#2)
// eventDescription = "_-1i8" (String#18215, DoABC#2)
// creationTime = "_-2Nt" (String#19960, DoABC#2)


