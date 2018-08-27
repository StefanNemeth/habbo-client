
package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.utils.Map;

    public class RoomQueueSet 
    {

        private var _name:String;
        private var _target:int;
        private var _SafeStr_4779:Map;

        public function RoomQueueSet(_arg_1:String, _arg_2:int)
        {
            this._name = _arg_1;
            this._target = _arg_2;
            this._SafeStr_4779 = new Map();
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get target():int
        {
            return (this._target);
        }
        public function get queueTypes():Array
        {
            return (this._SafeStr_4779.getKeys());
        }
        public function getQueueSize(_arg_1:String):int
        {
            return (this._SafeStr_4779.getValue(_arg_1));
        }
        public function addQueue(_arg_1:String, _arg_2:int):void
        {
            this._SafeStr_4779.add(_arg_1, _arg_2);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.session

// RoomQueueSet = "_-0bO" (String#4330, DoABC#2)
// _SafeStr_4779 = "_-2Pt" (String#6559, DoABC#2)
// queueTypes = "_-1Hm" (String#17182, DoABC#2)
// getQueueSize = "_-2ar" (String#20482, DoABC#2)
// addQueue = "_-RF" (String#23293, DoABC#2)


