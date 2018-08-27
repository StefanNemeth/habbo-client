
package com.sulake.habbo.session.events
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionQueueEvent extends RoomSessionEvent 
    {

        public static const RSQE_QUEUE_STATUS:String = "RSQE_QUEUE_STATUS";
        public static const _SafeStr_4775:String = "c";
        public static const _SafeStr_4776:String = "d";
        public static const _SafeStr_4777:int = 2;
        public static const _SafeStr_4778:int = 1;

        private var _name:String;
        private var _target:int;
        private var _SafeStr_4779:Map;
        private var _isActive:Boolean;
        private var _SafeStr_4780:String;

        public function RoomSessionQueueEvent(_arg_1:IRoomSession, _arg_2:String, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(RSQE_QUEUE_STATUS, _arg_1, _arg_5, _arg_6);
            this._name = _arg_2;
            this._target = _arg_3;
            this._SafeStr_4779 = new Map();
            this._isActive = _arg_4;
        }
        public function get isActive():Boolean
        {
            return (this._isActive);
        }
        public function get queueSetName():String
        {
            return (this._name);
        }
        public function get queueSetTarget():int
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
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionQueueEvent = "_-0n4" (String#4569, DoABC#2)
// _isActive = "_-Aj" (String#929, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// RSQE_QUEUE_STATUS = "_-0JP" (String#14818, DoABC#2)
// _SafeStr_4775 = "_-2sn" (String#21191, DoABC#2)
// _SafeStr_4776 = "_-1pn" (String#18535, DoABC#2)
// _SafeStr_4777 = "_-0DD" (String#14577, DoABC#2)
// _SafeStr_4778 = "_-06D" (String#14293, DoABC#2)
// _SafeStr_4779 = "_-2Pt" (String#6559, DoABC#2)
// _SafeStr_4780 = "_-0Ga" (String#14703, DoABC#2)
// queueSetName = "_-158" (String#16658, DoABC#2)
// queueSetTarget = "_-O2" (String#23170, DoABC#2)
// queueTypes = "_-1Hm" (String#17182, DoABC#2)
// getQueueSize = "_-2ar" (String#20482, DoABC#2)
// addQueue = "_-RF" (String#23293, DoABC#2)


