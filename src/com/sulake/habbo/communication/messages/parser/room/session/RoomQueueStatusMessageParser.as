
package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomQueueStatusMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _SafeStr_8507:Map;
        private var _activeTarget:int = 0;

        public function RoomQueueStatusMessageParser()
        {
            this._SafeStr_8507 = new Map();
            super();
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get activeTarget():int
        {
            return (this._activeTarget);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._SafeStr_8507.reset();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:RoomQueueSet;
            var _local_6:String;
            var _local_7:int;
            var _local_8:int;
            this._SafeStr_8507.reset();
            var _local_2:int = _arg_1.readInteger();
            var _local_5:int;
            while (_local_5 < _local_2) {
                _local_6 = _arg_1.readString();
                _local_7 = _arg_1.readInteger();
                if (_local_5 == 0){
                    this._activeTarget = _local_7;
                };
                _local_4 = new RoomQueueSet(_local_6, _local_7);
                _local_3 = _arg_1.readInteger();
                _local_8 = 0;
                while (_local_8 < _local_3) {
                    _local_4.addQueue(_arg_1.readString(), _arg_1.readInteger());
                    _local_8++;
                };
                this._SafeStr_8507.add(_local_4.target, _local_4);
                _local_5++;
            };
            return (true);
        }
        public function getQueueSetTargets():Array
        {
            return (this._SafeStr_8507.getKeys());
        }
        public function getQueueSet(_arg_1:int):RoomQueueSet
        {
            return ((this._SafeStr_8507.getValue(_arg_1) as RoomQueueSet));
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.session

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomQueueSet = "_-0bO" (String#4330, DoABC#2)
// RoomQueueStatusMessageParser = "_-1qx" (String#5873, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// addQueue = "_-RF" (String#23293, DoABC#2)
// getQueueSetTargets = "_-0lJ" (String#15877, DoABC#2)
// activeTarget = "_-38N" (String#21817, DoABC#2)
// getQueueSet = "_-1sT" (String#18652, DoABC#2)
// _activeTarget = "_-0En" (String#3846, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _SafeStr_8507 = "_-2Qn" (String#20079, DoABC#2)


